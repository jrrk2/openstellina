open Lwt

let get () =
  Quests.get "http://httpbin.org/get"
    ~params:[ ("key1", "value1"); ("key2", "value2") ]
  >|= Quests.Response.show >|= print_endline

let post_form () =
  Quests.post "http://httpbin.org/post" ~data:(Form [ ("key", "value") ])
  >|= Quests.Response.show >|= print_endline

let post_json () =
  Quests.post "http://httpbin.org/post" ~data:(Json [%yojson { key = "value" }])
  >|= Quests.Response.show >|= print_endline

let gzip_response () =
  Quests.get "http://httpbin.org/gzip"
  >|= Quests.Response.show >|= print_endline

let following_redirects () =
  Quests.get "http://httpbin.org/redirect/1"
  >|= Quests.Response.show >|= print_endline

let basic_authentication () =
    Quests.get "https://postman-echo.com/basic-auth" ~auth:(Basic ("username", "password"))
  >|= Quests.Response.show >|= print_endline

let bearer_authentication () =
    Quests.get "https://example.com/some-api" ~auth:(Bearer "a token")
  >|= Quests.Response.show >|= print_endline

(*
let sessions () =
  let open Quests in
  let s = Session.create () in
  let%lwt () =
    Session.get s "https://example.com" >|= Response.show >|= print_endline
  in
  Session.close s
*)

type session = {sid:string; ping_int: int; ping_tim: int }

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

let cnv body = try Yojson.Basic.from_string (cnv' body) with err -> `String body

let session = function
`Assoc
    [("sid", `String sid);
     ("upgrades", `List [`String "websocket"]); ("pingInterval", `Int ping_int);
     ("pingTimeout", `Int ping_tim)] -> { sid; ping_int; ping_tim }
    | oth -> failwith "session"

let show = Quests.Response.show
let time_ms = string_of_int (int_of_float (Unix.time() *. 1000.0))
let id = "iOS_Apple_iPad8_6_472AC2D5-B6DE-53DD-A563-BF202DF3203F"
let name = "Jonathan's iMac"
let polling = "polling"
let eio = "3"
let t' = "NzboPSr"
let params' = [ ("id", id); ("name", name); ("EIO", eio); ("transport", polling); ("t", t') ]
let headers = [ ("Content-Type", "text/plain; charset=utf-8") ]
let split = List.map (fun itm -> let ix = String.index itm ':' in (String.sub itm 0 ix, String.sub itm (ix+2) (String.length itm - ix - 4)))
let pth = "8083/socket.io/"
let cookie = ref []
let hdrs = ref []

let get' ix params headers pth =
  Quests.get ("http://192.168.0.36:"^pth)
    ~params:(params)
    ~headers:(headers)
  >|= ( fun arg -> hdrs := Cohttp.Header.to_list (Quests.Response.headers arg); Quests.Response.content arg) >|= (fun s -> rslt.(ix) <- cnv s)

let post' ix params headers pth form =
  Quests.post ("http://192.168.0.36:"^pth)
    ~params:(params)
    ~headers:(headers)
    ~data:(form)
  >|= Quests.Response.content >|= (fun s -> rslt.(ix) <- cnv s)

let get1' ix =
    get' ix params' headers pth

