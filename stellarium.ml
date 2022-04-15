(*
open Xml
*)
open Lwt

type attr =
  {
    mutable target: string;
    mutable ra: float;
    mutable dec: float;
    mutable ra_hms: string;
    mutable dec_dms: string;
    mutable alt: float;
    mutable az: float;
    mutable alt_dms: string;
    mutable az_dms: string;
    mutable rise: float;
    mutable transit: float;
    mutable set: float;
    mutable rise_hms: string;
    mutable transit_hms: string;
    mutable set_hms: string;
  }

let logfile = open_out "logfile.txt"

let get' proto server params headers pth f hdrs =
  Quests.get (proto^server^pth)
    ~params:(params)
    ~headers:(headers)
  >|= ( fun arg -> hdrs := Cohttp.Header.to_list (Quests.Response.headers arg); Quests.Response.content arg) >|= f

let split = List.map (fun itm -> let ix = String.index itm ':' in (String.sub itm 0 ix, String.sub itm (ix+2) (String.length itm - ix - 4)))

let hms_of_float x' =
    let neg = x' < 0.0 in
    let x = if neg then x' +. 360.0 else x' in
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

let rec descend' attr = function
| ("raJ2000", `Float f) -> attr.ra <- f; attr.ra_hms <- hms_of_float f
| ("decJ2000", `Float f) -> attr.dec <- f; attr.dec_dms <- dms_of_float f
| ("altitude", `Float f) -> attr.alt <- f; attr.alt_dms <- dms_of_float f
| ("azimuth", `Float f) -> attr.az <- f; attr.az_dms <- dms_of_float f
| ("rise-dhr", `Float f) -> attr.rise <- f; attr.rise_hms <- dms_of_float f
| ("transit-dhr", `Float f) -> attr.transit <- f; attr.transit_hms <- dms_of_float f
| ("set-dhr", `Float f) -> attr.set <- f; attr.set_hms <- dms_of_float f
| ("rise", `String _) -> ()
| ("set", `String _) -> ()
| (str, `Bool b) -> output_string logfile (str^": "^string_of_bool b^"\n")
| (str, `Float f) -> output_string logfile (str^": "^string_of_float f^"\n")
| (str, `Int n) -> output_string logfile (str^": "^string_of_int n^"\n")
| (str, `List lst) -> output_string logfile (str^":\n"); List.iter (descend attr) lst
| (str, `Null) -> output_string logfile (str^": Null\n")
| (str, `String s) -> output_string logfile (str^": \""^s^"\"\n")
| (str, `Assoc lst) -> output_string logfile (str^":\n"); List.iter (descend' attr) lst

and descend attr = function
| `Assoc lst -> List.iter (descend' attr) lst
| `List lst -> List.iter (descend attr) lst
| `Null
| `String _
| `Bool _
| `Float _
| `Int _ -> failwith "descend"

let debug attr =
    Printf.printf "target=%s: ra_hms=%s, dec_dms=%s\nalt_hms=%s, az_hms=%s\nrise_hms=%s, transit_hms=%s, set_hms=%s\n"
        attr.target
        attr.ra_hms attr.dec_dms
        attr.alt_dms attr.az_dms
        attr.rise_hms attr.transit_hms attr.set_hms;
    flush stdout

let stellarium' attr cb =
    let headers = split 
   ["Content-Type: application/json";
    "Accept: application/json"] in
    let server =  "127.0.0.1:8090" in
    let pth = "/api/objects/info" in
    let req = [("name", attr.target); ("format", "json")] in
    let hdrs = ref [] in
    get' "http://" server req headers pth cb hdrs

(* only for testing *)
let stellarium attr =
  let f = (fun s -> descend attr (Yojson.Basic.from_string s); debug attr) in
  let _ = Lwt_main.run (stellarium' attr f) in
  attr

let attr nam = {target=nam;
ra=0.; dec=0.; ra_hms=""; dec_dms="";
alt=0.; az=0.; alt_dms=""; az_dms="";
rise=0.; transit=0.; set=0.; rise_hms=""; transit_hms=""; set_hms=""; }
