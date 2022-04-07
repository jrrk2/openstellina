(* Stellina expert App *)

(* online simulator is here:

http://159.65.87.230/sim2/http/v1/app/status

*)

open Lwt

type session = {sid:string; ping_int: int; ping_tim: int }

let server = (try Sys.getenv "STELLINA_IP" with _ -> "10.0.0.1")^":"
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

(* Initializes GTK. *)
let _ = GMain.init ()
(* Install Lwt<->Glib integration. *)
let _ = Lwt_glib.install ()
let window = GWindow.window ~width:1000 ~height:800 ~title:"Openstellina GUI demo" ()
let vbox = GPack.vbox ~packing:window#add ()
(* Menu bar *)
let menubar = GMenu.menu_bar ~packing:vbox#pack ()
let factory = new GMenu.factory menubar
let accel_group = factory#accel_group
let file_menu = factory#add_submenu "File"
let stell_menu = factory#add_submenu "Stellina"
(* File menu *)
let factory_fil = new GMenu.factory file_menu ~accel_group
(* Stellina menu *)
let factory_stell = new GMenu.factory stell_menu ~accel_group

let box2 = GPack.vbox ~spacing:2 ~border_width: 10 ~packing: vbox#add ()
let boxu = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: box2#add ()
let boxh = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: box2#add ()

(* Button1 *)
let button1 = GButton.button ~label:"Open Arm" ~packing:boxu#add ()

(* Button2 *)
let button2 = GButton.button ~label:"Auto Initialise" ~packing:boxu#add ()

(* Button3 *)
let button3 = GButton.button ~label:"Park" ~packing:boxu#add ()

(* Button4 *)
let button4 = GButton.button ~label:"Stop Observation" ~packing:boxu#add ()

(* Button5 *)
let button5 = GButton.button ~label:"Observe" ~packing:boxh#add ()

let _= GPack.vbox ~spacing:2 ~border_width: 10 ~packing: boxh#add ()
let frame_ra = GBin.frame ~label: "Right ascension" ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) ()

let entry_ra = GEdit.entry ~max_length: 20 ~packing: frame_ra#add ()

let frame_dec = GBin.frame ~label: "Declination" ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) ()
let entry_dec = GEdit.entry ~max_length: 20 ~packing: frame_dec#add ()

(* Button6 *)
let button6 = GButton.button ~label:"Refocus" ~packing:boxh#add ()