let post2' ix =
    session' := session rslt.(1);
    cookie := List.filter (function ("Content-Length", _) -> false | _ -> true) !hdrs;
    let params = (("sid", (!session').sid) :: params') in
    post' ix params headers pth (Quests.Request.Raw ("44:420[\"message\",\"setSystemTime\","^time_ms^"]"))

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
    get' ix params headers pth

let get4' ix =
    let params = (("sid", (!session').sid) :: params') in
    let headers = split ["Accept-Encoding: gzip, deflate\r\n";
      "Referer: http://localhost:8080/\r\n";
      "Accept-Language: en-GB,en;q=0.9\r\n";
      "User-Agent: Mozilla/5.0 (iPad; CPU OS 15_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148\r\n";
      "Accept: application/json";
      "Connection: keep-alive\r\n"] in
    get' ix params headers pth

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
    get' ix params headers pth

let post7' ix =
    let params = [] in
    let headers = split 
   ["Content-Type: application/json";
    "Origin: http://localhost:8080";
    "Accept-Encoding: gzip, deflate";
    "Connection: keep-alive";
    "Accept: application/json, text/plain, */*";
    "Accept-Language: en-GB,en;q=0.9"] in
    let pth = "8082/v1//logs/consume" in
    post' ix params headers pth (Quests.Request.Raw ("{}"))

let post8' ix =
    let params = [] in
    let headers = split 
   ["Content-Type: application/json";
    "Origin: http://localhost:8080";
    "Accept-Encoding: gzip, deflate";
    "Connection: keep-alive";
    "Accept: application/json, text/plain, */*";
    "Accept-Language: en-GB,en;q=0.9"] in
    let pth = "8082/v1//expertMode/startStorageAcquisition" in
    post' ix params headers pth (Quests.Request.Json ( `Assoc
  [("path", `String "expert-mode/raw-images"); ("overwrite", `Bool true);
   ("numExposures", `Int 100); ("gain", `Int 200);
   ("exposureMicroSec", `Int 60000000); ("flip", `String "BOTH")] ))

let post9' ix =
    let params = [] in
    let headers = split 
   ["Content-Type: application/json";
    "Origin: http://localhost:8080";
    "Accept-Encoding: gzip, deflate";
    "Connection: keep-alive";
    "Accept: application/json, text/plain, */*";
    "Accept-Language: en-GB,en;q=0.9"] in
    let pth = "8082/v1//general/openForMaintenance" in
    post' ix params headers pth (Quests.Request.Raw "{}")

let stop' ix =
    let pth = "8082/v1//app/status" in
    get' ix params' headers pth

let taskarray =
       [|
         ("get1", get1');
         ("post2", post2');
         ("get3", get3');
         ("get4", get4');
         ("post5", post5');
         ("get6", get6');
         ("post7", post7');
         ("post9", post9');
         ("", stop');
       |]

let stoptask = Array.length taskarray - 1

let otherr = Array.init 100 (fun ix -> `Null)
let otherr' = ref ["", `Null]
let err ix errmsg =
    if !ix <> stoptask then print_endline ("terminating at step "^string_of_int !ix^" due to error "^errmsg);
    ix := stoptask

let rec errchklst' ix = function
| ("apiVersion", `String "1.0.2") -> ()
| ("atStop", `Bool false) -> ()
| ("autoInit", `Null) -> ()
| ("available", `Int available) -> ()
| ("availableReports", `Int reports) -> ()
| ("boardInDebugMode", `Bool false) -> ()
| ("bootCount", `Int bootcnt) -> ()
| ("bufferPosition", `Int bufpos) -> ()
| ("bufferSize", `Int bufsiz) -> ()
| ("calibrated", `Bool false) -> ()
| ("chain", `List errlst) -> List.iter (errchklst ix) errlst
| ("commandErrors", `List errlst) -> List.iter (errchklst ix) errlst
| ("connectedDevices", `List errlst) -> List.iter (errchklst ix) errlst
| ("ctx", `String ctx) -> ()
| ("currentOperation", `Null) -> ()
| ("data", `String "Error: Error: No such file or directory, cannot open /dev/ttyS0") -> ()
| ("data", `String "SEEK_STOP") -> ()
| ("defogStatus", `Null) -> ()
| ("dewpointDepression", `Null) -> ()
| ("elapsedTime", `Int elapsedTime) -> ()
| ("endTime", `Int endTime) -> ()
| ("id", `String _) -> ()
| ("initError", `Null) -> ()
| ("initialized", `Bool false) -> ()
| ("installedVersion", `String installed) -> ()
| ("masterDeviceId", `Null) -> ()
| ("minimumCompatibleVersion", `String minver) -> ()
| ("name", `String ("MOTORS.COMMAND_ERROR" as errmsg)) -> err ix errmsg
| ("name", `String ("MOTORS.OPERATION_FAILED" as errmsg)) -> err ix errmsg
| ("name", `String ("RUNTIME_ERROR" as errmsg)) -> err ix errmsg
| ("name", `String ("BOARD.PORT_CLOSED" as errmsg)) -> err ix errmsg
| ("name", `String _) -> ()
| ("numFiles", `Int numFiles) -> ()
| ("observation", `Null) -> ()
| ("otherCurrentOperations", `List errlst) -> List.iter (errchklst ix) errlst
| ("park", `Null) -> ()
| ("plan", `Null) -> ()
| ("position", `Int 0) -> ()
| ("potentialBatteryCandidates", `List errlst) -> List.iter (errchklst ix) errlst
| ("register", `String "MOT_STEL_CMD") -> ()
| ("shuttingDown", `Bool false) -> ()
| ("size", `Int size) -> ()
| ("startTime", `Int startTime) -> ()
| ("state", `String "IDLE") -> ()
| ("stopped", `Bool true) -> ()
| ("storageAcquisition", `Null) -> ()
| ("sunMode", `Null) -> ()
| ("telescopeId", `String telescopeId) -> ()
| ("telescopeName", `Null) -> ()
| ("timestamp", `Int timestamp) -> ()
| ("type", `String "OPEN") -> ()
| ("usb", `Null) -> ()
| ("usbFileTypes", `Null) -> ()
| ("version", `String "1.27.0") -> ()
| (_, `Assoc lst) -> List.iter (errchklst' ix) lst
| oth -> if not (List.mem oth !otherr') then otherr' := oth :: !otherr'

and errchklst ix = function
| `Assoc errlst -> List.iter (errchklst' ix) errlst
| oth -> otherr.(!ix) <- oth

let errchk' ix = function
| `String "" -> ()
| `String "ok" -> ()
| `Assoc
    [("sid", `String _);
     ("upgrades", `List _);
     ("pingInterval", `Int _);
     ("pingTimeout", `Int _)] -> ()
| `List errlst -> List.iter (errchklst ix) errlst
| oth -> otherr.(!ix) <- oth

let errchk ix = match !ix with
  | 0 -> ()
  | n -> errchk' ix (rslt.(n-1))

let rec iter_a ix a =
  errchk ix;
  match a.(!ix) with
  | ("", _) ->
    Lwt.return_unit
  | (lbl, x) -> incr ix;
    let f = fun f -> let cnt = string_of_int !ix in print_endline (cnt^":"^lbl); f !ix in
    Lwt.apply f x >>= fun () ->
    iter_a ix a

let tasks = iter_a (ref 0) taskarray

let run () = Lwt_main.run tasks
