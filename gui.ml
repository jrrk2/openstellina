open GMain
open GdkKeysyms
open Graph
open Lwt

type session = {sid:string; ping_int: int; ping_tim: int }

let timezone = List.rev (String.split_on_char '/' (Unix.readlink "/etc/localtime"))

let session' = ref {sid=""; ping_int=0; ping_tim=0}
let rslt = Array.init 100 (fun ix -> `Null)
let cnv' body =
  let trim = int_of_string (String.sub body 0 (String.index body ':')) in
  let lftidx1 = if String.contains body '{' then String.index body '{' else String.length body in
  let lftidx2 = if String.contains body '[' then String.index body '[' else String.length body in
  let lftidx = min lftidx1 lftidx2 in
  let body = String.sub body lftidx (min trim (String.length body - lftidx)) in
  let rghtidx1 = if String.contains body '}' then String.rindex body '}' else 0 in
  let rghtidx2 = if String.contains body ']' then String.rindex body ']' else 0 in
  let rghtidx = max rghtidx1 rghtidx2 in
  let body = String.sub body 0 (rghtidx + 1) in
  body

let cnv body = try Yojson.Basic.from_string (cnv' body) with err -> `String body

let session = function
`Assoc
    [("sid", `String sid);
     ("upgrades", `List [`String "websocket"]); ("pingInterval", `Int ping_int);
     ("pingTimeout", `Int ping_tim)] -> { sid; ping_int; ping_tim }
    | oth -> failwith "session"

let show = Quests.Response.show
let time_ms = string_of_int (int_of_float (Unix.time() *. 1000.0))
let id = "iOS_Apple_iPad8_6_472AC2D5-B6DE-53DD-A563-BF202DF3203F"
let name = "Jonathan's iMac"
let polling = "polling"
let eio = "3"
let t' = "NzboPSr"
let params' = [ ("id", id); ("name", name); ("EIO", eio); ("transport", polling); ("t", t') ]
let headers = [ ("Content-Type", "text/plain; charset=utf-8") ]
let split = List.map (fun itm -> let ix = String.index itm ':' in (String.sub itm 0 ix, String.sub itm (ix+2) (String.length itm - ix - 4)))
let pth = "8083/socket.io/"
let cookie = ref []
let hdrs = ref []

let get' ix params headers pth =
  Quests.get ("http://192.168.0.36:"^pth)
    ~params:(params)
    ~headers:(headers)
  >|= ( fun arg -> hdrs := Cohttp.Header.to_list (Quests.Response.headers arg); Quests.Response.content arg) >|= (fun s -> rslt.(ix) <- cnv s)

let post' ix params headers pth form =
  Quests.post ("http://192.168.0.36:"^pth)
    ~params:(params)
    ~headers:(headers)
    ~data:(form)
  >|= Quests.Response.content >|= (fun s -> rslt.(ix) <- cnv s)

let get1' ix =
    get' ix params' headers pth

