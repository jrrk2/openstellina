open Stellinapp_session_full
open Request

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
};
unhandled = ref [];
}

let new_req () =  {
http_method=ref "";
 uri=ref "";
 path=ref "";
 query=ref "";
 qtree=ref [];
 line=ref [];
 rline=ref [];
 code=ref 0;
 rdesc=ref "";
 lenh=ref 0;
 len=ref 0;
 cookie=ref [];
 ruri=ref "";
 fil=new_attr();
 key=ref "";
 sec=ref "";
}

let qtree' q = function
| ("http.request.uri.query.parameter", `String str) -> q := str :: !q
(*
| ("http.request.uri.query.parameter", `String "id=iOS_Apple_iPad8_6_472AC2D5-B6DE-53DD-A563-BF202DF3203F") -> q.id
| ("http.request.uri.query.parameter", `String "name=Jonathan%E2%80%99s%20iMac") -> ()
| ("http.request.uri.query.parameter", `String "transport=polling") -> ()
| ("http.request.uri.query.parameter", `String "t=NzboPSr") -> ()
*)
| oth -> failwith "qtree"

let othr = ref None

let req' req = function
| ("_ws.expert", _) -> ()
| ("http.request.method", `String http_method) -> req.http_method := http_method
| ("http.request.uri", `String uri) -> req.uri := uri
| ("http.request.uri_tree",
         `Assoc
           [("http.request.uri.path", `String path);
            ("http.request.uri.query", `String query);
            ("http.request.uri.query_tree", `Assoc qtree)]) -> req.path := path; req.query := query; List.iter (qtree' req.qtree) qtree
| ("http.request.version", `String "HTTP/1.1") -> ()
| ("http.response.version", `String "HTTP/1.1") -> ()
| ("http.response.code", `String code) -> req.code := int_of_string code
| ("http.response.code.desc", `String code) -> req.rdesc := code
| ("http.response.phrase", `String code) -> req.rdesc := code
| ("http.content_length", `String len) -> req.len := int_of_string len
| oth -> othr := Some oth; failwith "req"

let othd = ref `Null

let rec decode' attr = function
| ("success", `Bool _) -> ()
| ("result", `Assoc lst) -> List.iter (decode' attr) lst
| ("data", `String str) -> (try decode attr (Yojson.Basic.from_string str) with err -> attr.unhandled := str :: !(attr.unhandled))
| ("sid", `String sid) -> attr.id := sid
| ("upgrades", `List [`String "websocket"]) -> ()
| ("pingInterval", `Int t) -> ()
| ("pingTimeout", `Int t) -> ()
| ("message", `String "buffer is empty") -> ()
| ("latitude", `Float lat) -> attr.lat := lat
| ("longitude", `Float long) -> attr.long := long
| ("time", `Int t) -> ()
| ("apiVersion", `String str) -> attr.api_version := str
| ("version", `String ver) -> attr.version := ver
| oth -> othr := Some oth; failwith "decode'"

and decode attr = function
| `Assoc lst -> List.iter (decode' attr) lst
| `String str -> attr.unhandled := str :: !(attr.unhandled)
| oth -> othd := oth; failwith "decode"

let http' req = function
|   ("http.date", `String date) -> ()
|   ("http.time", `String time) -> ()
|   ("http.host", `String ""^ipaddr^":8082") -> ()
|   ("http.host", `String ""^ipaddr^":8083") -> ()
|   ("http.request.line", `String str) -> req.line := str :: !(req.line)
|   ("http.connection", `String "keep-alive") -> ()
|   ("http.accept", `String "*/*") -> ()
|   ("http.accept", `String "application/json, text/plain, */*") -> ()
|   ("http.user_agent", `String agent) -> ()
|   ("http.accept_language", `String "en-gb") -> ()
|   ("http.accept_language", `String "en-GB,en;q=0.9") -> ()
|   ("http.referer", `String "http://localhost:8080/") -> ()
|   ("http.accept_encoding", `String "gzip, deflate") -> ()
|   ("\\r\\n", `String "") -> ()
|   ("http.request.full_uri", `String full) -> ()
|   ("http.request", `String "1") -> ()
|   ("http.request_in", `String _) -> ()
|   ("http.request_number", `String _) -> ()
|   ("http.response_in", `String _) -> ()
|   ("http.response", `String "1") -> ()
|   ("http.response_number", `String _) -> ()
|   ("http.next_request_in", `String _) -> ()
|   ("http.next_response_in", `String _) -> ()
|   ("http.prev_request_in", `String _) -> ()
|   ("http.prev_response_in", `String _) -> ()
|   ("http.content_type", `String "text/plain; charset=UTF-8") -> ()
|   ("http.content_type", `String "text/html; charset=utf-8") -> ()
|   ("http.content_type", `String "text/plain;charset=UTF-8") -> ()
|   ("http.content_type", `String "text/html") -> ()
|   ("http.content_type", `String "image/jpeg") -> ()
|   ("http.content_type", `String "application/json") -> ()
|   ("http.content_type", `String "application/json; charset=utf-8") -> ()
|   ("http.response.line", `String "Content-Type: text/plain; charset=UTF-8\r\n") -> ()
|   ("http.content_length_header", `String len) -> req.lenh := int_of_string len
|   ("http.content_encoding", `String "gzip") -> ()
|   ("http.response.line", `String rline) -> req.rline := rline :: !(req.rline)
|   ("http.set_cookie", `String cookie) -> req.cookie := cookie :: !(req.cookie)
|   ("http.response_for.uri", `String uri) -> req.ruri := uri
|   ("http.file_data", `String j) -> (try decode req.fil (Yojson.Basic.from_string (let ix = String.index j '{' in String.sub j ix (String.length j - ix - ix))) with err -> req.fil.unhandled := j :: !(req.fil.unhandled))
|   ("http.sec_websocket_key", `String key) -> req.key := key
|   ("http.sec_websocket_version", `String "13") -> ()
|   ("http.sec_websocket_extensions", `String "permessage-deflate") -> ()
|   ("http.sec_websocket_accept", `String str) -> req.sec := str
|   ("http.cache_control", `String "no-cache") -> ()
|   ("http.cache_control", `String "public, max-age=31536000, immutable") -> ()
|   ("http.connection", `String "Upgrade") -> ()
|   ("http.upgrade", `String "websocket") -> ()
|   ("http.last_modified", `String date) -> ()
|   (_, `Assoc lst) -> List.iter (req' req) lst
|   (_, `String "") -> () (* Content-encoded entity body (gzip): X bytes -> Y bytes *)
| oth -> othr := Some oth; failwith "http'"

let lastitm = ref None
let lastlst' = ref []

let filt1 lst = List.map (fun itm ->
  lastitm := Some itm;
  let lst' = match itm with `Assoc lst -> List.filter (function ("_source", `Assoc lst) -> true | _ -> false) lst | _ -> failwith "lst'" in
  if lst' = [] then failwith "filt1'";
  lastlst' := lst';
  let lst'' = match List.hd lst' with ("_source", `Assoc [("layers", `Assoc lst)]) -> List.filter (function ("http", `Assoc _) -> true | _ -> false) lst | _ -> failwith "lst'" in
  let pkt req = match List.hd lst'' with ("http", `Assoc httplst) -> List.iter (http' req) httplst  | _ -> failwith "lst''" in
  let http = new_req() in
  if lst'' <> [] then pkt http;
  http) lst

let filtered = match json with `List lst -> filt1 lst | _ -> failwith "json";;
