(* Stellina expert App *)

(* online simulator is here:

http://159.65.87.230/sim2/http/v1/app/status

*)

open Lwt

type session = {sid:string; ping_int: int; ping_tim: int }

let server = (try Sys.getenv "STELLINA_IP" with _ -> "10.0.0.1")^":"
let pth2' = "8082"
let pth3' = "8083"

(*
let server = "159.65.87.230/sim1/"
let pth2' = "http"
let pth3' = "socket"
*)

let start = Queue.create ()

let timezone = List.rev (String.split_on_char '/' (try Unix.readlink "/etc/localtime" with _ -> "/var/db/timezone/zoneinfo/Europe/London"))
let tzcity = try Sys.getenv "TIME_ZONE" with _ -> List.hd (List.tl timezone)  ^ "/" ^ List.hd timezone
let defcat = try int_of_string (Sys.getenv "OPENSTELLINA_DEFAULT_CATALOGUE") with _ -> 0

let session' = ref {sid=""; ping_int=0; ping_tim=0}
let statush = Hashtbl.create 32767
let connecting = ref false

(* Initializes GTK. *)
let _ = GMain.init ()
(* Install Lwt<->Glib integration. *)
let _ = Lwt_glib.install ()
let window = GWindow.window ~width:1024 ~height:1024 ~title:"Openstellina GUI by Dr Jonathan Kimmitt" ()
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
let frame_eaa = GBin.frame ~label: "Electronically assisted astronomy functions" ~packing:(box2#pack ~expand:true ~fill:true ~padding:2) ()

let boxu = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: frame_eaa#add ()
let frame_target = GBin.frame ~label: "Target object settings" ~packing:(box2#pack ~expand:true ~fill:true ~padding:2) ()
let boxt = GPack.vbox ~spacing:2 ~border_width: 10 ~packing: frame_target#add ()
let boxd = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: boxt#add ()
let boxh = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: boxt#add ()
let boxv = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: boxt#add ()
let boxs = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: boxt#add ()

(* Button0 *)
let button0 = GButton.button ~label:"Take Control" ~packing:boxu#add ()

(* Button1 *)
let button1 = GButton.button ~label:"Open Arm" ~packing:boxu#add ()

(* Button2 *)
let button2 = GButton.button ~label:"Auto Initialise" ~packing:boxu#add ()

(* Button3 *)
let button3 = GButton.button ~label:"Observe" ~packing:boxu#add ()

(* Button4 *)
let button4 = GButton.button ~label:"Refocus" ~packing:boxu#add ()

(* Button5 *)
let button5 = GButton.button ~label:"Stop Observation" ~packing:boxu#add ()

(* Button6 *)
let button6 = GButton.button ~label:"Park" ~packing:boxu#add ()

let approach = try int_of_string (Sys.getenv "APPROACH") with _ -> 0

let tim = Array.init (if approach > 0 then 8 else 6) (fun ix -> let lbl = ["Year";"Month";"Day";"Hour";"Minute";"Second";"Closest(km)";"Abs Mag"] in
let fram_tim = GBin.frame ~label: (List.nth lbl ix) ~packing:(boxd#pack ~expand:true ~fill:true ~padding:2) () in
GEdit.entry ~max_length: 20 ~packing: fram_tim#add ()) 

let datum () = fst (Unix.mktime {
       tm_year=int_of_string(tim.(0)#text) - 1900;
       tm_mon=Utils.month (tim.(1)#text) - 1;
       tm_mday=int_of_string(tim.(2)#text);
       tm_hour=int_of_string(tim.(3)#text);
       tm_min=int_of_string(tim.(4)#text);
       tm_sec=int_of_string(tim.(5)#text);
       tm_yday=0;
       tm_wday=0;
       tm_isdst=false})

let update_date yr mon dy hr min sec =
      tim.(0)#set_text (string_of_int yr);
      tim.(1)#set_text (string_of_int mon);
      tim.(2)#set_text (string_of_int dy);
      tim.(3)#set_text (string_of_int hr);
      tim.(4)#set_text (string_of_int min);
      tim.(5)#set_text (string_of_int sec)

let split_date () =
    let tm = Unix.gmtime (datum()) in
    tm.tm_year+1900,tm.tm_mon+1,tm.tm_mday,tm.tm_hour,tm.tm_min,tm.tm_sec

let reset_date tim =
    let tm = Unix.gmtime tim in
    let yr,mon,dy,hr,min,sec = tm.tm_year+1900,tm.tm_mon+1,tm.tm_mday,tm.tm_hour,tm.tm_min,tm.tm_sec in
    update_date yr mon dy hr min sec

let _= GPack.vbox ~spacing:2 ~border_width: 10 ~packing: boxh#add ()
let frame_nam = GBin.frame ~label: "Target Name" ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) ()
let entry_nam = GEdit.entry ~max_length: 20 ~packing: frame_nam#add ()

let frame_ra = GBin.frame ~label: "Right ascension" ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) ()
let entry_ra = GEdit.entry ~max_length: 20 ~packing: frame_ra#add ()

let frame_dec = GBin.frame ~label: "Declination" ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) ()
let entry_dec = GEdit.entry ~max_length: 20 ~packing: frame_dec#add ()

let frame_alt = GBin.frame ~label: "Altitude" ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) ()
let entry_alt = GEdit.entry ~max_length: 20 ~packing: frame_alt#add ()

let frame_az = GBin.frame ~label: "Azimuth" ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) ()
let entry_az = GEdit.entry ~max_length: 20 ~packing: frame_az#add ()

let frame_mag = GBin.frame ~label: "Visual magnitude" ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) ()
let entry_mag = GEdit.entry ~max_length: 10 ~packing: frame_mag#add ()

let frame_ang = GBin.frame ~label: "Angular diameter" ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) ()
let entry_ang = GEdit.entry ~max_length: 10 ~packing: frame_ang#add ()

let frame_exp = GBin.frame ~label: "Exposure (sec)" ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) ()
let entry_exp = GEdit.entry ~max_length: 10 ~packing: frame_exp#add ()

let frame_gain = GBin.frame ~label: "Gain (dB)" ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) ()
let entry_gain = GEdit.entry ~max_length: 10 ~packing: frame_gain#add ()

(*
(* Range1 *)
let fram_rng = GBin.frame ~label: "Exposure" ~packing:(boxt#pack ~expand:true ~fill:true ~padding:2) ()
let expadj = GData.adjustment ~lower:26.0 ~upper:69.0 ~step_incr:0.01 ~page_incr:0.1 ()
let rng = GRange.scale `HORIZONTAL ~adjustment:expadj ~draw_value:false ~packing:fram_rng#add ()

(* Gain *)
let fram_gain = GBin.frame ~label: "Gain" ~packing:(boxt#pack ~expand:true ~fill:true ~padding:2) ()
let gainadj = GData.adjustment ~lower:0.0 ~upper:49.0 ~step_incr:0.1 ~page_incr:1.0 ()
let gain = GRange.scale `HORIZONTAL ~adjustment:gainadj ~draw_value:false ~packing:fram_gain#add ()
*)

(* Spare1 *)
let spare = Array.init 6 (fun ix -> let lbl = ["Altitude(catalog)";"Azimuth(catalog)";"Local Siderial Time";"Hour Angle";"LST(catalog)";"HA(catalog)"] in
let fram_spare = GBin.frame ~label: (List.nth lbl ix) ~packing:(boxv#pack ~expand:true ~fill:true ~padding:2) () in
GEdit.entry ~max_length: 20 ~packing: fram_spare#add ()) 
let spare' = Array.init 6 (fun ix -> let lbl = ["Right Ascension(Jnow)";"Declination(Jnow)";"Julian Date";"JD(catalog)";"raJ2000(decimal)";"decJ2000(decimal)"] in
let fram_spare = GBin.frame ~label: (List.nth lbl ix) ~packing:(boxs#pack ~expand:true ~fill:true ~padding:2) () in
GEdit.entry ~max_length: 20 ~packing: fram_spare#add ()) 

let framprog = GBin.frame ~label: "Observation/Mosaic program" ~packing:(box2#pack ~expand:true ~fill:true ~padding:0) ()

let frame_manual = GBin.frame ~label: "Manual Alt/Az observing" ~packing:(box2#pack ~expand:true ~fill:true ~padding:0) ()

let frame_observatory = GBin.frame ~label: "Observatory settings" ~packing:(box2#pack ~expand:true ~fill:true ~padding:0) ()

let framx = GBin.frame ~label: "Dark frames" ~packing:(box2#pack ~expand:true ~fill:true ~padding:2) ()

let bbox = GPack.hbox ~border_width:5 ~packing:frame_manual#add ()

let box3 = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: framx#add ()

let radio' selfun box lst = let grp = GButton.radio_button ~label:(List.hd lst) ~packing: box#add () in
                 let a = Array.of_list (grp :: List.map (fun itm ->
                                GButton.radio_button ~group:grp#group ~label:itm ~packing: box#add ()) (List.tl lst)) in
                 List.iteri (fun ix itm -> ignore (a.(ix)#connect#clicked ~callback:(fun () -> selfun ix itm))) lst;
                 fun ix -> a.(ix)#set_active true

let xflip = ref ""
let fitselfun ix _ = let fits = [| "FLIP"; "NO_FLIP"; "BOTH" |] in xflip := fits.(ix)
let rbutton = radio' fitselfun box3 ["flip"; "no_flip"; "both"]

let frame_darkcnt = GBin.frame ~label: "Dark Frame Count" ~packing:(box3#pack ~expand:true ~fill:true ~padding:2) ()
let entry_darkcnt = GEdit.entry ~max_length: 20 ~packing: frame_darkcnt#add ()

let _ = GMisc.separator `HORIZONTAL ~packing: vbox#pack ()

(* Dark Button2 *)
let dbutton2 = GButton.button ~label:"Generate darks" ~packing:box3#add ()

let obox = GPack.hbox ~border_width:10 ~packing:frame_observatory#add ()
let vbox' = GPack.vbox ~border_width:10 ~packing:obox#add ()
let frame_obs = GBin.frame ~label:"location" ~packing:vbox'#pack ()
let obox' = GPack.vbox ~border_width:5 ~packing:frame_obs#add ()
let frame_tz = GBin.frame ~label:"TimeZone (from O/S)" ~packing:vbox'#pack ()
let tz' = GEdit.entry ~max_length: 30 ~packing: frame_tz#add ()

(* check if verbose *)
let check = GButton.check_button ~label: "Verbose" ~active: false ~packing: vbox'#add ()

let xbox = GPack.vbox ~spacing:1 ~border_width: 1 ~packing: obox#add ()
let framserv = GBin.frame ~label: "Catalogue Server" ~packing:(xbox#pack ~expand:true ~fill:true ~padding:2) ()
let boxserv = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: framserv#add ()

let catalogues = ["Simbad"; "Stellarium"; "Horizons"; "Messier"; "PGC"; "NGC2000"]
let catdefaults = [|"M51"; "M51"; "301"; "M51"; "PGC47404"; "NGC 5194"|]
let xserv = ref ""
let rselfun _ itm = xserv := String.lowercase_ascii itm
let rbuttons = radio' rselfun boxserv catalogues

let sbox = GPack.hbox ~border_width:5 ~packing:xbox#add ()
let frame_entry = GBin.frame ~label:"Target Search" ~packing:sbox#pack ()
let targ_entry = GEdit.entry ~max_length: 30 ~packing: frame_entry#add ()
let frame_status = GBin.frame ~label:"Target Result" ~packing:(sbox#pack ~expand:true ~fill:true ~padding:2) ()
let targ_status = GEdit.entry ~max_length: 60 ~packing: frame_status#add ()

let ephem_lst = List.init 25 (fun ix -> Printf.sprintf "%.2d:00" ix)

let frame_planets = GBin.frame ~label:"NASA Horizons Solar System Ephemeris" ~packing:xbox#pack ()
let pbox = GPack.hbox ~border_width:5 ~packing:frame_planets#add ()
let planet_lst = ["Mercury"; "Venus"; "Moon"; "Mars"; "Jupiter"; "Saturn"; "Uranus"; "Neptune"; "Pluto"; "Other Minor Planets"]
let pmodel, ptext_column = GTree.store_of_list Gobject.Data.string planet_lst
let planets = GEdit.combo_box_entry ~text_column:ptext_column ~model:pmodel ~packing:pbox#pack ()
let emodel, etext_column = GTree.store_of_list Gobject.Data.string ephem_lst
let ephem = GEdit.combo_box_entry ~text_column:etext_column ~model:emodel ~packing:pbox#pack ()

let llbox = GPack.hbox ~spacing:1 ~border_width: 1 ~packing: obox'#add ()
let frame_lat = GBin.frame ~label: "Latitude" ~packing:(llbox#pack ~expand:true (* ~fill:false ~padding:0 *) ) ()
let entry_lat = GEdit.entry ~max_length: 20 ~packing: frame_lat#add ()
let frame_long = GBin.frame ~label: "Longitude" ~packing:(llbox#pack ~expand:true (* ~fill:false ~padding:0 *) ) ()
let entry_long = GEdit.entry ~max_length: 20 ~packing: frame_long#add ()

(* Button7 *)
let button7 = GButton.button ~label:"Alt/Az Go" ~packing:bbox#add ()
(* Button8 *)
let button8 = GButton.button ~label:"Single Focus" ~packing:bbox#add ()
(* Button9 *)
let button9 = GButton.button ~label:"Auto Focus" ~packing:bbox#add ()
(* ButtonA *)
let buttonA = GButton.button ~label:"Single Shot" ~packing:bbox#add ()
(* ButtonB *)
let buttonB = GButton.button ~label:"Single Astrometry" ~packing:bbox#add ()
(* ButtonC *)
let buttonC = GButton.button ~label:"Track On" ~packing:bbox#add ()
(* ButtonD *)
let buttonD = GButton.button ~label:"Track Off" ~packing:bbox#add ()
(* ButtonE *)
let buttonE = GButton.button ~label:"Manual Init" ~packing:bbox#add ()
(* ButtonF *)
let buttonF = GButton.button ~label:"Read Params" ~packing:bbox#add ()

let vboxprog = GPack.vbox ~spacing:2 ~border_width: 10 ~packing: framprog#add ()
let boxprog = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: vboxprog#add ()
let eboxprog = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: vboxprog#add ()

(* add text view with scroll bars for plannet observations *)
let scroll = GBin.scrolled_window
                 ~hpolicy:`AUTOMATIC ~vpolicy:`AUTOMATIC
                 ~packing:vboxprog#add ()
let textview = GText.view ~packing:scroll#add_with_viewport ()

(* Button12 *)
let buttonProg = Array.of_list (List.map (fun itm -> GButton.button ~label:itm ~packing:boxprog#add ()) ["Write Mosaic Program";"Run Mosaic Program";"Add Target to Observation Program";"Start Observation Program";"Take Samples";"Abort All"])

(* program parameters *)
let frame_gridw = GBin.frame ~label: "Grid width" ~packing:(eboxprog#pack ~expand:true ~fill:true ~padding:0) ()
let entry_gridw = GEdit.entry ~max_length: 5 ~packing: frame_gridw#add ()
let frame_gridh = GBin.frame ~label: "Grid height" ~packing:(eboxprog#pack ~expand:true ~fill:true ~padding:0) ()
let entry_gridh = GEdit.entry ~max_length: 5 ~packing: frame_gridh#add ()
let frame_numi = GBin.frame ~label: "Num images" ~packing:(eboxprog#pack ~expand:true ~fill:true ~padding:0) ()
let entry_numi = GEdit.entry ~max_length: 5 ~packing: frame_numi#add ()
let frame_nump = GBin.frame ~label: "Num passes" ~packing:(eboxprog#pack ~expand:true ~fill:true ~padding:0) ()
let entry_nump = GEdit.entry ~max_length: 5 ~packing: frame_nump#add ()
let frame_wminov = GBin.frame ~label: "Width min overlap" ~packing:(eboxprog#pack ~expand:true ~fill:true ~padding:0) ()
let entry_wminov = GEdit.entry ~max_length: 10 ~packing: frame_wminov#add ()
let frame_hminov = GBin.frame ~label: "Height min overlap" ~packing:(eboxprog#pack ~expand:true ~fill:true ~padding:0) ()
let entry_hminov = GEdit.entry ~max_length: 10 ~packing: frame_hminov#add ()
let frame_wpassof = GBin.frame ~label: "Width pass offset" ~packing:(eboxprog#pack ~expand:true ~fill:true ~padding:0) ()
let entry_wpassof = GEdit.entry ~max_length: 10 ~packing: frame_wpassof#add ()
let frame_hpassof = GBin.frame ~label: "Height pass offset" ~packing:(eboxprog#pack ~expand:true ~fill:true ~padding:0) ()
let entry_hpassof = GEdit.entry ~max_length: 10 ~packing: frame_hpassof#add ()
let frame_duration = GBin.frame ~label: "Target Duration" ~packing:(eboxprog#pack ~expand:true ~fill:true ~padding:0) ()
let entry_duration = GEdit.entry ~max_length: 8 ~packing: frame_duration#add ()

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

let visible_extra = Array.of_list (List.sort compare (Hidemsg.remove' Msgs.msgs))
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
  output_string logfile ("cnv: "^body^"\n"); flush logfile;
  try if body <> "" then Yojson.Basic.from_string body else `String ""
  with err -> output_string logfile ("Exception: "^Printexc.to_string_default err^"\n"^body'^"\n"^body^"\n"); flush logfile ; `String body

let session = function
| `Assoc
    [("sid", `String sid);
     ("upgrades", `List [`String "websocket"]); ("pingInterval", `Int ping_int);
     ("pingTimeout", `Int ping_tim)] -> { sid; ping_int; ping_tim }
| oth -> failwith ("session: "^Yojson.Basic.to_string oth)

let name = "Jonathans iMac"
let polling = "polling"
let eio = "3"
let t' = "NzboPSr"
let params' = [ ("id", "OpenStellina"); ("name", name); ("EIO", eio); ("transport", polling); ("t", t') ]
let headers = [ ("Content-Type", "text/plain; charset=utf-8") ]
let pth = pth3'^"/socket.io/"
let cookie = ref []
let hdrs = ref []
let misclst = ref []

let rec errchklst' user (arg:string*Yojson.Basic.t) = match arg with
| (kw', `List errlst) -> let errlst' = List.mapi (fun ix (itm) -> (kw'^"["^string_of_int ix^"]", itm)) errlst in List.iter (errchklst' user) errlst'
| (kw', `Assoc lst) -> let lst' = List.map (fun (kw,itm) -> (kw' ^ "@" ^ kw, itm)) lst in List.iter (errchklst' user) lst'
| (kw', `String s) -> Hashtbl.replace statush (if user then kw' else "!"^kw') s;
  (match s with
    | "" -> ()
    | "buffer is empty" -> ()
    | _ -> if s.[0] = '{' then List.iter (fun s -> try  if s <> "" then misclst := (kw', Yojson.Basic.from_string s) :: !misclst with _ -> print_endline ("errchklst':"^s)) (String.split_on_char '\n' s)
    )
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
let proto = "http://"

let cnv' iter = fun s -> let lst = fun s ->
    let l = String.split_on_char '\n' s in
    if check#active then List.iter (fun s ->
                   if s <> "{\"success\":true,\"result\":{\"message\":\"buffer is empty\"}}" then 
                     print_endline s) l;
    l in
    List.iter iter (lst s)

let get1' () =
    let iter = fun s -> session' := session (cnv s) in
    Utils.get' proto server params' headers pth (cnv' iter) hdrs

let post2' () =
    cookie := List.filter (function ("Content-Length", _) -> false | _ -> true) !hdrs;
    let params = (("sid", (!session').sid) :: params') in
    let time_ms_str = string_of_int (int_of_float (Unix.time() *. 1000.0)) in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server params headers pth (Quests.Request.Raw ("44:420[\"message\",\"setSystemTime\","^time_ms_str^"]")) (cnv' f)

let get3' () =
    let params = ("sid", (!session').sid) :: [ ("id", "OpenStellina"); ("name", name); ("EIO", eio); ("transport", "websocket") ] in
    let headers = Utils.split ["Upgrade: websocket"; "Connection: Upgrade";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148";
      "Origin: http://localhost:8080";
      "Accept-Encoding: gzip, deflate"; "Cache-Control: no-cache";
      "Sec-WebSocket-Extensions: permessage-deflate";
      "Accept-Language: en-GB,en;q=0.9"; "Sec-WebSocket-Version: 13";
      "Sec-WebSocket-Key: U3EsKacH/DvIMkbPXUr92Q=="; "Accept: */*";
      "Pragma: no-cache" (*; "Host: "^ipaddr^":8083" *) ] in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.get' proto server params headers pth (cnv' f) hdrs

let get4' () =
    let params = (("sid", (!session').sid) :: params') in
    let headers = Utils.split ["Accept-Encoding: gzip, deflate";
      "Referer: http://localhost:8080/";
      "Accept-Language: en-GB,en;q=0.9";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148";
      "Accept: application/json";
      "Connection: keep-alive"] in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.get' proto server params headers pth (cnv' f) hdrs

let post5' () =
    let params = (("sid", (!session').sid) :: params') in
    let headers = !cookie @ Utils.split [
      "Access-Control-Allow-Origin: http://localhost:8080";
      "Access-Control-Allow-Credentials: true";
      "Content-Encoding: gzip"] in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server params headers pth (Quests.Request.Raw ("31:421[\"message\",\"getStatus\",null]")) (cnv' f)

let get6' () =
    let params = (("sid", (!session').sid) :: params') in
    let headers = Utils.split ["Accept-Encoding: gzip, deflate";
      "Referer: http://localhost:8080/";
      "Accept-Language: en-GB,en;q=0.9";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148";
      "Accept: */*"; "Connection: keep-alive"] in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.get' proto server params headers pth (cnv' f) hdrs

let status' () =
    let params = [] in
    let headers = Utils.split 
   ["Content-Type: application/json";
    "Origin: http://localhost:8080";
    "Accept-Encoding: gzip, deflate";
    "Connection: keep-alive";
    "Accept: application/json, text/plain, */*";
    "Accept-Language: en-GB,en;q=0.9"] in
    let pth = pth2'^"/v1//logs/consume" in
    let f = (fun s -> errchk' false (cnv s)) in
    if !connecting then Utils.post' proto server params headers pth (Quests.Request.Raw ("{}")) (cnv' f) else Lwt.return_unit

let obj_id = ref ""
let obj_nam = ref ""
let mos_id  = ref ""
let xflip = ref "BOTH"

let xgain = ref 200
let jpegh = Hashtbl.create 127
(*
let gain_int = ref 200
let expos_us = ref 1000000
*)
let (prog_entries:Yojson.t list ref) = ref []
let ephem_data_lst = ref []

let expos_us () = let e = try float_of_string entry_exp#text with _ -> 10.0 in entry_exp#set_text (string_of_float e); int_of_float (1000000.0 *. e)
let gain_int () = let e = try float_of_string entry_gain#text with _ -> 20.0 in entry_gain#set_text (string_of_float e); int_of_float (10.0 *. e)

let jpegadd s =
 let len = String.length s in
 let root = "/files/" in
 let rlen = String.length root in
 if len > rlen && String.sub s 0 rlen = root then
    begin
    if Hashtbl.mem jpegh s then () else
        begin
        if check#active then print_endline ("jpegadd: "^s);
(* *)
        Hashtbl.add jpegh s (ref false);
(* *)
        end;
    status_jpeg#set_text s;
    end

(*
let fake = try int_of_string (Sys.getenv "FAKE_INIT") > 0 with _ -> false
if fake then "debug_fakeAutoInit" else 
if fake then "motors/pointTarget" else 
*)

let init' () =
    let cmd = "startAutoInit" in
    let pth = pth2'^"/v1//general/"^cmd in
    let time_ms = int_of_float (Unix.time() *. 1000.0) in
    let lat_flt = float_of_string entry_lat#text in
    let long_flt = float_of_string entry_long#text in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Json (`Assoc
    [("latitude", `Float lat_flt);
     ("longitude", `Float long_flt); ("time", `Int time_ms)] )) (cnv' f)

let manualinit' () =
    let cmd = "startManualInit" in
    let pth = pth2'^"/v1//general/"^cmd in
    let time_ms = int_of_float (Unix.time() *. 1000.0) in
    let lat_flt = float_of_string entry_lat#text in
    let long_flt = float_of_string entry_long#text in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Json (`Assoc
    [("latitude", `Float lat_flt);
     ("longitude", `Float long_flt); ("time", `Int time_ms)] )) (cnv' f)

let observe' () =
    let cmd = "general/startObservation" in
    let pth = pth2'^"/v1//"^cmd in
    let ra_flt = Utils.cnv_ra entry_ra#text in
    let dec_flt = Utils.cnv_dec entry_dec#text in
    if check#active then print_endline (string_of_float ra_flt^" "^string_of_float dec_flt);
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Json (`Assoc
    [("ra", `Float ra_flt);
     ("de", `Float dec_flt);
     ("isJ2000", `Bool true);
     ("rot", `Int 0);
     ("objectId", `String !obj_id);
     ("objectName", `String !obj_nam);
     ("gain", `Int (gain_int()));
     ("exposureMicroSec", `Int (expos_us()));
     ("doStacking", `Bool true);
     ("histogramEnabled", `Bool true);
     ("histogramLow", `Float (-0.75));
     ("histogramMedium", `Int 5);
     ("histogramHigh", `Int 0);
     ("backgroundEnabled", `Bool true);
     ("backgroundPolyorder", `Int 4)])) (cnv' f)

let darks' () =
    let pth = pth2'^"/v1//expertMode/startStorageAcquisition" in
    let xpth = "expert-mode/gain"^string_of_int !xgain in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Json (`Assoc
    [("path", `String xpth);
     ("overwrite", `Bool true);
     ("numExposures", `Int (int_of_string (entry_darkcnt#text)));
     ("gain", `Int !xgain);
     ("exposureMicroSec", `Int (expos_us()));
     ("flip", `String !xflip)])) (cnv' f)

let focus' () =
    let pth = pth2'^"/v1//general/adjustObservationFocus" in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Raw "{}") (cnv' f)

let stopobs' () =
    let pth = pth2'^"/v1//general/stopObservation" in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Raw "{}") (cnv' f)

(*
let status'' () =
    let pth = pth2'^"/v1//app/status" in
    get' ix [] [] pth (fun s -> errchk' true (cnv s))
*)

let openarm' () =
    let pth = pth2'^"/v1//general/openForMaintenance" in
    let f = (fun s -> errchk' true (cnv s)) in
    let headers = Utils.split [
      "Accept: */*"; "Connection: keep-alive"] in
    Utils.post' proto server [] headers pth (Quests.Request.Raw "{}") (cnv' f)

let motorstatus () =
    let pth = pth2'^"/v1//debug/motors/readAllStatusRegisters" in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Raw "{}") (cnv' f)

let motorgo () =
    let pth = pth2'^"/v1//motors/goAbsolute" in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Json (`Assoc
    [("ALT", `Float (Utils.cnv_dec entry_alt#text));
     ("AZ", `Float (Utils.cnv_dec entry_az#text))] )) (cnv' f)

let track () =
    let pth = pth2'^"/v1//motors/track" in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Json (`Assoc
    [("ALT", `Bool true);
     ("AZ", `Bool true)] )) (cnv' f)

let trackoff () =
    let pth = pth2'^"/v1//motors/track" in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Json (`Assoc
    [("ALT", `Bool false);
     ("AZ", `Bool false)] )) (cnv' f)

let singlefocus () =
    let pth = pth2'^"/v1//focus/singleFocus" in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Json (`Assoc
    [("algorithm", `String "DCT");
     ] )) (cnv' f)

let autofocus () =
    let pth = pth2'^"/v1//focus/startAutoFocus" in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Json (`Assoc
    [("algorithm", `String "DCT");
     ] )) (cnv' f)

let park' () =
    let pth = pth2'^"/v1//general/park" in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Raw "{}") (cnv' f)

let singleshot () =
    let pth = pth2'^"/v1//camera/singleAcquisition" in
    let f = (fun s -> errchk' true (cnv s)) in
    jpegadd "/files/temp/acquisition/IMG_0001.fits";
    Utils.post' proto server [] [] pth (Quests.Request.Json (`Assoc
    [("type", `String "FITS"); (* or JPEG *)
     ("wbr", `Int 50);
     ("wbb", `Int 60);
     ("flip", `Bool false);
     ("gain", `Int (gain_int()));
     ("binningType", `String "SOFT");
     ("binning", `Int 1);
     ("exposureMicroSec", `Int (expos_us()));
     ("requestStats", `Bool false);
     ("enableMoonStats", `Bool false)] )) (cnv' f)

let astrometry () =
    let pth = pth2'^"/v1//astrometry/singleAstrometry" in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Json (`Assoc
    [("type", `String "JPEG");
     ("binning", `Int 2);
     ("gain", `Int (gain_int()));
     ("exposureMicroSec", `Int 500000);
     ("convertToDate", `Bool false)] )) (cnv' f)

let readparams () =
    let pth = pth2'^"/v1//camera/debug_readParams" in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Json (`Assoc
    [] )) (cnv' f)

let mosaic () =
    mos_id := "mo"^string_of_int (int_of_float (Unix.time()) mod 1000000);
    let pth = pth2'^"/v1//automator/writeMosaicProgram" in
    let f = (fun s -> errchk' true (cnv s)) in
    let ra_flt = Utils.cnv_ra entry_ra#text in
    let dec_flt = Utils.cnv_dec entry_dec#text in
    let params = `Assoc [
      ("doStacking", `Bool true);
      ("gain", `Int (gain_int()));
      ("histogramEnabled", `Bool true);
      ("histogramLow", `Int (-1));
      ("histogramMedium", `Int 5);
      ("histogramHigh", `Int 0);
      ("backgroundEnabled", `Bool true);
      ("exposureMicroSec", `Int (expos_us()));
      ("objectId", `String (entry_nam#text))] in
    Utils.post' proto server [] [] pth (Quests.Request.Json (`Assoc
    [("programName", `String !mos_id);
     ("ra", `Float ra_flt);
     ("de", `Float dec_flt);
     ("settingsFrom", `String (entry_nam#text));
     ("gridWidth", `Int (int_of_string (entry_gridw#text)));
     ("gridHeight", `Int (int_of_string (entry_gridh#text)));
     ("numImages", `Int (int_of_string (entry_numi#text)));
     ("numPasses", `Int (int_of_string (entry_nump#text)));
     ("widthMinOverlap", `Float (float_of_string (entry_wminov#text)));
     ("heightMinOverlap", `Float (float_of_string (entry_hminov#text)));
     ("widthPassOffset", `Float (float_of_string (entry_wpassof#text)));
     ("heightPassOffset", `Float (float_of_string (entry_hpassof#text)));
     ("observationParams", params)] )) (cnv' f)

let startprog () =
    let pth = pth2'^"/v1//automator/startObservationProgram" in
    let time_ms = int_of_float (Unix.time() *. 1000.0) in
    let lat_flt = float_of_string entry_lat#text in
    let long_flt = float_of_string entry_long#text in
    let f = (fun s -> errchk' true (cnv s)) in
    let lst = List.rev !prog_entries in
    prog_entries := [];
    print_endline ("Entries in program: "^string_of_int (List.length lst));
    List.iteri (fun ix (itm:Yojson.t) -> print_endline ("observation["^string_of_int ix^"]: "^Yojson.to_string itm)) lst;
    let (prog':Yojson.t) = `Assoc
        [("skipAutoInit", `Bool false);
         ("latitude", `Float lat_flt);
         ("longitude", `Float long_flt);
         ("startTime", `Int time_ms);
         ("observations", `List lst)] in
    print_endline !mos_id;
    Utils.post' proto server [] [] pth (Quests.Request.Json prog') (cnv' f)

let obsprog () =
    let pth = pth2'^"/v1//automator/runObservationProgram" in
    let time_ms = int_of_float (Unix.time() *. 1000.0) in
    let lat_flt = float_of_string entry_lat#text in
    let long_flt = float_of_string entry_long#text in
    let f = (fun s -> errchk' true (cnv s)) in
    print_endline !mos_id;
    Utils.post' proto server [] [] pth (Quests.Request.Json (`Assoc
    [("programName", `String !mos_id);
     ("skipAutoInit", `Bool false);
     ("latitude", `Float lat_flt);
     ("longitude", `Float long_flt);
     ("startTime", `Int time_ms)] )) (cnv' f)

let samples () =
    let pth = pth2'^"/v1//automator/takeSamples" in
    let lat_flt = float_of_string entry_lat#text in
    let long_flt = float_of_string entry_long#text in
    let f = (fun s -> errchk' true (cnv s)) in
    let expos_lst = `Int (expos_us() / 4) :: `Int (expos_us() / 2) :: `Int (expos_us()) :: `Int (expos_us() * 2) :: `Int (expos_us() * 4) :: [] in
    Utils.post' proto server [] [] pth (Quests.Request.Json (`Assoc
  [("onlyEstimate", `Bool true);
   ("latitude", `Float lat_flt);
   ("longitude", `Float long_flt);
   ("type", `String "FITS");
   ("gains", `List [`Int 200]);
   ("exposures", `List expos_lst);
   ("binningTypes", `List [`String "SOFT"]);
   ("binnings", `List [`Int 2]);
   ("numExposures", `Int 1);
   ("doPanorama", `Bool true);
   ("azSampling", `Int 10);
   ("azRange", `List [`Int 0; `Int 20]);
   ("altSampling", `Int 5);
   ("altRange", `List [`Int 20; `Int 90]);
   ("doTracking", `Bool true);
   ("raSampling", `Int 5);
   ("raRange", `List [`Int 0; `Int 360]);
   ("deSampling", `Int 5);
   ("deRange", `List [`Int 10; `Int 90]);
   ("doFocus", `Bool true);
   ("mapSampling", `Int 5000);
   ("mapRange", `List [`Int 0; `Int 256000]);
   ("mapSampling2", `Int 0);
   ("mapRange2", `List [`Int 175000; `Int 225000])] )) (cnv' f)

let abortall () =
    let pth = pth2'^"/v1//app/abortAllOperations" in
    let f = (fun s -> errchk' true (cnv s)) in
    Utils.post' proto server [] [] pth (Quests.Request.Raw "{}") (cnv' f)

let show_entries nam jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc jd ra dec azi elev sidt apmag hour_ang ang_diam =
    if nam <> "" then entry_nam#set_text nam;
    entry_ra#set_text (Utils.hms_of_float ra);
    entry_dec#set_text (Utils.dms_of_float dec);
    entry_alt#set_text (Utils.dms_of_float (alt_calc));
    entry_az#set_text (Utils.dms_of_float (az_calc));
    entry_mag#set_text (Printf.sprintf "%.2f" apmag);
    entry_ang#set_text (Printf.sprintf "%.2f" ang_diam);
    spare.(0)#set_text (Utils.dms_of_float (elev));
    spare.(1)#set_text (Utils.dms_of_float (azi));
    spare.(2)#set_text (Printf.sprintf "%.4f" lst_calc);
    spare.(3)#set_text (Printf.sprintf "%.4f" hour_calc);
    spare.(4)#set_text (Printf.sprintf "%.4f" (sidt));
    spare.(5)#set_text (Printf.sprintf "%.4f" (hour_ang));
    spare'.(0)#set_text (Utils.hms_of_float ra_now);
    spare'.(1)#set_text (Utils.dms_of_float dec_now);
    spare'.(2)#set_text (string_of_float (jd_calc));
    spare'.(3)#set_text (string_of_float (jd));
    spare'.(4)#set_text (string_of_float ra);
    spare'.(5)#set_text (string_of_float dec)

let stellarium' () =
    let sattr = ref (Stellarium.attr targ_entry#text) in
    let debug (attr:Stellarium.attr) =
      let latitude = float_of_string entry_lat#text in
      let longitude = float_of_string entry_long#text in
      let yr,mon,dy,hr,min,sec = split_date() in
      let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Utils.altaz_calc yr mon dy hr min sec attr.ra attr.dec latitude longitude in
      show_entries attr.target jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc 0.0 attr.ra attr.dec attr.az attr.alt attr.sidt attr.vis_mag attr.hour_ang nan;
      targ_status#set_text ("Stellarium: "^attr.target) in
    let f = (fun s -> match s.[0] with '{' -> Stellarium.descend !sattr (Yojson.Basic.from_string s); debug !sattr | _ -> targ_status#set_text s ) in
    Stellarium.stellarium' !sattr (cnv' f)

let simbad_cnv = function
    | Xml.Element
   ("VOTABLE",
    [("xmlns", "http://www.ivoa.net/xml/VOTable/v1.2");
     ("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
     ("xsi:schemaLocation",
      "http://www.ivoa.net/xml/VOTable/v1.2 http://www.ivoa.net/xml/VOTable/v1.2");
     ("version", "1.2")],
    [Xml.Element
      ("DEFINITIONS", [],
       [Xml.Element
         ("COOSYS",
          [("ID", "COOSYS"); ("equinox", "2000"); ("epoch", "J2000");
           ("system", "ICRS")],
          [])]);
     Xml.Element
      ("RESOURCE", [("name", "Simbad query"); ("type", "results")],
       [Xml.Element
         ("TABLE", [("ID", "simbad"); ("name", "simbad query")],
          [Xml.Element
            ("DESCRIPTION", [], [Xml.PCData "... query string ..."]);
           Xml.Element
            ("FIELD",
             [("ID", "MAIN_ID"); ("name", "MAIN_ID"); ("datatype", "char");
              ("width", "22"); ("ucd", "meta.id;meta.main");
              ("arraysize", "*")],
             [Xml.Element
               ("DESCRIPTION", [],
                [Xml.PCData "Main identifier for an object"]);
              Xml.Element
               ("LINK",
                [("value", "${MAIN_ID}");
                 ("href",
                  "http://simbad.u-strasbg.fr/simbad/sim-id?Ident=${MAIN_ID}&amp;NbIdent=1")],
                [])]);
           Xml.Element
            ("FIELD",
             [("ID", "RA"); ("name", "RA"); ("datatype", "char");
              ("precision", "8"); ("width", "13");
              ("ucd", "pos.eq.ra;meta.main"); ("arraysize", "13");
              ("unit", "&quot;h:m:s&quot;")],
             [Xml.Element ("DESCRIPTION", [], [Xml.PCData "Right ascension"])]);
           Xml.Element
            ("FIELD",
             [("ID", "DEC"); ("name", "DEC"); ("datatype", "char");
              ("precision", "8"); ("width", "13");
              ("ucd", "pos.eq.dec;meta.main"); ("arraysize", "13");
              ("unit", "&quot;d:m:s&quot;")],
             [Xml.Element ("DESCRIPTION", [], [Xml.PCData "Declination"])]);
           Xml.Element
              ("FIELD",
               [("ID", "FLUX_V"); ("name", "FLUX_V"); ("datatype", "float");
                ("ucd", "phot.mag;em.opt.V"); ("unit", "mag")],
               [Xml.Element ("DESCRIPTION", [], [Xml.PCData "Magnitude V"])]);
             Xml.Element
              ("FIELD",
               [("ID", "FLUX_UNIT_mag"); ("name", "FLUX_UNIT_mag");
                ("datatype", "char"); ("width", "3");
                ("ucd", "meta.unit;phot.flux")],
               [Xml.Element ("DESCRIPTION", [], [Xml.PCData "flux unit"])]);
             Xml.Element
            ("DATA", [],
             [Xml.Element
               ("TABLEDATA", [],
                [Xml.Element
                  ("TR", [],
                   [Xml.Element ("TD", [], [Xml.PCData ident]);
                    Xml.Element ("TD", [], [Xml.PCData ra]);
                    Xml.Element ("TD", [], [Xml.PCData dec]);
                    Xml.Element ("TD", [], [Xml.PCData mag]);
                    Xml.Element ("TD", [], [])])])])])])]) ->
    let latitude = float_of_string entry_lat#text in
    let longitude = float_of_string entry_long#text in
    let yr,mon,dy,hr,min,sec = split_date() in
    let ra_flt = Utils.cnv_ra ra in
    let dec_flt = Utils.cnv_dec dec in
    let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Utils.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
    show_entries ident jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc nan ra_flt dec_flt nan nan nan (float_of_string mag) nan nan;
    targ_status#set_text ("SIMBAD found: "^ident)
| Xml.Element
     ("VOTABLE",
      [("xmlns", "http://www.ivoa.net/xml/VOTable/v1.2");
       ("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
       ("xsi:schemaLocation",
        "http://www.ivoa.net/xml/VOTable/v1.2 http://www.ivoa.net/xml/VOTable/v1.2");
       ("version", "1.2")],
      [Xml.Element
        ("INFO",
         [("name", "Error");
          ("value", errmsg)],
         [])]) ->
entry_ra#set_text "";
entry_dec#set_text "";
entry_alt#set_text "";
entry_az#set_text "";
targ_status#set_text (errmsg)
| _ -> failwith "simbad XML error"

let messier' () = 
    let sel = targ_entry#text in
    let len = Array.length Messier_catalogue.messier_array in
    let ix = ref (try int_of_string (String.sub sel 1 (String.length sel - 1)) with _ -> 0) in
    if sel.[0] <> 'M' || !ix = 0 || !ix > len then Array.iteri (fun i (a,_,_) -> if sel = a then ix := i+1) Messier_catalogue.messier_array;
    let (found,ra,dec) = if !ix = 0 || !ix > len
    then (targ_status#set_text ("Messier: " ^ sel ^ ": not found"); ("","",""))
    else (let (found,b,c) = Messier_catalogue.messier_array.(!ix - 1) in targ_status#set_text ("Messier found: " ^ found); (found,b,c)) in
    let latitude = float_of_string entry_lat#text in
    let longitude = float_of_string entry_long#text in
    let ra_flt = Utils.cnv_ra ra in
    let dec_flt = Utils.cnv_dec dec in
    let yr,mon,dy,hr,min,sec = split_date() in
    let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Utils.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
    show_entries found jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc nan ra_flt dec_flt nan nan nan nan nan nan;
    Lwt.return_unit

let focus_resp s =
  targ_status#set_text (if bool_of_string s then "Stellarium focussed" else "Stellarium not focussed");
  print_endline ("focus response: "^s)

let ngc2000' () = 
    let sel = targ_entry#text in
    (try (let (ra_flt,dec_flt,cnst,diam,mag,desc) = Hashtbl.find Ngc2000.ngchash sel in
    print_endline (string_of_float ra_flt^" : "^string_of_float dec_flt);
    targ_status#set_text ("NGC2000 found: " ^ sel);
    let yr,mon,dy,hr,min,sec = split_date() in
    let latitude = float_of_string entry_lat#text in
    let longitude = float_of_string entry_long#text in
    let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Utils.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
    ignore (cnst,diam,mag,desc);
    show_entries sel jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc nan ra_flt dec_flt nan nan nan mag nan nan);
    print_endline ("Focus: "^sel);
    Stellarium.focus' focus_resp sel
    with _ ->
    targ_status#set_text ("NGC2000: " ^ sel ^ ": not found");
    show_entries " " nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan;
    Lwt.return_unit)

(*
Principal Galaxy cataloogue, biggest 25000 items out of ~1M

("PGC", 4750, "J", 1, 19, 24.2, "+", 12, 26, 49, "GM", "Sd", 1.01, "+/-", 0.07, 0.27, "+/-", 0.06, 116., "+/-", 4., 8)
*)

let pgc' () = 
    let sel = targ_entry#text in
    print_endline ("Search "^string_of_int Pgc0.hlen^"&"^string_of_int Pgc1.hlen^" PGC for "^sel);
    (try (let (_,_,_,rh,rm,rs,decs,dd,dm,ds,_,_,a,_,_,_,_,_,_,_,_,_) = Hashtbl.find Pgchash.pgch sel in
    let mag = 20.0/.(a *. a) in
    let ra_flt = float_of_int rh *. 15.0 +. float_of_int rm /. 4.0 +. rs /. 240.0 in
    let dec_flt = float_of_int dd +. float_of_int dm /. 60.0 +. float_of_int ds /. 3600.0 in
    let dec_flt = if decs.[0] = '-' then -. dec_flt else dec_flt in
    print_endline (string_of_float ra_flt^" : "^string_of_float dec_flt);
    targ_status#set_text ("PGC found: " ^ sel);
    let yr,mon,dy,hr,min,sec = split_date() in
    let latitude = float_of_string entry_lat#text in
    let longitude = float_of_string entry_long#text in
    let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Utils.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
    show_entries sel jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc nan ra_flt dec_flt nan nan nan mag nan a);
    print_endline ("Focus: "^sel);
    Stellarium.focus' focus_resp sel
    with _ ->
    targ_status#set_text ("PGC: " ^ sel ^ ": not found");
    show_entries " " nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan;
    Lwt.return_unit)

let simbad' () =
    let hdrs = ref [] in
    let server =  "simbad.u-strasbg.fr" in
    let pth = "/simbad/sim-id" in
    let params = [ ("output.format", "VOTABLE"); ("output.params", "main_id,ra,dec,flux(V),flux_unit(mag)"); ("Ident", targ_entry#text) ] in
    let f = (fun s -> simbad_cnv (
                                  let m = XmlParser.make() in
                                      XmlParser.prove m false;
                                      try XmlParser.parse m (SString s)
                                      with _ -> let fd = open_out (targ_entry#text^".xml") in
                                      output_string fd s;
                                      close_out fd;
                                      failwith "Xml.parse_string")) in
    Utils.get' "http://" server params [] pth f hdrs

let show_ephem ix =
    let lst = !ephem_data_lst in
    let (eph:string) = if List.length lst > ix then List.nth lst ix else String.make 80 ' ' in
    print_endline eph;
    try let scan = Scanf.sscanf eph " %d-%[A-Za-z]-%d %d:%d %f %[A-Za-z*] %f %f %f %f %f %f %f %f %[^ ] %[A-Za-z] %f"
                        (fun yr mon dy hr min jd sun ra dec azi elev daz delv sidt apmag sbrt cnst hour_ang ->
                            (yr,mon,dy,hr,min,jd,sun,ra,dec,azi,elev,daz,delv,sidt,apmag,sbrt,cnst,hour_ang)) in
    let (yr,mon,dy,hr,min,jd,sun,ra,dec,azi,elev,daz,delv,sidt,apmag,sbrt,cnst,hour_ang) = scan in
    let latitude = float_of_string entry_lat#text in
    let longitude = float_of_string entry_long#text in
    let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Utils.altaz_calc yr (Utils.month mon) dy hr min 0 ra dec latitude longitude in
    ignore (sun,daz,delv,sbrt,cnst); (* prevent complier error because we don't use these at the moment *)
    show_entries "" jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc jd ra dec azi elev sidt apmag hour_ang nan
    with _ -> 
    show_entries "" nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan

(*
let datum = fst (Unix.mktime {tm_sec=0; tm_min=0; tm_hour=1; tm_mday=1; tm_mon=0; tm_year = 100; tm_wday=0; tm_yday=0; tm_isdst=false})
*)

(*
 2022-May-24 00:00 2459723.500000000 A   283.06729  45.34441   87.458179  62.208412    211.28    497.77  16.1126959778   18.610    n.a.   Lyr   -2.768899387
*)

let horizons' () =
    let hdrs = ref [] in
    let server =  "ssd.jpl.nasa.gov" in
    let pth = "/api/horizons.api?format=text" in
    let datum' = datum() in
    let t = Unix.gmtime datum' in
    let t' = Unix.gmtime (datum' +. 86400.0) in
    let f = (fun s ->
       let body = ref "" in
       ephem_data_lst := List.filter (fun x' ->
       let x = String.trim x' in
       let str = if String.length x > 5 then String.sub x 0 4 else "" in
       let trial = try (int_of_string str) with _ -> 0 in
       let use = trial = t.tm_year+1900 in
       if false then print_endline (string_of_bool use^": "^str^": "^string_of_int trial^": "^x);
       if String.length x >= 66 && (String.sub x 0 9 = "Revised: " || String.sub x 0 12 = "JPL/HORIZONS") then
          begin
          body := String.trim (String.sub x 22 (String.length x - 42));
          end;
       if check#active then print_endline x;
       use) (String.split_on_char '\n' s);
       targ_status#set_text ("horizons: "^ !body);
       entry_nam#set_text !body;
       ephem#set_active t.tm_hour;
       show_ephem t.tm_hour) in
    let lat_flt = float_of_string entry_lat#text in
    let long_flt = float_of_string entry_long#text in
    let req = 
    [("COMMAND", "'"^ targ_entry#text ^"'");
     ("OBJ_DATA", "'YES'");
     ("MAKE_EPHEM", "'YES'");
     ("EPHEM_TYPE", "'OBS'");
     ("CENTER", "'coord'");
     ("APPARENT", "'REFRACTED'");
     ("CAL_FORMAT", "'BOTH'");
     ("ANG_FORMAT", "'DEG'");
     ("SITE_COORD", Printf.sprintf "'%f,%f,%f'" long_flt lat_flt 0.0);
     ("START_TIME", Printf.sprintf "%d-%d-%d" (t.tm_year+1900) (t.tm_mon+1) t.tm_mday);
     ("STOP_TIME", Printf.sprintf "%d-%d-%d" (t'.tm_year+1900) (t'.tm_mon+1) t'.tm_mday);
     ("STEP_SIZE", "'1 h'");
     ("QUANTITIES", "'1,4,5,7,9,29,42");
    ] in
    if check#active then List.iter (fun (k,x) -> print_endline (k^": "^x)) req;
    Utils.get' "https://" server req [] pth f hdrs

type smdb = {
    h: float;
    des: string;
    orb: string;
    jd: string;
    cd: string;
    dist: string;
    dist_min: string;
    dist_max: string;
    v_rel: string;
    v_inf: string;
    t_sigma_f: string;
    }

let dump_smdb fd {des;orb;jd;cd;dist;dist_min;dist_max;v_rel;v_inf;t_sigma_f;h} =
  output_string fd (des^" "^orb^" "^jd^" "^cd^" "^dist^" "^dist_min^" "^dist_max^" "^v_rel^" "^v_inf^" "^t_sigma_f^" "^string_of_float h^"\n")

(*
let smdb_compare {h=a;_} {h=b;_} =
   let lft = float_of_string a in
   let rght = float_of_string b in
   print_endline (string_of_float lft^" "^string_of_float rght);
   int_of_float (lft -. rght)
*)

let smdb_list = function
| `List
           [`String des; `String orb; `String jd;
            `String cd; `String dist;
            `String dist_min; `String dist_max;
            `String v_rel; `String v_inf;
            `String t_sigma_f; `String h'] -> let h = float_of_string h' in {h;des;orb;jd;cd;dist;dist_min;dist_max;v_rel;v_inf;t_sigma_f}
| _ -> failwith "json_list"

let  (smdb_decode:Yojson.Basic.t -> smdb list) = function
| `Assoc
    [("signature",
      `Assoc
        [("source", `String "NASA/JPL SBDB Close Approach Data API");
         ("version", `String "1.4")]);
     ("count", `String _);
     ("fields",
      `List
        [`String "des"; `String "orbit_id"; `String "jd"; `String "cd";
         `String "dist"; `String "dist_min"; `String "dist_max";
         `String "v_rel"; `String "v_inf"; `String "t_sigma_f"; `String "h"]);
     ("data",
      `List lst)] -> List.map smdb_list lst
| _ -> failwith "json"

let smdb_entries = ref [||]

let dump_cat fd (sel, (ra_flt,dec_flt,cnst,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) =
  ignore (jd_calc, ra_now, dec_now, cnst, lst_calc, hour_calc);
  output_string fd (sel^" "^string_of_float ra_flt^" "^string_of_float dec_flt^" "^string_of_float mag^" "^string_of_float alt_calc^" "^string_of_float az_calc^" "^string_of_float diam^"\n")

let sort_ngc a b =
  let (_, (_,_,_,_,maga,_,_,_,_,_,_,_)) = a in
  let (_, (_,_,_,_,magb,_,_,_,_,_,_,_)) = b in
  if maga < magb then -1 else 1

let sort_pgc fd a b =
  let (_, (_,_,_,diama,_,_,_,_,_,_,_,_)) = a in
  let (_, (_,_,_,diamb,_,_,_,_,_,_,_,_)) = b in
(*
  dump_cat fd a;
  dump_cat fd b;
*)
  let diff = if diama < diamb then 1 else -1 in
(*
  output_string fd (string_of_float diamb^" "^string_of_float diama^" "^string_of_int diff^"\n");
*)
  ignore(fd);
  diff

let fetch' () =
    let jhash = ref ("",ref false) in
    Hashtbl.iter (fun k x -> if !x then () else jhash := (k,x)) jpegh;
    snd !jhash := true;
    let jpeg = fst !jhash in
    if check#active then print_endline ("Fetching: "^ jpeg);
    let pth = pth2'^jpeg in
    let headers = Utils.split ["Accept-Encoding: gzip, deflate";
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
    Utils.get' proto server [] headers pth (cnv' f) hdrs

let quit' = ref false

let setfocus' () =
  Stellarium.focus' focus_resp entry_nam#text

let rec cat'' cat_entries nentries lbl' =
  List.iteri (fun ix loc -> if loc=lbl' then
      begin
      let (sel, (ra_flt, dec_flt, cnst, diam, mag, jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) = cat_entries.(ix) in
      dump_cat stderr (sel, (ra_flt,dec_flt,cnst,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc));
      show_entries sel jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc nan ra_flt dec_flt nan nan nan mag nan diam;
      targ_entry#set_text "";
      targ_status#set_text "";
      sm_jump "setfocus";
      end) nentries

and sm_jump lbl' = 
  let target = ref (-1) in
  Array.iteri (fun ix (lbl, _) -> if lbl=lbl' then (target := ix; if check#active then print_endline (string_of_int (ix+1)^": "^lbl'))) taskarray;
  if !target <> -1 then
    begin
    Queue.add !target start;
    print_endline (fst taskarray.(!target))
    end

and search () = 
    let s = targ_entry#text in
    (try let _ = int_of_string s in rbuttons 2 with _ -> ());
    sm_jump !xserv

and smdb'' sentries lbl' = 
  List.iteri (fun ix loc -> if loc=lbl' then
      begin
      let {des;orb;jd;cd;dist;dist_min;dist_max;v_rel;v_inf;t_sigma_f;h} = !smdb_entries.(ix) in
      dump_smdb stderr ({des;orb;jd;cd;dist;dist_min;dist_max;v_rel;v_inf;t_sigma_f;h});
      let scan = Scanf.sscanf cd " %d-%[A-Za-z]-%d %d:%d"
                        (fun yr mon dy hr min ->
                            (yr,mon,dy,hr,min)) in
      let (yr,mon,dy,hr,min) = scan in
      update_date yr (Utils.month mon) dy hr min 0;
      tim.(6)#set_text (Printf.sprintf "%8.0f" (1.496e8 *. float_of_string dist_min));
      tim.(7)#set_text (string_of_float h);
      targ_entry#set_text lbl';
      rbuttons 2;
      search();
      end) sentries

and smdb' () = if approach > 0 then
    begin
    let hdrs = ref [] in
    let server =  "ssd-api.jpl.nasa.gov" in
    let pth = "/cad.api" in
    let datum = Unix.gettimeofday() in
    let t = Unix.gmtime datum in
    let t' = Unix.gmtime (datum +. 86400.0 *. 365.2425) in
    let f = (fun s ->
        let lst = smdb_decode (Yojson.Basic.from_string s) in
        let dbgfile = open_out "smdba1.txt" in
        List.iter (dump_smdb dbgfile) lst;
        close_out dbgfile;
        let srt = List.sort compare lst in
        let dbgfile = open_out "smdba2.txt" in
        List.iter (dump_smdb dbgfile) srt;
        close_out dbgfile;
        smdb_entries := Array.sub (Array.of_list srt) 0 20;
        let sentries = List.map (fun {des;_} -> des) (Array.to_list !smdb_entries) in
        let smodel, etext_column = GTree.store_of_list Gobject.Data.string sentries in
        let smenu = GEdit.combo_box_entry ~text_column:etext_column ~model:smodel ~packing:pbox#pack () in
        ignore (smenu#entry#connect#changed ~callback: (fun () -> smdb'' sentries smenu#entry#text));
        smenu#set_active 0;
         ) in
    let req = [
     ("date-min", Printf.sprintf "%d-%.2d-%.2d" (t.tm_year+1900) (t.tm_mon+1) t.tm_mday);
     ("date-max", Printf.sprintf "%d-%.2d-%.2d" (t'.tm_year+1900) (t'.tm_mon+1) t'.tm_mday);
    ] in
    if true then List.iter (fun (k,x) -> print_endline (k^": "^x)) req;
    Utils.get' "https://" server req [] pth f hdrs
    end
 else
    begin
    let yr,mon,dy,hr,min,sec = split_date() in
    let latitude = float_of_string entry_lat#text in
    let longitude = float_of_string entry_long#text in
    let lst = ref [] in
    let accstr = try Sys.getenv "OPENSTELLINA_ACCEPTANCE" with _ -> "alt_calc > 30.0 & (az_calc > 300.0 | az_calc < 60.0)" in
    let acceptance = Expr.simplify [] (Expr.expr accstr) in
    Expr.dump stdout [] acceptance;
    rbuttons defcat;
    let srt = match defcat with
      | 4 -> Hashtbl.iter (fun sel (_,_,_,rh,rm,rs,decs,dd,dm,ds,_,_,a,_,_,_,_,_,_,_,_,_) ->
        let mag = 20.0 in
        let diam = a in
        let cnst = "" in
        let ra_flt = float_of_int rh *. 15.0 +. float_of_int rm /. 4.0 +. rs /. 240.0 in
        let dec_flt = float_of_int dd +. float_of_int dm /. 60.0 +. float_of_int ds /. 3600.0 in
        let dec_flt = if decs.[0] = '-' then -. dec_flt else dec_flt in
        let yr,mon,dy,hr,min,sec = split_date() in
        let latitude = float_of_string entry_lat#text in
        let longitude = float_of_string entry_long#text in
        let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Utils.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
        let acclst = ("alt_calc", Calc.Num alt_calc) :: ("az_calc", Calc.Num az_calc) :: ("mag", Calc.Num mag) :: ("ang_diam", Calc.Num diam) :: [] in
        match Expr.simplify acclst acceptance with
          | Calc.Bool true ->
            if mag <> nan then lst := (sel, (ra_flt,dec_flt,cnst,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) :: !lst;
          | Calc.Bool false -> ()
          | oth -> Expr.dump stderr acclst oth
      ) Pgchash.pgch;
        let dbgfile = open_out "srt.txt" in
        let srt = List.sort (sort_pgc dbgfile) !lst in
        close_out dbgfile;
        srt
      | 5 -> Hashtbl.iter (fun sel (ra_flt,dec_flt,cnst,diam,mag,desc)  ->
        let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Utils.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
        ignore (cnst,diam,mag,desc);
        let acclst = ("alt_calc", Calc.Num alt_calc) :: ("az_calc", Calc.Num az_calc) :: ("mag", Calc.Num mag) :: ("ang_diam", Calc.Num diam) :: [] in
        match Expr.simplify acclst acceptance with
          | Calc.Bool true ->
            if mag <> nan then lst := (sel, (ra_flt,dec_flt,cnst,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) :: !lst;
          | Calc.Bool false -> ()
          | oth -> Expr.dump stderr acclst oth
        ) Ngc2000.ngchash;
       List.sort sort_ngc !lst
       | _ -> print_endline "That catalogue does not support searching by alt/az"; [] in
    print_endline ("selected catalogue objects = "^string_of_int (List.length !lst));
    let dbgfile = open_out "cat1.txt" in
    List.iter (dump_cat dbgfile) !lst;
    close_out dbgfile;
    let dbgfile = open_out "cat2.txt" in
    List.iter (dump_cat dbgfile) srt;
    close_out dbgfile;
    let entries = try int_of_string (Sys.getenv "OPENSTELLINA_ENTRIES") with _ -> 20 in
    let entries = if entries > List.length srt then List.length srt else entries in
    let cat_entries = Array.sub (Array.of_list srt) 0 entries in
    let nentries = List.map (fun (des,_) -> des) (Array.to_list cat_entries) in
    let nmodel, ntext_column = GTree.store_of_list Gobject.Data.string nentries in
    let nmenu = GEdit.combo_box_entry ~text_column:ntext_column ~model:nmodel ~packing:pbox#pack () in
    ignore (nmenu#entry#connect#changed ~callback: (fun () -> cat'' cat_entries nentries nmenu#entry#text));
    nmenu#set_active entries;
    Lwt.return_unit
    end

and taskarray =
       [|
         ("smdb", smdb');
         ("", status');
         ("connect", get1');
         ("post2", post2');
         ("get3", get3');
         ("get4", get4');
         ("post5", post5');
         ("get6", get6');
         ("post7", status');
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
         ("manualinit", manualinit');
         ("", status');
         ("motorgo", motorgo);
         ("motorstatus", motorstatus);
         ("", status');
         ("singlefocus", singlefocus);
         ("", status');
         ("autofocus", autofocus);
         ("", status');
         ("singleshot", singleshot);
         ("", status');
         ("astrometry", astrometry);
         ("", status');
         ("readparams", readparams);
         ("", status');
         ("track", track);
         ("", status');
         ("trackoff", trackoff);
         ("", status');
         ("mosaic", mosaic);
         ("", status');
         ("obsprog", obsprog);
         ("", status');
         ("startprog", startprog);
         ("", status');
         ("samples", samples);
         ("", status');
         ("abortall", abortall);
         ("", status');
         ("darks", darks');
         ("", status');
         ("fetch", fetch');
         ("", status');
         ("openarm", openarm');
         ("", status');
         ("simbad", simbad');
         ("", status');
         ("stellarium", stellarium');
         ("", status');
         ("horizons", horizons');
         ("", status');
         ("messier", messier');
         ("", status');
         ("ngc2000", ngc2000');
         ("", status');
         ("pgc", pgc');
         ("", status');
         ("setfocus", setfocus');
         ("", status');
       |]

let update_status' kw stat =
  let len = String.length kw in
  match Hashtbl.find_opt statush kw with
    | None -> ()
    | Some x -> if len > 4 && String.sub kw (len-4) 4 = "@url" then jpegadd x else stat#set_text x

let update_status () =
(*
  update_status' "success" status_line.(0);
  update_status' "error@name" status_line.(1);
  update_status' "update@state" status_line.(2);
  update_status' "message" status_line.(3);
  update_status' "result@message" status_line.(4);
  update_status' "R[1]@previousOperations@observation@capture@images[0]@url" status_jpeg;
*)
  Array.iteri (fun ix itm -> update_status' itm status_extra.(ix)) visible_extra;
  ()

let usleep t = ignore (Unix.select [] [] [] t)

let rec iter_a ix a =
  match a.(!ix) with
  | ("", x) ->
    if !quit' then
        begin
        usleep 0.1; (* to avoid unused function warning *)
        Lwt.return_unit
        end
    else if not (Queue.is_empty start) then iter_a (ref (Queue.take start)) a
    else
        begin
        Hashtbl.iter (fun _ x -> if !x then () else sm_jump "fetch") jpegh;
        update_status ();
        if !connecting then reset_date (Unix.gettimeofday());
        let waiting = true in
        Lwt_engine.iter waiting;
        Lwt.apply (fun f -> f ()) x >>= fun () -> iter_a ix a
        end
  | (lbl, x) -> incr ix;
    let f = fun f -> let cnt = string_of_int !ix in print_endline (cnt^": "^lbl); f () in
    Lwt.apply f x >>= fun () -> iter_a ix a
(*
let font = Printexc.print Pango.Font.from_string "Sans 12"

let color = ref (`RGB (0, 65535, 0)) 
*)

let app_quit' () = quit' := true
let app_status' () =
 print_endline (string_of_int (List.length !misclst));
 let fd = open_out "logfile.txt" in
 Hashtbl.iter (fun k x -> output_string fd (k^": "^x^"\n")) statush;
 close_out fd

(*
let exposlidefunc _ v = expos_us := int_of_float (floor (1.3 ** v)); entry_exp#set_text (string_of_int !expos_us)
let gainslidefunc _ v = gain_int := int_of_float (floor (v *. 10.0)); entry_gain#set_text (Printf.sprintf "%4.1f" (float_of_int !gain_int /. 10.0))
*)

let rec (yojson_of_yojson_basic:Yojson.Basic.t -> Yojson.t) = function
| `Assoc l -> `Assoc (List.map (fun (x,y) -> (x, yojson_of_yojson_basic y)) l)
| `List l -> `List (List.map (fun y -> (yojson_of_yojson_basic y)) l)
| `Int n -> `Int n
| `Bool b -> `Bool b
| `Float f -> `Float f
| `String s -> `String s
| `Null -> failwith "yojson_basic"

let load_prog_entries () =
    prog_entries := [];
    try let fd = open_in "prog_entries.json" in
    prog_entries := (match yojson_of_yojson_basic (Yojson.Basic.from_channel fd) with `List lst -> List.rev lst | _ -> []);
    with Sys_error _ -> ()

let dump_prog_entries () =
    let fd = open_out "prog_entries.json" in
    output_string fd (Yojson.pretty_to_string (`List (List.rev !prog_entries)));
    close_out fd

let show_prog_entries () =
    let progtxt = Buffer.create 100 in
    Printf.bprintf progtxt "Entry duration declination exposure gain target_name right_ascension rotation status\n";
    List.iteri (fun ix -> fun (json:Yojson.t) -> match json with `Assoc
         [("duration", `Int duration);
          ("params",
           `Assoc lst)] -> Printf.bprintf progtxt "  %5d  %8d " (ix+1) duration;
         let ra_flt = ref 0.0 in
         let dec_flt = ref 0.0 in
         List.iter (function
           | ("de", `Float dec) -> dec_flt := dec; Printf.bprintf progtxt "   %11s" (Utils.dms_of_float dec)
           | ("exposureMicroSec", `Int expos_us) -> Printf.bprintf progtxt "   %8.3f" (float_of_int expos_us /. 1e6)
           | ("gain", `Int gain) -> Printf.bprintf progtxt "   %4d" gain
           | ("objectId", `String id) -> Printf.bprintf progtxt "   %11s" id
           | ("ra", `Float ra) -> ra_flt := ra; Printf.bprintf progtxt "   %15s" (Utils.hms_of_float ra)
           | ("rot", `Int rot) -> Printf.bprintf progtxt "   %8d" rot
           | _ -> ()) (List.sort compare lst);
         let latitude = float_of_string entry_lat#text in
         let longitude = float_of_string entry_long#text in
         let yr,mon,dy,hr,min,sec = split_date() in
         let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Utils.altaz_calc yr mon dy hr min sec !ra_flt !dec_flt latitude longitude in
         if alt_calc < 0.0 then Printf.bprintf progtxt "  ** object below horizon ** ";
         ignore (jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc);
         Printf.bprintf progtxt "\n"
         | _ -> ()) (List.rev !prog_entries);
    let contents = Buffer.contents progtxt in
    if check#active then Printf.printf "buffer length = %d\n" (String.length contents);
    textview#buffer#set_text contents

let add_prog_entry () =
    let ra_flt = Utils.cnv_ra entry_ra#text in
    let dec_flt = Utils.cnv_dec entry_dec#text in
    let duration = int_of_string entry_duration#text in
    let obs = `Assoc
         [("duration", `Int duration);
          ("params",
           `Assoc
             [("objectId", `String ( entry_nam#text ));
              ("ra", `Float ra_flt);
              ("de", `Float dec_flt);
              ("rot", `Int 0);
              ("gain", `Int (gain_int()));
              ("histogramEnabled", `Bool true);
              ("histogramLow", `Int (-1));
              ("histogramMedium", `Int 5);
              ("histogramHigh", `Int 0);
              ("backgroundEnabled", `Bool true);
              ("exposureMicroSec", `Int (expos_us()));
              ("doStacking", `Bool true);
              ("debayerInterpolation", `String "VNG")])] in
    prog_entries := obs :: !prog_entries;
    dump_prog_entries();
    show_prog_entries()

let horizons'' lbl' = 
  List.iteri (fun ix loc -> if loc=lbl' then (match ix with
      | 2 -> targ_entry#set_text "301"; search()
      | 9 -> ()
      | _ -> targ_entry#set_text (string_of_int ((ix+1)*100+99)); search())) planet_lst

let gui () = 
  ignore @@ factory_fil#add_item "Quit" ~callback: app_quit';
  ignore @@ factory_stell#add_item "Status" ~callback: app_status';
(* Quit when the window is closed. *)
  ignore (window#connect#destroy ~callback: app_quit');
  ignore (button0#connect#clicked ~callback: (fun () -> connecting := true; reset_date (Unix.gettimeofday()); sm_jump "connect"));
  ignore (button1#connect#clicked ~callback: (fun () -> sm_jump "openarm"));
  ignore (button2#connect#clicked ~callback: (fun () -> sm_jump "init"));
  ignore (button3#connect#clicked ~callback: (fun () -> sm_jump "observe"));
  ignore (button4#connect#clicked ~callback: (fun () -> sm_jump "focus"));
  ignore (button5#connect#clicked ~callback: (fun () -> sm_jump "stopobs"));
  ignore (button6#connect#clicked ~callback: (fun () -> sm_jump "park"));
  ignore (button7#connect#clicked ~callback: (fun () -> sm_jump "motorgo"));
  ignore (button8#connect#clicked ~callback: (fun () -> sm_jump "singlefocus"));
  ignore (button9#connect#clicked ~callback: (fun () -> sm_jump "autofocus"));
  ignore (buttonA#connect#clicked ~callback: (fun () -> sm_jump "singleshot"));
  ignore (buttonB#connect#clicked ~callback: (fun () -> sm_jump "astrometry"));
  ignore (buttonC#connect#clicked ~callback: (fun () -> sm_jump "trackon"));
  ignore (buttonD#connect#clicked ~callback: (fun () -> sm_jump "trackoff"));
  ignore (buttonE#connect#clicked ~callback: (fun () -> sm_jump "manualinit"));
  ignore (buttonF#connect#clicked ~callback: (fun () -> sm_jump "readparams"));
  ignore (button12#connect#clicked ~callback: (fun () -> sm_jump "mosaic"));
  ignore (button13#connect#clicked ~callback: (fun () -> sm_jump "obsprog"));
  ignore (button14#connect#clicked ~callback: (fun () -> add_prog_entry() ));
  ignore (button15#connect#clicked ~callback: (fun () -> sm_jump "startprog"));
  ignore (button16#connect#clicked ~callback: (fun () -> sm_jump "samples"));
  ignore (button17#connect#clicked ~callback: (fun () -> sm_jump "abortall"));
(*
  ignore (rng#connect#change_value ~callback:exposlidefunc);
  ignore (gain#connect#change_value ~callback:gainslidefunc);
  exposlidefunc () 47.5;
  gainslidefunc () 20.0;
*)
  let timoff = try float_of_string (Sys.getenv "OPENSTELLINA_TIME_OFFSET") with _ -> 0.0 in
  reset_date (timoff +. Unix.gettimeofday());
  entry_darkcnt#set_text "100";
  entry_gridw#set_text "3";
  entry_gridh#set_text "3";
  entry_numi#set_text "3";
  entry_nump#set_text "3";
  entry_wminov#set_text "0.1";
  entry_hminov#set_text "0.1";
  entry_wpassof#set_text "0.1";
  entry_hpassof#set_text "0.1";
  entry_duration#set_text "15";
  textview#buffer#set_text "";

  ignore (dbutton2#connect#clicked ~callback: (fun () -> sm_jump "darks"));
  tz'#set_text tzcity;
  tz'#set_editable false;

  entry_exp#set_text "30.0";
  entry_gain#set_text "20.0";
  let cities' = Hashtbl.find Base_locations.loch tzcity in
  let latitude,longitude = try float_of_string (Sys.getenv "LATITUDE"), 
    float_of_string (Sys.getenv "LONGITUDE") with _ ->  51.477777, 0.001388 in
  let prev = ref 1000.0 in
  let deflt = ref 0 in
  let cities = List.mapi (fun ix (a,b,f',g') ->
     let nearest = sqrt((latitude -. f') *. (latitude -. f') +. ((longitude -. g') *. (longitude -. g'))) in
     if nearest < !prev then ( prev := nearest; deflt := ix );
     a^", "^b) cities' in
  let model, text_column = GTree.store_of_list Gobject.Data.string cities in
  let combo = GEdit.combo_box_entry ~text_column ~model ~packing:obox'#pack () in
  let loc_jump lbl' = List.iteri (fun ix loc -> if loc=lbl' then
    begin
    deflt := ix;
    let (_,_,f',g') = List.nth cities' ix in
    let lat' = string_of_float f' in
    let long' = string_of_float g' in
    entry_lat#set_text lat';
    entry_long#set_text long';
    if check#active then print_endline (string_of_int ix^": "^lat'^", "^long')
    end) cities in
  ignore (combo#entry#connect#changed ~callback: (fun () -> loc_jump combo#entry#text)) ;
  combo#set_active !deflt;
  status_jpeg#set_editable false;
  ignore (planets#entry#connect#changed ~callback: (fun () -> horizons'' planets#entry#text)) ;
  ignore (ephem#entry#connect#changed ~callback: (fun () -> let lbl' = ephem#entry#text in List.iteri (fun ix loc -> if loc=lbl' then show_ephem ix) ephem_lst)) ;
  planets#set_active 9;
  rbutton 1;
  load_prog_entries();
  show_prog_entries();

  (* Show the window. *)
  window#show ();

  ignore (targ_entry#connect#activate ~callback: search);
  targ_entry#set_editable true;
  targ_status#set_editable false;
  targ_entry#set_text (try Sys.getenv "STELLINA_TARGET" with _ -> catdefaults.(defcat));
  search()

let goto_received ra_int dec_int =
        let scal = 180. /. float_of_int(1 lsl 31) in
        let ra = float_of_int ra_int *. scal in
        let dec' = float_of_int dec_int *. scal in
        let dec = if dec' > 180.0 then dec' -. 360.0 else dec' in
        let rahms = Utils.hms_of_float ra in
        let decdms = Utils.dms_of_float dec in
        print_endline ("ra="^rahms^", dec="^decdms);
        entry_ra#set_text rahms;
        entry_dec#set_text decdms;
        entry_alt#set_text "";
        entry_az#set_text ""

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
  iter_a (ref 0) taskarray

let run () =
  (*try*) Lwt_main.run tasks (*with _ -> print_endline "error"*)

let _ = run()
