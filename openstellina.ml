open Js_of_ocaml
open Lwt.Syntax
open Astro_utils
open Cookie
open Telescope
open Lwt.Infix
open Js_of_ocaml_lwt

(* Control state type definition *)
type control_state = [
  | `NoControl          (* No one has control *)
  | `RequestingControl  (* We are requesting control *)
  | `HasControl        (* We have control *)
  | `OtherHasControl of string  (* Another client has control *)
]

type action =
  | Idle
  | TakeControl
  | ReleaseControl  
  | Motor 
  | Status
  | Consume
  | Init
  | Observe
  | Park
  | Openarm

(* Control state tracking variables *)
let control_state = ref (`NoControl:control_state)
let control_owner = ref None
let control_request_time = ref 0.0

let websocket = ref None

let action = ref Idle
let connect = ref false

let canvas_width = 1280.
let canvas_height = 480.

let action_seq = ref 0
let delay_seq = ref 0
let verbose = ref false
let verbose' = ref true
let poll_type = ref true

(* Add control state tracking *)
let has_control = ref false
let control_pending = ref false
let sid = ref ""
let ping_interval = ref 25000
let ping_timeout = ref 60000

let create_styled_div doc class_name =
 let div = Dom_html.createDiv doc in
 div##.className := Js.string class_name;
div

let add_message msg_type text =
  let doc = Dom_html.document in
  (match Dom_html.getElementById_opt "telescope-messages" with
  | None -> ()
  | Some panel ->
      let msg = create_styled_div doc ("message " ^ msg_type) in
      msg##.innerHTML := Js.string text;
      Dom.appendChild panel msg;
      (* Auto-scroll to bottom *)
      panel##.scrollTop := panel##.scrollHeight)

let show_error text = add_message "error" text
let show_info text = if false then print_endline text; add_message "info" text
let new_challenge = ref false
let get_session_id (fn:Yojson.Safe.t->unit) =
  let headers = Astro_utils.split ["Accept: */*"] in
  let params = [
    ("EIO", "3");
    ("transport", "polling");
    ("id", "openstellina-web");
    ("name", "openstellina-web")
] in
  let iter = fun s -> fn (cnv s) in
  Astro_utils.get' proto server params headers 
    (pth3'^"/socket.io/") (cnv' iter) hdrs

(* Release control sequence *)
let release_control () =
  if !has_control then begin
    (match !websocket with
    | Some ws ->
        let msg = {|42["message","releaseControl"]|} in
        ws##send (Js.string msg);
        show_info "Releasing control"
    | None ->
        has_control := false;
        show_info "No websocket connection")
  end

(* Add control message constructors *)
let make_take_control_msg () =
  {|42["message","takeControl"]|}

let make_release_control_msg () =
  {|42["message","releaseControl"]|}

let canvas =
  let r = Dom_html.createCanvas Dom_html.document in
  r##.width := int_of_float canvas_width;
  r##.height := int_of_float canvas_height;
  r

type graphics =
  | Empty
  | Fill of string * float * float
  | Font of string
  | Stroke of float * float * float * float

let send_message msg =
  (match !websocket with
  | Some ws ->
      if !verbose' then show_info ("WS sending: " ^ msg);
      ws##send (Js.string msg);
      true
  | None ->
      show_info "No websocket connection";
      false)

let create_status_section doc title items =
  let section = create_styled_div doc "status-section" in
  let title_div = create_styled_div doc "section-title" in
  title_div##.innerHTML := Js.string title;
  Dom.appendChild section title_div;
  
  List.iter (fun (label, value_ref) ->
    let row = create_styled_div doc "status-row" in
    let label_div = create_styled_div doc "status-label" in
    let value_div = create_styled_div doc "status-value" in
    label_div##.innerHTML := Js.string label;
    value_div##.id := Js.string ("status-" ^ label);
    value_div##.innerHTML := Js.string !value_ref;
    Dom.appendChild row label_div;
    Dom.appendChild row value_div;
    Dom.appendChild section row
  ) items;
  section

let process_json_value path = function
  | `Float f -> 
      begin match path with
      | ["sensors"; "temperature"] -> Telescope.tempref := string_of_float f
      | ["sensors"; "humidity"] -> Telescope.humref := string_of_float f
      | ["dewpointDepression"] -> Telescope.dewpointref := string_of_float f
      | ["motors"; "AZ"; "position"] -> Telescope.az_posref := string_of_float f
      | ["motors"; "ALT"; "position"] -> Telescope.alt_posref := string_of_float f
      | _ -> ()
      end
  | `String s ->
      begin match path with
      | ["challenge"] -> 
          if !Telescope.challengeref <> s then (
	    new_challenge := true;
	    show_info ("Challenge: "^s);
            Telescope.challengeref := s
          )
      | ["telescopeId"] -> 
          if !Telescope.telescopeId <> s then (
            new_challenge := true;
	    show_info ("Telescope ID: "^s);
            Telescope.telescopeId := s
          )
      | ["currentOperation"; "type"] -> Telescope.debugref := s
      | ["error"; "name"] -> Telescope.errorref := s
      | ["defogStatus"] -> Telescope.defogref := s
      | _ -> ()
      end
  | `Int i ->
      begin match path with 
      | ["bootCount"] ->
          if !Telescope.bootCnt <> i then (
            new_challenge := true;
	    show_info ("Boot Count: "^string_of_int i);
            Telescope.bootCnt := i
          )
      | _ -> ()
      end
| _ -> ()

let create_telescope_display doc =
  let display = create_styled_div doc "telescope-display" in

  let system = create_status_section doc "System" [
    ("ID", Telescope.telescopeId);
    ("Model", Telescope.model_ref);
    ("API Version", Telescope.api_version_ref);
    ("Version", Telescope.version_ref);
    ("Boot Count", ref (string_of_int !Telescope.bootCnt));
    ("Auth", ref "Unknown");
    ("Debug Mode", Telescope.board_debug_ref);
    ("Autofocus", Telescope.autofocus_ref);
    ("Challenge", Telescope.challengeref);
    ("Initialized", Telescope.initialized_ref);
    ("Shutting Down", Telescope.shutting_down_ref)
  ] in

  let environment = create_status_section doc "Environment" [
    ("Temperature", Telescope.tempref);
    ("Temp Delta", Telescope.temperature_delta_ref);
    ("Humidity", Telescope.humref);
    ("Humidity Delta", Telescope.humidity_delta_ref);
    ("Dew Point", Telescope.dewpointref); 
    ("Dew Point Depression", Telescope.dewpointref);
    ("Defog Status", Telescope.defogref)
  ] in

  let motors = create_status_section doc "Motors" [
    ("AZ Position", Telescope.az_posref);
    ("AZ State", ref !Telescope.motor_state_ref);
    ("ALT Position", Telescope.alt_posref);
    ("ALT State", ref !Telescope.motor_state_ref);
    ("DER Position", Telescope.der_posref);
    ("DER State", ref !Telescope.motor_state_ref);
    ("MAP Position", Telescope.map_posref);
    ("MAP State", ref !Telescope.motor_state_ref)
  ] in  

  let status = create_status_section doc "Status" [
    ("Operation", Telescope.debugref);
    ("Error", Telescope.errorref)
  ] in
  let storage = create_status_section doc "Storage" [
    ("System Size", Telescope.storage_system_size_ref);
    ("System Available", Telescope.storage_system_avail_ref);
    ("Data Size", Telescope.storage_data_size_ref);
    ("Data Available", Telescope.storage_data_avail_ref);
    ("Network Band", Telescope.storage_band_ref)
  ] in

  let updates = create_status_section doc "Updates" [
    ("Installed Version", Telescope.installed_version_ref);
    ("Min Compatible", Telescope.min_compat_version_ref); 
    ("State", Telescope.update_state_ref)
  ] in

  let observation = create_status_section doc "Current Observation" [
    ("Target", Telescope.current_target_ref);
    ("Latitude", Telescope.position_lat_ref);
    ("Longitude", Telescope.position_lon_ref) 
  ] in

  List.iter (fun section -> Dom.appendChild display section) 
    [system; environment; storage; motors; status; updates; observation];
  display

let debug_mode = ref true

let debug msg =
  if !debug_mode then
    begin 
    print_endline ("DEBUG: " ^ msg);
    show_info msg
    end

let update_display_value id value =
  (match Dom_html.getElementById_opt id with
  | Some element -> element##.innerHTML := Js.string value
  | None -> ())

let last_ctrl = ref (`OtherHasControl "")
let last_class = ref ""

let update_control_display () =
  let debug_msg s = if !verbose then debug ("Control update: " ^ s) in
  if !control_state <> !last_ctrl then debug_msg (match !control_state with
    | `NoControl -> "State: NoControl"
    | `RequestingControl -> "State: RequestingControl" 
    | `HasControl -> "State: HasControl"
    | `OtherHasControl u -> "State: OtherHasControl - " ^ u);
  last_ctrl := !control_state;

  (* Update status dot *)
  (match Dom_html.getElementById_opt "control-status-dot" with
  | Some dot ->
      let status_class = match !control_state with
      | `NoControl -> "status-dot no-control"  
      | `RequestingControl -> "status-dot requesting"
      | `HasControl -> "status-dot has-control"
      | `OtherHasControl _ -> "status-dot other-control"
      in
      if !last_class <> status_class then debug_msg ("Setting dot class to: " ^ status_class);
      last_class := status_class;
      dot##.className := Js.string status_class
  | None -> debug_msg "Could not find status dot");

  (* Update status text *)
  (match Dom_html.getElementById_opt "control-status-text" with
  | Some text ->
      let status_msg = match !control_state with
      | `NoControl -> "No Control"
      | `RequestingControl -> "Requesting Control"
      | `HasControl -> "Has Control"
      | `OtherHasControl user -> "Controlled by " ^ user
      in
      debug_msg ("Setting status text to: " ^ status_msg);
      text##.textContent := Js.some (Js.string status_msg)
  | None -> debug_msg "Could not find status text");

  (* Update detailed message *)
  (match Dom_html.getElementById_opt "control-details" with
  | Some details ->
      let msg = match !control_state with
      | `NoControl -> "The telescope is not being controlled"
      | `RequestingControl -> "Attempting to take control..."
      | `HasControl -> "You are controlling the telescope"
      | `OtherHasControl user -> "Telescope is being controlled by " ^ user
      in
      debug_msg ("Setting details to: " ^ msg);
      details##.textContent := Js.some (Js.string msg)
  | None -> debug_msg "Could not find details element");

  (* Update buttons *)
  (match Dom_html.getElementById_opt "take-control-button" with
  | Some element ->
      Js.Opt.iter (Dom_html.CoerceTo.input element)
        (fun btn ->
          let should_disable = match !control_state with
            | `NoControl -> false
            | _ -> true
          in
          debug_msg ("Setting take button disabled: " ^ string_of_bool should_disable);
          btn##.disabled := Js.bool should_disable)
  | None -> debug_msg "Could not find take button");

  (match Dom_html.getElementById_opt "release-control-button" with
  | Some element ->
      Js.Opt.iter (Dom_html.CoerceTo.input element)
        (fun btn ->
          let should_disable = match !control_state with
            | `HasControl -> false
            | _ -> true
          in
          debug_msg ("Setting release button disabled: " ^ string_of_bool should_disable);
          btn##.disabled := Js.bool should_disable)
  | None -> debug_msg "Could not find release button");

  debug_msg "Update complete"

let update_telescope_display () =
  update_display_value "status-ID" !Telescope.telescopeId;
  update_display_value "status-Boot Count" (string_of_int !Telescope.bootCnt);
  update_display_value "status-Auth" (let auth = !Telescope.authref in if String.length auth > 80 then (String.sub auth 16 64^" ...") else "Unknown");
  update_display_value "status-Challenge" !Telescope.challengeref;
  update_display_value "status-Temperature" !Telescope.tempref;
  update_display_value "status-Humidity" !Telescope.humref;
  update_display_value "status-Operation" !Telescope.debugref;
  update_display_value "status-Error" !Telescope.errorref

let ws_action = ref None  (* Separate from main action *)

let rec ping_loop () =
  (match !websocket with
  | Some ws ->
      let* () = Lwt_js.sleep (25.0) in
      if !connect then begin
        debug "Ping loop: Sending ping probe";
        ws##send (Js.string "2probe");
        let* () = ping_loop () in
        Lwt.return_unit
      end else begin
        debug "Ping loop: Connection not active, stopping";
        Lwt.return_unit
      end
  | None -> 
      debug "Ping loop: No websocket connection";
      Lwt.return_unit)

let handle_socketio msg =
  if false then print_endline ("socket.io: " ^ msg);
  (match msg with
  | "2" -> (* PING *)
     show_info "ping";
     begin match !websocket with
     | Some ws -> ws##send (Js.string "3") (* PONG *)
     | None -> ()
     end
  | "3" -> (* PONG *) 
     show_info "pong"
  | s when String.length s >= 2 && String.sub s 0 2 = "42" ->
     show_info ("socket.io message: " ^ s)
  | _ -> 
     show_info ("other socket.io: " ^ msg))

let rec process_json path = function
  | `Assoc
    [("sid", `String sid');
     ("upgrades", `List [`String "websocket"]); ("pingInterval", `Int ping_int');
     ("pingTimeout", `Int ping_tim')] ->
     if !sid = "" then
       begin
       if !verbose then show_info ("sid: " ^ sid');
       sid := sid';
       ping_interval := ping_int';
       ping_timeout := ping_tim';
       if connect_websocket Telescope.proto Telescope.server Telescope.pth3' then
         begin
	 (*
          connect := true;
          ignore (ping_loop ());
	  *)
         print_endline "WebSocket connection successful"
         end
       else
         print_endline "WebSocket connection failed"
     end;
  | `Assoc pairs -> List.iter (fun (k,v) -> process_json (k::path) v) pairs
  | `List items -> List.iteri (fun i v -> process_json (string_of_int i::path) v) items  
  | v -> (match List.rev path with
         | "temperature"::"sensors"::_ -> process_json_value ["sensors"; "temperature"] v
         | "humidity"::"sensors"::_ -> process_json_value ["sensors"; "humidity"] v 
         | "humidityDelta"::"sensors"::_ -> process_json_value ["sensors"; "humidityDelta"] v
         | "temperatureDelta"::"sensors"::_ -> process_json_value ["sensors"; "temperatureDelta"] v
         | "defogStatus"::"sensors"::_ -> process_json_value ["defogStatus"] v
         | "dewpointDepression"::"sensors"::_ -> process_json_value ["dewpointDepression"] v 
         | "challenge"::_ -> process_json_value ["challenge"] v
         | "telescopeId"::_ -> process_json_value ["telescopeId"] v 
         | "type"::"currentOperation"::_ -> process_json_value ["currentOperation"; "type"] v
         | "name"::"error"::_ -> process_json_value ["error"; "name"] v
         | "bootCount"::_ -> process_json_value ["bootCount"] v
         | "position"::"AZ"::"motors"::_ -> process_json_value ["motors"; "AZ"; "position"] v
         | "state"::"AZ"::"motors"::_ -> process_json_value ["motors"; "AZ"; "state"] v
         | "position"::"ALT"::"motors"::_ -> process_json_value ["motors"; "ALT"; "position"] v
         | "state"::"ALT"::"motors"::_ -> process_json_value ["motors"; "ALT"; "state"] v
         | "position"::"DER"::"motors"::_ -> process_json_value ["motors"; "DER"; "position"] v
         | "state"::"DER"::"motors"::_ -> process_json_value ["motors"; "DER"; "state"] v
         | "position"::"MAP"::"motors"::_ -> process_json_value ["motors"; "MAP"; "position"] v
         | "state"::"MAP"::"motors"::_ -> process_json_value ["motors"; "MAP"; "state"] v
         | "shuttingDown"::_ -> process_json_value ["shuttingDown"] v
         | "initialized"::_ -> process_json_value ["initialized"] v
         | "version"::_ -> process_json_value ["version"] v
         (* System info *)
         | "apiVersion"::_ -> process_json_value ["apiVersion"] v
         | "model"::_ -> process_json_value ["model"] v
         | "version"::_ -> process_json_value ["version"] v
         | "boardInDebugMode"::_ -> process_json_value ["boardDebug"] v
         | "autofocusPosition"::_ -> process_json_value ["autofocus"] v

         (* Storage *)
         | "size"::"system"::"storage"::_ -> process_json_value ["storage"; "system"; "size"] v
         | "available"::"system"::"storage"::_ -> process_json_value ["storage"; "system"; "available"] v
         | "size"::"data"::"storage"::_ -> process_json_value ["storage"; "data"; "size"] v
         | "available"::"data"::"storage"::_ -> process_json_value ["storage"; "data"; "available"] v
         | "band"::"settings"::_ -> process_json_value ["settings"; "band"] v

         (* Updates *)
         | "installedVersion"::"update"::_ -> process_json_value ["update"; "installed"] v
         | "minimumCompatibleVersion"::"update"::_ -> process_json_value ["update"; "mincompat"] v
         | "state"::"update"::_ -> process_json_value ["update"; "state"] v

         (* Current observation target *)
         | "objectName"::"target"::_ -> process_json_value ["target"; "name"] v
         | "latitude"::"position"::_ -> process_json_value ["position"; "lat"] v
         | "longitude"::"position"::_ -> process_json_value ["position"; "lon"] v

         | "result"::"data"::_ -> ()
         | "result"::"apiVersion"::_ -> process_json_value ["apiVersion"] v
         | "result"::"autofocusPosition"::_ -> process_json_value ["autofocus"] v
         | "result"::"availableReports"::_ -> ()
         | "result"::"boardInDebugMode"::_ -> ()
         | "result"::"boardInitError"::_ -> ()
         | "result"::"challenge"::_ -> process_json_value ["challenge"] v
         | "result"::"currentOperation"::_ -> ()
         | "result"::"elapsedTime"::_ -> ()
         | "result"::"filter"::_ -> ()
         | "result"::"initError"::_ -> ()
         | "result"::"initialized"::_ -> ()
         | "result"::"masterDeviceId"::_ -> ()
	 | "result"::"connectedDevices"::n::"id"::_ -> ()
	 | "result"::"connectedDevices"::n::"name"::_ -> ()
	 | "result"::"connectedDevices"::n::"user"::_ -> ()
         | "result"::"model"::_ -> process_json_value ["model"] v
         | "result"::"telescopeId"::_ -> process_json_value ["telescopeId"] v 
         | "result"::"bootCount"::_ -> process_json_value ["bootCount"] v
         | "result"::"captureStore"::"storedCaptures"::_::"exposureMicroSec"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"filter"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"lastImage"::"cropHeight"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"lastImage"::"cropWidth"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"lastImage"::"cropX"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"lastImage"::"cropY"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"lastImage"::"index"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"lastImage"::"metadata"::"mosaic"::"turnCount"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"lastImage"::"metadata"::"mosaic"::"turnProgress"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"lastImage"::"stackingCount"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"lastImage"::"stackingErrorCount"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"lastImage"::"time"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"lastImage"::"url"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"mosaic"::"heightDegree"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"mosaic"::"widthDegree"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"startTime"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"storeId"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"target"::"de"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"target"::"objectId"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"target"::"objectName"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"target"::"ra"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"target"::"rot"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"target"::"type"::_ -> ()
         | "result"::"captureStore"::"storedCaptures"::_::"totalStackingCount"::_ -> ()
	 | "result"::"motors"::"ALT"::"atStop"::_ -> ()
	 | "result"::"motors"::"AZ"::"atStop"::_ -> ()
	 | "result"::"motors"::"DER"::"atStop"::_ -> ()
         | "result"::"logs"::"bufferPosition"::_ -> ()
         | "result"::"logs"::"bufferSize"::_ -> ()
         | "result"::"logs"::"numFiles"::_ -> ()
         | "result"::"message"::_ -> ()
         | "result"::"motors"::"ALT"::"calibrated"::_ -> ()
         | "result"::"motors"::"ALT"::"position"::_ -> ()
         | "result"::"motors"::"ALT"::"state"::_ -> ()
         | "result"::"motors"::"AZ"::"calibrated"::_ -> ()
         | "result"::"motors"::"AZ"::"position"::_ -> ()
         | "result"::"motors"::"AZ"::"state"::_ -> ()
         | "result"::"motors"::"DER"::"calibrated"::_ -> ()
         | "result"::"motors"::"DER"::"position"::_ -> ()
         | "result"::"motors"::"DER"::"state"::_ -> ()
         | "result"::"motors"::"MAP"::"calibrated"::_ -> ()
         | "result"::"motors"::"MAP"::"position"::_ -> ()
         | "result"::"motors"::"MAP"::"state"::_ -> ()
         | "result"::"network"::"band"::_ -> ()
         | "result"::"network"::"channel"::_ -> ()
         | "result"::"previousBootError"::_ -> ()
         | "result"::"previousOperations"::_::_ -> ()
         | "result"::"sensors"::"defogStatus"::_ -> ()
         | "result"::"sensors"::"dewpointDepression"::_ -> ()
         | "result"::"sensors"::"humidity"::_ -> ()
         | "result"::"sensors"::"humidityDelta"::_ -> ()
         | "result"::"sensors"::"temperature"::_ -> ()
         | "result"::"sensors"::"temperatureDelta"::_ -> ()
         | "result"::"settings"::"band"::_ -> ()
         | "result"::"settings"::"enableFullResolution"::_ -> ()
         | "result"::"settings"::"enableLiveFocus"::_ -> ()
         | "result"::"settings"::"storageFileCategories"::_::_ -> ()
         | "result"::"settings"::"telescopeName"::_ -> ()
         | "result"::"shuttingDown"::_ -> ()
         | "result"::"storage"::"data"::"available"::_ -> ()
         | "result"::"storage"::"data"::"size"::_ -> ()
         | "result"::"storage"::"public"::_ -> ()
         | "result"::"storage"::"system"::"available"::_ -> ()
         | "result"::"storage"::"system"::"size"::_ -> ()
         | "result"::"storage"::"usb"::_ -> ()
         | "result"::"timestamp"::_ -> ()
         | "result"::"update"::"installedVersion"::_ -> ()
         | "result"::"update"::"minimumCompatibleVersion"::_ -> ()
         | "result"::"update"::"state"::_ -> ()
         | "result"::"version"::_ -> ()
         | "Status"::_ -> ()
         | "success"::_ -> ()
         | "code"::_ -> ()
         | "message"::_ -> ()
         | "1"::"logs"::"bufferPosition"::_ -> ()
         | "1"::"logs"::"bufferSize"::_ -> ()
         | "1"::"logs"::"numFiles"::_ -> ()
         | "1"::"previousOperations"::_::_ -> ()
         | "1"::"captureStore"::"storedCaptures"::_ -> ()
	 | "1"::"apiVersion"::_ -> ()
	 | "1"::"autofocusPosition"::_ -> ()
	 | "1"::"availableReports"::_ -> ()
	 | "1"::"boardInDebugMode"::_ -> ()
	 | "1"::"boardInitError"::_ -> ()
	 | "1"::"bootCount"::_ -> ()
	 | "1"::"challenge"::_ -> ()
	 | "1"::"connectedDevices"::n::"id"::_ -> ()
	 | "1"::"connectedDevices"::n::"name"::_ -> ()
	 | "1"::"connectedDevices"::n::"user"::_ -> ()
	 | "1"::"currentOperation"::_ -> ()
	 | "1"::"elapsedTime"::_ -> ()
	 | "1"::"filter"::_ -> ()
	 | "1"::"initError"::_ -> ()
	 | "1"::"initialized"::_ -> ()
	 | "1"::"logs::bufferPosition"::_ -> ()
	 | "1"::"logs::bufferSize"::_ -> ()
	 | "1"::"logs::numFiles"::_ -> ()
	 | "1"::"masterDeviceId"::_ -> ()
	 | "1"::"model"::_ -> ()
	 | "1"::"motors"::"ALT"::"atStop"::_ -> ()
	 | "1"::"motors"::"ALT"::"calibrated"::_ -> ()
	 | "1"::"motors"::"ALT"::"position"::_ -> ()
	 | "1"::"motors"::"ALT"::"state"::_ -> ()
	 | "1"::"motors"::"AZ"::"atStop"::_ -> ()
	 | "1"::"motors"::"AZ"::"calibrated"::_ -> ()
	 | "1"::"motors"::"AZ"::"position"::_ -> ()
	 | "1"::"motors"::"AZ"::"state"::_ -> ()
	 | "1"::"motors"::"DER"::"atStop"::_ -> ()
	 | "1"::"motors"::"DER"::"calibrated"::_ -> ()
	 | "1"::"motors"::"DER"::"position"::_ -> ()
	 | "1"::"motors"::"DER"::"state"::_ -> ()
	 | "1"::"motors"::"MAP"::"atStop"::_ -> ()
	 | "1"::"motors"::"MAP"::"calibrated"::_ -> ()
	 | "1"::"motors"::"MAP"::"position"::_ -> ()
	 | "1"::"motors"::"MAP"::"state"::_ -> ()
	 | "1"::"network"::"band"::_ -> ()
	 | "1"::"network"::"channel"::_ -> ()
	 | "1"::"previousBootError"::_ -> ()
	 | "1"::"sensors"::"defogStatus"::_ -> ()
	 | "1"::"sensors"::"dewpointDepression"::_ -> ()
	 | "1"::"sensors"::"humidity"::_ -> ()
	 | "1"::"sensors"::"humidityDelta"::_ -> ()
	 | "1"::"sensors"::"temperature"::_ -> ()
	 | "1"::"sensors"::"temperatureDelta"::_ -> ()
	 | "1"::"settings"::"band"::_ -> ()
	 | "1"::"settings"::"enableFullResolution"::_ -> ()
	 | "1"::"settings"::"enableLiveFocus"::_ -> ()
	 | "1"::"settings"::"storageFileCategories"::n::_ -> ()
	 | "1"::"settings"::"telescopeName"::_ -> ()
	 | "1"::"shuttingDown"::_ -> ()
	 | "1"::"storage"::"data"::"available"::_ -> ()
	 | "1"::"storage"::"data"::"size"::_ -> ()
	 | "1"::"storage"::"public"::_ -> ()
	 | "1"::"storage"::"system"::"available"::_ -> ()
	 | "1"::"storage"::"system"::"size"::_ -> ()
	 | "1"::"storage"::"usb"::_ -> ()
	 | "1"::"telescopeId"::_ -> ()
	 | "1"::"timestamp"::_ -> ()
	 | "1"::"update"::"installedVersion"::_ -> ()
	 | "1"::"update"::"minimumCompatibleVersion"::_ -> ()
	 | "1"::"update"::"state"::_ -> ()
         | "1"::"version"::_ -> ()
	 | "0"::_ -> print_endline "zero process_json"
         | oth -> print_endline ("Unhandled: "^String.concat "::" oth))

and process_ws_messages ws =
  ws##.onmessage := Dom.handler (fun e ->
    let msg = Js.to_string e##.data in
    handle_frame msg;
    Js._true
    )

and connect_websocket proto server port =
  let server' = if String.length server > 0 && server.[0] = '/' then 
    String.sub server 1 (String.length server - 1) else server in
  let device_info = {|id=openstellina-web&name=openstellina-wb|} in
  let ws_url = (if proto = "https://" then "wss://" else "ws://") ^ server' ^ port ^
    "/socket.io/?EIO=3&transport=websocket&" ^ device_info in
  if !verbose then show_info ("Connecting WebSocket to: " ^ ws_url);
  let connected = ref false in
  let open Js_of_ocaml.WebSockets in
  try
  let ws = new%js webSocket (Js.string ws_url) in
    websocket := Some ws;
      ws##.onopen := Dom.handler (fun _ ->
        debug "WebSocket connection opened";
        Js._true
      );
      
      ws##.onclose := Dom.handler (fun _ ->
        debug "WebSocket connection closed";
        connect := false;
        Js._true
      );
      
      ws##.onerror := Dom.handler (fun _ ->
        debug "WebSocket error occurred";
        Js._true
      );

      ws##.onmessage := Dom.handler (fun e ->
      let msg = Js.to_string e##.data in
      if String.length msg < 80 && !verbose then show_info ("WS received: " ^ msg);
      handle_frame msg;
      connected := true;
      Js._true
    );
    let rec wait_connect n =
      if n <= 0 then false
      else if !connected then true 
      else (
        ignore (Js_of_ocaml_lwt.Lwt_js.sleep 0.1);
        wait_connect (n-1)
      )
    in
    if wait_connect 50 then true
    else false
  with e ->
    show_info ("WebSocket connection failed: " ^ Printexc.to_string e);
false

(* Update handle_frame to handle control messages *)
and handle_frame msg =
  debug ("Received WebSocket frame: " ^ (if String.length msg < 80 then msg else String.sub msg 0 80 ^ " ..."));
  (match msg.[0] with
  | '0' -> (* Socket.IO handshake *)
      begin try
        let json = String.sub msg 1 (String.length msg - 1) in
        let handshake = Yojson.Safe.from_string json in
        let open Yojson.Safe.Util in
        sid := member "sid" handshake |> to_string;
        ping_interval := member "pingInterval" handshake |> to_int;
        ping_timeout := member "pingTimeout" handshake |> to_int;
        debug (Printf.sprintf "Handshake complete - SID: %s, Ping interval: %dms, Timeout: %dms" 
          !sid !ping_interval !ping_timeout);
        connect := true;
        if !control_state = `RequestingControl then
          (match !websocket with
          | Some ws ->
              let msg = {|42["message","takeControl"]|} in
              debug ("Sending take control message: " ^ msg);
              ws##send (Js.string msg)
          | None -> 
              debug "Cannot take control - websocket connection lost";
              control_state := `NoControl;
              control_pending := false);
        ignore (ping_loop ())
      with e ->
        debug ("Handshake parse failed: " ^ Printexc.to_string e ^ "\nMessage was: " ^ msg)
      end
  | '2' -> (* PING *)
      debug "Received PING, sending PONG";
      begin match !websocket with
      | Some ws -> ws##send (Js.string "3")
      | None -> debug "Cannot send PONG - no websocket connection"
      end
  | '3' -> (* PONG received *)
      debug "Received PONG response"
  | '4' when String.length msg >= 2 -> 
    begin match msg.[1] with
    | '2' -> (* Socket.IO event *)
        if String.length msg > 2 then
          let event_json = String.sub msg 2 (String.length msg - 2) in
          if false then debug ("Received Socket.IO event: " ^ event_json);
          begin try
            let json = Yojson.Safe.from_string event_json in
            match json with
            | `List [`String "STATUS_UPDATED"; status] ->
                (* Check masterDeviceId in status update *)
                begin match Yojson.Safe.Util.(member "masterDeviceId" status |> to_string_option) with
                | Some "openstellina-web" when !control_state <> `HasControl ->
                    control_state := `HasControl;
                    control_owner := Some "openstellina";
                    show_info "Control granted (via status)";
                    print_endline "Control granted (via status)";
                    has_control := true;
                    control_pending := false;
                    update_control_display ()
                | _ -> process_json [] json
                end
            | `List [`String "CONTROL_GRANTED"] ->
                control_state := `HasControl;
                control_owner := Some "openstellina";
                show_info "Control granted";
                has_control := true;
                control_pending := false;
                update_control_display ()
            | `List [`String "CONTROL_DENIED"; `String reason] ->
                control_state := `NoControl;
                show_info ("Control denied: " ^ reason);
                has_control := false;
                control_pending := false;
                update_control_display ()
            | _ -> process_json [] json
          with e -> 
            debug ("Failed to parse event: " ^ event_json ^ "\nError: " ^ Printexc.to_string e)
          end
    | _ -> debug ("Unknown type-4 message subtype: " ^ String.make 1 msg.[1] ^ "\nFull message: " ^ msg)
end
| c -> debug ("Unhandled frame type: " ^ String.make 1 c ^ "\nFull message: " ^ msg))

and handle_socketio msg =
  if !verbose' then print_endline ("socket.io: " ^ msg);
  (match msg with
  | "2" -> (* PING *)
     show_info "ping";
     begin match !websocket with
     | Some ws -> ws##send (Js.string "3") (* PONG *)
     | None -> ()
     end
  | "3" -> (* PONG *) 
     show_info "pong"
  | s when String.length s >= 2 && String.sub s 0 2 = "42" ->
     show_info ("socket.io message: " ^ s)
  | _ -> show_info ("other socket.io: " ^ msg))

let errchklst' user = function
  | (kw', `List [`String "message"; `String msg]) ->
      handle_socketio msg
  | (_, json) -> process_json [] json
	
let session (arg:Yojson.Safe.t) =
  if false then print_endline "session";
  errchklst' true ("R", arg);
  update_telescope_display ()

(* Update the take_control function to use the new state *)
let take_control () =
  debug "Initiating take control sequence";
  if !sid = "" then begin
    debug "No session ID - requesting new session";
    control_state := `RequestingControl;
    let* _ = get_session_id session in
    control_pending := true;
    Lwt.return_unit
  end else if !control_state = `NoControl then begin
    debug "Have session ID but no control - requesting control";
    (match !websocket with
    | Some ws ->
        control_state := `RequestingControl;
        control_pending := true;
        let msg = {|42["message","takeControl"]|} in
        debug ("Sending take control message: " ^ msg);
        ws##send (Js.string msg);
        Lwt.return_unit
    | None ->
        debug "No websocket connection - attempting to establish";
        if connect_websocket Telescope.proto Telescope.server Telescope.pth3' then
        begin
          control_state := `RequestingControl;
          control_pending := true;
          match !websocket with
          | Some ws ->
              let msg = {|42["message","takeControl"]|} in
              debug ("Sending take control message: " ^ msg);
              ws##send (Js.string msg);
              Lwt.return_unit
          | None -> 
              debug "Lost websocket connection after establishment";
              control_pending := false;
              control_state := `NoControl;
              Lwt.return_unit
        end else begin
          debug "Failed to establish websocket connection";
          control_state := `NoControl;
          Lwt.return_unit
        end)
  end else begin
    debug (Printf.sprintf "Take control blocked - current state: %s" 
      (match !control_state with
       | `NoControl -> "NoControl"
       | `RequestingControl -> "RequestingControl"
       | `HasControl -> "HasControl"
       | `OtherHasControl user -> "OtherHasControl:" ^ user));
    Lwt.return_unit
  end

(* Update release_control to use the new state *)
let release_control () =
  (match !control_state with
  | `HasControl ->
      begin (match !websocket with
      | Some ws ->
          let msg = {|42["message","releaseControl"]|} in
          ws##send (Js.string msg);
          control_state := `NoControl;
          control_owner := None;
          has_control := false;
          show_info "Released control"
      | None ->
          show_info "Cannot release control - no websocket connection")
      end
  | _ ->
      show_info "Cannot release control - do not have control")

let cnvauth s =
  try let auth = Telescope.cnv s in let authstr = Yojson.Safe.Util.to_string ( Yojson.Safe.Util.member "authorization" auth ) in show_info ("auth "^String.sub authstr 16 64^" ..."); Telescope.authref := authstr; 
  with _ -> Telescope.authref := "auth fail"

let rec action_func pending = function
  | TakeControl -> 
      let* () = take_control () in
      Js_of_ocaml_lwt.Lwt_js.sleep 0.1
  | ReleaseControl ->
      release_control ();
      Js_of_ocaml_lwt.Lwt_js.sleep 0.1
  | Idle -> 
      if !control_pending then
        Js_of_ocaml_lwt.Lwt_js.sleep 0.1
      else if !has_control then begin
        (match !action with
        | Idle -> Js_of_ocaml_lwt.Lwt_js.sleep 0.1
        | a -> action_func pending a)
      end else
        Js_of_ocaml_lwt.Lwt_js.sleep 0.1
  | a -> (* Other actions require control *)
      if !has_control then
        (match a with
        | Status -> Telescope.status_fun session
        | Consume -> Telescope.status_fun' session
        | Init -> Telescope.init' session
        | Observe -> Telescope.observe' session
        | Park -> Telescope.park' session
        | Openarm -> Telescope.openarm' session
        | Motor -> Telescope.motorgo session
        | _ -> Js_of_ocaml_lwt.Lwt_js.sleep 0.1)
      else
        Js_of_ocaml_lwt.Lwt_js.sleep 0.1

let sel = ref 0

let choose fn =
  fn();
  let (found, ra', dec', mag') = Messier_catalogue.messier_array.(!sel) in
  let ra_flt = Altaz.cnv_ra ra' in
  let dec_flt = Altaz.cnv_dec dec' in
  let yr,mon,dy,hr,min,sec = split_date() in
  let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = 
    Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt (latitude()) (longitude()) in
Astro_utils.show_entries found jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc nan ra_flt dec_flt nan nan nan (float_of_string mag') nan nan;
[Empty]

let rec draw_things fn arg = 
  let context = canvas##getContext Dom_html._2d_ in
  context##clearRect 0. 0. canvas_width canvas_height;
  List.iter (function
    | Font str -> context##.font := Js.string str
    | Fill (str,x,y) -> context##fillText (Js.string str) x y
    | Stroke (x,y,w,h) -> context##strokeRect x y w h
    | Empty -> ()) (fn arg);
    let* () = (Js_of_ocaml_lwt.Lwt_js.sleep 0.1) in
  let* () = if !new_challenge then (new_challenge := false; Telescope.postauth' cnvauth) else (Js_of_ocaml_lwt.Lwt_js.sleep 0.1) in
  let pending = !action in
  action := Idle;
  let* () = action_func 0 pending in
  draw_things fn (fun _ -> ())

let (promise:unit Lwt.t ref) = ref @@ draw_things choose (fun () -> ())

let create_styled_div doc class_name =
  let div = Dom_html.createDiv doc in
  div##.className := Js.string class_name;
  div

let create_button doc text onclick =
  let btn = Dom_html.createInput ~_type:(Js.string "button") doc in
  btn##.value := Js.string text;
  btn##.className := Js.string "btn";
  btn##.onclick := Dom_html.handler onclick;
  btn

let create_card doc title content =
  let card = create_styled_div doc "card" in
  let header = create_styled_div doc "card-header" in
  let title_div = Dom_html.createDiv doc in
  title_div##.innerHTML := Js.string title;
  title_div##.className := Js.string "card-title";
  let content_div = create_styled_div doc "card-content" in
  Dom.appendChild content_div content;
  Dom.appendChild header title_div;
  Dom.appendChild card header;
  Dom.appendChild card content_div;
  card

let create_connection_status doc =
  let status_div = create_styled_div doc "connection-status" in
  let update_status () =
    status_div##.innerHTML := Js.string (
      if !connect then "Connected" else "Disconnected"
    );
    status_div##.className := Js.string (
      "status-pill " ^ if !connect then "connected" else "disconnected"
    )
  in
  update_status ();
  status_div
  
let create_control_status_widget doc =
  let widget = create_styled_div doc "control-status-widget" in
  
  (* Create control panel *)
  let header = create_styled_div doc "control-status-header" in
  let indicator = create_styled_div doc "control-indicator" in
  
  let status_dot = create_styled_div doc "status-dot no-control" in
  status_dot##.id := Js.string "control-status-dot";
  
  let status_text = Dom_html.createDiv doc in
  status_text##.id := Js.string "control-status-text";
  status_text##.className := Js.string "status-text";
  status_text##.textContent := Js.some (Js.string "No Control");
  
  let details = create_styled_div doc "control-details" in
  details##.id := Js.string "control-details";
  details##.textContent := Js.some (Js.string "The telescope is not being controlled");
  
  (* Create action buttons *)
  let actions = create_styled_div doc "control-actions" in
  
  let take_button = Dom_html.createInput ~_type:(Js.string "button") doc in
  take_button##.value := Js.string "Take Control";
  take_button##.id := Js.string "take-control-button";
  take_button##.className := Js.string "control-button take";
  
  let release_button = Dom_html.createInput ~_type:(Js.string "button") doc in
  release_button##.value := Js.string "Release Control";
  release_button##.id := Js.string "release-control-button";
  release_button##.className := Js.string "control-button release";
  
  (* Assemble the widget *)
  Dom.appendChild indicator status_dot;
  Dom.appendChild indicator status_text;
  Dom.appendChild header indicator;
  Dom.appendChild widget header;
  Dom.appendChild widget details;
  Dom.appendChild actions take_button;
  Dom.appendChild actions release_button;
  Dom.appendChild widget actions;

  (* Add debug logging *)
  if !verbose then debug "Control widget created";
  widget

(* Modified control panel *)
let create_control_panel doc callback =
  let panel = create_styled_div doc "control-panel" in
  (* Add the control status widget at the top *)
  let control_status = create_control_status_widget doc in

  Dom.appendChild panel control_status;
  
  let buttons = [
    ("Take Control", (fun _ -> action := TakeControl; Js._false));
    ("Release Control", (fun _ -> action := ReleaseControl; Js._false));
    ("Initialize", (fun _ -> action := Init; Js._false));
    ("Observe", (fun _ -> action := Observe; Js._false));
    ("Park", (fun _ -> action := Park; Js._false));
    ("Open arm", (fun _ -> action := Openarm; Js._false));
    ("Status", (fun _ -> action := Status; Js._false));
    ("Consume", (fun _ -> action := Consume; Js._false));
  ] in

  List.iter
    (fun (text, onclick) ->
      let btn = create_button doc text onclick in
      btn##.disabled := Js._false;
      Dom.appendChild panel btn)
    buttons;
  panel

  let create_message_panel doc =
  let panel = create_styled_div doc "message-panel" in
  panel##.id := Js.string "telescope-messages";
  panel

 let element i _ =
  let elems = Dom_html.document##getElementsByClassName (Js.string "tab-content-item") in
  for j = 0 to (elems##.length - 1) do
    Js.Opt.iter (elems##item j) (fun el ->
      Js.Opt.iter (Dom_html.CoerceTo.element el) (fun e ->
        e##.style##.display := Js.string (if j = i then "block" else "none")
      )
    )
  done;
  let btns = Dom_html.document##getElementsByClassName (Js.string "tab-btn") in
  for j = 0 to (btns##.length - 1) do
    Js.Opt.iter (btns##item j) (fun el ->
      Js.Opt.iter (Dom_html.CoerceTo.element el) (fun b ->
        b##.className := Js.string ("tab-btn" ^ if j = i then " active" else "")
      )
    )
  done;
  Js._false
;;	     
let iterate doc tab_buttons tab_content i (title, content) =  
    let btn = create_button doc title (element i) in
    btn##.className := Js.string ("tab-btn" ^ if i = 0 then " active" else "");
    Dom.appendChild tab_buttons btn;
    
    let content_div = create_styled_div doc ("tab-content-item" ^ if i = 0 then " active" else "") in
    content_div##.style##.display := Js.string (if i = 0 then "block" else "none");
    Dom.appendChild content_div content;
    Dom.appendChild tab_content content_div
;;
let create_status_display doc =
  let status_grid = create_styled_div doc "status-grid" in
  let create_status_item label value =
    let item = create_styled_div doc "status-item" in
    let label_span = Dom_html.createDiv doc in
    let value_span = Dom_html.createDiv doc in
    label_span##.innerHTML := Js.string label;
    value_span##.innerHTML := Js.string value;
    Dom.appendChild item label_span;
    Dom.appendChild item value_span;
    item
  in
  List.iter
    (fun (label, value) -> Dom.appendChild status_grid (create_status_item label value))
    [ ("RA", !entry_ra_ref);
      ("DEC", !entry_dec_ref);
      ("Alt", !entry_alt_ref);
      ("Az", !entry_az_ref) ];
      status_grid
      
let create_tabs doc content_list =
  let tabs_container = create_styled_div doc "tabs-container" in
  let tab_buttons = create_styled_div doc "tab-buttons" in
  let tab_content = create_styled_div doc "tab-content" in
  
  List.iteri (iterate doc tab_buttons tab_content) content_list;
  
  Dom.appendChild tabs_container tab_buttons;
  Dom.appendChild tabs_container tab_content;
  tabs_container
let apply_styles doc =
  let style = Dom_html.createStyle doc in
  style##.innerHTML := Js.string {|
    .tabs-container {
      width: 100%;
      max-width: 800px;
      margin: 0 auto;
      padding: 20px;
    }
    .tab-buttons {
      display: flex;
      gap: 4px;
      border-bottom: 1px solid #ddd;
      margin-bottom: 20px;
    }
    .tab-btn {
      padding: 8px 16px;
      border: none;
      background: none;
      cursor: pointer;
      border-radius: 4px 4px 0 0;
      font-size: 14px;
    }
    .tab-btn.active {
      background: #007bff;
      color: white;
    }
    .tab-content-item {
      display: none;
    }
    .tab-content-item.active {
      display: block;
    }
    .status-pill {
      display: inline-block;
      padding: 4px 12px;
      border-radius: 12px;
      font-size: 14px;
      margin-bottom: 12px;
    }
    .connected {
      background: #10b981;
      color: white;
    }
    .disconnected {
      background: #ef4444;
      color: white;
    }
    .message-panel {
      height: 200px;
      overflow-y: auto;
      background: #f8f9fa;
      border: 1px solid #ddd;
      border-radius: 4px;
      padding: 8px;
      margin-top: 12px;
    }
    .message {
      padding: 4px 8px;
      margin: 4px 0;
      border-radius: 4px;
    }
    .error {
      background: #fee2e2;
      color: #991b1b;
    }
    .info {
      background: #dbeafe;
      color: #1e40af;
    }
    .telescope-display {
      display: flex;
      flex-direction: column;
      gap: 1rem;
      padding: 1rem;
    }
    .status-section {
      background: #fff;
      border: 1px solid #ddd;
      border-radius: 4px;
      padding: 1rem;
    }
    .section-title {
      font-weight: bold;
      margin-bottom: 0.5rem;
    }
    .status-row {
      display: flex;
      justify-content: space-between;
      padding: 0.25rem 0;
    }
    .status-label {
      color: #666;
    }

    /* Control Status Widget Styles */
    .control-status-widget {
      background: #f8f9fa;
      border: 1px solid #ddd;
      border-radius: 4px;
      padding: 12px;
      margin-bottom: 16px;
    }
    
    .control-status-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 8px;
    }
    
    .control-indicator {
      display: flex;
      align-items: center;
      gap: 8px;
    }
    
    .status-dot {
      width: 10px;
      height: 10px;
      border-radius: 50%;
    }
    
    .status-dot.no-control { background-color: #666666; }
    .status-dot.has-control { background-color: #10b981; }
    .status-dot.requesting { background-color: #f59e0b; }
    .status-dot.other-control { background-color: #ef4444; }
    
    .control-details {
      font-size: 14px;
      color: #666;
    }

    .control-actions {
      display: flex;
      gap: 8px;
    }

    .control-button {
      padding: 6px 12px;
      border-radius: 4px;
      border: none;
      cursor: pointer;
      font-size: 14px;
      transition: background-color 0.2s;
    }

    .control-button.take {
      background-color: #10b981;
      color: white;
    }

    .control-button.release {
      background-color: #ef4444;
      color: white;
    }

    .control-button:disabled {
      opacity: 0.5;
      cursor: not-allowed;
    }
  |};
Dom.appendChild doc##.head style

let handle_connect callback status_div _ =
  callback true;
  let status_div = Dom_html.getElementById_opt "connection-status" in
  Option.iter (fun div ->
    div##.innerHTML := Js.string "Connected";
    div##.className := Js.string "status-pill connected"
  ) status_div;
  Js._false

let handle_action action_type _ =
  action := action_type;
  Js._false

(* Add periodic updates *)
let start_control_updates () =
  let rec update_loop () =
    let%lwt () = Lwt_js.sleep 0.5 in
    update_control_display ();
    update_loop ()
  in
  ignore (update_loop ())
  
let modern_gui doc =
  apply_styles doc;
  
  let control_panel = create_control_panel doc (fun connected -> connect := connected) in
  let message_panel = create_message_panel doc in
  Dom.appendChild control_panel message_panel;
  let status_display = create_status_display doc in
  let object_select = create_styled_div doc "input-group" in
  let input = Dom_html.createInput ~_type:(Js.string "text") doc in
  input##.className := Js.string "input-field";
  input##.placeholder := Js.string "Enter Messier object (e.g., M31)";
  Dom.appendChild object_select input;
  
  start_control_updates ();  (* Start periodic updates *)
  
  create_tabs doc [
    ("Control", control_panel);
    ("Telescope", create_telescope_display doc);
    ("Position", status_display);
    ("Object", object_select)
  ]
    
let is_secure_session () = 
Js.to_string Dom_html.window##.location##.protocol = "https:"

let onload _ =
  let doc = Dom_html.window##.document in
  let main = Js.Opt.get (doc##getElementById (Js.string "openstellina"))
  (fun () -> assert false) in
  Dom.appendChild doc##.body canvas;
  Dom.appendChild main (modern_gui doc);
  if is_secure_session () then Geo.geo();
  Js._false

let _ = Dom_html.window##.onload := Dom_html.handler onload
