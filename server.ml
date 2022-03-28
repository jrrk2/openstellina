(** Multi-client server example.

    Clients can increment a shared counter or read its current value.

    Build with: ocamlfind ocamlopt -package lwt,lwt.unix,logs,logs.lwt -linkpkg -o counter-server ./counter-server.ml
 *)

open Lwt
open Replay_session
open Filtered

let listen_address = Unix.inet_addr_loopback
let port = 10000
let backlog = 10
let ix = ref 0
let buf = Array.init 256 (fun ix -> 0)
let desired_pos = Array.init 3 (fun _ -> 0.0)

let status = try int_of_string (Sys.getenv "STATUS") > 0 with err -> false;;
let expert = try int_of_string (Sys.getenv "EXPERT_ACQUISITION") > 0 with err -> false;;
let autoinit = try int_of_string (Sys.getenv "AUTO_INIT") > 0 with err -> false;;
let openarm = try int_of_string (Sys.getenv "OPEN_ARM") > 0 with err -> false;;
let observe = try int_of_string (Sys.getenv "OBSERVE") with err -> 0;;
let refocus = try int_of_string (Sys.getenv "REFOCUS") > 0 with err -> false;;
let stopobs = try int_of_string (Sys.getenv "STOP_OBSERVATION") > 0 with err -> false;;
let park = try int_of_string (Sys.getenv "PARK") > 0 with err -> false;;
let shut_down = try int_of_string (Sys.getenv "SHUT_DOWN") > 0 with err -> false;;
(* check lat/long and default to Greenwich Royal Observatory *)
let latitude = try float_of_string (Sys.getenv "LATITUDE") with err -> 51.4777777777777814;;
let longitude = try float_of_string (Sys.getenv "LONGITUDE") with err -> 0.00138888888888888894;;
let time_ms = string_of_int (int_of_float (Unix.time() *. 1000.0));;
let init_str = "{\"latitude\":"^string_of_float(latitude)^",\"longitude\":"^string_of_float(longitude)^",\"time\":"^time_ms^"}";;

let expert_path = "\"expert-mode/raw-images\"";;
let expert_overwrite = true;;
let expert_exposures = 100;;
let expert_gain = 200;;
let expert_exposureSec = 10.0;;
let expert_params = "{\"path\":"^(expert_path)^
    ",\"overwrite\":"^string_of_bool(expert_overwrite)^
    ",\"numExposures\":"^string_of_int(expert_exposures)^
    ",\"gain\":"^string_of_int(expert_gain)^
    ",\"exposureMicroSec\":"^string_of_int(int_of_float(expert_exposureSec *. 1000000.))^
"}";;

let _ = print_endline init_str;;

let ix_park = ref (-1);;
let _ = List.iteri (fun ix (itm:Request.req) -> match !(itm.uri) with "/v1/general/park" -> ix_park := ix | _ -> ()) filtered;;

let filt_obs = List.filter (fun (itm:Request.req) -> match !(itm.uri) with "/v1/general/startObservation" -> true | _ -> false) filtered;;

let filt_focus = List.filter (fun (itm:Request.req) -> match !(itm.uri) with "/v1/general/adjustObservationFocus" -> true | _ -> false) filtered;;

