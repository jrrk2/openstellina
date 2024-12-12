open Js_of_ocaml
open Lwt.Syntax
open Astro_utils
open Telescope
open Lwt.Infix
open Js_of_ocaml_lwt
open Js_of_ocaml_tyxml
open Tyxml_js.Html
open Geolocate

type tab_config = {
  id: string;
  label: string;
  description: string;
  content: Html_types.div Tyxml_js.Html.elt;
}

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

(* Message type and state *)
type message = {
  msg_type: string;  (* "error" or "info" *)
  text: string;
  timestamp: float;
}

let rec take n lst = 
  if n <= 0 then []
  else match lst with
    | [] -> []
    | x::xs -> x :: take (n-1) xs

let messages = ref ([] : message list)

(* Add message to the list *)
let add_message msg_type text =
  let new_message = {
    msg_type;
    text;
    timestamp = Unix.gettimeofday ()
  } in
  messages := !messages @ [new_message];
  
  (* Optional: Keep only last N messages *)
  let max_messages = 100 in
  if List.length !messages > max_messages then
    messages := List.rev (take max_messages (List.rev !messages));
    
  (* Update the message panel if it exists *)
  match Dom_html.getElementById_opt "telescope-messages" with
  | None -> ()
  | Some panel ->
      let message_element = 
        div ~a:[
          a_class ["message"; msg_type];
        ] [txt text]
      in
      let dom_msg = Tyxml_js.To_dom.of_div message_element in
      Dom.appendChild panel dom_msg;
      (* Auto-scroll to bottom *)
      panel##.scrollTop := panel##.scrollHeight

(* Helper functions *)
let show_error text = add_message "error" text
let show_info text = 
  if false then print_endline text; 
  add_message "info" text

(*
type motor_update = {
  position: float;
  state: string;
  calibrated: bool;
  at_stop: bool option; (* Only AZ has atStop *)
}
*)

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