let post2' ix =
    session' := session rslt.(1);
    cookie := List.filter (function ("Content-Length", _) -> false | _ -> true) !hdrs;
    let params = (("sid", (!session').sid) :: params') in
    post' ix params headers pth (Quests.Request.Raw ("44:420[\"message\",\"setSystemTime\","^time_ms^"]"))

let get3' ix =
    let params = ("sid", (!session').sid) :: [ ("id", id); ("name", name); ("EIO", eio); ("transport", "websocket") ] in
    let headers = split ["Upgrade: websocket\r\n"; "Connection: Upgrade\r\n";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148\r\n";
      "Origin: http://localhost:8080\r\n";
      "Accept-Encoding: gzip, deflate\r\n"; "Cache-Control: no-cache\r\n";
      "Sec-WebSocket-Extensions: permessage-deflate\r\n";
      "Accept-Language: en-GB,en;q=0.9\r\n"; "Sec-WebSocket-Version: 13\r\n";
      "Sec-WebSocket-Key: U3EsKacH/DvIMkbPXUr92Q==\r\n"; "Accept: */*\r\n";
      "Pragma: no-cache\r\n" (*; "Host: "^ipaddr^":8083\r\n" *) ] in
    get' ix params headers pth

let get4' ix =
    let params = (("sid", (!session').sid) :: params') in
    let headers = split ["Accept-Encoding: gzip, deflate\r\n";
      "Referer: http://localhost:8080/\r\n";
      "Accept-Language: en-GB,en;q=0.9\r\n";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148\r\n";
      "Accept: application/json";
      "Connection: keep-alive\r\n"] in
    get' ix params headers pth

let post5' ix =
    let params = (("sid", (!session').sid) :: params') in
    let headers = !cookie @ split [
      "Access-Control-Allow-Origin: http://localhost:8080\r\n";
      "Access-Control-Allow-Credentials: true\r\n";
      "Content-Encoding: gzip\r\n"] in
    post' ix params headers pth (Quests.Request.Raw ("31:421[\"message\",\"getStatus\",null]"))

let get6' ix =
    let params = (("sid", (!session').sid) :: params') in
    let headers = split ["Accept-Encoding: gzip, deflate\r\n";
      "Referer: http://localhost:8080/\r\n";
      "Accept-Language: en-GB,en;q=0.9\r\n";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148\r\n";
      "Accept: */*\r\n"; "Connection: keep-alive\r\n"] in
    get' ix params headers pth

let post7' ix =
    let params = [] in
    let headers = split 
   ["Content-Type: application/json";
    "Origin: http://localhost:8080";
    "Accept-Encoding: gzip, deflate";
    "Connection: keep-alive";
    "Accept: application/json, text/plain, */*";
    "Accept-Language: en-GB,en;q=0.9"] in
    let pth = "8082/v1//logs/consume" in
    post' ix params headers pth (Quests.Request.Raw ("{}"))

let post8' ix =
    let params = [] in
    let headers = split 
   ["Content-Type: application/json";
    "Origin: http://localhost:8080";
    "Accept-Encoding: gzip, deflate";
    "Connection: keep-alive";
    "Accept: application/json, text/plain, */*";
    "Accept-Language: en-GB,en;q=0.9"] in
    let pth = "8082/v1//expertMode/startStorageAcquisition" in
    post' ix params headers pth (Quests.Request.Json ( `Assoc
  [("path", `String "expert-mode/raw-images"); ("overwrite", `Bool true);
   ("numExposures", `Int 100); ("gain", `Int 200);
   ("exposureMicroSec", `Int 60000000); ("flip", `String "BOTH")] ))

let post8' ix = failwith "post8'"

let post9' ix =
    let params = [] in
    let headers = split 
   ["Content-Type: application/json";
    "Origin: http://localhost:8080";
    "Accept-Encoding: gzip, deflate";
    "Connection: keep-alive";
    "Accept: application/json, text/plain, */*";
    "Accept-Language: en-GB,en;q=0.9"] in
    let pth = "8082/v1//general/openForMaintenance" in
    post' ix params headers pth (Quests.Request.Raw "{}")

let status' ix =
    let pth = "8082/v1//app/status" in
    get' ix params' headers pth

let taskarray =
       [|
         ("get1", get1');
         ("post2", post2');
         ("get3", get3');
         ("get4", get4');
         ("post5", post5');
         ("get6", get6');
         ("post7", post7');
         ("post8", post8');
         ("post9", post9');
         ("", status');
       |]

let stoptask = Array.length taskarray - 1

let otherr = Array.init 100 (fun ix -> `Null)
let otherr' = ref ["", `Null]
let err ix errmsg =
    if !ix <> stoptask then print_endline ("terminating at step "^string_of_int !ix^" due to error "^errmsg);
    ix := stoptask

let rec errchklst' ix = function
| ("apiVersion", `String "1.0.2") -> ()
| ("atStop", `Bool false) -> ()
| ("autoInit", `Null) -> ()
| ("available", `Int available) -> ()
| ("availableReports", `Int reports) -> ()
| ("boardInDebugMode", `Bool false) -> ()
| ("bootCount", `Int bootcnt) -> ()
| ("bufferPosition", `Int bufpos) -> ()
| ("bufferSize", `Int bufsiz) -> ()
| ("calibrated", `Bool false) -> ()
| ("chain", `List errlst) -> List.iter (errchklst ix) errlst
| ("commandErrors", `List errlst) -> List.iter (errchklst ix) errlst
| ("connectedDevices", `List errlst) -> List.iter (errchklst ix) errlst
| ("ctx", `String ctx) -> ()
| ("currentOperation", `Null) -> ()
| ("data", `String "Error: Error: No such file or directory, cannot open /dev/ttyS0") -> ()
| ("data", `String "SEEK_STOP") -> ()
| ("defogStatus", `Null) -> ()
| ("dewpointDepression", `Null) -> ()
| ("elapsedTime", `Int elapsedTime) -> ()
| ("endTime", `Int endTime) -> ()
| ("id", `String _) -> ()
| ("initError", `Null) -> ()
| ("initialized", `Bool false) -> ()
| ("installedVersion", `String installed) -> ()
| ("masterDeviceId", `Null) -> ()
| ("minimumCompatibleVersion", `String minver) -> ()
| ("name", `String ("MOTORS.COMMAND_ERROR" as errmsg)) -> err ix errmsg
| ("name", `String ("MOTORS.OPERATION_FAILED" as errmsg)) -> err ix errmsg
| ("name", `String ("RUNTIME_ERROR" as errmsg)) -> err ix errmsg
| ("name", `String ("BOARD.PORT_CLOSED" as errmsg)) -> err ix errmsg
| ("name", `String _) -> ()
| ("numFiles", `Int numFiles) -> ()
| ("observation", `Null) -> ()
| ("otherCurrentOperations", `List errlst) -> List.iter (errchklst ix) errlst
| ("park", `Null) -> ()
| ("plan", `Null) -> ()
| ("position", `Int 0) -> ()
| ("potentialBatteryCandidates", `List errlst) -> List.iter (errchklst ix) errlst
| ("register", `String "MOT_STEL_CMD") -> ()
| ("shuttingDown", `Bool false) -> ()
| ("size", `Int size) -> ()
| ("startTime", `Int startTime) -> ()
| ("state", `String "IDLE") -> ()
| ("stopped", `Bool true) -> ()
| ("storageAcquisition", `Null) -> ()
| ("sunMode", `Null) -> ()
| ("telescopeId", `String telescopeId) -> ()
| ("telescopeName", `Null) -> ()
| ("timestamp", `Int timestamp) -> ()
| ("type", `String "OPEN") -> ()
| ("usb", `Null) -> ()
| ("usbFileTypes", `Null) -> ()
| ("version", `String "1.27.0") -> ()
| (_, `Assoc lst) -> List.iter (errchklst' ix) lst
| oth -> if not (List.mem oth !otherr') then otherr' := oth :: !otherr'

and errchklst ix = function
| `Assoc errlst -> List.iter (errchklst' ix) errlst
| oth -> otherr.(!ix) <- oth

let errchk' ix = function
| `String "" -> ()
| `String "ok" -> ()
| `Assoc
    [("sid", `String _);
     ("upgrades", `List _);
     ("pingInterval", `Int _);
     ("pingTimeout", `Int _)] -> ()
| `List errlst -> List.iter (errchklst ix) errlst
| oth -> otherr.(!ix) <- oth

let errchk ix = match !ix with
  | 0 -> ()
  | n -> errchk' ix (rslt.(n-1))

let quit' = ref false

let rec iter_a ix a =
  errchk ix;
  match a.(!ix) with
  | ("post8'", x) -> ix := Array.length a - 1; iter_a ix a
  | ("", x) ->
    if !quit' then
        Lwt.return_unit
    else 
        begin
        Lwt_engine.iter true;
        Lwt.apply (fun f -> f !ix) x >>= fun () ->
        iter_a ix a
        end
  | (lbl, x) -> incr ix;
    let f = fun f -> let cnt = string_of_int !ix in print_endline (cnt^":"^lbl); f !ix in
    Lwt.apply f x >>= fun () ->
    iter_a ix a

let font = Printexc.print Pango.Font.from_string "Sans 12"
(*
let color = ref (`RGB (0, 65535, 0)) 
*)

let app_quit' () = quit' := true

let app_status' () = print_endline "Status"

let button_pressed drawingarea ev = true

let catsel = ref 0

let gui () = 
  (* Initializes GTK. *)
  ignore (GMain.init ());

  (* Install Lwt<->Glib integration. *)
  Lwt_glib.install ();

  let window = GWindow.window ~width:640 ~height:480
      ~title:"Openstellina GUI demo" () in
  let vbox = GPack.vbox ~packing:window#add () in

  (* Menu bar *)
  let menubar = GMenu.menu_bar ~packing:vbox#pack () in
  let factory = new GMenu.factory menubar in
  let accel_group = factory#accel_group in
  let file_menu = factory#add_submenu "File" in
  let stell_menu = factory#add_submenu "Stellina" in

  (* File menu *)
  let factory_fil = new GMenu.factory file_menu ~accel_group in
  ignore @@ factory_fil#add_item "Quit" ~callback: app_quit';

  (* Stellina menu *)
  let factory_stell = new GMenu.factory stell_menu ~accel_group in
  ignore @@ factory_stell#add_item "Status" ~callback: app_status';

  (* Quit when the window is closed. *)
  ignore (window#connect#destroy app_quit');

  let box2 = GPack.vbox ~spacing:2 ~border_width: 10 ~packing: vbox#add () in
  let boxu = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: box2#add () in
  let boxh = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: box2#add () in

  (* Button1 *)
  let button1 = GButton.button ~label:"Open Arm"
                              ~packing:boxu#add () in
  ignore (button1#connect#clicked ~callback: (fun () -> prerr_endline "Open"));

  (* Button2 *)
  let button2 = GButton.button ~label:"Auto Initialise"
                              ~packing:boxu#add () in
  ignore (button2#connect#clicked ~callback: (fun () -> prerr_endline "Init"));

  (* Button3 *)
  let button3 = GButton.button ~label:"Park"
                              ~packing:boxu#add () in
  ignore (button3#connect#clicked ~callback: (fun () -> prerr_endline "Park"));

  (* Button4 *)
  let button4 = GButton.button ~label:"Observe"
                              ~packing:boxh#add () in
  ignore (button4#connect#clicked ~callback: (fun () -> prerr_endline "Observe"));

  let boxe = GPack.vbox ~spacing:2 ~border_width: 10 ~packing: boxh#add () in
  let frame_ra = GBin.frame ~label: "Right ascension"
            ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) () in

  let entry_ra = GEdit.entry ~max_length: 20 ~packing: frame_ra#add () in
  entry_ra#connect#activate ~callback:(fun () -> print_endline entry_ra#text);
  entry_ra#select_region ~start:0 ~stop:entry_ra#text_length;

  let frame_dec = GBin.frame ~label: "Declination"
            ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) () in
  let entry_dec = GEdit.entry ~max_length: 20 ~packing: frame_dec#add () in
  entry_dec#connect#activate ~callback:(fun () -> print_endline entry_dec#text);
  entry_dec#select_region ~start:0 ~stop:entry_dec#text_length;

(*
  let check = GButton.check_button ~label: "Editable" ~active: true
      ~packing: boxh#add () in
  check#connect#toggled
    ~callback:(fun () -> entry_ra#set_editable check#active; entry_dec#set_editable check#active);

  let check =
    GButton.check_button ~label:"Visible" ~active:true ~packing:boxh#add () in
  check#connect#toggled
    ~callback:(fun () -> entry#set_visibility check#active);
*)

  (* Button5 *)
  let button5 = GButton.button ~label:"Refocus"
                              ~packing:boxh#add () in
  ignore (button5#connect#clicked ~callback: (fun () -> prerr_endline "Refocus"));

  (* Range1 *)
  let fram_rng = GBin.frame ~label: "Exposure"
            ~packing:(box2#pack ~expand:true ~fill:true ~padding:2) () in
  let adj = GData.adjustment ~lower:0.1 ~upper:70.0 ~step_incr:1. ~page_incr:10. () in
  let rng = GRange.scale `HORIZONTAL ~adjustment:adj ~draw_value:true ~packing:fram_rng#add () in

(*
  let button = GButton.button ~label: "Close" ~packing: vbox#add () in
  button#connect#clicked ~callback:window#destroy;
  button#grab_default ();
*)

  ignore (rng#set_digits 2); (*decimal digits*)

  let framx = GBin.frame ~label: "Dark frames"
            ~packing:(box2#pack ~expand:true ~fill:true ~padding:2) () in

  let box3 = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: framx#add () in

  let button1 = GButton.radio_button ~label:"flip" ~packing: box3#add () in
  button1#connect#clicked ~callback:(fun () -> prerr_endline "Flip");

  let button2 = GButton.radio_button ~group:button1#group ~label:"no_flip"
      ~packing: box3#add () in
  button2#connect#clicked ~callback:(fun () -> prerr_endline "No flip");

  let button3 = GButton.radio_button
      ~group:button1#group ~label:"both" ~active:true ~packing: box3#add () in
  button3#connect#clicked ~callback:(fun () -> prerr_endline "Both");

  let frame_darkcnt = GBin.frame ~label: "Dark Frame Count"
            ~packing:(box3#pack ~expand:true ~fill:true ~padding:2) () in
  let entry_darkcnt = GEdit.entry ~max_length: 20 ~packing: frame_darkcnt#add () in
  entry_darkcnt#set_text "100";
  entry_darkcnt#connect#activate ~callback:(fun () -> print_endline entry_dec#text);
  entry_darkcnt#select_region ~start:0 ~stop:entry_dec#text_length;
  
  let separator =
    GMisc.separator `HORIZONTAL ~packing: vbox#pack () in


  (* Button2 *)
  let button2 = GButton.button ~label:"Generate darks"
                              ~packing:box3#add () in
  ignore (button2#connect#clicked ~callback: (fun () -> prerr_endline "generate_darks"));

  let tmp = GBin.frame ~label:"Target Source" ~packing:vbox#pack () in
  let box = GPack.vbox ~border_width:5 ~packing:tmp#add () in

  let options =
    [ "Messier Catalogue (built in)" ;
      "Manual RA/DEC entry" ;
      "Stellarium link"
    ] in
  let combobox,(_,column) = GEdit.combo_box_text ~strings:options ~packing:box#pack () in
  combobox#connect#changed
    (fun () ->
      match combobox#active_iter with
      | None -> ()
      | Some row -> 
          let data = combobox#model#get ~row ~column in
          List.iteri (fun ix itm -> if itm = data then catsel := ix) options;
          match !catsel with 
           | 0 -> entry_ra#set_editable false; entry_dec#set_editable false
           | 1 -> entry_ra#set_editable true; entry_dec#set_editable true
           | 2 -> entry_ra#set_editable false; entry_dec#set_editable false);
  catsel := 0;
  combobox#set_active !catsel ;

  let tmp = GBin.frame ~label:"Target (alias), RA, DEC" ~packing:vbox#pack () in
  let box = GPack.vbox ~border_width:5 ~packing:tmp#add () in
  let cat = List.mapi (fun ix (cat,rahms,decdms) -> let cat' = string_of_int (ix+1) in "M"^cat'^(if cat' <> String.trim(String.sub cat 1 (String.length cat -1)) then " ("^cat^"), " else ", ")^"RA="^rahms^", DEC="^decdms) (Array.to_list Messier_catalogue.messier_array) in
  let (combo, (_, column)) = 
    GEdit.combo_box_text ~packing:box#pack 
      ~strings:cat () in
  combo#connect#changed
    (fun () ->
      match combo#active_iter with
      | None -> ()
      | Some row -> 
          let data = combo#model#get ~row ~column in
          List.iteri (fun ix itm -> if itm = data && !catsel = 0 then
          let (cat,rahms,decdms) = Messier_catalogue.messier_array.(ix) in
          entry_ra#set_text rahms;
          entry_dec#set_text decdms) cat);
  combo#set_active 0 ;

  let tzcity = List.hd (List.tl timezone)  ^ "/" ^ List.hd timezone in
  let obs = tzcity ^ " Observatory, latitude, longitude" in
  let tmp = GBin.frame ~label: obs ~packing:vbox#pack () in
  let box = GPack.vbox ~border_width:5 ~packing:tmp#add () in
  let cities' = List.filter (fun (a,b,c,d,e,f,g,h,i,j,k,l) -> j=tzcity) Base_locations.base_locations in
  let cities = List.map (fun (a,b,c,d,e,f,g,h,i,j,k,l) -> a^", "^b^", LAT: "^f^", LONG: "^g) cities' in
  let model, text_column = 
    GTree.store_of_list Gobject.Data.string
      (List.sort compare cities) in
  let combo = GEdit.combo_box_entry ~text_column ~model ~packing:box#pack () in
  combo#entry#connect#changed 
    (fun () -> match combo#entry#text with "" -> () | s -> prerr_endline s) ;

  (* Show the window. *)
  window#show ()

let tasks = gui(); iter_a (ref 0) taskarray

let run () = Lwt_main.run tasks

let _ = run()
