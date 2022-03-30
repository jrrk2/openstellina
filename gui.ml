(* Stellina expert App *)

(* online simulator is here:

http://159.65.87.230/sim2/http/v1/app/status

*)

open GMain
open GdkKeysyms
open Graph
open Lwt

type session = {sid:string; ping_int: int; ping_tim: int }

let verbose = ref false

let server = "192.168.0.36:"
let pth2' = "8082"
let pth3' = "8083"
let start = ref 0


(*
let server = "159.65.87.230/sim1/"
let pth2' = "http"
let pth3' = "socket"
let start = ref 0
*)

let timezone = List.rev (String.split_on_char '/' (Unix.readlink "/etc/localtime"))

let session' = ref {sid=""; ping_int=0; ping_tim=0}
let statush = Hashtbl.create 32767
let status_line = Array.init 6 (fun ix -> GEdit.entry ())

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

let cnv body =
  let len = String.length body in
  let max = try int_of_string (Sys.getenv "MAX_DEBUG") with err -> 0 in
  if max > 0 then print_endline ("cnv:" ^ (if len < max then body else String.sub body 0 max));
  try Yojson.Basic.from_string (cnv' body) with err -> `String body

let session = function
| `Assoc
    [("sid", `String sid);
     ("upgrades", `List [`String "websocket"]); ("pingInterval", `Int ping_int);
     ("pingTimeout", `Int ping_tim)] -> { sid; ping_int; ping_tim }
| oth -> failwith ("session: "^Yojson.Basic.to_string oth)

let show = Quests.Response.show
let id = "OpenStellina"
let name = "Jonathans iMac"
let polling = "polling"
let eio = "3"
let t' = "NzboPSr"
let params' = [ ("id", id); ("name", name); ("EIO", eio); ("transport", polling); ("t", t') ]
let headers = [ ("Content-Type", "text/plain; charset=utf-8") ]
let split = List.map (fun itm -> let ix = String.index itm ':' in (String.sub itm 0 ix, String.sub itm (ix+2) (String.length itm - ix - 4)))
let pth = pth3'^"/socket.io/"
let cookie = ref []
let hdrs = ref []