let tab_styles = {|
/* Base Layout */
.tabs-container {
  width: 100%;
  max-width: 1200px; /* Increased from 800px */
  margin: 0 auto;
  padding: 20px;
}

/* Control Actions Layout */
.control-actions {
  display: flex;
  flex-wrap: wrap;
  gap: 4px;
  margin-top: 12px;
  justify-content: flex-start;
}

.control-button {
  padding: 8px 12px; /* Slightly increased padding */
  border-radius: 4px;
  border: none;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.2s;
  background: #e5e7eb;
  color: #374151;
  min-width: min-content; /* Ensure buttons take minimum required width */
  white-space: nowrap; /* Prevent button text from wrapping */
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .tabs-container {
    max-width: 100%;
    padding: 10px;
  }
  
  .control-actions {
    flex-wrap: wrap;
  }
  
  .control-button {
    flex: 1 1 auto;
    min-width: calc(50% - 8px); /* Two buttons per row on smaller screens */
  }
}

@media (max-width: 480px) {
  .control-button {
    min-width: 100%; /* Full width buttons on very small screens */
  }
}

  /* Base Layout */
  .tabs-container {
    width: 100%;
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
  }

  /* Tab Navigation */
  .tab-buttons {
    display: flex;
    gap: 4px;
    margin-bottom: -1px;
    position: relative;
    z-index: 1;
    border-bottom: 1px solid #ddd;
  }
  
  .tab-button-container {
    position: relative;
  }
  
  .tab-btn {
    padding: 10px 20px;
    border: 1px solid #ddd;
    border-bottom: none;
    border-radius: 8px 8px 0 0;
    background: #f0f0f0;
    cursor: pointer;
    transition: all 0.3s;
    font-size: 14px;
  }
  
  .tab-btn.active {
    background: white;
    border-bottom-color: white;
    color: #007bff;
  }
  
  .tab-tooltip {
    display: none;
    position: absolute;
    bottom: 100%;
    left: 50%;
    transform: translateX(-50%);
    background: #333;
    color: white;
    padding: 5px 10px;
    border-radius: 4px;
    font-size: 12px;
    white-space: nowrap;
    z-index: 20;
  }
  
  .tab-content {
    background: white;
    border: 1px solid #ddd;
    border-radius: 0 0 8px 8px;
    padding: 20px;
    margin-top: -1px;
  }

  .tab-content-item {
    display: none;
  }

  .tab-content-item.active {
    display: block;
  }

  /* Status Indicators */
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

  /* Message Panel */
  .message-panel {
    height: 200px;
    overflow-y: auto;
    background: #f8f9fa;
    border: 1px solid #ddd;
    border-radius: 4px;
    padding: 8px;
    margin-top: 12px;
    font-family: monospace;
    font-size: 13px;
  }
  
  .message {
    padding: 4px 8px;
    margin: 4px 0;
    border-radius: 4px;
    white-space: pre-wrap;
    word-break: break-word;
  }
  
  .message.error {
    background: #fee2e2;
    color: #991b1b;
  }
  
  .message.info {
    background: #dbeafe;
    color: #1e40af;
  }

  /* Telescope Display */
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
    margin-bottom: 1rem;
  }
  
  .section-title {
    font-weight: bold;
    margin-bottom: 0.5rem;
    color: #2563eb;
  }
  
  .status-row {
    display: flex;
    justify-content: space-between;
    padding: 0.25rem 0;
    border-bottom: 1px solid #f3f4f6;
  }
  
  .status-label {
    color: #666;
  }

  .status-value {
    font-family: monospace;
    color: #111;
  }

  /* Control Panel */
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
    flex-shrink: 0;
  }
  
  .status-dot.no-control { background-color: #666666; }
  .status-dot.has-control { background-color: #10b981; }
  .status-dot.requesting { background-color: #f59e0b; }
  .status-dot.other-control { background-color: #ef4444; }
  
  .control-details {
    font-size: 14px;
    color: #666;
    margin: 8px 0;
  }
  
  .control-actions {
    display: flex;
    gap: 8px;
    margin-top: 12px;
  }
  
  .control-button {
    padding: 6px 12px;
    border-radius: 4px;
    border: none;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
    background: #e5e7eb;
    color: #374151;
  }
  
  .control-button:hover:not(:disabled) {
    opacity: 0.9;
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
  
  .control-warning {
    margin: 8px 0;
    padding: 8px 12px;
    background: #fee2e2;
    color: #991b1b;
    border-radius: 4px;
    font-weight: bold;
  }

  /* Debug Settings */
  .debug-settings {
    padding: 16px;
    background: #f8f9fa;
    border: 1px solid #ddd;
    border-radius: 4px;
  }

  .debug-row {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 8px;
  }

  .debug-checkbox {
    width: 16px;
    height: 16px;
  }
  /* Enhanced 3D Tab Effects */
  .tab-buttons {
    display: flex;
    gap: 4px;
    margin-bottom: -1px;
    position: relative;
    z-index: 1;
    border-bottom: 1px solid #ddd;
    perspective: 1000px;
  }
  
  .tab-button-container {
    position: relative;
  }
  
  .tab-btn {
    padding: 10px 20px;
    border: 1px solid #ddd;
    border-bottom: none;
    border-radius: 8px 8px 0 0;
    background: #f0f0f0;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(.25,.8,.25,1);
    font-size: 14px;
    transform: rotateX(0deg) translateY(15px);
    box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  }
  
  .tab-btn:not(.active):hover {
    transform: rotateX(-2deg) translateY(12px);
    box-shadow: 0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
  }
  
  .tab-btn.active {
    background: white;
    border-bottom-color: white;
    color: #007bff;
    transform: rotateX(-5deg);
    box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
    z-index: 10;
  }

  .tab-content {
    background: white;
    border: 1px solid #ddd;
    border-radius: 0 0 8px 8px;
    padding: 20px;
    margin-top: -1px;
    box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
    position: relative;
    z-index: 1;
  }
  /* Picker Panels */
  .picker-panel {
    padding: 20px;
    background: #f8f9fa;
    border: 1px solid #ddd;
    border-radius: 4px;
  }

  .picker-panel select {
    width: 100%;
    padding: 8px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
  }

  .picker-button {
    padding: 8px 16px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    transition: background-color 0.2s;
  }

  .picker-button:hover {
    background: #0056b3;
  }

  /* Location Picker */
  .location-panel {
    padding: 20px;
    background: #f8f9fa;
    border: 1px solid #ddd;
    border-radius: 4px;
  }

  .location-input {
    width: 100%;
    padding: 8px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
  }

  .location-button {
    padding: 8px 16px;
    background: #28a745;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    margin-right: 8px;
    transition: background-color 0.2s;
  }

  .location-button:hover {
    background: #218838;
  }
  /* Base Layout */
  .tabs-container {
    width: 100%;
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    background: white;
    display: block !important;
    visibility: visible !important;
  }
  /* Safari-specific fixes */
  @supports (-webkit-hyphens:none) {
    .control-button {
      -webkit-appearance: none;
      display: inline-block !important;
      visibility: visible !important;
    }

    .control-actions {
      display: -webkit-flex;
      display: flex;
      -webkit-flex-wrap: wrap;
      flex-wrap: wrap;
      gap: 8px;
      margin-top: 12px;
      visibility: visible !important;
    }

    .tabs-container {
      visibility: visible !important;
      -webkit-transform: translate3d(0,0,0);
    }
  }
  .secure-connection-panel {
    padding: 20px;
    background: #f8f9fa;
    border: 1px solid #ddd;
    border-radius: 4px;
  }

  .secure-warning {
    margin: 16px 0;
    padding: 12px;
    background: #fff3cd;
    border: 1px solid #ffeeba;
    border-radius: 4px;
    color: #856404;
  }

  .secure-info {
    margin: 16px 0;
    padding: 12px;
    background: #d4edda;
    border: 1px solid #c3e6cb;
    border-radius: 4px;
    color: #155724;
  }

  .secure-redirect {
    margin-top: 12px;
    background-color: #28a745 !important;
    color: white !important;
  }

  .secure-redirect:hover {
    background-color: #218838 !important;
  }
  /* Base Layout */
  .tabs-container {
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
  }
  .secure-connection-panel {
    padding: 20px;
    background: #f8f9fa;
    border: 1px solid #ddd;
    border-radius: 4px;
  }

  .secure-warning {
    margin: 16px 0;
    padding: 12px;
    background: #fff3cd;
    border: 1px solid #ffeeba;
    border-radius: 4px;
    color: #856404;
  }

  .secure-info {
    margin: 16px 0;
    padding: 12px;
    background: #d4edda;
    border: 1px solid #c3e6cb;
    border-radius: 4px;
    color: #155724;
  }

  .secure-redirect {
    margin-top: 12px;
    background-color: #28a745 !important;
    color: white !important;
  }

  .http-redirect {
    margin-top: 12px;
    background-color: #dc3545 !important;
    color: white !important;
  }

  .control-panel.disabled {
    opacity: 0.5;
    pointer-events: none;
  }

  .control-disabled-message {
    padding: 20px;
    background: #f8d7da;
    border: 1px solid #f5c6cb;
    border-radius: 4px;
    color: #721c24;
    margin-bottom: 20px;
  }

|}

let create_styled_div ?(a=[]) contents =
  div ~a contents

let show_error text = add_message "error" text
let show_info text = add_message "info" text
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

let create_status_section titled items =
  div ~a:[a_class ["status-section"]] (
    div ~a:[a_class ["section-title"]] [txt titled] ::
    List.map (fun (label, value_ref) ->
      div ~a:[a_class ["status-row"]] [
        div ~a:[a_class ["status-label"]] [txt label];
        div ~a:[
          a_id ("status-" ^ label);
          a_class ["status-value"]
        ] [txt !value_ref]
      ]
    ) items
  )

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

let create_telescope_display () =
  div ~a:[a_class ["telescope-display"]] [
    create_status_section "System" [
      ("ID", Telescope.telescopeId);
      ("Model", Telescope.model_ref);
      ("API Version", Telescope.api_version_ref);
      ("Version", Telescope.version_ref);
      ("Boot Count", ref (string_of_int !Telescope.bootCnt));
      ("Auth", ref "Unknown");
      ("Challenge", Telescope.challengeref)
    ];

  create_status_section "Motors" [
    ("AZ Position", az_posref);
    ("AZ State", ref !motor_state_ref);
    ("ALT Position", alt_posref);
    ("ALT State", ref !motor_state_ref);
    ("DER Position", der_posref);
    ("DER State", ref !motor_state_ref);
    ("MAP Position", map_posref);
    ("MAP State", ref !motor_state_ref)
  ];

  create_status_section "Environment" [
    ("Temperature", Telescope.tempref);
    ("Temp Delta", Telescope.temperature_delta_ref);
    ("Humidity", Telescope.humref);
    ("Humidity Delta", Telescope.humidity_delta_ref);
    ("Dew Point", Telescope.dewpointref); 
    ("Dew Point Depression", Telescope.dewpointref);
    ("Defog Status", Telescope.defogref)
  ];

  create_status_section "Status" [
    ("Operation", Telescope.debugref);
    ("Error", Telescope.errorref)
  ];

  create_status_section "Storage" [
    ("System Size", Telescope.storage_system_size_ref);
    ("System Available", Telescope.storage_system_avail_ref);
    ("Data Size", Telescope.storage_data_size_ref);
    ("Data Available", Telescope.storage_data_avail_ref);
    ("Network Band", Telescope.storage_band_ref)
  ];

  create_status_section "Updates" [
    ("Installed Version", Telescope.installed_version_ref);
    ("Min Compatible", Telescope.min_compat_version_ref); 
    ("State", Telescope.update_state_ref)
  ];

  create_status_section "Current Observation" [
    ("Target", Telescope.current_target_ref);
    ("Latitude", Telescope.position_lat_ref);
    ("Longitude", Telescope.position_lon_ref) 
  ]

]

let debug_mode = ref true
let debug_flag = ref false

let create_debug_settings () =
  div ~a:[a_class ["debug-settings"]] [
    div ~a:[a_class ["section-title"]] [txt "Debug Settings"];
    div ~a:[a_class ["debug-row"]] [
      input ~a:[
        a_input_type `Checkbox;
        a_id "debug-enable";
        a_class ["debug-checkbox"];
        a_onclick (fun _ ->
          debug_flag := not !debug_flag;
          Geo.set_cookie "debug" (string_of_bool !debug_flag);
          true)
      ] ();
      label ~a:[a_label_for "debug-enable"] [txt "Enable Debug Mode"]
    ];
    div ~a:[a_class ["debug-row"]] [
      input ~a:[
        a_input_type `Checkbox;
        a_id "verbose-enable";
        a_class ["debug-checkbox"];
        a_onclick (fun _ ->
          verbose := not !verbose;
          Geo.set_cookie "verbose" (string_of_bool !verbose);
          true)
      ] ();
      label ~a:[a_label_for "verbose-enable"] [txt "Enable Verbose Logging"]
    ]
  ]

let debug_msg msg =
  if !debug_flag then begin
    if !verbose then print_endline ("DEBUG: " ^ msg);
    show_info msg
  end

let verbose_msg msg =
  if !verbose then
debug_msg msg

let update_display_value id value =
  (match Dom_html.getElementById_opt id with
  | Some element -> element##.innerHTML := Js.string value
  | None -> ())

(* Process motor updates from status message *)
let process_motors status =
  let open Yojson.Safe.Util in
  try 
    let motors = member "motors" status in
    (try
      let az = member "AZ" motors in
      let az_pos = member "position" az |> to_float in
      let az_state = member "state" az |> to_string in
      let az_stop = member "atStop" az |> to_bool_option in
      let az_cal = member "calibrated" az |> to_bool in
      debug_msg ("AZ: " ^ string_of_float az_pos ^ " " ^ az_state);
      update_display_value "status-AZ Position" (Printf.sprintf "%.2f°" az_pos);
      update_display_value "status-AZ State" az_state;
    with _ -> ());
    
    (try
      let alt = member "ALT" motors in  
      let alt_pos = member "position" alt |> to_float in
      let alt_state = member "state" alt |> to_string in
      let alt_cal = member "calibrated" alt |> to_bool in
      debug_msg ("ALT: " ^ string_of_float alt_pos ^ " " ^ alt_state);
      update_display_value "status-ALT Position" (Printf.sprintf "%.2f°" alt_pos);
      update_display_value "status-ALT State" alt_state;
    with _ -> ());
  with _ -> ()

let last_ctrl = ref (`OtherHasControl "")
let last_class = ref ""
(* Add button refs to track panel buttons *)
let button_lst =
  let trim' a = String.lowercase_ascii (if String.contains a ' ' then String.sub a 0 (String.index a ' ') else a) in
  let button' a b = 
    let c = trim' a in
    button ~a:[
      a_id (c^"-control-button");
      a_class ["control-button"; c];
      a_onclick (fun _ -> 
	action := b;
	true)
    ] [txt a] in
  [
      button' "Take Control" TakeControl;
      button' "Release" ReleaseControl;
      button' "Initialize" Init;
      button' "Observe" Observe;
      button' "Park" Park;
      button' "Open arm" Openarm;
      button' "Status" Status;
      button' "Consume" Consume
  ]

let panel_warning = ref None
let last_display_state = ref (`NoControl:control_state)

let update_control_display () =
  if !control_state <> !last_display_state then begin
    show_info (Printf.sprintf "Control state changed from %s to %s"
      (match !last_display_state with
       | `NoControl -> "NoControl"
       | `RequestingControl -> "RequestingControl"
       | `HasControl -> "HasControl" 
       | `OtherHasControl u -> "OtherHasControl:" ^ u)
      (match !control_state with
       | `NoControl -> "NoControl"
       | `RequestingControl -> "RequestingControl"
       | `HasControl -> "HasControl"
       | `OtherHasControl u -> "OtherHasControl:" ^ u));
    last_display_state := !control_state;
    (* Rest of display update code *)
  end;
  let debug_msg s = if !verbose then debug_msg ("Control update: " ^ s) in

  (* Update status dot *)
  (match Dom_html.getElementById_opt "control-status-dot" with
  | Some dot -> 
      let status_class = match !control_state with
      | `NoControl -> "status-dot no-control"  
      | `RequestingControl -> "status-dot requesting"
      | `HasControl -> "status-dot has-control"
      | `OtherHasControl _ -> "status-dot other-control"
      in
      dot##.className := Js.string status_class
  | None -> debug_msg "Could not find status dot");

  (* Update control panel buttons *)
  List.iter (fun btn' -> Js.Opt.iter (Dom_html.CoerceTo.button (Tyxml_js.To_dom.of_button btn')) (fun btn ->
    let btn_text = Js.to_string (Js.Opt.get btn##.textContent (fun () -> Js.string "")) in
    btn##.disabled := Js.bool (match !control_state with
      | `HasControl -> false 
      | `NoControl -> btn_text <> "Take Control"
      | `RequestingControl -> true
      | `OtherHasControl _ -> btn##.value = Js.string "Release"
    ))
  ) button_lst;

  (* Update warning display *)
  (match !panel_warning with
  | Some warning ->
      warning##.style##.display := Js.string (
        match !control_state with
        | `OtherHasControl device -> 
            warning##.innerHTML := Js.string ("Telescope is being controlled by: " ^ device);
            "block"
        | _ -> "none"
      )
  | None -> ());

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
  let device_info = {|id=openstellina-web&name=openstellina-web|} in
  let ws_url = (if proto = "https://" then "wss://" else "ws://") ^ server' ^ port ^
    "/socket.io/?EIO=3&transport=websocket&" ^ device_info in
  if !verbose then show_info ("Connecting WebSocket to: " ^ ws_url);
  let connected = ref false in
  let open Js_of_ocaml.WebSockets in
  try
  let ws = new%js webSocket (Js.string ws_url) in
    websocket := Some ws;
      ws##.onopen := Dom.handler (fun _ ->
        debug_msg "WebSocket connection opened";
        Js._true
      );
      
      ws##.onclose := Dom.handler (fun _ ->
        debug_msg "WebSocket connection closed";
        connect := false;
        Js._true
      );
      
      ws##.onerror := Dom.handler (fun _ ->
        debug_msg "WebSocket error occurred";
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
  debug_msg ("Received WebSocket frame: " ^ (if String.length msg < 80 then msg else String.sub msg 0 80 ^ " ..."));
  (match msg.[0] with
  | '0' -> (* Socket.IO handshake *)
      begin try
        let json = String.sub msg 1 (String.length msg - 1) in
        let handshake = Yojson.Safe.from_string json in
        let open Yojson.Safe.Util in
        sid := member "sid" handshake |> to_string;
        ping_interval := member "pingInterval" handshake |> to_int;
        ping_timeout := member "pingTimeout" handshake |> to_int;
        debug_msg (Printf.sprintf "Handshake complete - SID: %s, Ping interval: %dms, Timeout: %dms" 
          !sid !ping_interval !ping_timeout);
        connect := true;
        if !control_state = `RequestingControl then
          (match !websocket with
          | Some ws ->
              let msg = {|42["message","takeControl"]|} in
              debug_msg ("Sending take control message: " ^ msg);
              ws##send (Js.string msg)
          | None -> 
              debug_msg "Cannot take control - websocket connection lost";
              control_state := `NoControl;
              control_pending := false);
        ignore (ping_loop ())
      with e ->
        debug_msg ("Handshake parse failed: " ^ Printexc.to_string e ^ "\nMessage was: " ^ msg)
      end
  | '2' -> (* PING *)
      debug_msg "Received PING, sending PONG";
      begin match !websocket with
      | Some ws -> ws##send (Js.string "3")
      | None -> debug_msg "Cannot send PONG - no websocket connection"
      end
  | '3' -> (* PONG received *)
      debug_msg "Received PONG response";
  | '4' when String.length msg >= 2 -> 
    begin match msg.[1] with
    | '2' -> (* Socket.IO event *)
        if String.length msg > 2 then
          let event_json = String.sub msg 2 (String.length msg - 2) in
          debug_msg ("Received Socket.IO event: " ^ event_json);
          begin try
            let json = Yojson.Safe.from_string event_json in
            match json with
            | `List [`String "STATUS_UPDATED"; status] ->
                show_info "status updated";
                process_motors status;

		begin match Yojson.Safe.Util.(member "telescopeId" status |> to_string_option) with 
		| Some id when id <> !Telescope.telescopeId ->
		    new_challenge := true;
		    show_info ("New telescope ID: " ^ id);
		    Telescope.telescopeId := id
		| _ -> ()
		end;

		begin match Yojson.Safe.Util.(member "bootCount" status |> to_int_option) with
		| Some count when count <> !Telescope.bootCnt ->
		    new_challenge := true;
		    show_info ("New boot count: " ^ string_of_int count);
		    Telescope.bootCnt := count
		| _ -> ()
		end;

                (* Process challenge updates from status message *)
                begin match Yojson.Safe.Util.(member "challenge" status |> to_string_option) with
                | Some challenge when challenge <> !Telescope.challengeref ->
		    new_challenge := true;
                    show_info ("New challenge received: " ^ challenge);
                    Telescope.challengeref := challenge;
                | _ -> ()
                end;
                (* Check masterDeviceId in status update *)
		begin match Yojson.Safe.Util.(member "masterDeviceId" status |> to_string_option) with
		| Some device_id when device_id = "openstellina-web" ->
		    if !control_state <> `HasControl then (
			debug_msg "Web client getting control";
			control_state := `HasControl;
			control_owner := Some "openstellina";
			show_info "Control granted"; 
			has_control := true;
			control_pending := false;
			update_control_display ()
		    )
		| Some device_id when device_id <> "openstellina-web" ->
		    debug_msg ("Device " ^ device_id ^ " has taken control");
		    control_state := `OtherHasControl device_id;
		    control_owner := Some device_id;
		    show_info ("Control taken by: " ^ device_id);
		    has_control := false;
		    control_pending := false;
		    update_control_display ()
		| None ->
		    if !control_state <> `NoControl then (
			debug_msg "No device has control";
			control_state := `NoControl;
			control_owner := None;
			show_info "Control released";
			has_control := false;
			control_pending := false;
			update_control_display ()
		    )
		| Some device_id ->  
		    debug_msg (Printf.sprintf "Device %s has control (we are in state %s)" 
			device_id
			(match !control_state with
			 | `NoControl -> "NoControl"
			 | `RequestingControl -> "RequestingControl"
			 | `HasControl -> "HasControl"
			 | `OtherHasControl u -> "OtherHasControl:" ^ u))
		end;
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
            debug_msg ("Failed to parse event: " ^ event_json ^ "\nError: " ^ Printexc.to_string e)
          end
    | _ -> debug_msg ("Unknown type-4 message subtype: " ^ String.make 1 msg.[1] ^ "\nFull message: " ^ msg)
end
| c -> debug_msg ("Unhandled frame type: " ^ String.make 1 c ^ "\nFull message: " ^ msg))

and errchklst' user = function
  | (kw', `List [`String "message"; `String msg]) ->
      handle_socketio msg
  | (_, json) -> process_json [] json
	
and session (arg:Yojson.Safe.t) =
  debug_msg "session";
  errchklst' true ("R", arg);
  update_telescope_display ()

and ping_loop () =
  (match !websocket with
  | Some ws ->
      let* () = Lwt_js.sleep (25.0) in
      if !connect then begin
        debug_msg "Ping loop: Sending ping probe";
        ws##send (Js.string "2probe");
        let* () = ping_loop () in
        Lwt.return_unit
      end else begin
        debug_msg "Ping loop: Connection not active, stopping";
        Lwt.return_unit
      end
  | None -> 
      debug_msg "Ping loop: No websocket connection";
      Lwt.return_unit)

(* Update the take_control function to use the new state *)
let take_control () =
  debug_msg "Initiating take control sequence";
  if !sid = "" then begin
    debug_msg "No session ID - requesting new session";
    control_state := `RequestingControl;
    let* _ = get_session_id session in
    control_pending := true;
    Lwt.return_unit
  end else if !control_state = `NoControl then begin
    debug_msg "Have session ID but no control - requesting control";
    (match !websocket with
    | Some ws ->
        control_state := `RequestingControl;
        control_pending := true;
        let msg = {|42["message","takeControl"]|} in
        debug_msg ("Sending take control message: " ^ msg);
        ws##send (Js.string msg);
        Lwt.return_unit
    | None ->
        debug_msg "No websocket connection - attempting to establish";
        if connect_websocket Telescope.proto Telescope.server Telescope.pth3' then
        begin
          control_state := `RequestingControl;
          control_pending := true;
          match !websocket with
          | Some ws ->
              let msg = {|42["message","takeControl"]|} in
              debug_msg ("Sending take control message: " ^ msg);
              ws##send (Js.string msg);
              Lwt.return_unit
          | None -> 
              debug_msg "Lost websocket connection after establishment";
              control_pending := false;
              control_state := `NoControl;
              Lwt.return_unit
        end else begin
          debug_msg "Failed to establish websocket connection";
          control_state := `NoControl;
          Lwt.return_unit
        end)
  end else begin
    debug_msg (Printf.sprintf "Take control blocked - current state: %s" 
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

let create_control_status_widget () =
  div ~a:[a_class ["control-status-widget"]] [
    div ~a:[a_class ["control-status-header"]] [
      div ~a:[a_class ["control-indicator"]] [
        div ~a:[
          a_id "control-status-dot";
          a_class ["status-dot"; "no-control"]
        ] [];
        div ~a:[
          a_id "control-status-text";
          a_class ["status-text"]
        ] [txt "No Control"]
      ]
    ];
    div ~a:[
      a_id "control-details";
      a_class ["control-details"]
    ] [txt "The telescope is not being controlled"];
    div ~a:[
      a_id "control-actions";
      a_class ["control-actions"]
    ] button_lst;
    div ~a:[
      a_id "control-warning";
      a_class ["control-warning"];
      a_style "display: none;"
    ] []
]

let create_message_panel () =
  div ~a:[
    a_id "telescope-messages";
    a_class ["message-panel"]
  ] (
    List.map (fun msg ->
      div ~a:[
        a_class ["message"; msg.msg_type]
      ] [txt msg.text]
    ) !messages
  )

(* Update the control panel to be disabled in HTTPS mode *)
let create_control_panel () =
  let is_secure = Secure.is_secure_session() in
  if is_secure then
    div ~a:[a_class ["control-panel"; "disabled"]] [
      div ~a:[a_class ["control-disabled-message"]] [
        txt "Control features are not available in HTTPS mode. ";
        txt "Please switch to HTTP mode using the Security tab to access controls."
      ]
    ]
  else
    (* Original control panel implementation *)
    div ~a:[a_class ["control-panel"]] [
      create_control_status_widget ();
      div ~a:[
        a_id "control-warning";
        a_class ["control-warning"];
        a_style "display: none;"
      ] [];
      create_status_section "Motor Status" [
        ("AZ Position", az_posref);
        ("AZ State", ref !motor_state_ref);
        ("ALT Position", alt_posref);
        ("ALT State", ref !motor_state_ref)
      ];
      create_message_panel ()
    ]

let switch_tab tab_id =
  let doc = Dom_html.document in
  let tabs = doc##getElementsByClassName (Js.string "tab-btn") in
  let contents = doc##getElementsByClassName (Js.string "tab-content-item") in
  
  for i = 0 to tabs##.length - 1 do
    Js.Opt.iter (tabs##item i) (fun tab ->
      Js.Opt.iter (Dom_html.CoerceTo.element tab) (fun t ->
        if Js.to_string t##.id = (tab_id ^ "-tab") then begin
          t##.className := Js.string "tab-btn active";
          t##.style##.transform := Js.string "rotateX(-5deg)";
          ignore (t##.style##setProperty (Js.string "box-shadow") 
            (Js.string "0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23)")
            (Js.Optdef.empty));
          t##.style##.backgroundColor := Js.string "white";
          t##.style##.zIndex := Js.string "10"
        end else begin
          t##.className := Js.string "tab-btn";
          t##.style##.transform := Js.string ("rotateX(0deg) translateY(15px)");
          ignore (t##.style##setProperty (Js.string "box-shadow")
            (Js.string "0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24)")
            (Js.Optdef.empty));
          t##.style##.backgroundColor := Js.string "#f0f0f0";
          t##.style##.zIndex := Js.string "1"
        end
      )
    )
  done;

  for i = 0 to contents##.length - 1 do
    Js.Opt.iter (contents##item i) (fun content ->
      Js.Opt.iter (Dom_html.CoerceTo.element content) (fun c ->
        c##.style##.display := Js.string (
          if Js.to_string c##.id = (tab_id ^ "-content") 
          then "block" 
          else "none"
        )
      )
    )
  done;
true

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

let create_tabs tabs =
  let tab_headers = div ~a:[a_class ["tab-buttons"]] (
    List.mapi (fun i tab ->
      let base_style = if i = 0 then 
        "transform: rotateX(-5deg);" ^
        "box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);" ^
        "background-color: white;"
      else 
        "transform: rotateX(0deg) translateY(" ^ string_of_int ((i + 1) * 5) ^ "px);" ^
        "box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);" ^
        "background-color: #f0f0f0;" in

      div ~a:[a_class ["tab-button-container"]] [
        button ~a:[
          a_id (tab.id ^ "-tab");
          a_class ["tab-btn"; if i = 0 then "active" else ""];
          a_style base_style;
          a_onclick (fun _ -> switch_tab tab.id);
          a_onmouseover (fun _ ->
            let tooltip = Dom_html.getElementById (tab.id ^ "-tooltip") in
            tooltip##.style##.display := Js.string "block";
            true);
          a_onmouseout (fun _ ->
            let tooltip = Dom_html.getElementById (tab.id ^ "-tooltip") in
            tooltip##.style##.display := Js.string "none";
            true)
        ] [txt tab.label];
        div ~a:[
          a_id (tab.id ^ "-tooltip");
          a_class ["tab-tooltip"]
        ] [txt tab.description]
      ]
    ) tabs
  ) in
  
  let tab_contents = div ~a:[a_class ["tab-content"]] (
    List.mapi (fun i tab ->
      div ~a:[
        a_id (tab.id ^ "-content");
        a_class ["tab-content-item"; if tab.id = "control" then "active" else ""];  (* Make first content active *)
        a_style (if tab.id = "control" then "" else "display: none;")
      ] [tab.content]
    ) tabs
  ) in
  
  div ~a:[a_class ["tabs-container"]] [
    tab_headers;
    tab_contents
]

(*
let create_planet_picker () =
  div ~a:[a_class ["picker-panel"]] [
    div ~a:[a_class ["section-title"]] [txt "Planet Selection"];
    select ~a:[
      a_class ["planet-select"];
      a_onchange (fun _ -> 
        (* Implementation from tabbed_dialog *)
        true)
    ] (
      List.map (fun name ->
        option ~a:[a_value name] [txt name]
      ) ["Sun"; "Moon"; "Mercury"; "Venus"; "Mars"; "Jupiter"; "Saturn"; "Uranus"; "Neptune"]
    );
    button ~a:[
      a_class ["picker-button"];
      a_onclick (fun _ -> 
        (* Implementation from tabbed_dialog *)
        true)
    ] [txt "Find Major Body"]
  ]

let create_comet_picker () =
  div ~a:[a_class ["picker-panel"]] [
    div ~a:[a_class ["section-title"]] [txt "Comet Selection"];
    (* Add year dropdown *)
    select ~a:[
      a_class ["comet-year-select"];
      a_onchange (fun _ -> 
        (* Implementation from tabbed_dialog *)
        true)
    ] (
      List.map (fun (year, _) ->
        option ~a:[a_value year] [txt year]
      ) (group_comets Comets.comets)
    );
    (* Comet specific dropdown will be populated by JS *)
    select ~a:[
      a_id "comet-specific-dropdown";
      a_class ["comet-select"];
      a_style "display: none;"
    ] [];
    button ~a:[
      a_class ["picker-button"];
      a_onclick (fun _ -> 
        (* Implementation from tabbed_dialog *)
        true)
    ] [txt "Find Comet"]
  ]
*)
  
let modern_gui () =
  let tabs = [
    {
      id = "control";
      label = "Control";
      description = "Telescope control panel";
      content = create_control_panel ()
      };
    {
      id = "secure";
      label = "Security";
      description = "Connection security settings";
      content = Secure.create_secure_connection_tab ()
    };
    {
      id = "location";
      label = "Location";
      description = "Select and pick the nearest city";
      content = Location.create_location_picker ();
    };
    { 
      id = "date"; 
      label = "Date"; 
      description = "Select and pick a specific date";
      content = Tabbed_dialog.create_date_picker (); 
      };
    {
      id = "telescope";
      label = "Telescope";
      description = "Telescope status and information";
      content = create_telescope_display ()
    };
    {
      id = "planets";
      label = "Planets";
      description = "Planet picker";
      content = Tabbed_dialog.create_planet_picker ();
    };
    {
      id = "comets";
      label = "Comets";
      description = "Comet picker";
      content = Tabbed_dialog.create_comet_picker ();
    };
    {
      id = "debug";
      label = "Debug";
      description = "Debug settings and logs";
      content = create_debug_settings ()
    }
  ] in

  let version_info = div ~a:[
    a_class ["version-info"];
    a_style "text-align: right; font-size: 12px; color: #666; margin-top: 8px; font-family: monospace;"
  ] [
    txt (Version.version ^ " (" ^ Version.git_commit ^ ") •");
    txt (" Author: " ^ Version.git_author);
    txt (" Build date: " ^ Version.build_date);
  ] in

  
  div ~a:[
    a_style "max-width: 1200px; margin: 0 auto; padding: 20px;"
  ] [create_tabs tabs; br (); Table_update.table_element; version_info]

(* Remove migration code from onload since we're using cookies exclusively *)
let onload _ =
  print_endline "Starting onload";
  let doc = Dom_html.document in
  let main = Js.Opt.get (doc##getElementById (Js.string "openstellina"))
    (fun () -> print_endline "Could not find openstellina div"; assert false) in
  
  (* Add canvas for any drawing needs *)
  Dom.appendChild doc##.body canvas;
  
  (* Add styles *)
  let style = Dom_html.createStyle doc in
  style##.innerHTML := Js.string tab_styles;
  Dom.appendChild doc##.head style;
  
  (* Start control updates *)
  start_control_updates ();
  
  (* Create and mount UI *)
  let ui = modern_gui () in
  Dom.appendChild main (Tyxml_js.To_dom.of_div ui);

  (* Update julian dates *)
  let open Tabbed_dialog in
  let open Utils in
  let _ = handle_julian_date txtdate_start jd_start (format_date today) in
  let _ = handle_julian_time txttime_start jd_start (format_time today) in
  let _ = handle_julian_date txtdate_stop jd_stop (format_date tomorrow) in
  let _ = handle_julian_time txttime_stop jd_stop (format_time tomorrow) in
  Js._false

let _ = Dom_html.window##.onload := Dom_html.handler onload
