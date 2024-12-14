open Js_of_ocaml

external _myFunction : int -> float = "_myFunction"
external _myFloat : float -> float -> float -> float -> float -> float -> float -> unit = "_myFloat"
external _myAscii : int -> float -> unit = "_myAscii"

(* Existing dialog creation functions remain the same *)

let set_static_text element txt =
  element##.textContent := Js.some (Js.string txt);
  Js.Unsafe.set (element##.style) (Js.string "display") (Js.string "block")

(* Format dates to YYYY-MM-DD *)
let format_date (date:float) =
    let tm = Unix.gmtime date in
    let year = tm.tm_year + 1900 in
    let month = tm.tm_mon + 1 in
    let day = tm.tm_mday in
    Printf.sprintf "%04d-%02d-%02d" year month day  (* Format as YYYY-MM-DD *)

(* Format time to HH:MM *)
let format_time (date:float) =
    let tm = Unix.gmtime date in
    let hour = tm.tm_hour in
    let minute = tm.tm_min in
    Printf.sprintf "%02d:%02d" hour minute  (* Format as HH:MM *)

let string_to_float (s : string) : float =
  let len = String.length s in
  let rec aux acc i =
    if i < len then
      aux (acc *. 128.0 +. float_of_int (127 land (Char.code s.[i]))) (i + 1)
    else
      acc
  in
aux 0.0 0

let rec float_to_string f =
  let flr = floor (f /. 128.0) in let f' = f -. flr *. 128.0 in
  (if flr > 0.0 then float_to_string flr else "") ^ String.make 1 (Char.chr (int_of_float f'))

let ephem name sequence discoverer jd =
  let send idx str = _myAscii idx (string_to_float str) in
  send 1 name;
  send 2 sequence;
  send 3 discoverer;
  let open Astro_utils in
  let correct = 0.0 in (* topocentric correction *)
  let format = 1.0 in (* output format, only affects debugging log *)
  let _ = _myFloat jd (jd +. 0.001) 1.0 (latitude()) (longitude()) correct format in
  let ra = (_myFunction 3) *. 180. /. Float.pi in
  let dec = (_myFunction 4) *. 180. /. Float.pi in
  let mag = (_myFunction 5) in
  ra, dec, mag

let update_display_value id value =
  (match Dom_html.getElementById_opt id with
  | Some element -> element##.innerHTML := Js.string value
  | None -> ())
