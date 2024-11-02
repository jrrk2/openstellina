open Js_of_ocaml

let verbose = false

let set_location_cookie position =
  let document = Dom_html.window##.document in
  let cookie = Js.string (Printf.sprintf "location=%f,%f" position##.coords##.latitude position##.coords##.longitude) in
  document##.cookie := cookie

(* need GMT string format for cookies *)
class type date_ex = object
  inherit Js.date
  method toGMTString : Js.js_string Js.t Js.meth
end
let date_ex : date_ex Js.t Js.constr = Js.Unsafe.global##_Date
let one_day = 24. *. 60. *. 60. *. 1000.

let set name value = 
  let cookie = name ^ "=" ^ value ^ "; Expires=Session; SameSite=Lax; path=/" in
  Js.Unsafe.set Dom_html.document (Js.string "cookie") (Js.string cookie)

let get name = 
  let name' = (Js.string name)##concat(Js.string "=") in
  let tmp = Js.to_string (Js.Unsafe.get Dom_html.document (Js.string "cookie")) in
  if verbose then print_endline ("\""^tmp^"\"");
  let lst = String.split_on_char ';' tmp in
  let tmp' = List.map (fun itm ->
    let trm = String.trim itm in
    if verbose then print_endline trm;
    String.split_on_char '=' trm) lst in
  let tmp'' = List.filter (fun itm ->
    match itm with
      | key::value::[] -> let matched = key=name in
        if verbose then print_endline (key^" "^name^" "^string_of_bool matched); matched
      | _ -> false) tmp' in
  match tmp'' with [key::value::tl] -> Some value | _ -> None

let get' name = match get name with Some x -> x | None -> if verbose then print_endline ("get' "^name); ""

(* remove cookie *)
let remove name = set name ""

let latitude () = try float_of_string (get' "latitude") with _ -> 0.0
let longitude () = try float_of_string (get' "longitude") with _ -> 0.0
let city () = try get' "city" with _ -> "unknown"
let area () = try get' "area" with _ -> "unknown"
