(* Emulation of cookie functionality using HTML5 local storage *)

open Js_of_ocaml

let set_local key lang =
  Js.Optdef.iter Dom_html.window##.sessionStorage (fun st ->
      st##setItem (Js.string key) lang)

let set_language = set_local "hyp_lang"

let default_language () =
  (Js.Optdef.get
     Dom_html.window##.navigator##.language
     (fun () ->
       Js.Optdef.get Dom_html.window##.navigator##.userLanguage (fun () -> Js.string "en")))
  ##substring
    0
    2

let get_local key =
    (Js.Optdef.case Dom_html.window##.sessionStorage default_language (fun st ->
         Js.Opt.get (st##getItem (Js.string key)) default_language))

let language = ref (get_local "hyp_lang")

let set name value = set_local (name) (Js.string value)

let get name = Js.to_string (get_local name)

(* remove cookie *)
let remove name = Js.Optdef.iter Dom_html.window##.sessionStorage (fun st ->
      st##removeItem (Js.string name))