let rec errchklst' (arg:string*Yojson.Basic.t) = match arg with
| (kw', `List errlst) -> let errlst' = List.mapi (fun ix (itm) -> (kw'^"["^string_of_int ix^"]", itm)) errlst in List.iter (errchklst') errlst'
| (kw', `Assoc lst) -> let lst' = List.map (fun (kw,itm) -> (kw' ^ "@" ^ kw, itm)) lst in List.iter (errchklst') lst'
| (kw', json) -> Hashtbl.replace statush kw' json

and errchklst = function
| `Assoc errlst -> List.iter (errchklst') errlst
| oth -> failwith "errchklst"

let rec errchk' (arg:Yojson.Basic.t) = match arg with
| `String "" -> ()
| `String "ok" -> ()
| `Assoc
    [("sid", `String _);
     ("upgrades", `List _);
     ("pingInterval", `Int _);
     ("pingTimeout", `Int _)] -> ()
| `List errlst -> List.iter (errchk') errlst
| `String s -> ()
| `Bool b -> ()
| `Null -> ()
| `Float f -> ()
| `Int _ -> ()
| `Assoc errlst -> List.iter (errchklst') errlst
(*
| oth -> failwith "errchk'"
*)

let get' ix params headers pth f =
  Quests.get ("http://"^server^""^pth)
    ~params:(params)
    ~headers:(headers)
  >|= ( fun arg -> hdrs := Cohttp.Header.to_list (Quests.Response.headers arg); Quests.Response.content arg) >|= f

let post' ix params headers pth form =
  Quests.post ("http://"^server^""^pth)
    ~params:(params)
    ~headers:(headers)
    ~data:(form)
  >|= Quests.Response.content >|= (fun s -> errchk' (cnv s))

let get1' ix =
    get' ix params' headers pth (fun s -> session' := session (cnv s))

let post2' ix =
    cookie := List.filter (function ("Content-Length", _) -> false | _ -> true) !hdrs;
    let params = (("sid", (!session').sid) :: params') in
    let time_ms_str = string_of_int (int_of_float (Unix.time() *. 1000.0)) in
    post' ix params headers pth (Quests.Request.Raw ("44:420[\"message\",\"setSystemTime\","^time_ms_str^"]"))

let get3' ix =
    let params = ("sid", (!session').sid) :: [ ("id", id); ("name", name); ("EIO", eio); ("transport", "websocket") ] in
    let headers = split ["Upgrade: websocket"; "Connection: Upgrade";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148";
      "Origin: http://localhost:8080";
      "Accept-Encoding: gzip, deflate"; "Cache-Control: no-cache";
      "Sec-WebSocket-Extensions: permessage-deflate";
      "Accept-Language: en-GB,en;q=0.9"; "Sec-WebSocket-Version: 13";
      "Sec-WebSocket-Key: U3EsKacH/DvIMkbPXUr92Q=="; "Accept: */*";
      "Pragma: no-cache" (*; "Host: "^ipaddr^":8083" *) ] in
    get' ix params headers pth (fun s -> errchk' (cnv s))

let get4' ix =
    let params = (("sid", (!session').sid) :: params') in
    let headers = split ["Accept-Encoding: gzip, deflate";
      "Referer: http://localhost:8080/";
      "Accept-Language: en-GB,en;q=0.9";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148";
      "Accept: application/json";
      "Connection: keep-alive"] in
    get' ix params headers pth (fun s -> errchk' (cnv s))

let post5' ix =
    let params = (("sid", (!session').sid) :: params') in
    let headers = !cookie @ split [
      "Access-Control-Allow-Origin: http://localhost:8080";
      "Access-Control-Allow-Credentials: true";
      "Content-Encoding: gzip"] in
    post' ix params headers pth (Quests.Request.Raw ("31:421[\"message\",\"getStatus\",null]"))

let get6' ix =
    let params = (("sid", (!session').sid) :: params') in
    let headers = split ["Accept-Encoding: gzip, deflate";
      "Referer: http://localhost:8080/";
      "Accept-Language: en-GB,en;q=0.9";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148";
      "Accept: */*"; "Connection: keep-alive"] in
    get' ix params headers pth (fun s -> errchk' (cnv s))

let status' ix =
    let params = [] in
    let headers = split 
   ["Content-Type: application/json";
    "Origin: http://localhost:8080";
    "Accept-Encoding: gzip, deflate";
    "Connection: keep-alive";
    "Accept: application/json, text/plain, */*";
    "Accept-Language: en-GB,en;q=0.9"] in
    let pth = pth2'^"/v1//logs/consume" in
    post' ix params headers pth (Quests.Request.Raw ("{}"))

(*
let post8' ix =
    let params = [] in
    let headers = split 
   ["Content-Type: application/json";
    "Origin: http://localhost:8080";
    "Accept-Encoding: gzip, deflate";
    "Connection: keep-alive";
    "Accept: application/json, text/plain, */*";
    "Accept-Language: en-GB,en;q=0.9"] in
    let pth = pth2'^"/v1//expertMode/startStorageAcquisition" in
    post' ix params headers pth (Quests.Request.Json ( `Assoc
  [("path", `String "expert-mode/raw-images"); ("overwrite", `Bool true);
   ("numExposures", `Int 100); ("gain", `Int 200);
   ("exposureMicroSec", `Int 60000000); ("flip", `String "BOTH")] ))

let post8' ix =
    let pth = pth2'^"/v1//general/openForMaintenance" in
    post' ix [] [] pth (Quests.Request.Raw "{}")

let post9' ix =
    let params = [] in
    let headers = split 
   ["Content-Type: application/json";
    "Origin: http://localhost:8080";
    "Accept-Encoding: gzip, deflate";
    "Connection: keep-alive";
    "Accept: application/json, text/plain, */*";
    "Accept-Language: en-GB,en;q=0.9"] in
    let pth = pth2'^"/v1//general/openForMaintenance" in
    post' ix params headers pth (Quests.Request.Raw "{}")
*)

let obj_id = ref ""
let obj_nam = ref ""
let xflip = ref "BOTH"
let xgain = ref 200
let entry_ra = ref (GEdit.entry ())
let entry_dec = ref (GEdit.entry ())
let entry_lat = ref (GEdit.entry ())
let entry_long = ref (GEdit.entry ())
let entry_darkcnt = ref (GEdit.entry ())

let gain_int = ref 200
let expos_flt = ref 10.0
let cnv_ra fmt = print_endline fmt; Scanf.sscanf fmt "%f %f %f" (fun a b c -> a *. 15.0 +. b /. 4.0 +. c /. 240.0)
let cnv_dec fmt = print_endline fmt; try Scanf.sscanf fmt "%f %f %f" (fun a b c -> a +. b /. 60.0 +. c /. 3600.0) with err -> Scanf.sscanf fmt "%f %f" (fun a b -> a +. b /. 60.0)

let init' ix =
    let pth = pth2'^"/v1//general/startAutoInit" in
    let time_ms = int_of_float (Unix.time() *. 1000.0) in
    let lat_flt = float_of_string !entry_lat#text in
    let long_flt = float_of_string !entry_long#text in
    post' ix [] [] pth (Quests.Request.Json (`Assoc
    [("latitude", `Float lat_flt);
     ("longitude", `Float long_flt); ("time", `Int time_ms)] ))

let observe' ix =
    let pth = pth2'^"/v1//general/startObservation" in
    let ra_flt = cnv_ra !entry_ra#text in
    let dec_flt = cnv_dec !entry_dec#text in
    print_endline (string_of_float ra_flt^" "^string_of_float dec_flt);
    post' ix [] [] pth (Quests.Request.Json (`Assoc
    [("ra", `Float ra_flt); ("de", `Float dec_flt);
     ("rot", `Int 0); ("objectId", `String !obj_id);
     ("objectName", `String !obj_nam); ("gain", `Int !gain_int);
     ("exposureMicroSec", `Int (int_of_float (floor (!expos_flt *. 1000000.0)))); ("doStacking", `Bool true);
     ("histogramEnabled", `Bool true); ("histogramLow", `Float (-0.75));
     ("histogramMedium", `Int 5); ("histogramHigh", `Int 0);
     ("backgroundEnabled", `Bool true); ("backgroundPolyorder", `Int 4)]))

let darks' ix =
    let pth = pth2'^"/v1//expertMode/startStorageAcquisition" in
    let xpth = "expert-mode/gain"^string_of_int !xgain in
    post' ix [] [] pth (Quests.Request.Json (`Assoc
    [("path", `String xpth);
     ("overwrite", `Bool true);
     ("numExposures", `Int (int_of_string (!entry_darkcnt#text)));
     ("gain", `Int !xgain);
     ("exposureMicroSec", `Int (int_of_float (floor (!expos_flt *. 1000000.0))));
     ("flip", `String !xflip)]))

