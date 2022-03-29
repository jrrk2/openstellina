(* Stellina expert App *)

(* online simulator is here:

http://159.65.87.230/sim2/http/v1/app/status

*)


open GMain
open GdkKeysyms
open Graph
open Lwt

type session = {sid:string; ping_int: int; ping_tim: int }

let verbose = ref false

(*
let server = "192.168.0.36:"
let pth2' = "8082"
let pth3' = "8083"
let start = ref 0
*)

(*
let server = "159.65.87.230/sim2/http/"
let pth2' = ""
let pth3' = ""
let start = ref 6
*)

let server = "159.65.87.230/sim1/"
let pth2' = "http"
let pth3' = "socket"
let start = ref 0

let timezone = List.rev (String.split_on_char '/' (Unix.readlink "/etc/localtime"))

let session' = ref {sid=""; ping_int=0; ping_tim=0}
let rslt = Array.init 100 (fun ix -> `Null)
let cnv' body =
  let trim = int_of_string (String.sub body 0 (String.index body ':')) in
  let lftidx1 = if String.contains body '{' then String.index body '{' else String.length body in
  let lftidx2 = if String.contains body '[' then String.index body '[' else String.length body in
  let lftidx = min lftidx1 lftidx2 in
  let body = String.sub body lftidx (min trim (String.length body - lftidx)) in
  let rghtidx1 = if String.contains body '}' then String.rindex body '}' else 0 in
  let rghtidx2 = if String.contains body ']' then String.rindex body ']' else 0 in
  let rghtidx = max rghtidx1 rghtidx2 in
  let body = String.sub body 0 (rghtidx + 1) in
  body

let cnv body =
  let len = String.length body in
  let max = try int_of_string (Sys.getenv "MAX_DEBUG") with err -> 0 in
  if max > 0 then print_endline (if len < max then body else String.sub body 0 max);
  try Yojson.Basic.from_string (cnv' body) with err -> `String body

let session = function
`Assoc
    [("sid", `String sid);
     ("upgrades", `List [`String "websocket"]); ("pingInterval", `Int ping_int);
     ("pingTimeout", `Int ping_tim)] -> { sid; ping_int; ping_tim }
    | oth -> failwith "session"

let show = Quests.Response.show
let id = "iOS_Apple_iPad8_6_472AC2D5-B6DE-53DD-A563-BF202DF3203F"
let name = "Jonathan's iMac"
let polling = "polling"
let eio = "3"
let t' = "NzboPSr"
let params' = [ ("id", id); ("name", name); ("EIO", eio); ("transport", polling); ("t", t') ]
let headers = [ ("Content-Type", "text/plain; charset=utf-8") ]
let split = List.map (fun itm -> let ix = String.index itm ':' in (String.sub itm 0 ix, String.sub itm (ix+2) (String.length itm - ix - 4)))
let pth = pth3'^"/socket.io/"
let cookie = ref []
let hdrs = ref []

let get' ix params headers pth f =
  Quests.get ("http://"^server^""^pth)
    ~params:(params)
    ~headers:(headers)
  >|= ( fun arg -> hdrs := Cohttp.Header.to_list (Quests.Response.headers arg); Quests.Response.content arg) >|= f

let post' ix params headers pth form =
  Quests.post ("http://"^server^""^pth)
    ~params:(params)
    ~headers:(headers)
    ~data:(form)
  >|= Quests.Response.content >|= (fun s -> rslt.(ix) <- cnv s)

let get1' ix =
    get' ix params' headers pth (fun s -> rslt.(ix) <- cnv s)

