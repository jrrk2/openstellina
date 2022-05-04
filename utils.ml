open Lwt

let split = List.map (fun itm -> let ix = String.index itm ':' in (String.sub itm 0 ix, String.sub itm (ix+2) (String.length itm - ix - 2)))

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

let cnv_ra fmt =
    try Scanf.sscanf fmt "%f %f %f" (fun a b c -> a *. 15.0 +. b /. 4.0 +. c /. 240.0) with _ -> 0.0

let cnv_dec fmt =
    try Scanf.sscanf fmt "%f %f %f" (fun a b c -> a +. b /. 60.0 +. c /. 3600.0)
    with _ -> try Scanf.sscanf fmt "%f %f" (fun a b -> a +. b /. 60.0) with _ -> 0.0

let get' proto server params headers pth f hdrs =
  let pth' = proto^server^pth in
  print_endline pth';
  Quests.get pth'
    ~params:(params)
    ~headers:(headers)
  >|= ( fun arg -> hdrs := Cohttp.Header.to_list (Quests.Response.headers arg); Quests.Response.content arg) >|= f

let get' proto server params headers pth f hdrs = try get' proto server params headers pth f hdrs with _ -> Lwt.return_unit

let post' proto server params headers pth form f =
  Quests.post (proto^server^""^pth)
    ~params:(params)
    ~headers:(headers)
    ~data:(form)
  >|= Quests.Response.content >|= f

let post' proto server params headers pth form f = try post' proto server params headers pth form f with _ -> Lwt.return_unit