let focus' ix =
    let pth = pth2'^"/v1//general/adjustObservationFocus" in
    post' ix [] [] pth (Quests.Request.Raw "{}")

let stopobs' ix =
    let pth = pth2'^"/v1//general/stopObservation" in
    post' ix [] [] pth (Quests.Request.Raw "{}")

(*
let status'' ix =
    let pth = pth2'^"/v1//app/status" in
    get' ix [] [] pth (fun s -> errchk' (cnv s))
*)

let park' ix =
    let pth = pth2'^"/v1//general/park" in
    post' ix [] [] pth (Quests.Request.Raw "{}")

let jpegh = Hashtbl.create 127

let fetch' ix =
    let jhash = ref ("",ref false) in
    Hashtbl.iter (fun k x -> if !x then () else jhash := (k,x)) jpegh;
    snd !jhash := true;
    let jpeg = fst !jhash in
    print_endline ("Fetching: "^ jpeg);
    let pth = pth2'^"/"^jpeg in
    let headers = split ["Accept-Encoding: gzip, deflate";
      "Referer: http://localhost:8080/";
      "Accept-Language: en-GB,en;q=0.9";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148";
      "Accept: */*"; "Connection: keep-alive"] in
    let f = fun s -> let pth = String.rindex jpeg '/' in
                     let pth' = String.sub jpeg (pth+1) (String.length jpeg - pth - 1) in
                     print_endline ("Dumping: "^pth');
                     let fd = open_out pth' in
                     output_string fd s;
                     close_out fd in
    get' ix [] headers pth f

let taskarray =
       [|
         ("get1", get1');
         ("post2", post2');
         ("get3", get3');
         ("get4", get4');
         ("post5", post5');
         ("get6", get6');
         ("post7", status');
(*
         ("post8", post8');
         ("post9", post9');
*)
         ("", status');
         ("init", init');
         ("", status');
         ("observe", observe');
         ("", status');
         ("focus", focus');
         ("", status');
         ("stopobs", stopobs');
         ("", status');
         ("park", park');
         ("", status');
         ("darks", darks');
         ("", status');
(*
         ("status''", status'');
         ("", status');
*)
         ("fetch", fetch');
         ("", status');
       |]

let stoptask = Array.length taskarray - 1

let err ix errmsg =
    if !ix <> stoptask then print_endline ("terminating at step "^string_of_int !ix^" due to error "^errmsg);
    ix := stoptask

let jpegadd s =
 print_endline ("jpegadd: "^s);
 if Hashtbl.mem jpegh s then () else Hashtbl.add jpegh s (ref false);
 status_line.(5)#set_text s

let quit' = ref false

let sm_jump lbl' = Array.iteri (fun ix (lbl, _) -> if lbl=lbl' then (start := ix; if !verbose then print_endline (string_of_int (ix+1)^": "^lbl'))) taskarray

let update_status' kw stat =
  match Hashtbl.find_opt statush kw with
    | None -> ()
    | Some x -> stat#set_text (Yojson.Basic.to_string x)

let update_status () =
  update_status' "motors@AZ@state" status_line.(0);
  update_status' "motors@ALT@state" status_line.(1);
  update_status' "motors@MAP@state" status_line.(2);
  update_status' "motors@MAP@position" status_line.(3);
  update_status' "currentOperation@type" status_line.(4);
  update_status' "previousOperations@observation@capture@images@url" status_line.(5);
  ()

let rec iter_a ix a =
  match a.(!ix) with
  | ("post8'", x) -> ix := Array.length a - 1; iter_a ix a
  | ("", x) ->
    if !quit' then
        Lwt.return_unit
    else
        begin
        Hashtbl.iter (fun k x -> if !x then () else sm_jump "fetch") jpegh;
        update_status ();
        let waiting = false in
        Lwt_engine.iter waiting;
        Lwt.apply (fun f -> f !ix) x >>= fun () -> iter_a ix a
        end
  | (lbl, x) -> incr ix;
    let f = fun f -> let cnt = string_of_int !ix in print_endline (cnt^": "^lbl); f !ix in
    Lwt.apply f x >>= fun () ->
    iter_a ix a

let font = Printexc.print Pango.Font.from_string "Sans 12"
(*
let color = ref (`RGB (0, 65535, 0)) 
*)

let app_quit' () = quit' := true

let button_pressed drawingarea ev = true

let catsel = ref 0

let cnv_latlong latlong = 
  match latlong.[String.length latlong - 1] with
    | 'N' -> float_of_string (String.sub latlong 0 (String.length latlong - 1))
    | 'E' -> float_of_string (String.sub latlong 0 (String.length latlong - 1))
    | 'W' -> -. float_of_string (String.sub latlong 0 (String.length latlong - 1))
    | 'S' -> -. float_of_string (String.sub latlong 0 (String.length latlong - 1))

let app_status' () =
 let fd = open_out "logfile.txt" in
 Hashtbl.iter (fun k x -> output_string fd (k^": "^Yojson.Basic.to_string x^"\n")) statush;
 close_out fd

let gui () = 
  (* Initializes GTK. *)
  ignore (GMain.init ());

  (* Install Lwt<->Glib integration. *)
  Lwt_glib.install ();

  let window = GWindow.window ~width:800 ~height:600
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
  ignore (button2#connect#clicked ~callback: (fun () -> sm_jump "init"));

  (* Button3 *)
  let button3 = GButton.button ~label:"Park"
                              ~packing:boxu#add () in
  ignore (button3#connect#clicked ~callback: (fun () -> sm_jump "park"));

  (* Button4 *)
  let button4 = GButton.button ~label:"Stop Observation"
                              ~packing:boxu#add () in
  ignore (button4#connect#clicked ~callback: (fun () -> sm_jump "stopobs"));

  (* Button5 *)
  let button5 = GButton.button ~label:"Observe"
                              ~packing:boxh#add () in
  ignore (button5#connect#clicked ~callback: (fun () -> sm_jump "observe"));

  let boxe = GPack.vbox ~spacing:2 ~border_width: 10 ~packing: boxh#add () in
  let frame_ra = GBin.frame ~label: "Right ascension"
            ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) () in

  entry_ra := GEdit.entry ~max_length: 20 ~packing: frame_ra#add ();
(*
  !entry_ra#connect#activate ~callback:(fun () -> print_endline "entry_ra");
  !entry_ra#select_region ~start:0 ~stop:entry_ra#text_length;
*)

  let frame_dec = GBin.frame ~label: "Declination"
            ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) () in
  entry_dec := GEdit.entry ~max_length: 20 ~packing: frame_dec#add ();
(*
  !entry_dec#connect#activate ~callback:(fun () -> print_endline "entry_dec");
  !entry_dec#select_region ~start:0 ~stop:entry_dec#text_length;
*)

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

  (* Button6 *)
  let button6 = GButton.button ~label:"Refocus"
                              ~packing:boxh#add () in
  ignore (button6#connect#clicked ~callback: (fun () -> sm_jump "focus"));

  (* Range1 *)
  let fram_rng = GBin.frame ~label: "Exposure"
            ~packing:(box2#pack ~expand:true ~fill:true ~padding:2) () in
  let adj = GData.adjustment ~lower:0.1 ~upper:70.0 ~step_incr:1. ~page_incr:10. ~value:10. () in
  let rng = GRange.scale `HORIZONTAL ~adjustment:adj ~draw_value:true ~packing:fram_rng#add () in
  rng#connect#change_value ~callback:(fun _ v -> expos_flt := v);

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
  button1#connect#clicked ~callback:(fun () -> xflip := "true");

  let button2 = GButton.radio_button ~group:button1#group ~label:"no_flip"
      ~packing: box3#add () in
  button2#connect#clicked ~callback:(fun () -> xflip := "false");

  let button3 = GButton.radio_button
      ~group:button1#group ~label:"both" ~active:true ~packing: box3#add () in
  button3#connect#clicked ~callback:(fun () -> xflip := "BOTH");

  let frame_darkcnt = GBin.frame ~label: "Dark Frame Count"
            ~packing:(box3#pack ~expand:true ~fill:true ~padding:2) () in
  entry_darkcnt := GEdit.entry ~max_length: 20 ~packing: frame_darkcnt#add ();
  !entry_darkcnt#set_text "100";

  let separator =
    GMisc.separator `HORIZONTAL ~packing: vbox#pack () in

  (* Button2 *)
  let button2 = GButton.button ~label:"Generate darks"
                              ~packing:box3#add () in
  ignore (button2#connect#clicked ~callback: (fun () -> sm_jump "darks"));

  let ttmp = GBin.frame ~label:"Target Source" ~packing:vbox#pack () in
  let tbox = GPack.vbox ~border_width:5 ~packing:ttmp#add () in

  let options =
    [ "Messier Catalogue (built in)" ;
      "Manual RA/DEC entry" ;
      "Stellarium link"
    ] in
  let combobox,(_,column) = GEdit.combo_box_text ~strings:options ~packing:tbox#pack () in
  combobox#connect#changed
    (fun () ->
      match combobox#active_iter with
      | None -> ()
      | Some row -> 
          let data = combobox#model#get ~row ~column in
          List.iteri (fun ix itm -> if itm = data then catsel := ix) options;
          match !catsel with 
           | 0 -> !entry_ra#set_editable false; !entry_dec#set_editable false
           | 1 -> !entry_ra#set_editable true; !entry_dec#set_editable true
           | 2 -> !entry_ra#set_editable false; !entry_dec#set_editable false);
  catsel := 0;
  combobox#set_active !catsel ;

  let tmp2 = GBin.frame ~label:"Target (alias), RA, DEC" ~packing:vbox#pack () in
  let cbox = GPack.vbox ~border_width:5 ~packing:tmp2#add () in
  let cat = List.mapi (fun ix (cat,rahms,decdms) -> let cat' = string_of_int (ix+1) in "M"^cat'^(if cat' <> String.trim(String.sub cat 1 (String.length cat -1)) then " ("^cat^")" else "") ) (Array.to_list Messier_catalogue.messier_array) in
  let (combo, (_, column)) = 
    GEdit.combo_box_text ~packing:cbox#pack 
      ~strings:cat () in
  combo#connect#changed
    (fun () ->
      match combo#active_iter with
      | None -> ()
      | Some row -> 
          let data = combo#model#get ~row ~column in
          List.iteri (fun ix itm -> if itm = data && !catsel = 0 then
          let (cat,rahms,decdms) = Messier_catalogue.messier_array.(ix) in
          !entry_ra#set_text rahms;
          !entry_dec#set_text decdms) cat);
  combo#set_active 50 ;

  let tzcity = List.hd (List.tl timezone)  ^ "/" ^ List.hd timezone in
  let obox = GPack.hbox ~border_width:10 ~packing:vbox#add () in
  let vbox' = GPack.vbox ~border_width:10 ~packing:obox#add () in
  let obs = "Observatory location" in
  let frame_obs = GBin.frame ~label: obs ~packing:vbox'#pack () in
  let obox' = GPack.vbox ~border_width:5 ~packing:frame_obs#add () in
  let tz = "TimeZone" in
  let frame_tz = GBin.frame ~label:tz ~packing:vbox'#pack () in
  let tz' = GEdit.entry ~max_length: 30 ~packing: frame_tz#add () in
  tz'#set_text tzcity;
  tz'#set_editable false;

  let llbox = GPack.vbox ~spacing:1 ~border_width: 10 ~packing: obox#add () in
  let frame_lat = GBin.frame ~label: "Latitude"
            ~packing:(llbox#pack ~expand:true (* ~fill:false ~padding:0 *) ) () in

  entry_lat := GEdit.entry ~max_length: 20 ~packing: frame_lat#add ();
  let frame_long = GBin.frame ~label: "Longitude"
            ~packing:(llbox#pack ~expand:true (* ~fill:false ~padding:0 *) ) () in
  entry_long := GEdit.entry ~max_length: 20 ~packing: frame_long#add ();

  let cities' = List.sort compare (List.filter (fun (a,b,c,d,e,f,g,h,i,j,k,l) -> j=tzcity && (match d with | "L" | "I" | "A" | "O" -> false | _ -> true)) Base_locations.base_locations) in
  let latitude,longitude = try float_of_string (Sys.getenv "LATITUDE"), 
    float_of_string (Sys.getenv "LONGITUDE") with err ->  51.477777, 0.001388 in
  let prev = ref 1000.0 in
  let deflt = ref 0 in
  let cities = List.mapi (fun ix (a,b,c,d,e,f,g,h,i,j,k,l) ->
     let f' = cnv_latlong f in
     let g' = cnv_latlong g in
     let nearest = sqrt((latitude -. f') *. (latitude -. f') +. ((longitude -. g') *. (longitude -. g'))) in
     if nearest < !prev then ( prev := nearest; deflt := ix );
     a^", "^b) cities' in
  let model, text_column = GTree.store_of_list Gobject.Data.string cities in
  let combo = GEdit.combo_box_entry ~text_column ~model ~packing:obox'#pack () in
  let loc_jump lbl' = List.iteri (fun ix loc -> if loc=lbl' then
    begin
    deflt := ix;
    let (a,b,c,d,e,f,g,h,i,j,k,l) = List.nth cities' ix in
    let f' = cnv_latlong f in
    let g' = cnv_latlong g in
    let lat' = string_of_float f' in
    let long' = string_of_float g' in
    !entry_lat#set_text lat';
    !entry_long#set_text long';
    if !verbose then print_endline (string_of_int ix^": "^lat'^", "^long')
    end) cities in
  combo#entry#connect#changed 
    (fun () -> loc_jump combo#entry#text) ;
  combo#set_active !deflt;

  let boxs = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: vbox#add () in

  let lbls = [|
 "AZ Status";
 "ALT Status";
 "Focus Status";
 "Focus pos";
 "Focus cal";
 "JPEG"
|] in

  for i = 0 to 4 do
  let frame_stat = GBin.frame ~label: lbls.(i)
            ~packing:(boxs#pack ~expand:false ~fill:false ~padding:0) () in

  status_line.(i) <- GEdit.entry ~max_length: 12 ~packing: frame_stat#add ();
  status_line.(i)#set_editable false;
  done;

  let frame_jpeg = GBin.frame ~label: "JPEG file"
            ~packing:(vbox#pack ~expand:false ~fill:false ~padding:0) () in

  status_line.(5) <- GEdit.entry ~max_length: 80 ~packing: frame_jpeg#add ();
  status_line.(5)#set_editable false;

  (* Show the window. *)
  window#show ()

let tasks = gui(); iter_a start taskarray

let run () = Lwt_main.run tasks

let _ = run()
