open Lwt

let options txt (headers:Cohttp.Header.t) =
  Cohttp_lwt_unix.Client.call `OPTIONS (Uri.of_string ("http://10.0.0.1:8082/v1/"^txt)) ?chunked:(Some false) ?headers:(Some headers) >>= fun (resp, body) ->
  let code = resp |> Cohttp_lwt_unix.Response.status |> Cohttp.Code.code_of_status in
  Printf.printf "Response code: %d\n" code;
  Printf.printf "Headers: %s\n" (resp |> Cohttp_lwt_unix.Response.headers |> Cohttp.Header.to_string);
  body |> Cohttp_lwt.Body.to_string >|= fun body ->
  Printf.printf "Body of length: %d\n" (String.length body);
  body

let get' txt =
  Cohttp_lwt_unix.Client.call `GET (Uri.of_string ("http://10.0.0.1:8082/v1/"^txt)) >>= fun (resp, body) ->
  let code = resp |> Cohttp_lwt_unix.Response.status |> Cohttp.Code.code_of_status in
  Printf.printf "Response code: %d\n" code;
  Printf.printf "Headers: %s\n" (resp |> Cohttp_lwt_unix.Response.headers |> Cohttp.Header.to_string);
  body |> Cohttp_lwt.Body.to_string >|= fun body ->
  Printf.printf "Body of length: %d\n" (String.length body);
  body

let body2 kind txt headers body =
  Cohttp_lwt_unix.Client.call kind (Uri.of_string ("http://10.0.0.1:8083/socket.io/?id="^txt)) ?chunked:(Some false) ?headers:(Some headers) ?body:body >>= fun (resp, body) ->
  let code = resp |> Cohttp_lwt_unix.Response.status |> Cohttp.Code.code_of_status in
  Printf.printf "Response code: %d\n" code;
  Printf.printf "Headers: %s\n" (resp |> Cohttp_lwt_unix.Response.headers |> Cohttp.Header.to_string);
  body |> Cohttp_lwt.Body.to_string >|= fun body ->
  Printf.printf "Body of length: %d\n" (String.length body);
  body

let post txt (headers:Cohttp.Header.t) body =
  Cohttp_lwt_unix.Client.call `POST (Uri.of_string ("http://10.0.0.1:8082/v1/"^txt)) ?chunked:(Some false) ?headers:(Some headers) ?body:body >>= fun (resp, body) ->
  let code = resp |> Cohttp_lwt_unix.Response.status |> Cohttp.Code.code_of_status in
  Printf.printf "Response code: %d\n" code;
  Printf.printf "Headers: %s\n" (resp |> Cohttp_lwt_unix.Response.headers |> Cohttp.Header.to_string);
  body |> Cohttp_lwt.Body.to_string >|= fun body ->
  Printf.printf "Body of length: %d\n" (String.length body);
  body

type motor' = {
pos: float;
state: string;
stopped: bool;
calib: bool;
}

type motor = {
az: motor' ref;
alt: motor' ref;
der: motor' ref;
map: motor' ref;
}

type sens = {
temp: float ref;
tempd: float ref;
humid: float ref;
humidd: float ref;
defog: string ref;
dewp: float ref;
}

type conn = {
conid: string;
nam: string;
user: string;
}

type settings = {
telname: string option ref;
usbftypes: string list ref;
}

type update = {
instver: string ref;
minver: string ref;
state: string ref;
}

type store = {
size: int;
avail: int;
chng: int option;
}

type storage = {
system: store ref;
data: store ref;
usb: store ref;
}

type op = 
| Open
| Park of (string * Yojson.Basic.t) list
| AutoInit of (string * Yojson.Basic.t) list
| Observation of (string * Yojson.Basic.t) list
| SunMode
| Plan of (string * Yojson.Basic.t) list
| Storage

type attr = {
version: string ref;
api_version: string ref;
id: string ref;
motors: motor;
bootcnt : int ref;
initerr : Yojson.Basic.t ref;
board_initerr : Yojson.Basic.t ref;
debug : bool ref;
ts : int ref;
elap : int ref;
init : bool ref;
shut : bool ref;
connlst : conn list ref;
master_str : string option ref;
sett_lst : settings;
avail : int ref;
update : update;
storage : storage;
sens_lst : sens;
crnt : Yojson.Basic.t ref;
oth_crnt : Yojson.Basic.t list ref;
prev_op_lst : op list ref;
planner : (string * Yojson.Basic.t) list ref;
numfiles : int ref;
bufpos : int ref;
bufsiz : int ref;
lat: float ref;
long: float ref;
autofoctemp: float ref;
}

type status = { success: bool; attr: attr }

let othmot = ref []
let othrslt = ref None

let (motors':(string*Yojson.Basic.t)list -> motor') = function
|              [("position", `Int pos);
               ("state", `String state);
               ("atStop", `Bool stopped);
               ("calibrated", `Bool calib)] -> let pos=float_of_int pos in {pos; state; stopped; calib}
|              [("position", `Int pos);
               ("state", `String state);
               ("calibrated", `Bool calib)] -> let pos=float_of_int pos and stopped=false in {pos; state; stopped; calib}
