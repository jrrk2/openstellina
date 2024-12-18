open Cohttp
open Altaz
open Lwt.Infix
open Xml
open Cohttp
open Astro_utils
(*
open Cohttp_lwt_unix
open Lwt_unix
*)
(* *)
open Cohttp_lwt_jsoo
open Js_of_ocaml_lwt
open Lwt_js
(* *)

(*
 open Geolocate
 *)

let cb callback show_info jd = fun s' -> let body = ref "" in let s = String.split_on_char '\n' (match Yojson.Basic.from_string s' with `Assoc [("result", `String rslt); ("signature", signature)] -> rslt | `Assoc [("signature", signature); ("result", `String rslt)] -> rslt | _ -> show_info "json error"; s') in
       List.iter (fun x' -> if String.length x' > 6 && String.sub x' 0 6 = "Date__" then print_endline x';
       let tok = Array.of_list (List.filter (function "" -> false |"*" -> false | _ -> true) (String.split_on_char ' ' x')) in
       let trial = try (float_of_string tok.(0)) with _ -> 0.0 in
       if trial = jd then callback !body tok;
       if Array.length tok > 0 && tok.(0) = "Revised:" then
          begin
          let ix = ref (Array.length tok - 1) in
          while (tok.(!ix).[0] >= '0' && tok.(!ix).[0] <= '9') || (tok.(!ix) = "/") do decr ix done;
          body := String.concat " " (Array.to_list (Array.sub tok 4 (!ix - 3)));
          end
       else if Array.length tok > 0 && tok.(0) = "JPL/HORIZONS" then
          begin
          body := String.concat " " (Array.to_list (Array.sub tok 1 (Array.length tok - 3)));
          end) s

(*	  
let callback_complete = ref false

let get' proto server params headers pth f hdrs =
  callback_complete := false;
  let pth' = proto^server^pth in
  let uri' = Uri.of_string pth' in
  let uri = Uri.with_uri ~query:(Some (List.map (fun (a,b) -> a,[b]) params)) uri' in
  
  let wrapped_f body =
    let result = f body in
    callback_complete := true;
    result in

  let rec poll_until_done max_tries delay_seconds =
    if !callback_complete then
      Lwt.return_unit
    else if max_tries <= 0 then
      Lwt.return_unit
    else
      let%lwt () = sleep delay_seconds in
      poll_until_done (max_tries - 1) delay_seconds in
  
  let%lwt () = 
    Client.get uri ~headers:(Cohttp.Header.of_list headers)
    >>= (fun (resp,body) -> 
      hdrs := Cohttp.Header.to_list (Response.headers resp);
      body |> Cohttp_lwt.Body.to_string >|= fun body -> wrapped_f body) in
  
      poll_until_done 10 1.0  (* Try for 10 seconds *)
      *)

let horizons' show_info callback target jd =
    let hdrs = ref [] in
    let server =  "ssd.jpl.nasa.gov" in
    (*
     let server = "cors-anywhere.herokuapp.com/ssd.jpl.nasa.gov" in
     *)
    let pth = "/api/horizons.api?format=text" in
    let f = cb callback show_info jd in

(*
 callback !body ephem;
 let lat_flt = latitude() in
    let long_flt = longitude() in
*)
    let lat_flt = 52.2 in
    let long_flt = 0.0 in
    let req = 
    [("COMMAND", "'"^ target ^"'");
     ("OBJ_DATA", "'YES'");
     ("MAKE_EPHEM", "'YES'");
     ("EPHEM_TYPE", "'OBS'");
     ("CENTER", "'coord'");
     ("APPARENT", "'REFRACTED'");
     ("CAL_FORMAT", "'JD'");
     ("ANG_FORMAT", "'DEG'");
     ("SITE_COORD", Printf.sprintf "'%f,%f,%f'" long_flt lat_flt 0.0);
     ("TLIST", string_of_float jd);
     ("QUANTITIES", "'1,4,7,9,42");
    ] in
    if false then List.iter (fun (k,x) -> show_info (k^": "^x)) req;
    get' "https://" server req [] pth f hdrs
    ;;
