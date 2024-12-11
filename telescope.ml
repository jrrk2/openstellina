(* Stellina expert App *)

open Lwt
open Cookie
open Version

let server = "10.0.0.1:"
let pth2' = "8082"
let pth3' = "8083"

let verbose_flag = ref false

let defcat = 7
let accstr = "alt_calc > 30.0 & (az_calc > 300.0 | az_calc < 60.0)"
let acceptance = Expr.simplify [] (Expr.expr accstr)
let tmpdir = (Filename.get_temp_dir_name ())^"/"

let approach = Array.length Sys.argv > 1 && Sys.argv.(1) = "-f"
let pairing = Array.length Sys.argv > 1 && Sys.argv.(1) = "-p"

let tim = Array.init (if approach then 8 else 6)
  (fun ix -> let lbl = ["Year";"Month";"Day";"Hour";"Minute";"Second";"Closest(km)";"Abs Mag"] in List.nth lbl ix)

let update_date yr mon dy hr min sec = ()

(*
let datum () = fst (Unix.mktime {
       tm_year=int_of_string(tim.(0)'()) - 1900;
       tm_mon=Altaz.month (tim.(1)'()) - 1;
       tm_mday=int_of_string(tim.(2)'());
       tm_hour=int_of_string(tim.(3)'());
       tm_min=int_of_string(tim.(4)'());
       tm_sec=int_of_string(tim.(5)'());
       tm_yday=0;
       tm_wday=0;
       tm_isdst=false})

let update_date yr mon dy hr min sec =
      tim_0_set_text (string_of_int yr);
      tim_1_set_text (string_of_int mon);
      tim_2_set_text (string_of_int dy);
      tim_3_set_text (string_of_int hr);
      tim_4_set_text (string_of_int min);
      tim_5_set_text (string_of_int sec)
*)

let split_date () =
    let tm = Unix.gmtime (Astro_utils.datum()) in
    tm.tm_year+1900,tm.tm_mon+1,tm.tm_mday,tm.tm_hour,tm.tm_min,tm.tm_sec

let reset_date tim =
    let tm = Unix.gmtime tim in
    let yr,mon,dy,hr,min,sec = tm.tm_year+1900,tm.tm_mon+1,tm.tm_mday,tm.tm_hour,tm.tm_min,tm.tm_sec in
    update_date yr mon dy hr min sec

let ephem_lst = List.init 25 (fun ix -> Printf.sprintf "%.2d:00" ix)

let cnv body =
  let trim = try int_of_string (String.sub body 0 (String.index body ':')) with _ -> String.length body in
  let lftidx1 = if String.contains body '{' then String.index body '{' else String.length body in
  let lftidx2 = if String.contains body '[' then String.index body '[' else String.length body in
  let lftidx = min lftidx1 lftidx2 in
  let body = String.sub body lftidx (min trim (String.length body - lftidx)) in
  let rghtidx1 = if String.contains body '}' then String.rindex body '}' else 0 in
  let rghtidx2 = if String.contains body ']' then String.rindex body ']' else 0 in
  let rghtidx = max rghtidx1 rghtidx2 in
  let body = if rghtidx+1 < String.length body then String.sub body 0 (rghtidx + 1) else body in
  if false then print_endline ("cnv: "^body^"\n");
  try if body <> "" then Yojson.Safe.from_string body else `String ""
  with err -> print_endline ("Exception: "^Printexc.to_string_default err^"\n"^body^"\n"^body^"\n"); `String body

let params' = [ ("name", version); ("EIO", "3"); ("id", version); ("transport", "polling")]
let pth = pth3'^"/socket.io/"
let hdrs = ref []
let authref = ref ""
let bootCnt = ref 0
let telescopeId = ref "Unknown"
let challengeref = ref "Unknown"
let debugref = ref ""
let errorref = ref "startup"
let tempref = ref ""
let humref = ref ""
let defogref = ref "Unknown"
let dewpointref = ref "Unknown" 
let az_posref = ref "0.0"
let alt_posref = ref "0.0"
let motor_state_ref = ref "IDLE"
let der_posref = ref "0.0"
let map_posref = ref "0.0"
let version_ref = ref "Unknown"
let initialized_ref = ref "No"
let shutting_down_ref = ref "No"
let humidity_delta_ref = ref "0.0"
let temperature_delta_ref = ref "0.0"
let autofocus_ref = ref "0"
let model_ref = ref "Unknown"
let board_debug_ref = ref "No"
let api_version_ref = ref "Unknown"
let storage_system_size_ref = ref "0"  
let storage_system_avail_ref = ref "0"
let storage_data_size_ref = ref "0"
let storage_data_avail_ref = ref "0"
let storage_band_ref = ref "Unknown"
let installed_version_ref = ref "Unknown"
let min_compat_version_ref = ref "Unknown"
let update_state_ref = ref "Unknown"
let current_target_ref = ref "None"
let position_lat_ref = ref "Unknown"
let position_lon_ref = ref "Unknown"

let proto = "http://"

let cnv' iter = fun s -> let lst = fun s ->
    let l = String.split_on_char '\n' s in
    List.iter (fun s ->
                   if s <> "{\"success\":true,\"result\":{\"message\":\"buffer is empty\"}}" then 
                   if false then print_endline s) l;
    l in
    List.iter iter (lst s)

let rotate = ref 0

let jwrap json =
   let json' = "42"^Yojson.Safe.to_string json in
   let body = string_of_int (String.length json')^":"^json' in
   body

let senduser user =
  let json = `List
  [`String "message"; `String "sendUserName";
   `Assoc
     [("device", `String version);
      ("user", `String user)]] in
   jwrap json

let preref = ref ""
let key_server = "62.210.163.183"
let key_port = "49049"

let handle_response body_text headers =
  preref := Printf.sprintf "Body: %s\nHeaders: %s\n" body_text
    (String.concat ", " (List.map (fun (k, v) -> k ^ ": " ^ v) headers))

let preauth' () =
  let uri = Uri.of_string ("http://"^key_server^":"^key_port^"/generate-authorization") in
  Astro_utils.send_preflight_options_request uri handle_response

let postauth' cnvauth =
    let server = key_server^":" in
    let params = [ ] in
    let headers = ["Content-Type", "application/json"] in
    let f = (fun s -> cnvauth s) in
    let (json:Yojson.Safe.t) = (`Assoc [
      ("bootCount", `Int !bootCnt);
      ("telescopeId", `String !telescopeId);
      ("challenge", `String !challengeref)
    ])
  in
    Astro_utils.post' proto server params headers (key_port^"/generate-authorization") ((Yojson.Safe.to_string json)) (cnv' f)

let auth' () = 
let auth = !authref in
Astro_utils.split (
("Authorization: "^ auth) ::
"Content-Type: application/json; charset=UTF-8" ::
[])

let status_fun' fn =
    let params = [] in
    let headers = auth' () in
    let pth = pth2'^"/v1/logs/consume" in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server params headers pth (("{}")) (cnv' f)

let mos_id  = ref ""
let xflip = ref "BOTH"

let xgain = ref 200
let ephem_data_lst = ref []

let planet_lst = []
let expos_us () = Astro_utils.expos_us()

let entry_ra' = Astro_utils.entry_ra'
let entry_dec' = Astro_utils.entry_dec'
let entry_alt' = Astro_utils.entry_alt'
let entry_az' = Astro_utils.entry_az'
let entry_nam' = Astro_utils.entry_nam'

let entry_duration'() = "10"
let entry_darkcnt'() = "1"
let entry_gridw'() = "1"
let entry_gridh'() = "1"
let entry_numi'() = "1"
let entry_nump'() = "1"
let entry_wminov'() = "1"
let entry_hminov'() = "1"
let entry_wpassof'() = "1"
let entry_hpassof'() = "1"

let entry_nam_set_text nam = ()
let entry_ra_set_text nam = ()
let entry_dec_set_text nam = ()
let entry_alt_set_text nam = ()
let entry_az_set_text nam = ()
let entry_mag_set_text nam = ()
let entry_ang_set_text nam = ()
let entry_darkcnt_set_text nam = ()
let targ_status_set_text nam = ()
let targ_entry_set_text nam = ()

let stellarium_enabled_active() = false

let targ_entry'() = "target"
let ephem_set_active hr = ()
let tbuffer_set_text txt = ()
let tbuffer_insert ~tag_names txt = ()
let tbuffer_bounds'() = (0,99)
let tbuffer_apply_tag_by_name nam ~start ~stop = ()

let tim_6_set_text txt = ()
let tim_7_set_text txt = ()

(*
let jpegadd s =
 let len = String.length s in
 let root = "/files/" in
 let rlen = String.length root in
 if len > rlen && String.sub s 0 rlen = root then
    begin
    if Hashtbl.mem jpegh s then () else
        begin
        if!verbose_flag then print_endline ("jpegadd: "^s);
(* *)
        Hashtbl.add jpegh s (ref false);
(* *)
        end;
(*
    status_jpeg_set_text s;
*)
    end
*)

let rec to_ascii x =
  let d = floor (x /. 10.) in
  (if d > 0. then to_ascii d else "")^string_of_int (int_of_float(x -. d *. 10.))

let time_ms() = to_ascii (Astro_utils.datum() *. 1000.0)

let init' fn =
    let cmd = "startAutoInit" in
    print_endline cmd;
    let pth = pth2'^"/v1/general/"^cmd in
    let lat_flt = Cookie.get' "latitude" in
    let long_flt = Cookie.get' "longitude" in
    let lat_flt = "52.2" and long_flt = "0.0" in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Raw.to_string (`Assoc
    [
    ("longitude", `Floatlit long_flt);
    ("latitude", `Floatlit lat_flt);
    ("time", `Intlit (time_ms()));
    ("observatoryId", `Stringlit ("\"111a4385-b4cc-4be6-a1a6-eab551711501\""));
    ("observatoryName", `Stringlit ("\"Hardwick\""));
    ("skipAutoFocus", `Bool false)
    ] )^"\r\n")) (cnv' f)

let manualinit' fn =
    let cmd = "startManualInit" in
    let pth = pth2'^"/v1/general/"^cmd in
    let lat_flt = latitude() in
    let long_flt = longitude() in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string (`Assoc
    [("latitude", `Float lat_flt);
     ("longitude", `Float long_flt); ("time", `Intlit (time_ms()))] ))) (cnv' f)

let observe' fn =
    let cmd = "general/startObservation" in
    let pth = pth2'^"/v1/"^cmd in
    let ra_flt = Altaz.cnv_ra (entry_ra'()) in
    let dec_flt = Altaz.cnv_dec (entry_dec'()) in
    if!verbose_flag then print_endline (string_of_float ra_flt^" "^string_of_float dec_flt);
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string (`Assoc
    [("ra", `Float ra_flt);
     ("de", `Float dec_flt);
     ("isJ2000", `Bool true);
     ("rot", `Int 0);
     ("objectId", `String (Astro_utils.entry_nam'()));
     ("objectName", `String (Astro_utils.entry_nam'()));
     ("gain", `Int (Astro_utils.gain_int()));
     ("exposureMicroSec", `Int (expos_us()));
     ("doStacking", `Bool true);
     ("histogramEnabled", `Bool true);
     ("histogramLow", `Float (-0.75));
     ("histogramMedium", `Int 5);
     ("histogramHigh", `Int 0);
     ("backgroundEnabled", `Bool true);
     ("backgroundPolyorder", `Int 4)]))) (cnv' f)

let darks' fn =
    let pth = pth2'^"/v1/expertMode/startStorageAcquisition" in
    let xpth = "expert-mode/gain"^string_of_int !xgain in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string (`Assoc
    [("path", `String xpth);
     ("overwrite", `Bool true);
     ("numExposures", `Int (int_of_string (entry_darkcnt'())));
     ("gain", `Int !xgain);
     ("exposureMicroSec", `Int (expos_us()));
     ("flip", `String !xflip)]))) (cnv' f)

let focus' fn =
    let pth = pth2'^"/v1/general/adjustObservationFocus" in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ("{}") (cnv' f)

let stopobs' fn =
    let pth = pth2'^"/v1/general/stopObservation" in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ("{}") (cnv' f)

let status_fun fn =
    let pth = pth2'^"/v1/app/status" in
    let f = (fun s -> fn (cnv s)) in
    let headers = Astro_utils.split [
      "Accept: */*";
    ] in
    Astro_utils.get' proto server [] headers pth (cnv' f) hdrs

let openarm' fn =
    let pth = pth2'^"/v1/general/openForMaintenance" in
    let f = (fun s -> fn (cnv s)) in
    let headers = auth' () in
    Astro_utils.post' proto server [] headers pth ("{}") (cnv' f)

let motorstatus fn =
    let pth = pth2'^"/v1/debug/motors/readAllStatusRegisters" in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ("{}") (cnv' f)

let motorgo fn =
    let pth = pth2'^"/v1/motors/goAbsolute" in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string (`Assoc
    [("ALT", `Float (Altaz.cnv_dec (entry_alt'())));
     ("AZ", `Float (Altaz.cnv_dec (entry_az'())))] ))) (cnv' f)

let track fn =
    let pth = pth2'^"/v1/motors/track" in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string (`Assoc
    [("ALT", `Bool true);
     ("AZ", `Bool true)] ))) (cnv' f)

let trackoff fn =
    let pth = pth2'^"/v1/motors/track" in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string (`Assoc
    [("ALT", `Bool false);
     ("AZ", `Bool false)] ))) (cnv' f)

let singlefocus fn =
    let pth = pth2'^"/v1/focus/singleFocus" in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string (`Assoc
    [("algorithm", `String "DCT");
     ] ))) (cnv' f)

let autofocus fn =
    let pth = pth2'^"/v1/focus/startAutoFocus" in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string (`Assoc
    [("algorithm", `String "DCT");
     ] ))) (cnv' f)

let park' fn =
    print_endline "Park'";
    let pth = pth2'^"/v1/general/park" in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ("{}") (cnv' f)

let astrometry fn =
    let pth = pth2'^"/v1/astrometry/singleAstrometry" in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string (`Assoc
    [("type", `String "JPEG");
     ("binning", `Int 2);
     ("gain", `Int (Astro_utils.gain_int()));
     ("exposureMicroSec", `Int 500000);
     ("convertToDate", `Bool false)] ))) (cnv' f)

let readparams fn =
    let pth = pth2'^"/v1/camera/debug_readParams" in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string (`Assoc
    [] ))) (cnv' f)

let mosaic fn =
    mos_id := "mo"^string_of_int (int_of_float (Unix.time()) mod 1000000);
    let pth = pth2'^"/v1/automator/writeMosaicProgram" in
    let f = (fun s -> fn (cnv s)) in
    let ra_flt = Altaz.cnv_ra (entry_ra'()) in
    let dec_flt = Altaz.cnv_dec (entry_dec'()) in
    let params = `Assoc [
      ("doStacking", `Bool true);
      ("gain", `Int (Astro_utils.gain_int()));
      ("histogramEnabled", `Bool true);
      ("histogramLow", `Int (-1));
      ("histogramMedium", `Int 5);
      ("histogramHigh", `Int 0);
      ("backgroundEnabled", `Bool true);
      ("exposureMicroSec", `Int (expos_us()));
      ("objectId", `String (entry_nam'()))] in
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string (`Assoc
    [("programName", `String !mos_id);
     ("ra", `Float ra_flt);
     ("de", `Float dec_flt);
     ("settingsFrom", `String (entry_nam'()));
     ("gridWidth", `Int (int_of_string (entry_gridw'())));
     ("gridHeight", `Int (int_of_string (entry_gridh'())));
     ("numImages", `Int (int_of_string (entry_numi'())));
     ("numPasses", `Int (int_of_string (entry_nump'())));
     ("widthMinOverlap", `Float (float_of_string (entry_wminov'())));
     ("heightMinOverlap", `Float (float_of_string (entry_hminov'())));
     ("widthPassOffset", `Float (float_of_string (entry_wpassof'())));
     ("heightPassOffset", `Float (float_of_string (entry_hpassof'())));
     ("observationParams", params)] ))) (cnv' f)

let obsprog fn =
    let pth = pth2'^"/v1/automator/runObservationProgram" in
    let lat_flt = latitude() in
    let long_flt = longitude() in
    let f = (fun s -> fn (cnv s)) in
    print_endline !mos_id;
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string (`Assoc
    [("programName", `String !mos_id);
     ("skipAutoInit", `Bool false);
     ("latitude", `Float lat_flt);
     ("longitude", `Float long_flt);
     ("startTime", `Intlit (time_ms()))] ))) (cnv' f)

let samples fn =
    let pth = pth2'^"/v1/automator/takeSamples" in
    let lat_flt = latitude() in
    let long_flt = longitude() in
    let f = (fun s -> fn (cnv s)) in
    let expos_lst = `Int (expos_us() / 4) :: `Int (expos_us() / 2) :: `Int (expos_us()) :: `Int (expos_us() * 2) :: `Int (expos_us() * 4) :: [] in
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string (`Assoc
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
   ("mapRange2", `List [`Int 175000; `Int 225000])] ))) (cnv' f)

let abortall fn =
    let pth = pth2'^"/v1/app/abortAllOperations" in
    let f = (fun s -> fn (cnv s)) in
    Astro_utils.post' proto server [] (auth' ()) pth ("{}") (cnv' f)

let show_entries nam jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc jd ra dec azi elev sidt apmag hour_ang ang_diam =
    if nam <> "" then entry_nam_set_text nam;
    entry_ra_set_text (Altaz.hms_of_float ra);
    entry_dec_set_text (Altaz.dms_of_float dec);
    entry_alt_set_text (Altaz.dms_of_float (alt_calc));
    entry_az_set_text (Altaz.dms_of_float (az_calc));
    entry_mag_set_text (Printf.sprintf "%.2f" apmag);
    entry_ang_set_text (Printf.sprintf "%.2f" ang_diam);
(*
    spare_0_set_text (Altaz.dms_of_float (elev));
    spare_1_set_text (Altaz.dms_of_float (azi));
    spare_2_set_text (Printf.sprintf "%.4f" lst_calc);
    spare_3_set_text (Printf.sprintf "%.4f" hour_calc);
    spare_4_set_text (Printf.sprintf "%.4f" (sidt));
    spare_5_set_text (Printf.sprintf "%.4f" (hour_ang));
    spare'_0_set_text (Altaz.hms_of_float ra_now);
    spare'_1_set_text (Altaz.dms_of_float dec_now);
    spare'_2_set_text (string_of_float (jd_calc));
    spare'_3_set_text (string_of_float (jd));
    spare'_4_set_text (string_of_float ra);
    spare'_5_set_text (string_of_float dec)
*)
    ()

let show_ephem ix =
    let lst = !ephem_data_lst in
    let (eph:string) = if List.length lst > ix then List.nth lst ix else String.make 80 ' ' in
    print_endline eph;
    try let scan = Scanf.sscanf eph " %d-%[A-Za-z]-%d %d:%d %f %[A-Za-z*] %f %f %f %f %f %f %f %f %[^ ] %[A-Za-z] %f"
                        (fun yr mon dy hr min jd sun ra dec azi elev daz delv sidt apmag sbrt cnst hour_ang ->
                            (yr,mon,dy,hr,min,jd,sun,ra,dec,azi,elev,daz,delv,sidt,apmag,sbrt,cnst,hour_ang)) in
    let (yr,mon,dy,hr,min,jd,sun,ra,dec,azi,elev,daz,delv,sidt,apmag,sbrt,cnst,hour_ang) = scan in
    let latitude = latitude() in
    let longitude = longitude() in
    let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr (Altaz.month mon) dy hr min 0 ra dec latitude longitude in
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
    let datum' = Astro_utils.datum() in
    let t = Unix.gmtime datum' in
    let t' = Unix.gmtime (datum' +. 86400.0) in
    let f = (fun s ->
       let body = ref "" in
       ephem_data_lst := List.filter (fun x' ->
       let x = String.trim x' in
       let str = if String.length x > 5 then String.sub x 0 4 else "" in
       let trial = try (int_of_string str) with _ -> 0 in
       let use = trial = t.tm_year+1900 in
       let tok = Array.of_list (List.filter (function "" -> false | _ -> true) (String.split_on_char ' ' x)) in
       if Array.length tok > 0 && tok.(0) = "Revised:" then
          begin
          let ix = ref (Array.length tok - 1) in
          while (tok.(!ix).[0] >= '0' && tok.(!ix).[0] <= '9') || (tok.(!ix) = "/") do decr ix done;
(*
          print_endline ("last ix="^string_of_int !ix);
          if true then Array.iteri (fun ix itm -> print_endline (string_of_int ix^": \""^itm^"\"")) tok;
*)
          body := String.concat " " (Array.to_list (Array.sub tok 4 (!ix - 3)));
          end
       else if Array.length tok > 0 && tok.(0) = "JPL/HORIZONS" then
          begin
(*
          if true then Array.iteri (fun ix itm -> print_endline (string_of_int ix^": "^itm)) tok;
*)
          body := String.concat " " (Array.to_list (Array.sub tok 1 (Array.length tok - 3)));
          end;
       if!verbose_flag then print_endline x;
       use) (String.split_on_char '\n' s);
       targ_status_set_text ("horizons: "^ !body);
       entry_nam_set_text !body;
       ephem_set_active t.tm_hour;
       show_ephem t.tm_hour) in
    let lat_flt = latitude() in
    let long_flt = longitude() in
    let req = 
    [("COMMAND", "'"^ (targ_entry'()) ^"'");
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
    if!verbose_flag then List.iter (fun (k,x) -> print_endline (k^": "^x)) req;
    Astro_utils.get' "https://" server req [] pth f hdrs

type smdb = {
    jd: float;
    h: float;
    des: string;
    orb: string;
    cd: string;
    dist: string;
    dist_min: string;
    dist_max: string;
    v_rel: string;
    v_inf: string;
    t_sigma_f: string;
    }

let dump_smdb fd {jd;des;orb;cd;dist;dist_min;dist_max;v_rel;v_inf;t_sigma_f;h} =
  output_string fd (des^" "^orb^" "^string_of_float jd^" "^cd^" "^dist^" "^dist_min^" "^dist_max^" "^v_rel^" "^v_inf^" "^t_sigma_f^" "^string_of_float h^"\n")

(*
let smdb_compare {h=a;_} {h=b;_} =
   let lft = float_of_string a in
   let rght = float_of_string b in
   print_endline (string_of_float lft^" "^string_of_float rght);
   int_of_float (lft -. rght)
*)

let smdb_list = function
| `List
           [`String des; `String orb; `String jd';
            `String cd; `String dist;
            `String dist_min; `String dist_max;
            `String v_rel; `String v_inf;
            `String t_sigma_f; `String h'] -> let jd = float_of_string jd' and h = float_of_string h' in {jd;h;des;orb;cd;dist;dist_min;dist_max;v_rel;v_inf;t_sigma_f}
| _ -> failwith "json_list"

let  (smdb_decode:Yojson.Safe.t -> smdb list) = function
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

let dump_cat fd (sel, (ra_flt,dec_flt,desc,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) =
  ignore (jd_calc, ra_now, dec_now, lst_calc, hour_calc);
  output_string fd (sel^" \""^desc^"\" "^string_of_float ra_flt^" "^string_of_float dec_flt^" "^string_of_float mag^" "^string_of_float alt_calc^" "^string_of_float az_calc^" "^string_of_float diam^"\n")

let sort_mag a b =
  let (_, (_,_,_,_,maga,_,_,_,_,_,_,_)) = a in
  let (_, (_,_,_,_,magb,_,_,_,_,_,_,_)) = b in
  if maga < magb then -1 else 1

let sort_diam a b =
  let (_, (_,_,_,diama,_,_,_,_,_,_,_,_)) = a in
  let (_, (_,_,_,diamb,_,_,_,_,_,_,_,_)) = b in
  if diama < diamb then 1 else -1

let fitsref = ref "/files/temp/acquisition/IMG_0001.fits"

let usleep t = ()
(*
ignore (Unix.select [] [] [] t)
*)

(*

old version that seems unreliable

let fetch' () =
    if!verbose_flag then print_endline ("Fetching: "^ (!fitsref));
    let pth = pth2'^(!fitsref) in
    let headers = Astro_utils.split ["Accept-Encoding: identity";
      "Accept: */*";
      "Connection: Keep-Alive"] in
    Alpaca_lwt.rs := "";
    let f = fun s -> print_endline ("Downloaded "^string_of_int (String.length s)); Alpaca_lwt.rs := !(Alpaca_lwt.rs)^s; usleep 0.1 in
    Astro_utils.get' proto server [] headers pth (cnv' f) hdrs

let dump' () =
    let pth = String.rindex (!fitsref) '/' in
    let pth' = String.sub (!fitsref) (pth+1) (String.length (!fitsref) - pth - 1) in
    print_endline ("Dumping: "^tmpdir^pth'^" bytes = "^string_of_int (String.length !(Alpaca_lwt.rs)));
    let fd = open_out (tmpdir^pth') in
    output_string fd !(Alpaca_lwt.rs);
    close_out fd;
    Lwt.return_unit
*)

let fetch' () =
    if!verbose_flag then print_endline ("Fetching: "^ (!fitsref));
    Lwt.return_unit

let dump' () =
    let pth = String.rindex (!fitsref) '/' in
    let pth' = String.sub (!fitsref) (pth+1) (String.length (!fitsref) - pth - 1) in
    let url = "curl -s "^proto^server^pth2'^(!fitsref)^" >"^tmpdir^pth' in
    print_endline url;
(*
    let rc = Sys.command url in
    print_endline ("Dumping: "^tmpdir^pth'^" return code = "^string_of_int rc);
    Alpaca_lwt.read_image (tmpdir^pth');
    Alpaca_lwt.image_ready true;
*)
    Lwt.return_unit

let quit' = ref false

let show_prog_entries prog_entries =
    tbuffer_set_text "";
    tbuffer_insert ~tag_names:["bold";"monospace"] (Printf.sprintf "                      target_name # time right_asc. declination expos. gain rot.    ra_now   dec_now  altitude  azimuth   loc. sid.   hour ang status");
    tbuffer_insert ~tag_names:["monospace"] "\n";
    List.iteri (fun ix -> fun (json:Yojson.Safe.t) -> match json with `Assoc
         [("duration", `Int duration);
          ("params",
           `Assoc [("objectId", `String id);
             ("ra", `Float ra_flt);
             ("de", `Float dec_flt);
             ("rot", `Int rot); 
             ("gain", `Int gain);
             ("histogramEnabled", _);
             ("histogramLow", _);
             ("histogramMedium", _);
             ("histogramHigh", _);
             ("backgroundEnabled", _);
             ("exposureMicroSec", `Int expos_us);
             ("doStacking", _);
             ("debayerInterpolation", _)])] ->
         tbuffer_insert ~tag_names:["monospace"] (Printf.sprintf " %32s" id);
         tbuffer_insert ~tag_names:["monospace"] (Printf.sprintf "%2d %4d" (ix+1) duration);
         tbuffer_insert ~tag_names:["monospace"] (Printf.sprintf " %9s" (Altaz.hms_of_float ra_flt));
         tbuffer_insert ~tag_names:["monospace"] (Printf.sprintf " %9s" (Altaz.dms_of_float dec_flt));
         tbuffer_insert ~tag_names:["monospace"] (Printf.sprintf "%8.3f" (float_of_int expos_us /. 1e6));
         tbuffer_insert ~tag_names:["monospace"] (Printf.sprintf " %4.1f" (float_of_int gain /. 10.));
         tbuffer_insert ~tag_names:["monospace"] (Printf.sprintf "   %4d" rot);
         let latitude = latitude() in
         let longitude = longitude() in
         let yr,mon,dy,hr,min,sec = split_date() in
         let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
         let acclst = ("alt_calc", Calc.Num alt_calc) :: ("az_calc", Calc.Num az_calc) :: ("mag", Calc.Num nan) :: ("ang_diam", Calc.Num nan) :: [] in
         tbuffer_insert ~tag_names:["monospace"] (Printf.sprintf " %9s" (Altaz.hms_of_float ra_now));
         tbuffer_insert ~tag_names:["monospace"] (Printf.sprintf " %9s" (Altaz.dms_of_float dec_now));
         tbuffer_insert ~tag_names:["monospace"] (Printf.sprintf " %9s" (Altaz.dms_of_float alt_calc));
         tbuffer_insert ~tag_names:["monospace"] (Printf.sprintf " %10s" (Altaz.dms_of_float az_calc));
         tbuffer_insert ~tag_names:["monospace"] (Printf.sprintf " %8.4f" lst_calc);
         tbuffer_insert ~tag_names:["monospace"] (Printf.sprintf " %8.4f " hour_calc);
         let stat = match Expr.simplify acclst acceptance with
           | Calc.Bool true -> "  ** observable **\n"
           | Calc.Bool false -> "  ** outside viewport **\n"
           | _ -> "  ** undecidadable **\n" in
         ignore (jd_calc);
         tbuffer_insert ~tag_names:["monospace"] stat
         | _ -> ()) (List.rev prog_entries);
    let start,stop = (tbuffer_bounds'()) in
    tbuffer_apply_tag_by_name "monospace" ~start ~stop
    
let rec (yojson_of_yojson_basic:Yojson.Safe.t -> Yojson.t) = function
| `Assoc l -> `Assoc (List.map (fun (x,y) -> (x, yojson_of_yojson_basic y)) l)
| `List l -> `List (List.map (fun y -> (yojson_of_yojson_basic y)) l)
| `Int n -> `Int n
| `Bool b -> `Bool b
| `Float f -> `Float f
| `String s -> `String s
| `Tuple t -> `Tuple (List.map (fun y -> (yojson_of_yojson_basic y)) t)
| `Intlit i -> `Intlit i
| `Variant (v,None) -> `Variant (v,None)
| `Variant (v,Some j) -> `Variant (v,Some (yojson_of_yojson_basic j))
| `Null -> failwith "yojson_basic"

let load_prog_entries () =
    try let fd = open_in (tmpdir^"prog_entries.json") in
    (match (*yojson_of_yojson_basic*) (Yojson.Safe.from_channel fd) with `List lst -> List.rev lst | _ -> []);
    with Sys_error _ -> []

let dump_prog_entries prog_entries =
    let fd = open_out (tmpdir^"prog_entries.json") in
    output_string fd (Yojson.Safe.pretty_to_string (`List (List.rev prog_entries)));
    close_out fd

let clearprog() =
    dump_prog_entries [];
    show_prog_entries [];
    Lwt.return_unit

let app_quit' () = print_endline "quit flagged"; quit' := true; Lwt.return_unit

let startprog fn =
    let pth = pth2'^"/v1/automator/startObservationProgram" in
    let lat_flt = latitude() in
    let long_flt = longitude() in
    let f = (fun s -> fn (cnv s)) in
    let lst = List.rev (load_prog_entries()) in
    dump_prog_entries [];
    print_endline ("Entries in program: "^string_of_int (List.length lst));
    List.iteri (fun ix (itm:Yojson.Safe.t) -> print_endline ("observation["^string_of_int ix^"]: "^Yojson.Safe.to_string itm)) lst;
    let (prog':Yojson.Safe.t) = `Assoc
        [("skipAutoInit", `Bool false);
         ("latitude", `Float lat_flt);
         ("longitude", `Float long_flt);
         ("startTime", `Intlit (time_ms()));
         ("observations", `List lst)] in
    print_endline !mos_id;
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string prog')) (cnv' f)
(*
let rec cat'' cat_entries nentries lbl' =
  List.iteri (fun ix loc -> if loc=lbl' then
      begin
      let (sel, (ra_flt, dec_flt, cnst, diam, mag, jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) = cat_entries.(ix) in
      dump_cat stderr (sel, (ra_flt,dec_flt,cnst,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc));
      show_entries sel jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc nan ra_flt dec_flt nan nan nan mag nan diam;
      targ_entry_set_text "";
      targ_status_set_text "";
      sm_jump "setfocus";
      end) nentries

and singleshot () =
    let pth = pth2'^"/v1/camera/singleAcquisition" in
(*
    let binning = match Hashtbl.find Alpaca_lwt.alpacah ("camera", [("connected","binx")]) with `Int size -> size | _ -> 1 in
*)
    let binning = 1 in
    let f = (fun s -> match cnv s with
      | `Assoc
  [("success", `Bool true);
   ("result",
    `Assoc
      [("type", `String "FITS"); ("acqTime", `Int acqtime);
       ("mean", `Int mean);
       ("motors",
        `Assoc
          [("AZ", az); ("ALT", alt); ("DER", der); ("MAP", map)]);
       ("path", `String path);
       ("url", `String fits)])] -> ignore (acqtime,mean,az,alt,der,map,path); fitsref := fits; sm_jump "fetch"
  | `Assoc
  [("success", `Bool false);
   ("error",
    `Assoc
      [("name", `String "CAMERA.CAMERA_FAILURE");
       ("chain", `List [`String ""])])] -> print_endline "failed"

       | _ -> print_endline "response from singleshot not understood") in
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string (`Assoc
    [("type", `String "FITS"); (* or JPEG *)
     ("wbr", `Int 50);
     ("wbb", `Int 60);
     ("flip", `Bool false);
     ("gain", `Int (Astro_utils.gain_int()));
     ("binningType", `String "HARD");
     ("binning", `Int binning);
     ("exposureMicroSec", `Int (expos_us()));
     ("requestStats", `Bool false);
     ("enableMoonStats", `Bool false)] ))) (cnv' f)

and sm_jump lbl' = 
  let target = ref (-1) in
  print_endline lbl';
  Array.iteri (fun ix (lbl, _) -> if lbl=lbl' && !target==(-1) then (target := ix; if true || !verbose_flag then print_endline (string_of_int (ix+1)^": "^lbl'))) taskarray;
  if !target <> -1 then
    begin
    Queue.add !target start;
    if!verbose_flag then print_endline (fst taskarray.(!target))
    end

and search () = 
    let s = (targ_entry'()) in
    (try let _ = int_of_string s in rbuttons 2 with _ -> ());
    sm_jump !xserv
*)

and smdb'' sentries lbl' = 
  List.iteri (fun ix loc -> if loc=lbl' then
      begin
      let {des;orb;jd;cd;dist;dist_min;dist_max;v_rel;v_inf;t_sigma_f;h} = !smdb_entries.(ix) in
      dump_smdb stderr ({des;orb;jd;cd;dist;dist_min;dist_max;v_rel;v_inf;t_sigma_f;h});
      let scan = Scanf.sscanf cd " %d-%[A-Za-z]-%d %d:%d"
                        (fun yr mon dy hr min ->
                            (yr,mon,dy,hr,min)) in
      let (yr,mon,dy,hr,min) = scan in
      update_date yr (Altaz.month mon) dy hr min 0;
      tim_6_set_text (Printf.sprintf "%8.0f" (1.496e8 *. float_of_string dist_min));
      tim_7_set_text (string_of_float h);
      targ_entry_set_text lbl';
(*
      rbuttons 2;
      search();
*)
      end) sentries

and smdb' () = if approach then
    begin
    print_endline "Flyby/closest approach calculation";
    let hdrs = ref [] in
    let server =  "ssd-api.jpl.nasa.gov" in
    let pth = "/cad.api" in
    let datum = Unix.gettimeofday() in
    let t = Unix.gmtime datum in
    let t' = Unix.gmtime (datum +. 86400.0 *. 365.2425) in
    let f = (fun s ->
        let lst = smdb_decode (Yojson.Safe.from_string s) in
        let dbgfile = open_out (tmpdir^"smdba1.txt") in
        List.iter (dump_smdb dbgfile) lst;
        close_out dbgfile;
        let srt = List.sort compare lst in
        let dbgfile = open_out (tmpdir^"smdba2.txt") in
        List.iter (dump_smdb dbgfile) srt;
        close_out dbgfile;
        smdb_entries := Array.sub (Array.of_list srt) 0 20;
        let sentries = List.map (fun {des;_} -> des) (Array.to_list !smdb_entries) in
(*
        List.iter (GEdit.text_combo_add smenu) sentries;
        ignore ((fst smenu)#entry#connect#changed ~callback: (fun () -> smdb'' sentries (fst smenu)#entry'()));
        (fst smenu)#set_active 0;
*)
        ()
         ) in
    let req = [
     ("date-min", Printf.sprintf "%d-%.2d-%.2d" (t.tm_year+1900) (t.tm_mon+1) t.tm_mday);
     ("date-max", Printf.sprintf "%d-%.2d-%.2d" (t'.tm_year+1900) (t'.tm_mon+1) t'.tm_mday);
    ] in
    if true then List.iter (fun (k,x) -> print_endline (k^": "^x)) req;
    Astro_utils.get' "https://" server req [] pth f hdrs
    end
 else
    begin
    let yr,mon,dy,hr,min,sec = split_date() in
    let latitude = latitude() in
    let longitude = longitude() in
    let lst = ref [] in
    Expr.dump stdout [] acceptance;
    let skiplst = ["DN" ; "CL" ; "YSO" ; "MoC"; "*"; "ISM"; "CGb"] in
    let srt = match defcat with
      | 3 -> Array.iter (fun (sel, ra, dec, mag) ->
        let mag = float_of_string mag in
        let diam = nan in
        let cnst = "" in
        let ra_flt = Altaz.cnv_ra ra in
        let dec_flt = Altaz.cnv_dec dec in
        let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
        let acclst = ("alt_calc", Calc.Num alt_calc) :: ("az_calc", Calc.Num az_calc) :: ("mag", Calc.Num mag) :: ("ang_diam", Calc.Num diam) :: [] in
        match Expr.simplify acclst acceptance with
          | Calc.Bool true ->
            if mag <> nan then lst := (sel, (ra_flt,dec_flt,cnst,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) :: !lst;
          | Calc.Bool false -> ()
          | oth -> Expr.dump stderr acclst oth
        ) Messier_catalogue.messier_array;
        List.rev !lst
(*
      | 4 -> Hashtbl.iter (fun sel -> function (_ :: _ :: _ :: rh :: rm :: rs :: decs :: dd :: dm :: ds :: _ :: _ :: a :: _ :: _ :: _ :: _ :: _ :: _ :: _ :: _ :: _ :: _) ->
        let mag = 20.0 in
        let diam = float_of_string a in
        let cnst = "" in
    let ra_flt = float_of_string rh *. 15.0 +. float_of_string rm /. 4.0 +. float_of_string rs /. 240.0 in
    let dec_flt = float_of_string dd +. float_of_string dm /. 60.0 +. float_of_string ds /. 3600.0 in
    let dec_flt = if decs.[0] = '-' then -. dec_flt else dec_flt in
        let yr,mon,dy,hr,min,sec = split_date() in
        let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
        let acclst = ("alt_calc", Calc.Num alt_calc) :: ("az_calc", Calc.Num az_calc) :: ("mag", Calc.Num mag) :: ("ang_diam", Calc.Num diam) :: [] in
        (match Expr.simplify acclst acceptance with
          | Calc.Bool true ->
            if mag <> nan then lst := (sel, (ra_flt,dec_flt,cnst,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) :: !lst;
          | Calc.Bool false -> ()
          | oth -> Expr.dump stderr acclst oth)
      | _ -> ()) Pgc_cnv.pgch;
        List.sort sort_diam !lst
*)
      | 5 -> Hashtbl.iter (fun sel (ra_flt,dec_flt,cnst,diam,mag,desc)  ->
        let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
        ignore (cnst,diam,mag,desc);
        let acclst = ("alt_calc", Calc.Num alt_calc) :: ("az_calc", Calc.Num az_calc) :: ("mag", Calc.Num mag) :: ("ang_diam", Calc.Num diam) :: [] in
        match Expr.simplify acclst acceptance with
          | Calc.Bool true ->
            if mag <> nan then lst := (sel, (ra_flt,dec_flt,cnst,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) :: !lst;
          | Calc.Bool false -> ()
          | oth -> Expr.dump stderr acclst oth
        ) Ngc2000.ngchash;
       List.sort sort_mag !lst
      | 6 -> Hashtbl.iter (fun sel -> function (aco :: rah :: ram :: des :: ded :: dem :: bmtype :: count :: ra2000h :: ra2000m :: de2000s :: de2000d :: de2000m :: xpos :: ypos :: glon :: glat :: redshift :: rich :: dclass :: m10 :: []) ->
        let mag = nan in
        let diam = nan in
        let cnst = "" in
    let ra_flt = float_of_string ra2000h *. 15.0 +. float_of_string ra2000m /. 4.0 in
    let dec_flt = float_of_string de2000d +. float_of_string de2000m /. 60.0 in
    let dec_flt = if de2000s.[0] = '-' then -. dec_flt else dec_flt in
        let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
        ignore (aco,rah,ram,des,ded,dem,bmtype,count,xpos,ypos,glon,glat,redshift,rich,dclass,m10);
        let acclst = ("alt_calc", Calc.Num alt_calc) :: ("az_calc", Calc.Num az_calc) :: ("mag", Calc.Num mag) :: ("ang_diam", Calc.Num diam) :: [] in
        (match Expr.simplify acclst acceptance with
          | Calc.Bool true ->
            if mag <> nan then lst := (sel, (ra_flt,dec_flt,cnst,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) :: !lst;
          | Calc.Bool false -> ()
          | oth -> Expr.dump stderr acclst oth)
        | _ -> ()) Abell_cnv.abellh;
       List.sort sort_mag !lst
      | 7 -> Hashtbl.iter (fun _ (num,ra_flt,dec_flt,magb,mag,typ,morph,major,minor,orient,redshift,eredshift,parallax,eparallax,dist,edist,_,_,sel) ->
        let diam = major in
        let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
        ignore (num,magb,morph,major,minor,orient,redshift,eredshift,parallax,eparallax,dist,edist);
        let acclst = ("alt_calc", Calc.Num alt_calc) :: ("az_calc", Calc.Num az_calc) :: ("mag", Calc.Num mag) :: ("ang_diam", Calc.Num diam) :: [] in
        match Expr.simplify acclst acceptance with
          | Calc.Bool true ->
            if mag <> nan && not (List.mem typ skiplst) then lst := (List.hd sel, (ra_flt,dec_flt,typ,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) :: !lst;
          | Calc.Bool false -> ()
          | oth -> Expr.dump stderr acclst oth
        ) Dso_read.dsoh;
       if pairing then
         begin
         let lst' = ref [] in
         List.iteri (fun ix' (sel', (ra_flt',dec_flt',_,_,mag',_,_,_,_,_,_,_) as a) ->
            List.iteri (fun ix'' (sel'', (ra_flt'',dec_flt'',_,_,mag'',_,_,_,_,_,_,_) as b) ->
               let diam = sqrt ((ra_flt' -. ra_flt'') *. (ra_flt' -. ra_flt'') +. (dec_flt' -. dec_flt'') *. (dec_flt' -. dec_flt'')) in
               if ix' < ix'' && (diam < 0.9) && (mag' < 10.) && (mag'' < 10.) then
                  begin
                  let mag = if mag' < mag'' then mag' else mag'' in
                  let cnst = "" in
                  let ra_flt = (ra_flt' +. ra_flt'') /. 2. in
                  let dec_flt = (dec_flt' +. dec_flt'') /. 2. in
                  let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
                  lst' := (sel'^" + "^sel'', (ra_flt,dec_flt,cnst,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) :: !lst';
                  dump_cat stdout a;
                  dump_cat stdout b;
                  print_newline ();
                  end;
            ) !lst
         ) !lst;
         lst := !lst';
         end;
       List.sort sort_mag !lst
       | _ -> print_endline "That catalogue does not support searching by alt/az"; [] in
    print_endline ("selected catalogue objects = "^string_of_int (List.length !lst));
    let dbgfile = open_out (tmpdir^"cat1.txt") in
    List.iter (dump_cat dbgfile) !lst;
    close_out dbgfile;
    let dbgfile = open_out (tmpdir^"cat2.txt") in
    List.iter (dump_cat dbgfile) srt;
    close_out dbgfile;
    let entries = 20 in (* hardwired for now *)
    let entries = if entries > List.length srt then List.length srt else entries in
    let cat_entries = Array.sub (Array.of_list srt) 0 entries in
    let nentries = List.map (fun (des,_) -> des) (Array.to_list cat_entries) in
(*
    List.iter (GEdit.text_combo_add smenu) nentries;
    ignore ((fst smenu)#entry#connect#changed ~callback: (fun () -> cat'' cat_entries nentries (fst smenu)#entry'()));
    (fst smenu)#set_active entries;
*)
    Lwt.return_unit
    end

and add_prog_entry () =
    let ra_flt = Altaz.cnv_ra (entry_ra'()) in
    let dec_flt = Altaz.cnv_dec (entry_dec'()) in
    let duration = int_of_string (entry_duration'()) in
    let obs = `Assoc
         [("duration", `Int duration);
          ("params",
           `Assoc
             [("objectId", `String ( entry_nam'() ));
              ("ra", `Float ra_flt);
              ("de", `Float dec_flt);
              ("rot", `Int 0);
              ("gain", `Int (Astro_utils.gain_int()));
              ("histogramEnabled", `Bool true);
              ("histogramLow", `Int (-1));
              ("histogramMedium", `Int 5);
              ("histogramHigh", `Int 0);
              ("backgroundEnabled", `Bool true);
              ("exposureMicroSec", `Int (expos_us()));
              ("doStacking", `Bool true);
              ("debayerInterpolation", `String "VNG")])] in
    let prog_entries = obs :: load_prog_entries() in
    dump_prog_entries prog_entries;
    show_prog_entries prog_entries;
    Lwt.return_unit

let update_status () =
(*
  update_status' "success" status_line.(0);
  update_status' "error@name" status_line.(1);
  update_status' "update@state" status_line.(2);
  update_status' "message" status_line.(3);
  update_status' "result@message" status_line.(4);
  update_status' "R[1]@previousOperations@observation@capture@images[0]@url" status_jpeg;
  Array.iteri (fun ix itm -> update_status' itm status_extra.(ix)) visible_extra;
*)
  ()

(*
let rec iter_a ix a =
  if true || !verbose_flag then print_endline ("iter_a: "^string_of_int !ix^" "^fst a.(!ix));
  match a.(!ix) with
  | ("", x) ->
    if !quit' then
        begin
        usleep 0.1; (* to avoid unused function warning *)
        exit(0);
        Lwt.return_unit
        end
    else if not (Queue.is_empty start) then
        begin
        if!verbose_flag then print_endline "take queue";
        iter_a (ref (Queue.take start)) a
        end
    else
        begin
        if false then print_endline "idle queue";
        update_status ();
        reset_date (Unix.gettimeofday());
        usleep 0.5;
        sm_jump("sockio");
        let waiting = false in
(*
        Lwt_engine.iter waiting;
*)
        Lwt.apply (fun f -> f ()) x >>= fun () -> iter_a ix a
        end
  | (lbl, x) -> incr ix;
        begin
        let f = fun f -> let cnt = string_of_int !ix in if!verbose_flag then print_endline (cnt^": "^lbl); f () in
        Lwt.apply f x >>= fun () -> iter_a ix a
        end
let gui () = ()

let goto_received ra_flt dec_flt =
        let rahms = Altaz.hms_of_float ra_flt in
        let decdms = Altaz.dms_of_float dec_flt in
        let latitude = latitude() in
        let longitude = longitude() in
        let yr,mon,dy,hr,min,sec = split_date() in
        let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
        show_entries "Alpaca object" jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc nan ra_flt dec_flt nan nan nan nan nan nan;
        sm_jump "motorgo"

let single_exposure exposure is_light =
        if is_light then 
            begin
            Astro_utils.entry_exp_set_text (string_of_float exposure);
            sm_jump "singleshot"
            end
        else
            begin
            entry_darkcnt_set_text "1";
            sm_jump "darks"
            end
*)