let post2' ix =
    session' := session rslt.(1);
    cookie := List.filter (function ("Content-Length", _) -> false | _ -> true) !hdrs;
    let params = (("sid", (!session').sid) :: params') in
    let time_ms_str = string_of_int (int_of_float (Unix.time() *. 1000.0)) in
    post' ix params headers pth (Quests.Request.Raw ("44:420[\"message\",\"setSystemTime\","^time_ms_str^"]"))

let get3' ix =
    let params = ("sid", (!session').sid) :: [ ("id", id); ("name", name); ("EIO", eio); ("transport", "websocket") ] in
    let headers = split ["Upgrade: websocket\r\n"; "Connection: Upgrade\r\n";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148\r\n";
      "Origin: http://localhost:8080\r\n";
      "Accept-Encoding: gzip, deflate\r\n"; "Cache-Control: no-cache\r\n";
      "Sec-WebSocket-Extensions: permessage-deflate\r\n";
      "Accept-Language: en-GB,en;q=0.9\r\n"; "Sec-WebSocket-Version: 13\r\n";
      "Sec-WebSocket-Key: U3EsKacH/DvIMkbPXUr92Q==\r\n"; "Accept: */*\r\n";
      "Pragma: no-cache\r\n" (*; "Host: "^ipaddr^":8083\r\n" *) ] in
    get' ix params headers pth (fun s -> rslt.(ix) <- cnv s)

let get4' ix =
    let params = (("sid", (!session').sid) :: params') in
    let headers = split ["Accept-Encoding: gzip, deflate\r\n";
      "Referer: http://localhost:8080/\r\n";
      "Accept-Language: en-GB,en;q=0.9\r\n";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148\r\n";
      "Accept: application/json";
      "Connection: keep-alive\r\n"] in
    get' ix params headers pth (fun s -> rslt.(ix) <- cnv s)

let post5' ix =
    let params = (("sid", (!session').sid) :: params') in
    let headers = !cookie @ split [
      "Access-Control-Allow-Origin: http://localhost:8080\r\n";
      "Access-Control-Allow-Credentials: true\r\n";
      "Content-Encoding: gzip\r\n"] in
    post' ix params headers pth (Quests.Request.Raw ("31:421[\"message\",\"getStatus\",null]"))

let get6' ix =
    let params = (("sid", (!session').sid) :: params') in
    let headers = split ["Accept-Encoding: gzip, deflate\r\n";
      "Referer: http://localhost:8080/\r\n";
      "Accept-Language: en-GB,en;q=0.9\r\n";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148\r\n";
      "Accept: */*\r\n"; "Connection: keep-alive\r\n"] in
    get' ix params headers pth (fun s -> rslt.(ix) <- cnv s)

let post7' ix =
    let params = [] in
    let headers = split 
   ["Content-Type: application/json";
    "Origin: http://localhost:8080";
    "Accept-Encoding: gzip, deflate";
    "Connection: keep-alive";
    "Accept: application/json, text/plain, */*";
    "Accept-Language: en-GB,en;q=0.9"] in
    let pth = pth2'^"/v1//logs/consume" in
    post' ix params headers pth (Quests.Request.Raw ("{}"))

(*
let post8' ix =
    let params = [] in
    let headers = split 
   ["Content-Type: application/json";
    "Origin: http://localhost:8080";
    "Accept-Encoding: gzip, deflate";
    "Connection: keep-alive";
    "Accept: application/json, text/plain, */*";
    "Accept-Language: en-GB,en;q=0.9"] in
    let pth = pth2'^"/v1//expertMode/startStorageAcquisition" in
    post' ix params headers pth (Quests.Request.Json ( `Assoc
  [("path", `String "expert-mode/raw-images"); ("overwrite", `Bool true);
   ("numExposures", `Int 100); ("gain", `Int 200);
   ("exposureMicroSec", `Int 60000000); ("flip", `String "BOTH")] ))

let post8' ix =
    let pth = pth2'^"/v1//general/openForMaintenance" in
    post' ix [] [] pth (Quests.Request.Raw "{}")

let post9' ix =
    let params = [] in
    let headers = split 
   ["Content-Type: application/json";
    "Origin: http://localhost:8080";
    "Accept-Encoding: gzip, deflate";
    "Connection: keep-alive";
    "Accept: application/json, text/plain, */*";
    "Accept-Language: en-GB,en;q=0.9"] in
    let pth = pth2'^"/v1//general/openForMaintenance" in
    post' ix params headers pth (Quests.Request.Raw "{}")
*)

let obj_id = ref ""
let obj_nam = ref ""
let ra_flt = ref 0.0
let dec_flt = ref 0.0
let gain_int = ref 200
let expos_flt = ref 10.0
let lat_flt = ref 0.0
let long_flt = ref 0.0

let init' ix =
    let pth = pth2'^"/v1//general/startAutoInit" in
    let time_ms = int_of_float (Unix.time() *. 1000.0) in
    post' ix [] [] pth (Quests.Request.Json (`Assoc
    [("latitude", `Float !lat_flt);
     ("longitude", `Float !long_flt); ("time", `Int time_ms)] ))

let observe' ix =
    let pth = pth2'^"/v1//general/startObservation" in
    post' ix [] [] pth (Quests.Request.Json (`Assoc
    [("ra", `Float !ra_flt); ("de", `Float !dec_flt);
     ("rot", `Int 0); ("objectId", `String !obj_id);
     ("objectName", `String !obj_nam); ("gain", `Int !gain_int);
     ("exposureMicroSec", `Int (int_of_float (floor (!expos_flt *. 1000000.0)))); ("doStacking", `Bool true);
     ("histogramEnabled", `Bool true); ("histogramLow", `Float (-0.75));
     ("histogramMedium", `Int 5); ("histogramHigh", `Int 0);
     ("backgroundEnabled", `Bool true); ("backgroundPolyorder", `Int 4)]))

let focus' ix =
    let pth = pth2'^"/v1//general/adjustObservationFocus" in
    post' ix [] [] pth (Quests.Request.Raw "{}")

let stopobs' ix =
    let pth = pth2'^"/v1//general/stopObservation" in
    post' ix [] [] pth (Quests.Request.Raw "{}")

let status'' ix =
    let pth = pth2'^"/v1//app/status" in
    post' ix [] [] pth (Quests.Request.Raw "{}")

let status' ix =
    print_endline "status'";
    post7' ix

let park' ix =
    let pth = pth2'^"/v1//general/park" in
    post' ix [] [] pth (Quests.Request.Raw "{}")

let jpegh = Hashtbl.create 127

let jpegadd s = if Hashtbl.mem jpegh s then () else Hashtbl.add jpegh s (ref false)

let fetch' ix =
    let jpeg = ref "" in
    Hashtbl.iter (fun k x -> if !x then () else jpeg := k; x := true) jpegh;
    print_endline ("Fetching: "^ !jpeg);
    let pth = pth2'^"/"^(!jpeg) in
    let headers = split ["Accept-Encoding: gzip, deflate\r\n";
      "Referer: http://localhost:8080/\r\n";
      "Accept-Language: en-GB,en;q=0.9\r\n";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148\r\n";
      "Accept: */*\r\n"; "Connection: keep-alive\r\n"] in
    let f = fun s -> let pth = String.rindex !jpeg '/' in
                     let pth' = String.sub !jpeg (pth+1) (String.length !jpeg - pth - 1) in
                     print_endline ("Dumping: "^pth');
                     let fd = open_out pth' in
                     output_string fd s;
                     close_out fd in
    get' ix [] headers pth f

let taskarray =
       [|
         ("get1", get1');
         ("post2", post2');
         ("get3", get3');
         ("get4", get4');
         ("post5", post5');
         ("get6", get6');
         ("post7", post7');
(*
         ("post8", post8');
         ("post9", post9');
*)
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
         ("status''", status'');
         ("", status');
         ("fetch", fetch');
         ("", status');
       |]

let stoptask = Array.length taskarray - 1
let status = ref None

let logfile = open_out "logfile.txt"

(*
let otherr = Array.init 100 (fun ix -> `Null)
let otherr' = ref ["", `Null]
*)
let err ix errmsg =
    if !ix <> stoptask then print_endline ("terminating at step "^string_of_int !ix^" due to error "^errmsg);
    ix := stoptask

let rec errchklst' ix (arg:string*Yojson.Basic.t) = match arg with
| (kw', `List errlst) -> let errlst' = List.map (fun (itm) -> (kw', itm)) errlst in List.iter (errchklst' ix) errlst'
| ("state", `String state) -> print_endline (state); (match !status with Some e -> e#set_text state )
| (kw', `Assoc lst) -> let lst' = List.map (fun (kw,itm) -> (kw' ^ "@" ^ kw, itm)) lst in List.iter (errchklst' ix) lst'
| ("currentOperation@steps@steps@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("currentOperation@steps@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("currentOperation@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("previousOperations@autoInit@steps@steps@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("previousOperations@autoInit@steps@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("previousOperations@autoInit@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("previousOperations@observation@steps@steps@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("previousOperations@observation@steps@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("previousOperations@observation@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("previousOperations@open@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("status@currentOperation@steps@steps@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("status@currentOperation@steps@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("status@currentOperation@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("status@previousOperations@autoInit@steps@steps@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("status@previousOperations@autoInit@steps@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("status@previousOperations@autoInit@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("status@previousOperations@observation@steps@steps@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("status@previousOperations@observation@steps@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("status@previousOperations@observation@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("status@previousOperations@open@type", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("currentOperation@steps@name", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("currentOperation@steps@name", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("currentOperation@steps@steps@astrometryDelta", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("status@currentOperation@steps@name", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("status@currentOperation@steps@name", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("status@currentOperation@steps@steps@astrometryDelta", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("status@previousOperations@observation@capture@images@url", `String json) -> print_endline json; jpegadd json
| ("currentOperation@capture@images@url", `String json) -> print_endline json; jpegadd json

| oth,json ->
   Printf.fprintf logfile "| (\"%s\", json) -> (match !status with Some e -> e#set_text \"%s\")\n" oth (Yojson.Basic.to_string json);
   flush logfile
| ("apiVersion", _) -> ()
| ("autofocusTemperature", _) -> ()
| ("availableReports", _) -> ()
| ("boardInDebugMode", _) -> ()
| ("boardInitError", _) -> ()
| ("bootCount", _) -> ()
| ("connectedDevices@id", _) -> ()
| ("connectedDevices@name", _) -> ()
| ("currentOperation@actionInProgress", json) -> (if false then match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("currentOperation@capture@acquisitionCount", _) -> ()
| ("currentOperation@capture@cameraParams@exposureMicroSec", _) -> ()
| ("currentOperation@capture@cameraParams@gain", _) -> ()
| ("currentOperation@capture@cameraParams@height", _) -> ()
| ("currentOperation@capture@cameraParams@width", _) -> ()
| ("currentOperation@capture@captureType", _) -> ()
| ("currentOperation@capture@ctx", _) -> ()
| ("currentOperation@capture@endTime", _) -> ()
| ("currentOperation@capture@error", _) -> ()
| ("currentOperation@capture@hasStacking", _) -> ()
| ("currentOperation@capture@id", _) -> ()
| ("currentOperation@capture@images@cropHeight", _) -> ()
| ("currentOperation@capture@images@cropWidth", _) -> ()
| ("currentOperation@capture@images@cropX", _) -> ()
| ("currentOperation@capture@images@cropY", _) -> ()
| ("currentOperation@capture@images@exifSize", _) -> ()
| ("currentOperation@capture@images@index", _) -> ()
| ("currentOperation@capture@images@stackingCount", _) -> ()
| ("currentOperation@capture@images@stackingErrorCount", _) -> ()
| ("currentOperation@capture@images@time", _) -> ()
| ("currentOperation@capture@outputImageCount", _) -> ()
| ("currentOperation@capture@outputImageErrorCount", _) -> ()
| ("currentOperation@capture@position@latitude", _) -> ()
| ("currentOperation@capture@position@longitude", _) -> ()
| ("currentOperation@capture@stackingCount", _) -> ()
| ("currentOperation@capture@stackingErrorCount", _) -> ()
| ("currentOperation@capture@stackingErrorMap@StackingRoundnessError", _) -> ()
| ("currentOperation@capture@startHumidity", _) -> ()
| ("currentOperation@capture@startTemperature", _) -> ()
| ("currentOperation@capture@startTime", _) -> ()
| ("currentOperation@capture@stopped", _) -> ()
| ("currentOperation@capture@target@de", _) -> ()
| ("currentOperation@capture@target@objectId", _) -> ()
| ("currentOperation@capture@target@objectName", _) -> ()
| ("currentOperation@capture@target@ra", _) -> ()
| ("currentOperation@capture@target@rot", _) -> ()
| ("currentOperation@ctx", _) -> ()
| ("currentOperation@endTime", _) -> ()
| ("currentOperation@error", _) -> ()
| ("currentOperation@framing@de", _) -> ()
| ("currentOperation@framing@ra", _) -> ()
| ("currentOperation@framing@rot", _) -> ()
| ("currentOperation@id", _) -> ()
| ("currentOperation@previousCaptures@acquisitionCount", _) -> ()
| ("currentOperation@previousCaptures@cameraParams@exposureMicroSec", _) -> ()
| ("currentOperation@previousCaptures@cameraParams@gain", _) -> ()
| ("currentOperation@previousCaptures@cameraParams@height", _) -> ()
| ("currentOperation@previousCaptures@cameraParams@width", _) -> ()
| ("currentOperation@previousCaptures@captureType", _) -> ()
| ("currentOperation@previousCaptures@ctx", _) -> ()
| ("currentOperation@previousCaptures@endHumidity", _) -> ()
| ("currentOperation@previousCaptures@endTemperature", _) -> ()
| ("currentOperation@previousCaptures@endTime", _) -> ()
| ("currentOperation@previousCaptures@error@name", _) -> ()
| ("currentOperation@previousCaptures@hasStacking", _) -> ()
| ("currentOperation@previousCaptures@id", _) -> ()
| ("currentOperation@previousCaptures@outputImageCount", _) -> ()
| ("currentOperation@previousCaptures@outputImageErrorCount", _) -> ()
| ("currentOperation@previousCaptures@position@latitude", _) -> ()
| ("currentOperation@previousCaptures@position@longitude", _) -> ()
| ("currentOperation@previousCaptures@stackingCount", _) -> ()
| ("currentOperation@previousCaptures@stackingErrorCount", _) -> ()
| ("currentOperation@previousCaptures@stackingErrorMap@StackingRoundnessError", _) -> ()
| ("currentOperation@previousCaptures@startHumidity", _) -> ()
| ("currentOperation@previousCaptures@startTemperature", _) -> ()
| ("currentOperation@previousCaptures@startTime", _) -> ()
| ("currentOperation@previousCaptures@stopped", _) -> ()
| ("currentOperation@previousCaptures@target@de", _) -> ()
| ("currentOperation@previousCaptures@target@objectId", _) -> ()
| ("currentOperation@previousCaptures@target@objectName", _) -> ()
| ("currentOperation@previousCaptures@target@ra", _) -> ()
| ("currentOperation@previousCaptures@target@rot", _) -> ()
| ("currentOperation@startTime", _) -> ()
| ("currentOperation@steps@autoFocus@focusValue", _) -> ()
| ("currentOperation@steps@autoFocus@map", _) -> ()
| ("currentOperation@steps@name", json) -> (match !status with Some e -> e#set_text (Yojson.Basic.to_string json))
| ("currentOperation@steps@progress", _) -> ()
| ("currentOperation@steps@steps@astrometryDelta", _) -> ()
| ("currentOperation@steps@steps@type", _) -> ()
| ("currentOperation@steps@type", _) -> ()
| ("currentOperation@stopped", _) -> ()
| ("currentOperation@target@de", _) -> ()
| ("currentOperation@target@objectId", _) -> ()
| ("currentOperation@target@objectName", _) -> ()
| ("currentOperation@target@ra", _) -> ()
| ("currentOperation@target@rot", _) -> ()
| ("currentOperation@type", _) -> ()
| ("elapsedTime", _) -> ()
| ("initError", _) -> ()
| ("initialized", _) -> ()
| ("logs@bufferPosition", _) -> ()
| ("logs@bufferSize", _) -> ()
| ("logs@numFiles", _) -> ()
| ("masterDeviceId", _) -> ()
| ("motors@ALT@calibrated", _) -> ()
| ("motors@ALT@position", _) -> ()
| ("motors@ALT@state", _) -> ()
| ("motors@AZ@calibrated", _) -> ()
| ("motors@AZ@position", _) -> ()
| ("motors@AZ@state", _) -> ()
| ("motors@DER@calibrated", _) -> ()
| ("motors@DER@position", _) -> ()
| ("motors@DER@state", _) -> ()
| ("motors@MAP@calibrated", _) -> ()
| ("motors@MAP@position", _) -> ()
| ("motors@MAP@state", _) -> ()
| ("position@latitude", _) -> ()
| ("position@longitude", _) -> ()
| ("previousOperations@autoInit@armPosition@ALT", _) -> ()
| ("previousOperations@autoInit@armPosition@AZ", _) -> ()
| ("previousOperations@autoInit@armPosition@index", _) -> ()
| ("previousOperations@autoInit@astrometry@de", _) -> ()
| ("previousOperations@autoInit@astrometry@ra", _) -> ()
| ("previousOperations@autoInit@astrometry@rot", _) -> ()
| ("previousOperations@autoInit@ctx", _) -> ()
| ("previousOperations@autoInit@endTime", _) -> ()
| ("previousOperations@autoInit@error", _) -> ()
| ("previousOperations@autoInit@focusResult@focusValue", _) -> ()
| ("previousOperations@autoInit@focusResult@map", _) -> ()
| ("previousOperations@autoInit@id", _) -> ()
| ("previousOperations@autoInit@position@latitude", _) -> ()
| ("previousOperations@autoInit@position@longitude", _) -> ()
| ("previousOperations@autoInit@startTime", _) -> ()
| ("previousOperations@autoInit@steps@steps@astrometry@de", _) -> ()
| ("previousOperations@autoInit@steps@steps@astrometry@ra", _) -> ()
| ("previousOperations@autoInit@steps@steps@astrometry@rot", _) -> ()
| ("previousOperations@autoInit@steps@steps@autoFocus@focusValue", _) -> ()
| ("previousOperations@autoInit@steps@steps@autoFocus@map", _) -> ()
| ("previousOperations@autoInit@steps@steps@progress", _) -> ()
| ("previousOperations@autoInit@steps@steps@type", _) -> ()
| ("previousOperations@autoInit@steps@type", _) -> ()
| ("previousOperations@autoInit@stopped", _) -> ()
| ("previousOperations@autoInit@time", _) -> ()
| ("previousOperations@autoInit@type", _) -> ()
| ("previousOperations@observation@actionInProgress", _) -> ()
| ("previousOperations@observation@capture@acquisitionCount", _) -> ()
| ("previousOperations@observation@capture@cameraParams@exposureMicroSec", _) -> ()
| ("previousOperations@observation@capture@cameraParams@gain", _) -> ()
| ("previousOperations@observation@capture@cameraParams@height", _) -> ()
| ("previousOperations@observation@capture@cameraParams@width", _) -> ()
| ("previousOperations@observation@capture@captureType", _) -> ()
| ("previousOperations@observation@capture@ctx", _) -> ()
| ("previousOperations@observation@capture@endHumidity", _) -> ()
| ("previousOperations@observation@capture@endTemperature", _) -> ()
| ("previousOperations@observation@capture@endTime", _) -> ()
| ("previousOperations@observation@capture@error@data@byOp", _) -> ()
| ("previousOperations@observation@capture@error@name", _) -> ()
| ("previousOperations@observation@capture@hasStacking", _) -> ()
| ("previousOperations@observation@capture@id", _) -> ()
| ("previousOperations@observation@capture@images@cropHeight", _) -> ()
| ("previousOperations@observation@capture@images@cropWidth", _) -> ()
| ("previousOperations@observation@capture@images@cropX", _) -> ()
| ("previousOperations@observation@capture@images@cropY", _) -> ()
| ("previousOperations@observation@capture@images@exifSize", _) -> ()
| ("previousOperations@observation@capture@images@index", _) -> ()
| ("previousOperations@observation@capture@images@stackingCount", _) -> ()
| ("previousOperations@observation@capture@images@stackingErrorCount", _) -> ()
| ("previousOperations@observation@capture@images@time", _) -> ()
| ("previousOperations@observation@capture@images@url", _) -> ()
| ("previousOperations@observation@capture@outputImageCount", _) -> ()
| ("previousOperations@observation@capture@outputImageErrorCount", _) -> ()
| ("previousOperations@observation@capture@position@latitude", _) -> ()
| ("previousOperations@observation@capture@position@longitude", _) -> ()
| ("previousOperations@observation@capture@stackingCount", _) -> ()
| ("previousOperations@observation@capture@stackingErrorCount", _) -> ()
| ("previousOperations@observation@capture@stackingErrorMap@StackingRoundnessError", _) -> ()
| ("previousOperations@observation@capture@startHumidity", _) -> ()
| ("previousOperations@observation@capture@startTemperature", _) -> ()
| ("previousOperations@observation@capture@startTime", _) -> ()
| ("previousOperations@observation@capture@stopped", _) -> ()
| ("previousOperations@observation@capture@target@de", _) -> ()
| ("previousOperations@observation@capture@target@objectId", _) -> ()
| ("previousOperations@observation@capture@target@objectName", _) -> ()
| ("previousOperations@observation@capture@target@ra", _) -> ()
| ("previousOperations@observation@capture@target@rot", _) -> ()
| ("previousOperations@observation@ctx", _) -> ()
| ("previousOperations@observation@endTime", _) -> ()
| ("previousOperations@observation@error", _) -> ()
| ("previousOperations@observation@error@name", _) -> ()
| ("previousOperations@observation@framing@de", _) -> ()
| ("previousOperations@observation@framing@ra", _) -> ()
| ("previousOperations@observation@framing@rot", _) -> ()
| ("previousOperations@observation@id", _) -> ()
| ("previousOperations@observation@previousCaptures@acquisitionCount", _) -> ()
| ("previousOperations@observation@previousCaptures@cameraParams@exposureMicroSec", _) -> ()
| ("previousOperations@observation@previousCaptures@cameraParams@gain", _) -> ()
| ("previousOperations@observation@previousCaptures@cameraParams@height", _) -> ()
| ("previousOperations@observation@previousCaptures@cameraParams@width", _) -> ()
| ("previousOperations@observation@previousCaptures@captureType", _) -> ()
| ("previousOperations@observation@previousCaptures@ctx", _) -> ()
| ("previousOperations@observation@previousCaptures@endHumidity", _) -> ()
| ("previousOperations@observation@previousCaptures@endTemperature", _) -> ()
| ("previousOperations@observation@previousCaptures@endTime", _) -> ()
| ("previousOperations@observation@previousCaptures@error@name", _) -> ()
| ("previousOperations@observation@previousCaptures@hasStacking", _) -> ()
| ("previousOperations@observation@previousCaptures@id", _) -> ()
| ("previousOperations@observation@previousCaptures@outputImageCount", _) -> ()
| ("previousOperations@observation@previousCaptures@outputImageErrorCount", _) -> ()
| ("previousOperations@observation@previousCaptures@position@latitude", _) -> ()
| ("previousOperations@observation@previousCaptures@position@longitude", _) -> ()
| ("previousOperations@observation@previousCaptures@stackingCount", _) -> ()
| ("previousOperations@observation@previousCaptures@stackingErrorCount", _) -> ()
| ("previousOperations@observation@previousCaptures@stackingErrorMap@StackingRoundnessError", _) -> ()
| ("previousOperations@observation@previousCaptures@startHumidity", _) -> ()
| ("previousOperations@observation@previousCaptures@startTemperature", _) -> ()
| ("previousOperations@observation@previousCaptures@startTime", _) -> ()
| ("previousOperations@observation@previousCaptures@stopped", _) -> ()
| ("previousOperations@observation@previousCaptures@target@de", _) -> ()
| ("previousOperations@observation@previousCaptures@target@objectId", _) -> ()
| ("previousOperations@observation@previousCaptures@target@objectName", _) -> ()
| ("previousOperations@observation@previousCaptures@target@ra", _) -> ()
| ("previousOperations@observation@previousCaptures@target@rot", _) -> ()
| ("previousOperations@observation@startTime", _) -> ()
| ("previousOperations@observation@steps@autoFocus@focusValue", _) -> ()
| ("previousOperations@observation@steps@autoFocus@map", _) -> ()
| ("previousOperations@observation@steps@name", _) -> ()
| ("previousOperations@observation@steps@progress", _) -> ()
| ("previousOperations@observation@steps@steps@astrometryDelta", _) -> ()
| ("previousOperations@observation@steps@steps@type", _) -> ()
| ("previousOperations@observation@steps@type", _) -> ()
| ("previousOperations@observation@stopped", _) -> ()
| ("previousOperations@observation@target@de", _) -> ()
| ("previousOperations@observation@target@objectId", _) -> ()
| ("previousOperations@observation@target@objectName", _) -> ()
| ("previousOperations@observation@target@ra", _) -> ()
| ("previousOperations@observation@target@rot", _) -> ()
| ("previousOperations@observation@type", _) -> ()
| ("previousOperations@open@ctx", _) -> ()
| ("previousOperations@open@endTime", _) -> ()
| ("previousOperations@open@error", _) -> ()
| ("previousOperations@open@id", _) -> ()
| ("previousOperations@open@startTime", _) -> ()
| ("previousOperations@open@stopped", _) -> ()
| ("previousOperations@open@type", _) -> ()
| ("previousOperations@park", _) -> ()
| ("previousOperations@runPlan", _) -> ()
| ("previousOperations@storageAcquisition", _) -> ()
| ("previousOperations@sunMode", _) -> ()
| ("sensors@defogStatus", _) -> ()
| ("sensors@dewpointDepression", _) -> ()
| ("sensors@humidity", _) -> ()
| ("sensors@humidityDelta", _) -> ()
| ("sensors@temperature", _) -> ()
| ("sensors@temperatureDelta", _) -> ()
| ("settings@telescopeName", _) -> ()
| ("settings@usbFileTypes", _) -> ()
| ("shuttingDown", _) -> ()
| ("status@apiVersion", _) -> ()
| ("status@autofocusTemperature", _) -> ()
| ("status@availableReports", _) -> ()
| ("status@boardInDebugMode", _) -> ()
| ("status@boardInitError", _) -> ()
| ("status@bootCount", _) -> ()
| ("status@connectedDevices@id", _) -> ()
| ("status@connectedDevices@name", _) -> ()
| ("status@currentOperation@actionInProgress", _) -> ()
| ("status@currentOperation@capture@acquisitionCount", _) -> ()
| ("status@currentOperation@capture@cameraParams@exposureMicroSec", _) -> ()
| ("status@currentOperation@capture@cameraParams@gain", _) -> ()
| ("status@currentOperation@capture@cameraParams@height", _) -> ()
| ("status@currentOperation@capture@cameraParams@width", _) -> ()
| ("status@currentOperation@capture@captureType", _) -> ()
| ("status@currentOperation@capture@ctx", _) -> ()
| ("status@currentOperation@capture@endTime", _) -> ()
| ("status@currentOperation@capture@error", _) -> ()
| ("status@currentOperation@capture@hasStacking", _) -> ()
| ("status@currentOperation@capture@id", _) -> ()
| ("status@currentOperation@capture@images@cropHeight", _) -> ()
| ("status@currentOperation@capture@images@cropWidth", _) -> ()
| ("status@currentOperation@capture@images@cropX", _) -> ()
| ("status@currentOperation@capture@images@cropY", _) -> ()
| ("status@currentOperation@capture@images@exifSize", _) -> ()
| ("status@currentOperation@capture@images@index", _) -> ()
| ("status@currentOperation@capture@images@stackingCount", _) -> ()
| ("status@currentOperation@capture@images@stackingErrorCount", _) -> ()
| ("status@currentOperation@capture@images@time", _) -> ()
| ("status@currentOperation@capture@images@url", _) -> ()
| ("status@currentOperation@capture@outputImageCount", _) -> ()
| ("status@currentOperation@capture@outputImageErrorCount", _) -> ()
| ("status@currentOperation@capture@position@latitude", _) -> ()
| ("status@currentOperation@capture@position@longitude", _) -> ()
| ("status@currentOperation@capture@stackingCount", _) -> ()
| ("status@currentOperation@capture@stackingErrorCount", _) -> ()
| ("status@currentOperation@capture@stackingErrorMap@StackingRoundnessError", _) -> ()
| ("status@currentOperation@capture@startHumidity", _) -> ()
| ("status@currentOperation@capture@startTemperature", _) -> ()
| ("status@currentOperation@capture@startTime", _) -> ()
| ("status@currentOperation@capture@stopped", _) -> ()
| ("status@currentOperation@capture@target@de", _) -> ()
| ("status@currentOperation@capture@target@objectId", _) -> ()
| ("status@currentOperation@capture@target@objectName", _) -> ()
| ("status@currentOperation@capture@target@ra", _) -> ()
| ("status@currentOperation@capture@target@rot", _) -> ()
| ("status@currentOperation@ctx", _) -> ()
| ("status@currentOperation@endTime", _) -> ()
| ("status@currentOperation@error", _) -> ()
| ("status@currentOperation@framing@de", _) -> ()
| ("status@currentOperation@framing@ra", _) -> ()
| ("status@currentOperation@framing@rot", _) -> ()
| ("status@currentOperation@id", _) -> ()
| ("status@currentOperation@previousCaptures@acquisitionCount", _) -> ()
| ("status@currentOperation@previousCaptures@cameraParams@exposureMicroSec", _) -> ()
| ("status@currentOperation@previousCaptures@cameraParams@gain", _) -> ()
| ("status@currentOperation@previousCaptures@cameraParams@height", _) -> ()
| ("status@currentOperation@previousCaptures@cameraParams@width", _) -> ()
| ("status@currentOperation@previousCaptures@captureType", _) -> ()
| ("status@currentOperation@previousCaptures@ctx", _) -> ()
| ("status@currentOperation@previousCaptures@endHumidity", _) -> ()
| ("status@currentOperation@previousCaptures@endTemperature", _) -> ()
| ("status@currentOperation@previousCaptures@endTime", _) -> ()
| ("status@currentOperation@previousCaptures@error@name", _) -> ()
| ("status@currentOperation@previousCaptures@hasStacking", _) -> ()
| ("status@currentOperation@previousCaptures@id", _) -> ()
| ("status@currentOperation@previousCaptures@outputImageCount", _) -> ()
| ("status@currentOperation@previousCaptures@outputImageErrorCount", _) -> ()
| ("status@currentOperation@previousCaptures@position@latitude", _) -> ()
| ("status@currentOperation@previousCaptures@position@longitude", _) -> ()
| ("status@currentOperation@previousCaptures@stackingCount", _) -> ()
| ("status@currentOperation@previousCaptures@stackingErrorCount", _) -> ()
| ("status@currentOperation@previousCaptures@stackingErrorMap@StackingRoundnessError", _) -> ()
| ("status@currentOperation@previousCaptures@startHumidity", _) -> ()
| ("status@currentOperation@previousCaptures@startTemperature", _) -> ()
| ("status@currentOperation@previousCaptures@startTime", _) -> ()
| ("status@currentOperation@previousCaptures@stopped", _) -> ()
| ("status@currentOperation@previousCaptures@target@de", _) -> ()
| ("status@currentOperation@previousCaptures@target@objectId", _) -> ()
| ("status@currentOperation@previousCaptures@target@objectName", _) -> ()
| ("status@currentOperation@previousCaptures@target@ra", _) -> ()
| ("status@currentOperation@previousCaptures@target@rot", _) -> ()
| ("status@currentOperation@startTime", _) -> ()
| ("status@currentOperation@steps@autoFocus@focusValue", _) -> ()
| ("status@currentOperation@steps@autoFocus@map", _) -> ()
| ("status@currentOperation@steps@name", _) -> ()
| ("status@currentOperation@steps@progress", _) -> ()
| ("status@currentOperation@steps@steps@astrometryDelta", _) -> ()
| ("status@currentOperation@steps@steps@type", _) -> ()
| ("status@currentOperation@steps@type", _) -> ()
| ("status@currentOperation@stopped", _) -> ()
| ("status@currentOperation@target@de", _) -> ()
| ("status@currentOperation@target@objectId", _) -> ()
| ("status@currentOperation@target@objectName", _) -> ()
| ("status@currentOperation@target@ra", _) -> ()
| ("status@currentOperation@target@rot", _) -> ()
| ("status@currentOperation@type", _) -> ()
| ("status@elapsedTime", _) -> ()
| ("status@initError", _) -> ()
| ("status@initialized", _) -> ()
| ("status@logs@bufferPosition", _) -> ()
| ("status@logs@bufferSize", _) -> ()
| ("status@logs@numFiles", _) -> ()
| ("status@masterDeviceId", _) -> ()
| ("status@motors@ALT@calibrated", _) -> ()
| ("status@motors@ALT@position", _) -> ()
| ("status@motors@ALT@state", _) -> ()
| ("status@motors@AZ@calibrated", _) -> ()
| ("status@motors@AZ@position", _) -> ()
| ("status@motors@AZ@state", _) -> ()
| ("status@motors@DER@calibrated", _) -> ()
| ("status@motors@DER@position", _) -> ()
| ("status@motors@DER@state", _) -> ()
| ("status@motors@MAP@calibrated", _) -> ()
| ("status@motors@MAP@position", _) -> ()
| ("status@motors@MAP@state", _) -> ()
| ("status@position@latitude", _) -> ()
| ("status@position@longitude", _) -> ()
| ("status@previousOperations@autoInit@armPosition@ALT", _) -> ()
| ("status@previousOperations@autoInit@armPosition@AZ", _) -> ()
| ("status@previousOperations@autoInit@armPosition@index", _) -> ()
| ("status@previousOperations@autoInit@astrometry@de", _) -> ()
| ("status@previousOperations@autoInit@astrometry@ra", _) -> ()
| ("status@previousOperations@autoInit@astrometry@rot", _) -> ()
| ("status@previousOperations@autoInit@ctx", _) -> ()
| ("status@previousOperations@autoInit@endTime", _) -> ()
| ("status@previousOperations@autoInit@error", _) -> ()
| ("status@previousOperations@autoInit@focusResult@focusValue", _) -> ()
| ("status@previousOperations@autoInit@focusResult@map", _) -> ()
| ("status@previousOperations@autoInit@id", _) -> ()
| ("status@previousOperations@autoInit@position@latitude", _) -> ()
| ("status@previousOperations@autoInit@position@longitude", _) -> ()
| ("status@previousOperations@autoInit@startTime", _) -> ()
| ("status@previousOperations@autoInit@steps@steps@astrometry@de", _) -> ()
| ("status@previousOperations@autoInit@steps@steps@astrometry@ra", _) -> ()
| ("status@previousOperations@autoInit@steps@steps@astrometry@rot", _) -> ()
| ("status@previousOperations@autoInit@steps@steps@autoFocus@focusValue", _) -> ()
| ("status@previousOperations@autoInit@steps@steps@autoFocus@map", _) -> ()
| ("status@previousOperations@autoInit@steps@steps@progress", _) -> ()
| ("status@previousOperations@autoInit@steps@steps@type", _) -> ()
| ("status@previousOperations@autoInit@steps@type", _) -> ()
| ("status@previousOperations@autoInit@stopped", _) -> ()
| ("status@previousOperations@autoInit@time", _) -> ()
| ("status@previousOperations@autoInit@type", _) -> ()
| ("status@previousOperations@observation@actionInProgress", _) -> ()
| ("status@previousOperations@observation@capture@acquisitionCount", _) -> ()
| ("status@previousOperations@observation@capture@cameraParams@exposureMicroSec", _) -> ()
| ("status@previousOperations@observation@capture@cameraParams@gain", _) -> ()
| ("status@previousOperations@observation@capture@cameraParams@height", _) -> ()
| ("status@previousOperations@observation@capture@cameraParams@width", _) -> ()
| ("status@previousOperations@observation@capture@captureType", _) -> ()
| ("status@previousOperations@observation@capture@ctx", _) -> ()
| ("status@previousOperations@observation@capture@endHumidity", _) -> ()
| ("status@previousOperations@observation@capture@endTemperature", _) -> ()
| ("status@previousOperations@observation@capture@endTime", _) -> ()
| ("status@previousOperations@observation@capture@error@data@byOp", _) -> ()
| ("status@previousOperations@observation@capture@error@name", _) -> ()
| ("status@previousOperations@observation@capture@hasStacking", _) -> ()
| ("status@previousOperations@observation@capture@id", _) -> ()
| ("status@previousOperations@observation@capture@images@cropHeight", _) -> ()
| ("status@previousOperations@observation@capture@images@cropWidth", _) -> ()
| ("status@previousOperations@observation@capture@images@cropX", _) -> ()
| ("status@previousOperations@observation@capture@images@cropY", _) -> ()
| ("status@previousOperations@observation@capture@images@exifSize", _) -> ()
| ("status@previousOperations@observation@capture@images@index", _) -> ()
| ("status@previousOperations@observation@capture@images@stackingCount", _) -> ()
| ("status@previousOperations@observation@capture@images@stackingErrorCount", _) -> ()
| ("status@previousOperations@observation@capture@images@time", _) -> ()
| ("status@previousOperations@observation@capture@images@url", _) -> ()
| ("status@previousOperations@observation@capture@outputImageCount", _) -> ()
| ("status@previousOperations@observation@capture@outputImageErrorCount", _) -> ()
| ("status@previousOperations@observation@capture@position@latitude", _) -> ()
| ("status@previousOperations@observation@capture@position@longitude", _) -> ()
| ("status@previousOperations@observation@capture@stackingCount", _) -> ()
| ("status@previousOperations@observation@capture@stackingErrorCount", _) -> ()
| ("status@previousOperations@observation@capture@stackingErrorMap@StackingRoundnessError", _) -> ()
| ("status@previousOperations@observation@capture@startHumidity", _) -> ()
| ("status@previousOperations@observation@capture@startTemperature", _) -> ()
| ("status@previousOperations@observation@capture@startTime", _) -> ()
| ("status@previousOperations@observation@capture@stopped", _) -> ()
| ("status@previousOperations@observation@capture@target@de", _) -> ()
| ("status@previousOperations@observation@capture@target@objectId", _) -> ()
| ("status@previousOperations@observation@capture@target@objectName", _) -> ()
| ("status@previousOperations@observation@capture@target@ra", _) -> ()
| ("status@previousOperations@observation@capture@target@rot", _) -> ()
| ("status@previousOperations@observation@ctx", _) -> ()
| ("status@previousOperations@observation@endTime", _) -> ()
| ("status@previousOperations@observation@error", _) -> ()
| ("status@previousOperations@observation@error@name", _) -> ()
| ("status@previousOperations@observation@framing@de", _) -> ()
| ("status@previousOperations@observation@framing@ra", _) -> ()
| ("status@previousOperations@observation@framing@rot", _) -> ()
| ("status@previousOperations@observation@id", _) -> ()
| ("status@previousOperations@observation@previousCaptures@acquisitionCount", _) -> ()
| ("status@previousOperations@observation@previousCaptures@cameraParams@exposureMicroSec", _) -> ()
| ("status@previousOperations@observation@previousCaptures@cameraParams@gain", _) -> ()
| ("status@previousOperations@observation@previousCaptures@cameraParams@height", _) -> ()
| ("status@previousOperations@observation@previousCaptures@cameraParams@width", _) -> ()
| ("status@previousOperations@observation@previousCaptures@captureType", _) -> ()
| ("status@previousOperations@observation@previousCaptures@ctx", _) -> ()
| ("status@previousOperations@observation@previousCaptures@endHumidity", _) -> ()
| ("status@previousOperations@observation@previousCaptures@endTemperature", _) -> ()
| ("status@previousOperations@observation@previousCaptures@endTime", _) -> ()
| ("status@previousOperations@observation@previousCaptures@error@name", _) -> ()
| ("status@previousOperations@observation@previousCaptures@hasStacking", _) -> ()
| ("status@previousOperations@observation@previousCaptures@id", _) -> ()
| ("status@previousOperations@observation@previousCaptures@outputImageCount", _) -> ()
| ("status@previousOperations@observation@previousCaptures@outputImageErrorCount", _) -> ()
| ("status@previousOperations@observation@previousCaptures@position@latitude", _) -> ()
| ("status@previousOperations@observation@previousCaptures@position@longitude", _) -> ()
| ("status@previousOperations@observation@previousCaptures@stackingCount", _) -> ()
| ("status@previousOperations@observation@previousCaptures@stackingErrorCount", _) -> ()
| ("status@previousOperations@observation@previousCaptures@stackingErrorMap@StackingRoundnessError", _) -> ()
| ("status@previousOperations@observation@previousCaptures@startHumidity", _) -> ()
| ("status@previousOperations@observation@previousCaptures@startTemperature", _) -> ()
| ("status@previousOperations@observation@previousCaptures@startTime", _) -> ()
| ("status@previousOperations@observation@previousCaptures@stopped", _) -> ()
| ("status@previousOperations@observation@previousCaptures@target@de", _) -> ()
| ("status@previousOperations@observation@previousCaptures@target@objectId", _) -> ()
| ("status@previousOperations@observation@previousCaptures@target@objectName", _) -> ()
| ("status@previousOperations@observation@previousCaptures@target@ra", _) -> ()
| ("status@previousOperations@observation@previousCaptures@target@rot", _) -> ()
| ("status@previousOperations@observation@startTime", _) -> ()
| ("status@previousOperations@observation@steps@autoFocus@focusValue", _) -> ()
| ("status@previousOperations@observation@steps@autoFocus@map", _) -> ()
| ("status@previousOperations@observation@steps@name", _) -> ()
| ("status@previousOperations@observation@steps@progress", _) -> ()
| ("status@previousOperations@observation@steps@steps@astrometryDelta", _) -> ()
| ("status@previousOperations@observation@steps@steps@type", _) -> ()
| ("status@previousOperations@observation@steps@type", _) -> ()
| ("status@previousOperations@observation@stopped", _) -> ()
| ("status@previousOperations@observation@target@de", _) -> ()
| ("status@previousOperations@observation@target@objectId", _) -> ()
| ("status@previousOperations@observation@target@objectName", _) -> ()
| ("status@previousOperations@observation@target@ra", _) -> ()
| ("status@previousOperations@observation@target@rot", _) -> ()
| ("status@previousOperations@observation@type", _) -> ()
| ("status@previousOperations@open@ctx", _) -> ()
| ("status@previousOperations@open@endTime", _) -> ()
| ("status@previousOperations@open@error", _) -> ()
| ("status@previousOperations@open@id", _) -> ()
| ("status@previousOperations@open@startTime", _) -> ()
| ("status@previousOperations@open@stopped", _) -> ()
| ("status@previousOperations@open@type", _) -> ()
| ("status@previousOperations@park", _) -> ()
| ("status@previousOperations@runPlan", _) -> ()
| ("status@previousOperations@storageAcquisition", _) -> ()
| ("status@previousOperations@sunMode", _) -> ()
| ("status@sensors@defogStatus", _) -> ()
| ("status@sensors@dewpointDepression", _) -> ()
| ("status@sensors@humidity", _) -> ()
| ("status@sensors@humidityDelta", _) -> ()
| ("status@sensors@temperature", _) -> ()
| ("status@sensors@temperatureDelta", _) -> ()
| ("status@settings@telescopeName", _) -> ()
| ("status@settings@usbFileTypes", _) -> ()
| ("status@shuttingDown", _) -> ()
| ("status@storage@data@available", _) -> ()
| ("status@storage@data@size", _) -> ()
| ("status@storage@system@available", _) -> ()
| ("status@storage@system@size", _) -> ()
| ("status@storage@usb", _) -> ()
| ("status@telescopeId", _) -> ()
| ("status@timestamp", _) -> ()
| ("status@update@installedVersion", _) -> ()
| ("status@update@minimumCompatibleVersion", _) -> ()
| ("status@update@state", _) -> ()
| ("status@version", _) -> ()
| ("storage@data@available", _) -> ()
| ("storage@data@size", _) -> ()
| ("storage@system@available", _) -> ()
| ("storage@system@size", _) -> ()
| ("storage@usb", _) -> ()
| ("telescopeId", _) -> ()
| ("timestamp", _) -> ()
| ("update@installedVersion", _) -> ()
| ("update@minimumCompatibleVersion", _) -> ()
| ("update@state", _) -> ()
| ("version", _) -> ()

| oth ->
   Printf.fprintf logfile "| (\"%s\", _) -> ()\n" (fst oth);
   flush logfile

and errchklst ix = function
| `Assoc errlst -> List.iter (errchklst' ix) errlst
| oth -> failwith "errchklst"

let rec errchk' ix (arg:Yojson.Basic.t) = match arg with
| `String "" -> ()
| `String "ok" -> ()
| `Assoc
    [("sid", `String _);
     ("upgrades", `List _);
     ("pingInterval", `Int _);
     ("pingTimeout", `Int _)] -> ()
| `List errlst -> List.iter (errchk' ix) errlst
| `String s -> print_endline s
| `Bool b -> ()
| `Null -> ()
| `Float f -> ()
| `Int _ -> ()
| `Assoc errlst -> List.iter (errchklst' ix) errlst
(*
| oth -> failwith "errchk'"
*)

let errchk ix = match !ix with
  | 0 -> ()
  | n -> errchk' ix (rslt.(n-1))

let quit' = ref false

let sm_jump lbl' = Array.iteri (fun ix (lbl, _) -> if lbl=lbl' then (start := ix; if !verbose then print_endline (string_of_int (ix+1)^": "^lbl'))) taskarray

let rec iter_a ix a =
  errchk ix;
  match a.(!ix) with
  | ("post8'", x) -> ix := Array.length a - 1; iter_a ix a
  | ("", x) ->
    if !quit' then
        Lwt.return_unit
    else
        begin
        Hashtbl.iter (fun k x -> if !x then () else sm_jump "fetch") jpegh;
        Lwt_engine.iter true;
        Lwt.apply (fun f -> f !ix) x >>= fun () -> iter_a ix a
        end
  | (lbl, x) -> incr ix;
    let f = fun f -> let cnt = string_of_int !ix in print_endline (cnt^":"^lbl); f !ix in
    Lwt.apply f x >>= fun () ->
    iter_a ix a

let font = Printexc.print Pango.Font.from_string "Sans 12"
(*
let color = ref (`RGB (0, 65535, 0)) 
*)

let app_quit' () = quit' := true

let button_pressed drawingarea ev = true

let catsel = ref 0

let cnv_ra fmt = Scanf.sscanf fmt "%f %f %f" (fun a b c -> a *. 15.0 +. b /. 4.0 +. c /. 240.0)
let cnv_dec fmt = try Scanf.sscanf fmt "%f %f %f" (fun a b c -> a +. b /. 60.0 +. c /. 3600.0) with err -> Scanf.sscanf fmt "%f %f" (fun a b -> a +. b /. 60.0)

let cnv_latlong latlong = 
  match latlong.[String.length latlong - 1] with
    | 'N' -> float_of_string (String.sub latlong 0 (String.length latlong - 1))
    | 'E' -> float_of_string (String.sub latlong 0 (String.length latlong - 1))
    | 'W' -> -. float_of_string (String.sub latlong 0 (String.length latlong - 1))
    | 'S' -> -. float_of_string (String.sub latlong 0 (String.length latlong - 1))

let app_status' () = sm_jump "status''"

let gui () = 
  (* Initializes GTK. *)
  ignore (GMain.init ());

  (* Install Lwt<->Glib integration. *)
  Lwt_glib.install ();

  let window = GWindow.window ~width:640 ~height:480
      ~title:"Openstellina GUI demo" () in
  let vbox = GPack.vbox ~packing:window#add () in

  (* Menu bar *)
  let menubar = GMenu.menu_bar ~packing:vbox#pack () in
  let factory = new GMenu.factory menubar in
  let accel_group = factory#accel_group in
  let file_menu = factory#add_submenu "File" in
  let stell_menu = factory#add_submenu "Stellina" in

  (* File menu *)
  let factory_fil = new GMenu.factory file_menu ~accel_group in
  ignore @@ factory_fil#add_item "Quit" ~callback: app_quit';

  (* Stellina menu *)
  let factory_stell = new GMenu.factory stell_menu ~accel_group in
  ignore @@ factory_stell#add_item "Status" ~callback: app_status';

  (* Quit when the window is closed. *)
  ignore (window#connect#destroy app_quit');

  let box2 = GPack.vbox ~spacing:2 ~border_width: 10 ~packing: vbox#add () in
  let boxu = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: box2#add () in
  let boxh = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: box2#add () in

  (* Button1 *)
  let button1 = GButton.button ~label:"Open Arm"
                              ~packing:boxu#add () in
  ignore (button1#connect#clicked ~callback: (fun () -> prerr_endline "Open"));

  (* Button2 *)
  let button2 = GButton.button ~label:"Auto Initialise"
                              ~packing:boxu#add () in
  ignore (button2#connect#clicked ~callback: (fun () -> sm_jump "init"));

  (* Button3 *)
  let button3 = GButton.button ~label:"Park"
                              ~packing:boxu#add () in
  ignore (button3#connect#clicked ~callback: (fun () -> sm_jump "park"));

  (* Button4 *)
  let button4 = GButton.button ~label:"Stop Observation"
                              ~packing:boxu#add () in
  ignore (button4#connect#clicked ~callback: (fun () -> sm_jump "stopobs"));

  (* Button5 *)
  let button5 = GButton.button ~label:"Observe"
                              ~packing:boxh#add () in
  ignore (button5#connect#clicked ~callback: (fun () -> sm_jump "observe"));

  let boxe = GPack.vbox ~spacing:2 ~border_width: 10 ~packing: boxh#add () in
  let frame_ra = GBin.frame ~label: "Right ascension"
            ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) () in

  let entry_ra = GEdit.entry ~max_length: 20 ~packing: frame_ra#add () in
  entry_ra#connect#activate ~callback:(fun () -> ra_flt := cnv_ra entry_ra#text);
  entry_ra#select_region ~start:0 ~stop:entry_ra#text_length;

  let frame_dec = GBin.frame ~label: "Declination"
            ~packing:(boxh#pack ~expand:true ~fill:true ~padding:2) () in
  let entry_dec = GEdit.entry ~max_length: 20 ~packing: frame_dec#add () in
  entry_dec#connect#activate ~callback:(fun () -> dec_flt := cnv_dec entry_dec#text);
  entry_dec#select_region ~start:0 ~stop:entry_dec#text_length;

(*
  let check = GButton.check_button ~label: "Editable" ~active: true
      ~packing: boxh#add () in
  check#connect#toggled
    ~callback:(fun () -> entry_ra#set_editable check#active; entry_dec#set_editable check#active);

  let check =
    GButton.check_button ~label:"Visible" ~active:true ~packing:boxh#add () in
  check#connect#toggled
    ~callback:(fun () -> entry#set_visibility check#active);
*)

  (* Button6 *)
  let button6 = GButton.button ~label:"Refocus"
                              ~packing:boxh#add () in
  ignore (button6#connect#clicked ~callback: (fun () -> sm_jump "focus"));

  (* Range1 *)
  let fram_rng = GBin.frame ~label: "Exposure"
            ~packing:(box2#pack ~expand:true ~fill:true ~padding:2) () in
  let adj = GData.adjustment ~lower:0.1 ~upper:70.0 ~step_incr:1. ~page_incr:10. () in
  let rng = GRange.scale `HORIZONTAL ~adjustment:adj ~draw_value:true ~packing:fram_rng#add () in
  rng#connect#change_value ~callback:(fun _ v -> expos_flt := v);
(*
  let button = GButton.button ~label: "Close" ~packing: vbox#add () in
  button#connect#clicked ~callback:window#destroy;
  button#grab_default ();
*)

  ignore (rng#set_digits 2); (*decimal digits*)

  let framx = GBin.frame ~label: "Dark frames"
            ~packing:(box2#pack ~expand:true ~fill:true ~padding:2) () in

  let box3 = GPack.hbox ~spacing:2 ~border_width: 10 ~packing: framx#add () in

  let button1 = GButton.radio_button ~label:"flip" ~packing: box3#add () in
  button1#connect#clicked ~callback:(fun () -> prerr_endline "Flip");

  let button2 = GButton.radio_button ~group:button1#group ~label:"no_flip"
      ~packing: box3#add () in
  button2#connect#clicked ~callback:(fun () -> prerr_endline "No flip");

  let button3 = GButton.radio_button
      ~group:button1#group ~label:"both" ~active:true ~packing: box3#add () in
  button3#connect#clicked ~callback:(fun () -> prerr_endline "Both");

  let frame_darkcnt = GBin.frame ~label: "Dark Frame Count"
            ~packing:(box3#pack ~expand:true ~fill:true ~padding:2) () in
  let entry_darkcnt = GEdit.entry ~max_length: 20 ~packing: frame_darkcnt#add () in
  entry_darkcnt#set_text "100";
  entry_darkcnt#connect#activate ~callback:(fun () -> print_endline entry_dec#text);
  entry_darkcnt#select_region ~start:0 ~stop:entry_dec#text_length;
  
  let separator =
    GMisc.separator `HORIZONTAL ~packing: vbox#pack () in


  (* Button2 *)
  let button2 = GButton.button ~label:"Generate darks"
                              ~packing:box3#add () in
  ignore (button2#connect#clicked ~callback: (fun () -> prerr_endline "generate_darks"));

  let tmp = GBin.frame ~label:"Target Source" ~packing:vbox#pack () in
  let box = GPack.vbox ~border_width:5 ~packing:tmp#add () in

  let options =
    [ "Messier Catalogue (built in)" ;
      "Manual RA/DEC entry" ;
      "Stellarium link"
    ] in
  let combobox,(_,column) = GEdit.combo_box_text ~strings:options ~packing:box#pack () in
  combobox#connect#changed
    (fun () ->
      match combobox#active_iter with
      | None -> ()
      | Some row -> 
          let data = combobox#model#get ~row ~column in
          List.iteri (fun ix itm -> if itm = data then catsel := ix) options;
          match !catsel with 
           | 0 -> entry_ra#set_editable false; entry_dec#set_editable false
           | 1 -> entry_ra#set_editable true; entry_dec#set_editable true
           | 2 -> entry_ra#set_editable false; entry_dec#set_editable false);
  catsel := 0;
  combobox#set_active !catsel ;

  let tmp = GBin.frame ~label:"Target (alias), RA, DEC" ~packing:vbox#pack () in
  let box = GPack.vbox ~border_width:5 ~packing:tmp#add () in
  let cat = List.mapi (fun ix (cat,rahms,decdms) -> let cat' = string_of_int (ix+1) in "M"^cat'^(if cat' <> String.trim(String.sub cat 1 (String.length cat -1)) then " ("^cat^")" else "") ) (Array.to_list Messier_catalogue.messier_array) in
  let (combo, (_, column)) = 
    GEdit.combo_box_text ~packing:box#pack 
      ~strings:cat () in
  combo#connect#changed
    (fun () ->
      match combo#active_iter with
      | None -> ()
      | Some row -> 
          let data = combo#model#get ~row ~column in
          List.iteri (fun ix itm -> if itm = data && !catsel = 0 then
          let (cat,rahms,decdms) = Messier_catalogue.messier_array.(ix) in
          entry_ra#set_text rahms;
          entry_dec#set_text decdms) cat);
  combo#set_active 0 ;

  let tzcity = List.hd (List.tl timezone)  ^ "/" ^ List.hd timezone in
  let obs = "Observatory location / timezone ("^tzcity^")" in
  let obox = GPack.hbox ~border_width:5 ~packing:vbox#add () in
  let tmp = GBin.frame ~label: obs ~packing:obox#pack () in
  let box = GPack.vbox ~border_width:5 ~packing:tmp#add () in

  let llbox = GPack.vbox ~spacing:2 ~border_width: 10 ~packing: boxh#add () in
  let frame_lat = GBin.frame ~label: "Latitude"
            ~packing:(obox#pack ~expand:false ~fill:false ~padding:0) () in

  let entry_lat = GEdit.entry ~max_length: 20 ~packing: frame_lat#add () in
  entry_lat#connect#activate ~callback:(fun () -> lat_flt := float_of_string entry_lat#text);
  entry_lat#select_region ~start:0 ~stop:entry_lat#text_length;

  let frame_long = GBin.frame ~label: "Longitude"
            ~packing:(obox#pack ~expand:false ~fill:false ~padding:0) () in
  let entry_long = GEdit.entry ~max_length: 20 ~packing: frame_long#add () in
  entry_long#connect#activate ~callback:(fun () -> dec_flt := float_of_string entry_long#text);
  entry_long#select_region ~start:0 ~stop:entry_long#text_length;

  let cities' = List.sort compare (List.filter (fun (a,b,c,d,e,f,g,h,i,j,k,l) -> j=tzcity && (match d with | "L" | "I" | "A" | "O" -> false | _ -> true)) Base_locations.base_locations) in
  let latitude,longitude = try float_of_string (Sys.getenv "LATITUDE"), 
    float_of_string (Sys.getenv "LONGITUDE") with err ->  51.477777, 0.001388 in
  let prev = ref 1000.0 in
  let deflt = ref 0 in
  let cities = List.mapi (fun ix (a,b,c,d,e,f,g,h,i,j,k,l) ->
     let f' = cnv_latlong f in
     let g' = cnv_latlong g in
     let nearest = sqrt((latitude -. f') *. (latitude -. f') +. ((longitude -. g') *. (longitude -. g'))) in
     if nearest < !prev then ( prev := nearest; deflt := ix; lat_flt := f'; long_flt := g'; );
     a^", "^b) cities' in
  let model, text_column = GTree.store_of_list Gobject.Data.string cities in
  let combo = GEdit.combo_box_entry ~text_column ~model ~packing:box#pack () in
  let loc_jump lbl' = List.iteri (fun ix loc -> if loc=lbl' then
    begin
    deflt := ix;
    let (a,b,c,d,e,f,g,h,i,j,k,l) = List.nth cities' ix in
    let f' = cnv_latlong f in
    let g' = cnv_latlong g in
    let lat' = string_of_float f' in
    let long' = string_of_float g' in
    entry_lat#set_text lat';
    entry_long#set_text long';
    if !verbose then print_endline (string_of_int ix^": "^lat'^", "^long')
    end) cities in
  combo#entry#connect#changed 
    (fun () -> loc_jump combo#entry#text) ;
  combo#set_active !deflt;

  let frame_stat = GBin.frame ~label: "Status"
            ~packing:(vbox#pack ~expand:false ~fill:false ~padding:0) () in

  let entry_stat = GEdit.entry ~max_length: 20 ~packing: frame_stat#add () in
  entry_stat#connect#activate ~callback:(fun () -> print_endline entry_stat#text);
  entry_stat#select_region ~start:0 ~stop:entry_stat#text_length;
  entry_stat#set_text "waiting";
  entry_stat#set_editable false;
  status := Some entry_stat;

  (* Show the window. *)
  window#show ()

let tasks = gui(); iter_a start taskarray

let run () = Lwt_main.run tasks

let _ = run()
