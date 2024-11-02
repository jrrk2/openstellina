open Js_of_ocaml
open Lwt.Syntax
open Cookie
open Astro_utils

type graphics =
  | Empty
  | Fill of string * float * float
  | Font of string
  | Stroke of float * float * float * float

type action =
  | None
  | Motor
  | Status
  | Consume
  | Init
  | Observe
  | Park
  | Preauth
  | Postauth

let action_func = function
  | None -> Js_of_ocaml_lwt.Lwt_js.sleep 0.1
  | Motor -> Telescope.motorgo ()
  | Status -> Telescope.status'' ()
  | Consume -> Telescope.status' ()
  | Init -> Telescope.init' ()
  | Observe -> Telescope.observe' ()
  | Park -> Telescope.park' ()
  | Preauth -> Telescope.preauth' ()
  | Postauth -> Telescope.postauth' ()

let action = ref None
let connect = ref false

let canvas_width = 1280.
let canvas_height = 480.
let (sel:int ref) = ref 0
let window_url = Js.to_string Dom_html.window##.location##.href
let parent_url = Js.to_string Dom_html.window##.parent##.location##.href
let window_protocol = Js.to_string Dom_html.window##.location##.protocol
let parent_protocol = Js.to_string Dom_html.window##.parent##.location##.protocol

let is_secure_session () =
  Js.to_string Dom_html.window##.location##.protocol = "https:"

let canvas =
  let r = Dom_html.createCanvas Dom_html.document in
  r##.width := int_of_float canvas_width;
  r##.height := int_of_float canvas_height;
  r

let tz_local () =
    let dummy = (Js.Unsafe.obj [||]) in
    let intl = Js.Unsafe.global##.Intl in
    let date = intl##DateTimeFormat(dummy) in
    let options = date##resolvedOptions(dummy) in
    let tz = options##.timeZone in
    Js.to_string tz

let split_date () =
    let tm = Unix.gmtime (datum()) in
    tm.tm_year+1900,tm.tm_mon+1,tm.tm_mday,tm.tm_hour,tm.tm_min,tm.tm_sec

let rec draw_things fn arg = 
  let context = canvas##getContext Dom_html._2d_ in
  context##clearRect 0. 0. canvas_width canvas_height;
  List.iter (function
    | Font str -> context##.font := Js.string str
    | Fill (str,x,y) -> context##fillText (Js.string str) x y
    | Stroke (x,y,w,h) -> context##strokeRect x y w h
    | Empty -> ()) (fn arg);
  let* () = (Js_of_ocaml_lwt.Lwt_js.sleep 1.0) in
  let* () = if !connect then Telescope.status'' () else (Js_of_ocaml_lwt.Lwt_js.sleep 0.1) in
  let* () = if !connect then Telescope.postauth' () else (Js_of_ocaml_lwt.Lwt_js.sleep 0.1) in
  let* () = action_func !action in
  action := None;
  draw_things fn (fun _ -> ())

