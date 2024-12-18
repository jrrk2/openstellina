(* Stellina expert App *)

open Lwt
open Version
open Astro_utils
open Geolocate

let server = "10.0.0.1:"
(*
 let server = "127.0.0.1:"
 *)
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

let params' = [ ("name", Version.version); ("EIO", "3"); ("id", version); ("transport", "polling")]
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
(*
 let ephem_data_lst = ref []
*)
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

let stellarium_enabled_active() = false

let targ_entry'() = "target"
let ephem_set_active hr = ()
let tbuffer_set_text txt = ()
let tbuffer_insert ~tag_names txt = ()
let tbuffer_bounds'() = (0,99)
let tbuffer_apply_tag_by_name nam ~start ~stop = ()

let tim_6_set_text txt = ()
let tim_7_set_text txt = ()

let rec to_ascii x =
  let d = floor (x /. 10.) in
  (if d > 0. then to_ascii d else "")^string_of_int (int_of_float(x -. d *. 10.))

let time_ms() = to_ascii (Astro_utils.datum() *. 1000.0)

let init' fn =
    let cmd = "startAutoInit" in
    print_endline cmd;
    let pth = pth2'^"/v1/general/"^cmd in
    let lat_flt = latitude() in
    let long_flt = longitude() in
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
     ("backgroundPolyorder", `Int 4);
     ("observationType", `String "STANDARD");
     ("algorithm", `String "AUTO");
     ("store", `Assoc [
       ("state", `String "NON_RESUMABLE")
     ]);
     ("mosaic", `Assoc [
       ("widthDegree", `Float 1.58208);
       ("heightDegree", `Float 1.0712)
     ]);
     ("targetType", `String "MANUAL")
  ]))) (cnv' f)

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

(*    
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
          body := String.concat " " (Array.to_list (Array.sub tok 4 (!ix - 3)));
          end
       else if Array.length tok > 0 && tok.(0) = "JPL/HORIZONS" then
          begin
          body := String.concat " " (Array.to_list (Array.sub tok 1 (Array.length tok - 3)));
          end;
       if!verbose_flag then print_endline x;
       use) (String.split_on_char '\n' s);
       targ_status_set_text ("horizons: "^ !body);
       entry_nam_set_text !body;
       ephem_set_active t.tm_hour;
(*
       show_ephem t.tm_hour
*)
) in
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
*)

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

let fetch' () =
    if!verbose_flag then print_endline ("Fetching: "^ (!fitsref));
    Lwt.return_unit

let dump' () =
    let pth = String.rindex (!fitsref) '/' in
    let pth' = String.sub (!fitsref) (pth+1) (String.length (!fitsref) - pth - 1) in
    let url = "curl -s "^proto^server^pth2'^(!fitsref)^" >"^tmpdir^pth' in
    print_endline url;
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