|              [("position", `Float pos);
               ("state", `String state);
               ("calibrated", `Bool calib)] -> let stopped=false in {pos; state; stopped; calib}
|              [("position", `Float pos);
               ("state", `String state);
               ("atStop", `Bool stopped);
               ("calibrated", `Bool calib)] -> {pos; state; stopped; calib}
| oth -> othmot := oth; failwith "motors'"

let motors (motor:motor) (arg:string*Yojson.Basic.t) = match arg with
| ("AZ", `Assoc lst) -> motor.az := motors' lst
| ("ALT", `Assoc lst) -> motor.alt := motors' lst
| ("DER", `Assoc lst) -> motor.der := motors' lst
| ("MAP", `Assoc lst) -> motor.map := motors' lst
| _ -> failwith "motors"

let oths = ref None
let othc = ref None

let sensors' sens = function
| ("temperature", `Float t) -> sens.temp := t
| ("temperature", `Int t) -> sens.temp := float_of_int t
| ("temperatureDelta", `Float t) -> sens.tempd := t
| ("temperatureDelta", `Int t) -> sens.tempd := float_of_int t
| ("humidity", `Float f) -> sens.humid := f
| ("humidity", `Int f) -> sens.humid := float_of_int f
| ("humidityDelta", `Float f) -> sens.humidd := f
| ("humidityDelta", `Int f) -> sens.humidd := float_of_int f
| ("defogStatus", `String stat) -> sens.defog := stat
| ("dewpointDepression", `Float f) -> sens.dewp := f
| oth -> oths := Some oth; failwith "sensors'"

let connlst' conn = function
| `Assoc
      [("id", `String conid);
       ("name", `String nam);
       ("user", `String user)] -> conn := {conid; nam; user} :: !conn
| oth -> othc := Some oth; failwith "connlst'"

let settlst' sett = function
| ("telescopeName", `Null) -> sett.telname := None
| ("usbFileTypes", `List (uft:Yojson.Basic.t list)) -> List.iter (function `String str -> sett.usbftypes := str :: !(sett.usbftypes) | _ -> failwith "uft") uft
| oth -> oths := Some oth; failwith "settlst'"

let update' upd = function
| ("installedVersion", `String v) -> upd.instver := v
| ("minimumCompatibleVersion", `String v) -> upd.minver := v
| ("state", `String v) -> upd.state := v
| oth -> oths := Some oth; failwith "update'"

let storage' stor = function
| ("system", `Assoc [("size", `Int size); ("available", `Int avail)]) -> stor.system := {size; avail; chng=None}
| ("data", `Assoc [("size", `Int size); ("available", `Int avail)]) -> stor.data := {size; avail; chng=None}
| ("usb", `Assoc [("size", `Int size); ("available", `Int avail); ("changeCount", `Int chng)]) -> stor.usb := {size; avail; chng=Some chng}
| oth -> oths := Some oth; failwith "storage'"

let op' op = function
| ("open", `Null) -> op := Open :: !op
| ("park", `Assoc park) -> op := Park park :: !op
| ("autoInit", `Assoc init) -> op := AutoInit init :: !op
| ("observation", `Assoc obs) -> op := Observation obs :: !op
| ("sunMode", `Null) -> op := SunMode :: !op
| ("plan", `Assoc plan) -> op := Plan plan :: !op
| ("storageAcquisition", `Null) -> op := Storage :: !op
| oth -> oths := Some oth; failwith "op'"

let rslt (attr:attr) (arg:string*Yojson.Basic.t) = match arg with
|       ("apiVersion", `String str) -> attr.api_version := str
|       ("version", `String ver) -> attr.version := ver
|       ("telescopeId", `String stellina) -> attr.id := stellina
|       ("bootCount", `Int bootcnt) -> attr.bootcnt := bootcnt
|       ("initError", initerr) -> attr.initerr := initerr
|       ("boardInitError", board_initerr) -> attr.board_initerr := board_initerr
|       ("boardInDebugMode", `Bool debug) -> attr.debug := debug
|       ("timestamp", `Int ts) -> attr.ts := ts
|       ("elapsedTime", `Int elap) -> attr.elap := elap
|       ("initialized", `Bool init) -> attr.init := init
|       ("shuttingDown", `Bool shut) -> attr.shut := shut
|       ("connectedDevices", `List connlst) -> List.iter (connlst' attr.connlst) connlst
|       ("masterDeviceId", `Null) -> attr.master_str := None
|       ("masterDeviceId", `String master_str) -> attr.master_str := Some master_str
|       ("settings", `Assoc sett_lst) -> List.iter (settlst' attr.sett_lst) sett_lst
|       ("availableReports", `Int avail) -> attr.avail := avail
|       ("update", `Assoc update) -> List.iter (update' attr.update) update
|       ("storage", `Assoc storage) -> List.iter (storage' attr.storage) storage
|       ("battery", `Assoc [("potentialBatteryCandidates", `List batt_lst)]) -> ()
|       ("sensors", `Assoc sens_lst) -> List.iter (sensors' attr.sens_lst) sens_lst
|       ("motors", `Assoc motor_lst) -> List.iter (motors attr.motors) motor_lst
|       ("currentOperation", crnt) -> attr.crnt := crnt
|       ("otherCurrentOperations", `List oth_crnt_ops) -> attr.oth_crnt := oth_crnt_ops
|       ("previousOperations", `Assoc prev_op_lst) -> List.iter (op' attr.prev_op_lst) prev_op_lst
|       ("planner", `Assoc planner) -> attr.planner := planner
|       ("logs", `Assoc
          [("numFiles", `Int fil); ("bufferPosition", `Int bufpos); ("bufferSize", `Int sz)]) -> attr.numfiles := fil; attr.bufpos := bufpos; attr.bufsiz := sz
|       ("position", `Assoc [("latitude", `Float lat); ("longitude", `Float long)]) -> attr.lat := lat; attr.long := long
|       ("autofocusTemperature", `Float autofoctemp) -> attr.autofoctemp := autofoctemp
| oth -> othrslt := Some oth; failwith "rslt"

let new_motor () = {pos=0.0;state=""; stopped=false; calib=false;}

let new_stor () = ref {size=0; avail=0; chng=None}

let new_attr () = {
version=ref "";
api_version=ref "";
id=ref "";
bootcnt = ref 0;
initerr = ref `Null;
board_initerr = ref `Null;
debug = ref false;
ts = ref 0;
elap = ref 0;
init = ref false;
shut = ref false;
connlst = ref [];
master_str = ref None;
sett_lst = {telname=ref None; usbftypes=ref [];};
avail = ref 0;
update = {instver=ref ""; minver = ref ""; state = ref ""};
storage = {system=new_stor(); data=new_stor(); usb=new_stor()};
sens_lst = {temp=ref 0.0; tempd=ref 0.0; humid=ref 0.0; humidd = ref 0.0; defog = ref ""; dewp = ref 0.0};
crnt = ref `Null;
oth_crnt = ref [];
prev_op_lst = ref [];
planner = ref [];
numfiles = ref 0;
bufpos = ref 0;
bufsiz = ref 0;
lat = ref 0.0;
long = ref 0.0;
autofoctemp = ref 0.0;
motors={
az=ref (new_motor());
alt=ref (new_motor());
der=ref (new_motor());
map=ref (new_motor());
}

}

let (get_status:Yojson.Basic.t -> status) = function
| `Assoc
  [("success", `Bool succ);
   ("result", `Assoc res_lst);
] ->  let attr = new_attr () in
      List.iter (rslt attr) res_lst;
      { success=succ; attr }
| _ -> failwith "bodyref"
;;

let app_status () =
  let body = Lwt_main.run (get' "app/status") in
  let json = Yojson.Basic.from_string body in
  json

let headlst'' = Cohttp.Header.of_list ([
    ("Content-Type", "application/json");
    ("Origin", "http://localhost:8080");
    ("Connection", "keep-alive");
    ("Accept", "application/json, text/plain, */*");
    ("Referer", "http://localhost:8080/");
    ("Accept-Language", "en-GB,en;q=0.9");
    ("Accept-Encoding", "gzip, deflate");
    ])

let open_arm () =
  let body = Lwt_main.run (options "/general/openForMaintenance" headlst'') in
  let body' = Lwt_main.run (post "/general/openForMaintenance" headlst'' None) in
  body

let stop_obs () =
  let body = Lwt_main.run (options "/general/stopObservation" headlst'') in
  let body' = Lwt_main.run (post "/general/stopObservation" headlst'' None) in
  body

let request_shutdown () =
  let body = Lwt_main.run (options "/board/requestShutdown" headlst'') in
  let body = Lwt_main.run (post "/board/requestShutdown" headlst'' None) in
  body

let expert_acquisition params =
  let body = Lwt_main.run (options "/expertMode/startStorageAcquisition" headlst'') in
  let body = Lwt_main.run (post "/expertMode/startStorageAcquisition" headlst'' (Some (`String params))) in
  body

let othsock = ref None

let json3 () =
  let body = Lwt_main.run (body2 `GET "iOS_Apple_iPad8_6_472AC2D5-B6DE-53DD-A563-BF202DF3203F&name=Jonathan%E2%80%99s%20iMac&EIO=3&transport=polling&t=Nzb3bUR" headlst'' None) in
  let json' = Yojson.Basic.from_string  ( String.sub body 4 (String.length body - 8)) in
  match json' with
    | `Assoc
    [("sid", `String sid);
     ("upgrades", `List [`String "websocket"]); ("pingInterval", `Int ping_int);
     ("pingTimeout", `Int ping_tim)] -> sid,ping_int,ping_tim
    | oth -> othsock := Some oth; failwith "json3"

let socklst'' = Cohttp.Header.of_list ([
    ("Pragma", "no-cache");
    ("Accept", "*/*");
    ("Sec-WebSocket-Key", "VZKbK6pxn54d/kqZXbyv/w==");
    ("Sec-WebSocket-Version", "13");
    ("Accept-Language", "en-GB,en;q=0.9");
    ("Sec-WebSocket-Extensions", "permessage-deflate");
    ("Cache-Control", "no-cache");
    ("Accept-Encoding", "gzip, deflate");
    ("Origin", "http://localhost:8080");
    ("Connection", "Upgrade");
    ("Upgrade", "websocket");
    ])

let json4 sid =
  let body = Lwt_main.run (body2 `GET ("iOS_Apple_iPad8_6_472AC2D5-B6DE-53DD-A563-BF202DF3203F&name=Jonathan%E2%80%99s%20iMac&EIO=3&transport=websocket&sid="^sid) socklst'' None) in
  body

(*
let timlst'' = Cohttp.Header.of_list ([
    ("Content-Type", "text/plain;charset=UTF-8");
    ("Origin", "http://localhost:8080");
    ("Accept-Encoding", "gzip, deflate");
    ("Connection", "keep-alive");
    ("Accept", "*/*");
    ("Referer", "http://localhost:8080/");
    ("Accept-Language", "en-GB,en;q=0.9");
    ])

let json5 sid =
  let payload = Some (`String "44:420[\"message\",\"setSystemTime\",1646674164069]") in
  let body = Lwt_main.run (body2 `POST ("iOS_Apple_iPad8_6_472AC2D5-B6DE-53DD-A563-BF202DF3203F&name=Jonathan%E2%80%99s%20iMac&EIO=3&transport=polling&t=Nzb3bV5&sid="^sid) timlst'' payload) in
  body
*)

let headlst6 = Cohttp.Header.of_list ([
    ("Origin", "http://localhost:8080");
    ("Connection", "keep-alive");
    ("Accept", "*/*");
    ("Referer", "http://localhost:8080/");
    ("Accept-Language", "en-GB,en;q=0.9");
    ("Accept-Encoding", "gzip, deflate");
    ])

let json6 sid =
  let body = Lwt_main.run (body2 `GET ("iOS_Apple_iPad8_6_472AC2D5-B6DE-53DD-A563-BF202DF3203F&name=Jonathan%E2%80%99s%20iMac&EIO=3&transport=polling&t=Nzb3bWH&sid="^sid) headlst6 None) in
  body

(*
let json7 sid =
  let msg = "31:421[\"message\",\"GetStatus\",null]" in
  let payload = Some (`String msg) in
  let body = Lwt_main.run (body2 `POST ("iOS_Apple_iPad8_6_472AC2D5-B6DE-53DD-A563-BF202DF3203F&name=Jonathan%E2%80%99s%20iMac&EIO=3&transport=polling&t=Nzb3bV5&sid="^sid) timlst'' payload) in
  body
*)

let sess_len = List.length Filtered.filtered;;

let tran_meth = function
| "GET" -> `GET
| "POST" -> `POST
| "OPTIONS" -> `OPTIONS
| _ -> failwith "tran_meth"

let body2' kind txt headers body =
  Cohttp_lwt_unix.Client.call kind (Uri.of_string ("http://"^txt)) ?chunked:(Some false) ?headers:(Some headers) ?body:body >>= fun (resp, body) ->
  let code = resp |> Cohttp_lwt_unix.Response.status |> Cohttp.Code.code_of_status in
  Printf.printf "Response code: %d\n" code;
(*
  Printf.printf "Headers: %s\n" (resp |> Cohttp_lwt_unix.Response.headers |> Cohttp.Header.to_string);
*)
  body |> Cohttp_lwt.Body.to_string >|= fun body ->
  Printf.printf "Body of length: %d\n" (String.length body);
  body

let filt4' x = List.rev (List.filter (fun (a,b) -> let used = match a with
| "User-Agent" -> false
| "Response code" -> false
| "Pragma" -> true
| "Access-Control-Request-Headers" -> true
| "Access-Control-Request-Method" -> true
| "Sec-WebSocket-Extensions" -> true
| "Sec-WebSocket-Version" -> true
| "Sec-WebSocket-Key" -> true
| "Upgrade" -> true
| "Cache-Control" -> true
| "Accept-Encoding" -> true
| "Referer" -> true
| "Accept-Language" -> true
| "Accept" -> true
| "Connection" -> true
| "Origin" -> true
| "Host" -> true
| "Content-Length" -> false
| "Content-Type" -> true
| _ -> failwith a in
(*
if used then print_endline (a^": "^b);
*)
used) x)

let split = List.map (fun itm -> let ix = String.index itm ':' in (String.sub itm 0 ix, String.sub itm (ix+2) (String.length itm - ix - 4)))

let json3' (itm:Request.req) =
  let meth = tran_meth !(itm.http_method) in
  let headlst = Cohttp.Header.of_list (filt4' (split !(itm.line))) in
  let body = Lwt_main.run (body2' meth ("10.0.0.1:8083/socket.io/?" ^ !(itm.query)) headlst None) in
  let json' = Yojson.Basic.from_string  ( String.sub body 4 (String.length body - 8)) in
  json'

let assoc' qsplit x = "/?" ^ String.concat "&" (List.map (fun itm -> if List.mem_assoc itm qsplit then List.assoc itm qsplit else failwith itm) x)

let pth (itm:Request.req) = if !(itm.path) <> "" then !(itm.path) else !(itm.uri)

let json4' (itm:Request.req) sid =
  let meth = tran_meth !(itm.http_method) in
  let split' = split !(itm.line) in
  let headlst = Cohttp.Header.of_list (filt4' split') in
  let qsplit = List.map (fun itm -> let ix = String.index itm '=' in (String.sub itm 0 ix, itm)) !(itm.qtree) in
  let query =  List.assoc "Host" split' ^ pth itm ^ assoc' qsplit ["id";"name";"EIO";"transport";"t"] ^ "&sid=" ^ sid in
  print_endline ("QUERY: "^ !(itm.http_method) ^" " ^query);
  let body = Lwt_main.run (body2' meth query headlst (Some (`String (List.hd !(itm.fil.unhandled))))) in
(*
  let json' = Yojson.Basic.from_string  ( String.sub body 4 (String.length body - 8)) in
  json'
*)
  body

let json5' (itm:Request.req) sid amper json' =
  let meth = tran_meth !(itm.http_method) in
  let split' = split !(itm.line) in
  let headlst = Cohttp.Header.of_list (filt4' split') in
  let qsplit = List.map (fun itm -> let ix = String.index itm '=' in (String.sub itm 0 ix, itm)) !(itm.qtree) in
  let query =  List.assoc "Host" split' ^ pth itm ^ (if amper <> [] then assoc' qsplit amper ^ "&sid=" ^ sid else "") in
  print_endline ("QUERY: "^ !(itm.http_method) ^" "^query);
  let payload = match meth with `POST -> let lst' = !(itm.fil.unhandled) in Some (if lst' <> [] then (`String (List.hd lst')) else `String json') | `GET -> None | `OPTIONS -> None in
  let body = Lwt_main.run (body2' meth query headlst (payload)) in
(*
  let json' = Yojson.Basic.from_string  ( String.sub body 4 (String.length body - 8)) in
  json'
*)
  if String.length body > 0 && body.[0] = '{' then print_endline body;
  body