let choose fn =
  fn();
  let (found, ra', dec', mag') = Messier_catalogue.messier_array.(!sel) in
  let ra_flt = Altaz.cnv_ra ra' in
  let dec_flt = Altaz.cnv_dec dec' in

  let yr,mon,dy,hr,min,sec = split_date() in
  let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt (latitude()) (longitude()) in
  Astro_utils.show_entries found jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc nan ra_flt dec_flt nan nan nan (float_of_string mag') nan nan;
  let both = [
    Font "18px serif";
    Fill ( (Printf.sprintf "UTC: %.2d:%.2d:%.2d %d %s %.4d" hr min sec dy (Altaz.from_month mon) yr), 150., 140.);
    Fill ( ("GPS Status: "^ Cookie.get' "status"), 20., 180.);
    Font "14px serif";
    ] in
  let secure = [
    Font "18px serif";
    Fill ( ("Lat: "^Altaz.dms_of_float (latitude())), 20., 120.);
    Fill ( ("Long: "^Altaz.dms_of_float (longitude())), 150., 120.);
    Fill ( ("City: "^ city() ^"/"^ area() ^" TZ "^ tz_local()), 20., 160.) ] in
  let insecure = [
    Font "24px serif";
    Fill ( ("Messier Object: "^found), 20., 30.);
    Stroke (0., 0., canvas_width, canvas_height);
    Font "18px serif";
    Fill ( ("RA: "^ !entry_ra_ref), 20., 60.);
    Fill ( ("DEC: "^ !entry_dec_ref), 150., 60.);
    Fill ( ("Alt: "^ !entry_alt_ref), 20., 80.);
    Fill ( ("Az: "^ !entry_az_ref), 150., 80.); 
    Fill ( ("HA: "^Altaz.dms_of_float hour_calc), 20., 100.);
    Fill ( ("LST: "^Altaz.dms_of_float lst_calc), 150., 100.);
    Fill ( ("Bootcnt: "^string_of_int !Telescope.bootCnt), 200., 180.);
    Fill ( ("ID: "^ !Telescope.telescopeId), 20., 200.);
    Fill ( ("Humidity: "^ !Telescope.humref), 200., 200.);
    Font "10px serif";
    Fill ( ("Challenge: "^ !Telescope.challengeref), 20., 220.);
    Fill ( ("Auth: "^ !Telescope.authref), 20., 240.);
    Fill ( ("Version: "^ !Telescope.version), 20., 260.);
    Fill ( ("Temp: "^ !Telescope.tempref), 20., 280.);
    ] in
  insecure @ secure @ both

let (promise:unit Lwt.t ref) = ref @@ draw_things choose (fun () -> ())

let callback = fun main fn arg _ ->
      let doc = Dom_html.window##.document in
      let div = Dom_html.createDiv doc in
      Dom.appendChild main div;
      Lwt.cancel !promise;
      promise := draw_things fn arg;
      Js._false

let menu br name main fn lst = 
  let menu_showhide action =
    let action' = Js.string (if action then "block" else "none") in
    List.iter (fun itm -> itm##.style##.display := action') in
  let doc = Dom_html.window##.document in
  let res = doc##createDocumentFragment in
  let menu = Dom_html.createInput  ~_type:(Js.string "block") doc in
  menu##.value := Js.string (name^": ?");
  let itmref = ref [] in
  itmref := List.map (fun (itm,arg) ->
  let input = Dom_html.createInput  ~_type:(Js.string "block") doc in
  input##.value := Js.string itm;
  input##.onclick := Dom_html.handler (fun _ -> 
    menu_showhide false !itmref;
    menu_showhide true [menu];
    menu##.value := Js.string (name^": "^itm);
    fn itm arg;
    Js._false);
  Dom.appendChild res input;
  Dom.appendChild main res;
  input
  ) lst;
  menu_showhide false !itmref;
  menu##.onclick := Dom_html.handler (fun _ ->
    menu_showhide true !itmref;
    menu_showhide false [menu];
    Js._false);
  if br then Dom.appendChild res (Dom_html.createBr doc);
  Dom.appendChild res menu;
  Dom.appendChild main res

(* Generic button with text on input and an event gotten via onclick *)

let button br name main fn arg = 
  let doc = Dom_html.window##.document in
  let res = doc##createDocumentFragment in
  let input = Dom_html.createInput  ~_type:(Js.string "button") doc in
  input##.value := Js.string name;
  input##.onclick := Dom_html.handler (callback main fn arg);
  if br then Dom.appendChild res (Dom_html.createBr doc);
  Dom.appendChild res input;
  Dom.appendChild main res

let keyb br main =
  let shift = ref false in
  let doc = Dom_html.window##.document in
  let preview = Dom_html.createTextarea doc in
      preview##.readOnly := Js._false;
      preview##.cols := 16;
      preview##.rows := 2;
      preview##.style##.border := Js.string "1px black solid";
      preview##.style##.padding := Js.string "5px";
      preview##.style##.visibility := Js.string "visible";
      preview##.value := Js.string "";
  ignore
      (Dom_html.addEventListener
         Dom_html.document
         Dom_html.Event.keydown
         (Dom_html.handler (fun ev ->
           let cod = ev##.keyCode in
           let chr = char_of_int cod in
           match cod,chr  with
           | 13,_ ->
               shift := false;
               let sel' = Js.to_string preview##.value in
               preview##.value := Js.string "";
               let len = Array.length Messier_catalogue.messier_array in
               let ix = ref (try int_of_string (String.sub sel' 1 (String.length sel' - 1)) with _ -> 0) in
               if sel'.[0] <> 'M' || !ix = 0 || !ix > len then Array.iteri (fun i (a,_,_,_) -> if sel' = a then ix := i+1) Messier_catalogue.messier_array;
               if !ix = 0 || !ix > len
               then preview##.value := Js.string ("Messier: " ^ sel' ^ ": not found")
               else sel := !ix - 1;
               Js._false
           | 8,_ ->
               shift := false;
               let old = Js.to_string preview##.value in
               let len = String.length old in
               preview##.value := Js.string (String.sub old 0 (if len > 0 then len-1 else 0));
               Js._false
           | 16,_ ->
               shift := true;
               Js._false
           | num, '0' .. '9' ->
               let num' = if !shift then ")!@#$%^&*(".[num-(int_of_char '0')] else char_of_int num in
               shift := false;
               preview##.value := Js.string ((Js.to_string preview##.value) ^ String.make 1 (num'));
               Js._false
           | alpha, 'A' .. 'Z' ->
               let alpha' = if !shift then alpha else alpha+32 in
               shift := false;
               preview##.value := Js.string ((Js.to_string preview##.value) ^ String.make 1 (char_of_int alpha'));
               Js._false
           | 37,_ ->
               preview##.value := Js.string (" left ");
               Js._false
           | 38,_ ->
               preview##.value := Js.string (" up ");
               Js._false
           | 39,_ ->
               preview##.value := Js.string (" right ");
               Js._false
           | 40,_ ->
               preview##.value := Js.string (" down ");
               Js._false
           | cod,chr -> 
               preview##.value := Js.string (Js.to_string preview##.value^"\n"^string_of_int cod^": \""^String.make 1 chr^"\"");
               Js._true)) Js._true);
  if false then ignore
      (Dom_html.addEventListener
         Dom_html.document
         Dom_html.Event.click
         (Dom_html.handler (fun ev -> let codx,cody = ev##.screenX,ev##.screenY in if !verbose then print_endline (string_of_int codx^":"^string_of_int cody); preview##focus; Js._true)) Js._true);
  if br then Dom.appendChild preview (Dom_html.createBr doc);
  Dom.appendChild main preview

let catalogues = ["Simbad"; "Stellarium"; "Horizons"; "Messier"; "PGC"; "NGC2000"; "Abell"; "DSO"]

(*
let timezone = Js.to_string @@ Js.Unsafe.get Js.Unsafe.global (Js.string "Intl")##.DateTimeFormat##.resolvedOptions##.timeZone
*)

let onload _ =
  let doc = Dom_html.window##.document in
  Dom.appendChild doc##.body canvas;
  let main = Js.Opt.get (doc##getElementById (Js.string "openstellina")) (fun () -> assert false) in
  keyb false main;
  if not (is_secure_session ()) then 
    begin
    button true "connect" main choose (fun () -> connect := true);
    button true "Up" main choose (fun () -> incr sel; if !sel >= Array.length Messier_catalogue.messier_array then sel := Array.length Messier_catalogue.messier_array - 1);
    button false "Down" main choose (fun () -> decr sel; if !sel < 0 then sel := 0);
    button true "init" main choose (fun () -> action := Init);
    button false "observe" main choose (fun () -> action := Observe);
    button false "park" main choose (fun () -> action := Park);
    button false "status" main choose (fun () -> action := Consume);
    button false "preauth" main choose (fun () -> action := Preauth);
    button false "postauth" main choose (fun () -> action := Postauth);
    end;
  menu true  "Catalog" main (fun _ _ -> ()) (List.combine catalogues catalogues);
  let tz = tz_local() in
  Cookie.set "TZ" tz;
  let cities = Hashtbl.find Base_locations.loch tz in
  let cities' = List.map (fun (city,area,lat,long) -> city,(area,lat,long)) cities in
  menu true "Location" main (fun city (area,lat,long) ->
        Cookie.set "latitude" (string_of_float lat);
        Cookie.set "longitude" (string_of_float long);
        Cookie.set "city" city;
        Cookie.set "area" area;
        Cookie.set "status" "manual";
        ) cities';
(*
  ignore (Dom_html.addEventListener
         Dom_html.document
         Dom_html.Event.keydown
         (Dom_html.handler (fun ev -> 
           let cod = ev##.keyCode in
            match cod  with
           | 88 ->
               print_endline "alert";
               Js._false
           | cod -> 
               print_endline "unknown";
               Js._true)) Js._true);
  Json.save_text_to_file "hello.txt" "goodbye";
*)
  if is_secure_session () then Geo.geo();
(*
  Table.main main;
*)
  Js._false

let _ =
  Dom_html.window##.onload := Dom_html.handler onload