(* Range1 *)
let fram_rng = GBin.frame ~label: "Exposure" ~packing:(box2#pack ~expand:true ~fill:true ~padding:2) ()
let adj = GData.adjustment ~lower:0.1 ~upper:70.0 ~step_incr:1. ~page_incr:10. ~value:10. ()
let rng = GRange.scale `HORIZONTAL ~adjustment:adj ~draw_value:true ~packing:fram_rng#add ()

let framx = GBin.frame ~label: "Dark frames" ~packing:(box2#pack ~expand:true ~fill:true ~padding:2) ()

let box3 = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: framx#add ()

let rbutton1 = GButton.radio_button ~label:"flip" ~packing: box3#add ()
let rbutton2 = GButton.radio_button ~group:rbutton1#group ~label:"no_flip" ~packing: box3#add ()
let rbutton3 = GButton.radio_button ~group:rbutton1#group ~label:"both" ~active:true ~packing: box3#add ()

let frame_darkcnt = GBin.frame ~label: "Dark Frame Count" ~packing:(box3#pack ~expand:true ~fill:true ~padding:2) ()
let entry_darkcnt = GEdit.entry ~max_length: 20 ~packing: frame_darkcnt#add ()

let _ = GMisc.separator `HORIZONTAL ~packing: vbox#pack ()

(* Button2 *)
let dbutton2 = GButton.button ~label:"Generate darks" ~packing:box3#add ()

let ttmp = GBin.frame ~label:"Target Source" ~packing:vbox#pack ()
let tbox = GPack.vbox ~border_width:5 ~packing:ttmp#add ()

let options =
    [ "Messier Catalogue (built in)" ;
      "Manual RA/DEC entry" ;
      "Stellarium link"
    ]
let combobox,(_,column) = GEdit.combo_box_text ~strings:options ~packing:tbox#pack ()
let tmp2 = GBin.frame ~label:"Target (alias), RA, DEC" ~packing:vbox#pack ()
let cbox = GPack.vbox ~border_width:5 ~packing:tmp2#add ()
let tzcity = List.hd (List.tl timezone)  ^ "/" ^ List.hd timezone
let obox = GPack.hbox ~border_width:10 ~packing:vbox#add ()
let vbox' = GPack.vbox ~border_width:10 ~packing:obox#add ()
let obs = "Observatory location"
let frame_obs = GBin.frame ~label: obs ~packing:vbox'#pack ()
let obox' = GPack.vbox ~border_width:5 ~packing:frame_obs#add ()
let tz = "TimeZone (from O/S)"
let frame_tz = GBin.frame ~label:tz ~packing:vbox'#pack ()
let tz' = GEdit.entry ~max_length: 30 ~packing: frame_tz#add ()
let check = GButton.check_button ~label: "Verbose" ~active: false ~packing: vbox'#add ()
let llbox = GPack.vbox ~spacing:1 ~border_width: 10 ~packing: obox#add ()
let frame_lat = GBin.frame ~label: "Latitude" ~packing:(llbox#pack ~expand:true (* ~fill:false ~padding:0 *) ) ()
let entry_lat = GEdit.entry ~max_length: 20 ~packing: frame_lat#add ()
let frame_long = GBin.frame ~label: "Longitude" ~packing:(llbox#pack ~expand:true (* ~fill:false ~padding:0 *) ) ()
let entry_long = GEdit.entry ~max_length: 20 ~packing: frame_long#add ()
let _ = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: vbox#add ()
let status_win (box':GPack.box array) lbls =
  Array.init (Array.length lbls) (fun ix ->
  let lmax = 30 in
  let trans = Trans.trans lbls.(ix) in
  let llen = String.length trans in
  let slbl = if llen < lmax then trans else String.sub trans (llen-lmax) lmax in
  if check#active then print_endline slbl;

  let frame_stat = GBin.frame ~label: slbl
            ~packing:(box'.(ix)#pack ~expand:true ~fill:true ~padding:0) () in

  let stat = GEdit.entry ~max_length: 24 ~packing: frame_stat#add () in
  stat#set_editable false;
  stat)
(*
let status_line =
let lbls = [|
 "AZ Status";
 "ALT Status";
 "Focus Status";
 "Message";
 "Message2";
|] in
status_win (Array.init (Array.length lbls) (fun ix -> boxs)) lbls
*)

let visible_extra = Array.of_list (Hidemsg.remove' Msgs.msgs)
let crntbox () = GPack.hbox ~spacing:1 ~border_width: 5 ~packing: vbox#add ()
let crnt' = ref (crntbox())
let boxa = Array.init (Array.length visible_extra) (fun ix -> let rslt = !crnt' in if ix mod 5 = 4 then crnt' := crntbox(); rslt)
let status_extra = status_win boxa visible_extra

let frame_jpeg = GBin.frame ~label: "JPEG file" ~packing:(vbox#pack ~expand:false ~fill:false ~padding:0) ()
let status_jpeg = GEdit.entry ~max_length: 80 ~packing: frame_jpeg#add ()

let cnv' body =
  let trim = try int_of_string (String.sub body 0 (String.index body ':')) with _ -> String.length body in
  let lftidx1 = if String.contains body '{' then String.index body '{' else String.length body in
  let lftidx2 = if String.contains body '[' then String.index body '[' else String.length body in
  let lftidx = min lftidx1 lftidx2 in
  let body = String.sub body lftidx (min trim (String.length body - lftidx)) in
  let rghtidx1 = if String.contains body '}' then String.rindex body '}' else 0 in
  let rghtidx2 = if String.contains body ']' then String.rindex body ']' else 0 in
  let rghtidx = max rghtidx1 rghtidx2 in
  let body = if rghtidx+1 < String.length body then String.sub body 0 (rghtidx + 1) else body in
  body

let logfile = open_out "json.log"

let cnv body' =
  let body = cnv' body' in
  try if body <> "" then Yojson.Basic.from_string body else `String ""
  with err -> output_string logfile ("Exception: "^Printexc.to_string_default err^"\n"^body'^"\n"^body^"\n"); flush logfile ; `String body

let session = function
| `Assoc
    [("sid", `String sid);
     ("upgrades", `List [`String "websocket"]); ("pingInterval", `Int ping_int);
     ("pingTimeout", `Int ping_tim)] -> { sid; ping_int; ping_tim }
| oth -> failwith ("session: "^Yojson.Basic.to_string oth)

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

let rec errchklst' user (arg:string*Yojson.Basic.t) = match arg with
| (kw', `List errlst) -> let errlst' = List.mapi (fun ix (itm) -> (kw'^"["^string_of_int ix^"]", itm)) errlst in List.iter (errchklst' user) errlst'
| (kw', `Assoc lst) -> let lst' = List.map (fun (kw,itm) -> (kw' ^ "@" ^ kw, itm)) lst in List.iter (errchklst' user) lst'
| (kw', `String s) -> Hashtbl.replace statush (if user then kw' else "!"^kw') s
| (kw', `Bool b) -> Hashtbl.replace statush (if user then kw' else "!"^kw') (string_of_bool b)
| (kw', `Null) -> Hashtbl.replace statush (if user then kw' else "!"^kw') "empty"
| (kw', `Float f) -> Hashtbl.replace statush (if user then kw' else "!"^kw') (string_of_float f)
| (kw', `Int i) -> Hashtbl.replace statush (if user then kw' else "!"^kw') (string_of_int i)
(*
and errchklst user = function
| `Assoc errlst -> List.iter (errchklst' user) errlst
| oth -> failwith "errchklst"
*)
let errchk' user (arg:Yojson.Basic.t) = errchklst' user ("R", arg)

let get' _ params headers pth f =
  Quests.get ("http://"^server^""^pth)
    ~params:(params)
    ~headers:(headers)
  >|= ( fun arg -> hdrs := Cohttp.Header.to_list (Quests.Response.headers arg); Quests.Response.content arg) >|= f

let post' user _ params headers pth form =
  Quests.post ("http://"^server^""^pth)
    ~params:(params)
    ~headers:(headers)
    ~data:(form)
  >|= Quests.Response.content >|= (fun s -> errchk' user (cnv s))

let get1' ix =
    get' ix params' headers pth (fun s -> session' := session (cnv s))

let post2' ix =
    cookie := List.filter (function ("Content-Length", _) -> false | _ -> true) !hdrs;
    let params = (("sid", (!session').sid) :: params') in
    let time_ms_str = string_of_int (int_of_float (Unix.time() *. 1000.0)) in
    post' true ix params headers pth (Quests.Request.Raw ("44:420[\"message\",\"setSystemTime\","^time_ms_str^"]"))

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
    get' ix params headers pth (fun s -> errchk' true (cnv s))

let get4' ix =
    let params = (("sid", (!session').sid) :: params') in
    let headers = split ["Accept-Encoding: gzip, deflate";
      "Referer: http://localhost:8080/";
      "Accept-Language: en-GB,en;q=0.9";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148";
      "Accept: application/json";
      "Connection: keep-alive"] in
    get' ix params headers pth (fun s -> errchk' true (cnv s))

let post5' ix =
    let params = (("sid", (!session').sid) :: params') in
    let headers = !cookie @ split [
      "Access-Control-Allow-Origin: http://localhost:8080";
      "Access-Control-Allow-Credentials: true";
      "Content-Encoding: gzip"] in
    post' true ix params headers pth (Quests.Request.Raw ("31:421[\"message\",\"getStatus\",null]"))

let get6' ix =
    let params = (("sid", (!session').sid) :: params') in
    let headers = split ["Accept-Encoding: gzip, deflate";
      "Referer: http://localhost:8080/";
      "Accept-Language: en-GB,en;q=0.9";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148";
      "Accept: */*"; "Connection: keep-alive"] in
    get' ix params headers pth (fun s -> errchk' true (cnv s))

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
    post' false ix params headers pth (Quests.Request.Raw ("{}"))

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
    post' true ix params headers pth (Quests.Request.Json ( `Assoc
  [("path", `String "expert-mode/raw-images"); ("overwrite", `Bool true);
   ("numExposures", `Int 100); ("gain", `Int 200);
   ("exposureMicroSec", `Int 60000000); ("flip", `String "BOTH")] ))

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
    post' true ix params headers pth (Quests.Request.Raw "{}")
*)

let obj_id = ref ""
let obj_nam = ref ""
let xflip = ref "BOTH"
let xgain = ref 200

let gain_int = ref 200
let expos_flt = ref 10.0
let cnv_ra fmt = if check#active then print_endline fmt; Scanf.sscanf fmt "%f %f %f" (fun a b c -> a *. 15.0 +. b /. 4.0 +. c /. 240.0)
let cnv_dec fmt = if check#active then print_endline fmt; try Scanf.sscanf fmt "%f %f %f" (fun a b c -> a +. b /. 60.0 +. c /. 3600.0) with _ -> Scanf.sscanf fmt "%f %f" (fun a b -> a +. b /. 60.0)

let init' ix =
    let pth = pth2'^"/v1//general/startAutoInit" in
    let time_ms = int_of_float (Unix.time() *. 1000.0) in
    let lat_flt = float_of_string entry_lat#text in
    let long_flt = float_of_string entry_long#text in
    post' true ix [] [] pth (Quests.Request.Json (`Assoc
    [("latitude", `Float lat_flt);
     ("longitude", `Float long_flt); ("time", `Int time_ms)] ))

let observe' ix =
    let pth = pth2'^"/v1//general/startObservation" in
    let ra_flt = cnv_ra entry_ra#text in
    let dec_flt = cnv_dec entry_dec#text in
    if check#active then print_endline (string_of_float ra_flt^" "^string_of_float dec_flt);
    post' true ix [] [] pth (Quests.Request.Json (`Assoc
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
    post' true ix [] [] pth (Quests.Request.Json (`Assoc
    [("path", `String xpth);
     ("overwrite", `Bool true);
     ("numExposures", `Int (int_of_string (entry_darkcnt#text)));
     ("gain", `Int !xgain);
     ("exposureMicroSec", `Int (int_of_float (floor (!expos_flt *. 1000000.0))));
     ("flip", `String !xflip)]))

let focus' ix =
    let pth = pth2'^"/v1//general/adjustObservationFocus" in
    post' true ix [] [] pth (Quests.Request.Raw "{}")

let stopobs' ix =
    let pth = pth2'^"/v1//general/stopObservation" in
    post' true ix [] [] pth (Quests.Request.Raw "{}")

(*
let status'' ix =
    let pth = pth2'^"/v1//app/status" in
    get' ix [] [] pth (fun s -> errchk' true (cnv s))
*)

let openarm' ix =
    let pth = pth2'^"/v1//general/openForMaintenance" in
    post' true ix [] [] pth (Quests.Request.Raw "{}")

let park' ix =
    let pth = pth2'^"/v1//general/park" in
    post' true ix [] [] pth (Quests.Request.Raw "{}")

let jpegh = Hashtbl.create 127

let fetch' ix =
    let jhash = ref ("",ref false) in
    Hashtbl.iter (fun k x -> if !x then () else jhash := (k,x)) jpegh;
    snd !jhash := true;
    let jpeg = fst !jhash in
    if check#active then print_endline ("Fetching: "^ jpeg);
    let pth = pth2'^"/"^jpeg in
    let headers = split ["Accept-Encoding: gzip, deflate";
      "Referer: http://localhost:8080/";
      "Accept-Language: en-GB,en;q=0.9";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148";
      "Accept: */*"; "Connection: keep-alive"] in
    let f = fun s -> let pth = String.rindex jpeg '/' in
                     let pth' = String.sub jpeg (pth+1) (String.length jpeg - pth - 1) in
                     if check#active then print_endline ("Dumping: "^pth');
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
         ("openarm", openarm');
         ("", status');
       |]
(*
let stoptask = Array.length taskarray - 1

let err ix errmsg =
    if !ix <> stoptask then print_endline ("terminating at step "^string_of_int !ix^" due to error "^errmsg);
    ix := stoptask
*)
(*
let jpegadd s =
 if check#active then print_endline ("jpegadd: "^s);
 if Hashtbl.mem jpegh s then () else Hashtbl.add jpegh s (ref false);
 status_jpeg#set_text s
*)
let quit' = ref false

let sm_jump lbl' = Array.iteri (fun ix (lbl, _) -> if lbl=lbl' then (start := ix; if check#active then print_endline (string_of_int (ix+1)^": "^lbl'))) taskarray

let update_status' kw stat =
  match Hashtbl.find_opt statush kw with
    | None -> ()
    | Some x -> stat#set_text x

let update_status () =
(*
  update_status' "success" status_line.(0);
  update_status' "error@name" status_line.(1);
  update_status' "update@state" status_line.(2);
  update_status' "message" status_line.(3);
  update_status' "result@message" status_line.(4);
*)
  update_status' "previousOperations@observation@capture@images@url" status_jpeg;
  Array.iteri (fun ix itm -> update_status' itm status_extra.(ix)) visible_extra;
  ()

let usleep t = ignore (Unix.select [] [] [] t)

let rec iter_a ix a =
  match a.(!ix) with
  | ("post8'", _) -> ix := Array.length a - 1; iter_a ix a
  | ("", x) ->
    if !quit' then
        Lwt.return_unit
    else
        begin
        Hashtbl.iter (fun _ x -> if !x then () else sm_jump "fetch") jpegh;
        update_status ();
        usleep 0.1;
        let waiting = false in
        Lwt_engine.iter waiting;
        Lwt.apply (fun f -> f !ix) x >>= fun () -> iter_a ix a
        end
  | (lbl, x) -> incr ix;
    let f = fun f -> let cnt = string_of_int !ix in print_endline (cnt^": "^lbl); f !ix in
    Lwt.apply f x >>= fun () ->
    iter_a ix a
(*
let font = Printexc.print Pango.Font.from_string "Sans 12"

let color = ref (`RGB (0, 65535, 0)) 
*)

let app_quit' () = quit' := true
(*
let button_pressed drawingarea ev = true
*)
let catsel = ref 0

let cnv_latlong latlong = 
  match latlong.[String.length latlong - 1] with
    | 'N' -> float_of_string (String.sub latlong 0 (String.length latlong - 1))
    | 'E' -> float_of_string (String.sub latlong 0 (String.length latlong - 1))
    | 'W' -> -. float_of_string (String.sub latlong 0 (String.length latlong - 1))
    | 'S' -> -. float_of_string (String.sub latlong 0 (String.length latlong - 1))
    | _ -> failwith "cnv_latlong"

let app_status' () =
 let fd = open_out "logfile.txt" in
 Hashtbl.iter (fun k x -> output_string fd (k^": "^x^"\n")) statush;
 close_out fd

let gui () = 

  ignore @@ factory_fil#add_item "Quit" ~callback: app_quit';
  ignore @@ factory_stell#add_item "Status" ~callback: app_status';
(* Quit when the window is closed. *)
  ignore (window#connect#destroy ~callback: app_quit');
  ignore (button1#connect#clicked ~callback: (fun () -> sm_jump "openarm"));
  ignore (button2#connect#clicked ~callback: (fun () -> sm_jump "init"));
  ignore (button3#connect#clicked ~callback: (fun () -> sm_jump "park"));
  ignore (button4#connect#clicked ~callback: (fun () -> sm_jump "stopobs"));
  ignore (button5#connect#clicked ~callback: (fun () -> sm_jump "observe"));
  ignore (button6#connect#clicked ~callback: (fun () -> sm_jump "focus"));
  ignore (rng#connect#change_value ~callback:(fun _ v -> expos_flt := v));
  ignore (rng#set_digits 2); (*decimal digits*)
  ignore (rbutton1#connect#clicked ~callback:(fun () -> xflip := "true"));
  ignore (rbutton2#connect#clicked ~callback:(fun () -> xflip := "false"));
  ignore (rbutton3#connect#clicked ~callback:(fun () -> xflip := "BOTH"));
  entry_darkcnt#set_text "100";
  ignore (dbutton2#connect#clicked ~callback: (fun () -> sm_jump "darks"));

  let cb = fun () ->
      match combobox#active_iter with
      | None -> ()
      | Some row -> 
          let data = combobox#model#get ~row ~column in
          List.iteri (fun ix itm -> if itm = data then catsel := ix) options;
          match !catsel with 
           | 0 -> entry_ra#set_editable false; entry_dec#set_editable false
           | 1 -> entry_ra#set_editable true; entry_dec#set_editable true
           | 2 -> entry_ra#set_editable false; entry_dec#set_editable false
           | _ -> () in
  ignore (combobox#connect#changed ~callback: cb);
  catsel := 0;
  combobox#set_active !catsel ;

  let cat = List.mapi (fun ix (cat,_,_) -> let cat' = string_of_int (ix+1) in "M"^cat'^(if cat' <> String.trim(String.sub cat 1 (String.length cat -1)) then " ("^cat^")" else "") ) (Array.to_list Messier_catalogue.messier_array) in
  let (combo, (_, column)) = 
    GEdit.combo_box_text ~packing:cbox#pack 
      ~strings:cat () in
  ignore (combo#connect#changed ~callback:
    (fun () ->
      match combo#active_iter with
      | None -> ()
      | Some row -> 
          let data = combo#model#get ~row ~column in
          List.iteri (fun ix itm -> if itm = data && !catsel = 0 then
          let (cat,rahms,decdms) = Messier_catalogue.messier_array.(ix) in
          obj_id := cat;
          obj_nam := cat;
          entry_ra#set_text rahms;
          entry_dec#set_text decdms) cat));
  combo#set_active 50 ;

  tz'#set_text tzcity;
  tz'#set_editable false;


  let cities' = List.sort compare (List.filter (fun (_,_,_,d,_,_,_,_,_,j,_,_) -> j=tzcity && (match d with | "L" | "I" | "A" | "O" -> false | _ -> true)) Base_locations.base_locations) in
  let latitude,longitude = try float_of_string (Sys.getenv "LATITUDE"), 
    float_of_string (Sys.getenv "LONGITUDE") with _ ->  51.477777, 0.001388 in
  let prev = ref 1000.0 in
  let deflt = ref 0 in
  let cities = List.mapi (fun ix (a,b,_,_,_,f,g,_,_,_,_,_) ->
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
    let (_,_,_,_,_,f,g,_,_,_,_,_) = List.nth cities' ix in
    let f' = cnv_latlong f in
    let g' = cnv_latlong g in
    let lat' = string_of_float f' in
    let long' = string_of_float g' in
    entry_lat#set_text lat';
    entry_long#set_text long';
    if check#active then print_endline (string_of_int ix^": "^lat'^", "^long')
    end) cities in
  ignore (combo#entry#connect#changed ~callback:
    (fun () -> loc_jump combo#entry#text)) ;
  combo#set_active !deflt;
  status_jpeg#set_editable false;

  (* Show the window. *)
  window#show ()

let hms_of_float x =
    let x15 = x /. 15.0 in
    let h = floor (x15) in
    let m' = (x15 -. h) *. 60.0 in
    let m = floor (m') in
    let s = (m' -. m) *. 60.0 in
    Printf.sprintf "%d %d %d" (int_of_float h) (int_of_float m) (int_of_float s)

let dms_of_float x' =
    let neg = x' < 0.0 in
    let x = if neg then -. x' else x' in
    let d = floor (x) in
    let m' = (x -. d) *. 60.0 in
    let m = floor (m') in
    let s = (m' -. m) *. 60.0 in
    Printf.sprintf "%c%d %d %d" (if neg then '-' else '+') (int_of_float d) (int_of_float m) (int_of_float s)

let goto_received ra_int dec_int =
        let scal = 180. /. float_of_int(1 lsl 31) in
        let ra = float_of_int ra_int *. scal in
        let dec' = float_of_int dec_int *. scal in
        let dec = if dec' > 180.0 then dec' -. 360.0 else dec' in
        let rahms = hms_of_float ra in
        let decdms = dms_of_float dec in
        print_endline ("ra="^rahms^", dec="^decdms);
        catsel := 2;
        combobox#set_active !catsel ;
        entry_ra#set_text rahms;
        entry_dec#set_text decdms

let goto_rslt = ref None

let rec radix_256 buf ix wid = 
    buf.(ix) + (if wid > 1 then ((radix_256 buf (ix+1) (wid-1)) lsl 8) else 0)

let handle_message buf ix msg =
    if check#active then print_endline ("msg["^string_of_int !ix^"] : "^string_of_int (int_of_char (msg)));
    buf.(!ix) <- int_of_char (msg);
    incr ix;
    if (!ix >= 2) then
        begin
        let len = radix_256 buf 0 2 in
        if false then print_endline ("msg len : "^string_of_int len);
        if (!ix >= len) then
            begin
            let typ = radix_256 buf 2 2 in
            if check#active then print_endline ("msg complete, typ = "^string_of_int typ);
            ix := 0;
            match typ with
               | 0 -> (* goto *)
                      let client_micros = radix_256 buf 4 8 in
                      let ra_int = radix_256 buf 12 4 in
                      let dec_int = radix_256 buf 16 4 in
                      if check#active then print_endline ("ra="^string_of_int ra_int^", dec="^string_of_int dec_int^", us="^string_of_int client_micros);
                      goto_rslt := Some (goto_received ra_int dec_int);
               | oth -> print_endline ("Unknown typ: "^string_of_int oth);
            ix := 0;
            end;
        end;
    ""

let rec handle_connection ix buf ic oc () =
    if check#active then print_endline "handle_conn";
    Lwt_io.read_char_opt ic >>=
    (function Some msg ->
            let reply = handle_message buf ix msg in
            Lwt_io.write_line oc reply >>= handle_connection ix buf ic oc
              | None -> Logs_lwt.info (fun m -> m "Connection closed") >>= return)

let accept_connection conn =
    if check#active then print_endline "accept_conn";
    let ix = ref 0 in
    let buf = Array.init 256 (fun _ -> 0) in
    let fd, _ = conn in
    let ic = Lwt_io.of_fd ~mode:Lwt_io.Input fd in
    let oc = Lwt_io.of_fd ~mode:Lwt_io.Output fd in
    Lwt.on_failure (handle_connection ix buf ic oc ()) (fun e -> Logs.err (fun m -> m "%s" (Printexc.to_string e) ));
    Logs_lwt.info (fun m -> m "New connection") >>= return
 
let create_socket () =
    let open Lwt_unix in
    let sock = socket PF_INET SOCK_STREAM 0 in
    let listen_address = Unix.inet_addr_loopback in
    let port = 10000 in
    let backlog = 10 in
    let rslt = bind sock @@ ADDR_INET(listen_address, port) in
    listen sock backlog;
    sock, rslt

let create_server sock =
    let rec serve () =
        let rslt = Lwt_unix.accept sock >>= accept_connection >>= serve in
        print_endline "end of serve";
        rslt
    in serve

let tasks =
  gui();
  let sock, _ = create_socket () in
  let serve = create_server sock in
  let _ = serve() in
  iter_a start taskarray

let run () =
  Lwt_main.run tasks

let _ = run()
