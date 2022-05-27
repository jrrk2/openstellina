type attr =
  {
    mutable target: string;
    mutable ra: float;
    mutable dec: float;
    mutable ra_hms: string;
    mutable dec_dms: string;
    mutable ranow: float;
    mutable decnow: float;
    mutable ranow_hms: string;
    mutable decnow_dms: string;
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
    mutable vis_mag: float;
    mutable sidt: float;
    mutable hour_ang: float;
  }

let logfile = open_out "stellarium_logfile.txt"

let rec descend' attr = function
| ("raJ2000", `Float f) -> attr.ra <- f; attr.ra_hms <- Utils.hms_of_float f
| ("decJ2000", `Float f) -> attr.dec <- f; attr.dec_dms <- Utils.dms_of_float f
| ("ra", `Float f) -> attr.ranow <- f; attr.ranow_hms <- Utils.hms_of_float f
| ("dec", `Float f) -> attr.decnow <- f; attr.decnow_dms <- Utils.dms_of_float f
| ("altitude", `Float f) -> attr.alt <- f; attr.alt_dms <- Utils.dms_of_float f
| ("azimuth", `Float f) -> attr.az <- f; attr.az_dms <- Utils.dms_of_float f
| ("rise-dhr", `Float f) -> attr.rise <- f; attr.rise_hms <- Utils.dms_of_float f
| ("transit-dhr", `Float f) -> attr.transit <- f; attr.transit_hms <- Utils.dms_of_float f
| ("set-dhr", `Float f) -> attr.set <- f; attr.set_hms <- Utils.dms_of_float f
| ("vmag", `Float f) -> attr.vis_mag <- f
| ("hourAngle-hms", `String s) -> attr.hour_ang <- Utils.mod_ha (Utils.cnv_hms s /. 15.)
| ("rise", `String _) -> ()
| ("set", `String _) -> ()
| ("appSidTm", `String s) -> attr.sidt <- Utils.cnv_hms s /. 15.
| (str, `Bool b) -> output_string logfile (str^": "^string_of_bool b^"\n"); flush logfile
| (str, `Float f) -> output_string logfile (str^": "^string_of_float f^"\n"); flush logfile
| (str, `Int n) -> output_string logfile (str^": "^string_of_int n^"\n"); flush logfile
| (str, `List lst) -> output_string logfile (str^":\n"); List.iter (descend attr) lst; flush logfile
| (str, `Null) -> output_string logfile (str^": Null\n"); flush logfile
| (str, `String s) -> output_string logfile (str^": \""^s^"\"\n"); flush logfile
| (str, `Assoc lst) -> output_string logfile (str^":\n"); List.iter (descend' attr) lst; flush logfile

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
    let headers = Utils.split 
   ["Content-Type: application/json";
    "Accept: application/json"] in
    let server =  "127.0.0.1:8090" in
    let pth = "/api/objects/info" in
    let req = [("name", attr.target); ("format", "json")] in
    let hdrs = ref [] in
    Utils.get' "http://" server req headers pth cb hdrs

let focus' resp target =
    let headers = Utils.split 
   ["Content-Type: application/json";
    "Accept: application/json"] in
    let server =  "127.0.0.1:8090" in
    let pth = "/api/main/focus" in
    let cb = Quests.Request.Raw "{}" in
    let params = [ ("target", target); ("mode", "center") ] in (* notice: American spelling *)
    let f = (fun s -> resp s) in
    Utils.post' "http://" server params headers pth cb f

(* only for testing *)
let stellarium attr =
  let f = (fun s -> descend attr (Yojson.Basic.from_string s); debug attr) in
  let _ = Lwt_main.run (stellarium' attr f) in
  attr

let attr nam = {target=nam;
ra=0.; dec=0.; ra_hms=""; dec_dms="";
ranow=0.; decnow=0.; ranow_hms=""; decnow_dms="";
alt=0.; az=0.; alt_dms=""; az_dms="";
rise=0.; transit=0.; set=0.; rise_hms=""; transit_hms=""; set_hms=""; vis_mag=0.0;
sidt=0.0; hour_ang=0.0;
 }
