open Js_of_ocaml

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