let connect_stellina () =
    let x0 = json3' (List.nth filtered 0) in

    let sid,ping_int,ping_tim = match x0 with
        | `Assoc
        [("sid", `String sid);
         ("upgrades", `List [`String "websocket"]); ("pingInterval", `Int ping_int);
         ("pingTimeout", `Int ping_tim)] -> sid,ping_int,ping_tim
        | oth -> othsock := Some oth; failwith "json3'" in

    let x2 = json5' (List.nth filtered 2) sid ["id";"name";"EIO";"transport";"t"] ("44:420[\"message\",\"setSystemTime\","^time_ms^"]") in
    let x3 = json5' (List.nth filtered 3) sid ["id";"name";"EIO";"transport"] "{}" in
    let x4 = json5' (List.nth filtered 4) sid ["id";"name";"EIO";"transport";"t"] "{}" in
    let x7 = json5' (List.nth filtered 7) sid ["id";"name";"EIO";"transport";"t"] "{}" in
    let x10 = json5' (List.nth filtered 10) sid ["id";"name";"EIO";"transport";"t"] "{}" in
    let x12 = json5' (List.nth filtered 12) sid [] "{}" in
    let x14 = json5' (List.nth filtered 14) sid [] "{}" in
    let x16 = json5' (List.nth filtered 16) sid [] "{}" in
    let x18 = json5' (List.nth filtered 18) sid [] "{}" in

    let x20, x22 = if autoinit then (let a = (json5' (List.nth filtered 20) sid [] "{}") in (a, json5' (List.nth filtered 22) sid [] init_str)) else ("","") in
    let xfocus = if refocus then (let a = (json5' (List.nth filt_focus 0) sid [] "{}") in (a, json5' (List.nth filt_focus 1) sid [] init_str)) else ("","") in
    let xopen = if openarm then (open_arm ()) else "" in
(*
    let xstatus = if status then (app_status ()) else `Null in
*)
    let xexpert = if expert then (expert_acquisition expert_params) else "" in
    let xstop = if stopobs then (stop_obs ()) else "" in
    let xpark = if park then (json5' (List.nth filtered !ix_park) sid [] "{}") else "" in
    let xshut_down = if shut_down then (request_shutdown ()) else "" in
    sid

let cnv_ra fmt = Scanf.sscanf fmt "%f %f %f" (fun a b c -> a *. 15.0 +. b /. 4.0 +. c /. 240.0)
let cnv_dec fmt = try Scanf.sscanf fmt "%f %f %f" (fun a b c -> a +. b /. 60.0 +. c /. 3600.0) with err -> Scanf.sscanf fmt "%f %f" (fun a b -> a +. b /. 60.0)

let find_messier_obj observe =
    let cat,rahms,decdms = Messier_catalogue.messier_array.(observe-1) in
    print_endline ("**** Fetching object "^cat^" at RA:"^rahms^", DEC:"^decdms^" ****");
    let ra = cnv_ra rahms in
    let de = cnv_dec decdms in
    cat,ra,de

let prep_obs sid cat ra de =
    let rot = 0 in
    let objectId = "\""^cat^"\"" in
    let objectName = "\""^cat^"\"" in
    let gain = 200 in
    let exposureSec = 10.0 in
    let doStacking = true in
    let histogramEnabled = true in
    let histogramLow = -0.75 in
    let histogramMedium=5 in
    let histogramHigh=0 in
    let backgroundEnabled=true in
    let backgroundPolyorder=4 in
    let obs_str = "{\"ra\":"^string_of_float(ra)^
        ",\"de\":"^string_of_float(de)^
        ",\"rot\":"^string_of_int(rot)^
        ",\"objectId\":"^(objectId)^
        ",\"objectName\":"^(objectName)^
        ",\"gain\":"^string_of_int(gain)^
        ",\"exposureMicroSec\":"^string_of_int(int_of_float(exposureSec *. 1000000.))^
        ",\"doStacking\":"^string_of_bool(doStacking)^
        ",\"histogramEnabled\":"^string_of_bool(histogramEnabled)^
        ",\"histogramLow\":"^string_of_float(histogramLow)^
        ",\"histogramMedium\":"^string_of_int(histogramMedium)^
        ",\"histogramHigh\":"^string_of_int(histogramHigh)^
        ",\"backgroundEnabled\":"^string_of_bool(backgroundEnabled)^
        ",\"backgroundPolyorder\":"^string_of_int(backgroundPolyorder)^
    "}" in
    let _ = print_endline obs_str in
    let obs = List.nth filt_obs 1 in
    obs.fil.unhandled := [obs_str];
    let a = json6' (List.nth filt_obs 0) sid [] "{}" in
    json6' obs sid [] ""

(*
let xobs = if observe > 0 then
    begin
    let cat,ra,de = find_messier_obj observe in
    prep_obs cat ra de
    end else ("","")
*)

