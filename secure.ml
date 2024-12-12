open Js_of_ocaml
open Lwt.Syntax
open Astro_utils
open Telescope
open Lwt.Infix
open Js_of_ocaml_lwt
open Js_of_ocaml_tyxml
open Tyxml_js.Html

(* Add to existing type definitions *)
type secure_state = {
  secure_url: string option;
  is_secure: bool;
  pending_redirect: bool;
}
    
let is_secure_session () = 
  Js.to_string Dom_html.window##.location##.protocol = "https:"

let secure_state = {
  secure_url = None;
  is_secure = is_secure_session();
  pending_redirect = false;
}
(* Cookie handling for GPS data *)
let set_gps_cookie lat lon = 
  let cookie_options = {|; SameSite=Lax; path=/; max-age=31536000|} in (* 1 year expiry *)
  Dom_html.document##.cookie := Js.string (Printf.sprintf "gps_lat=%f%s" lat cookie_options);
  Dom_html.document##.cookie := Js.string (Printf.sprintf "gps_lon=%f%s" lon cookie_options)

let get_gps_cookie () =
  let cookies = Js.to_string Dom_html.document##.cookie in
  let cookie_list = String.split_on_char ';' cookies |> List.map String.trim in
  let find_value prefix = 
    try 
      List.find (fun s -> String.starts_with ~prefix s) cookie_list
      |> fun s -> String.sub s (String.length prefix) (String.length s - String.length prefix)
      |> float_of_string
    with Not_found -> 0.0
  in
  (find_value "gps_lat=", find_value "gps_lon=")

(* Replace existing localStorage GPS functions with cookie versions *)
let update_gps_location lat lon =
  set_gps_cookie lat lon

let get_gps_location () =
  get_gps_cookie ()

(* Create secure connection tab content *)
let create_secure_connection_tab () =
  let open Tyxml_js.Html in
  div ~a:[a_class ["secure-connection-panel"]] [
    div ~a:[a_class ["section-title"]] [txt "Connection Security Status"];
    div ~a:[a_class ["connection-status"]] [
      div ~a:[
        a_id "secure-status";
        a_class ["status-pill"; if secure_state.is_secure then "connected" else "disconnected"]
      ] [txt (if secure_state.is_secure then "Secure (HTTPS)" else "Insecure (HTTP)")];
      
      (if secure_state.is_secure then
        div ~a:[a_class ["secure-info"]] [
          txt "You are using a secure connection. Control features are disabled in HTTPS mode.";
          br ();
          button ~a:[
            a_class ["control-button"; "http-redirect"];
            a_onclick (fun _ ->
              let current_url = Js.to_string Dom_html.window##.location##.href in
              let http_url = Js.string ("http://" ^ 
                String.sub current_url 8 (String.length current_url - 8)) in
              Dom_html.window##.location##.href := http_url;
              true
            )
          ] [txt "Switch to HTTP for Control"]
        ]
      else
        div ~a:[a_class ["secure-warning"]] [
          txt "You are currently using an insecure connection.";
          br ();
          button ~a:[
            a_class ["control-button"; "secure-redirect"];
            a_onclick (fun _ ->
              let current_url = Js.to_string Dom_html.window##.location##.href in
              let https_url = Js.string ("https://" ^ 
                String.sub current_url 7 (String.length current_url - 7)) in
              Dom_html.window##.location##.href := https_url;
              true
            )
          ] [txt "Switch to HTTPS"]
        ]
      )
    ]
  ]

(* Modify migration function to handle Js.opt for getItem results *)
let migrate_gps_data () =
  if secure_state.is_secure then
    try
      Js.Optdef.iter (Dom_html.window##.localStorage) (fun storage ->
        Js.Opt.iter (storage##getItem (Js.string "gps_lat")) (fun lat_str ->
          Js.Opt.iter (storage##getItem (Js.string "gps_lon")) (fun lon_str ->
            let lat = float_of_string (Js.to_string lat_str) in
            let lon = float_of_string (Js.to_string lon_str) in
            set_gps_cookie lat lon;
            (* Clear localStorage after migration *)
            storage##removeItem (Js.string "gps_lat");
            storage##removeItem (Js.string "gps_lon");
            print_endline "GPS data migrated from localStorage to cookies"
          )
        )
      )
    with _ -> ()

(* Update GPS data access function to handle Js.opt for getItem *)
let get_gps_location () =
  if secure_state.is_secure then
    get_gps_cookie ()
  else
    try
      match Js.Optdef.to_option (Dom_html.window##.localStorage) with
      | None -> (0.0, 0.0)
      | Some storage ->
          let lat_opt = storage##getItem (Js.string "gps_lat") in
          let lon_opt = storage##getItem (Js.string "gps_lon") in
          match Js.Opt.to_option lat_opt, Js.Opt.to_option lon_opt with
          | Some lat_str, Some lon_str -> 
              (float_of_string (Js.to_string lat_str), 
               float_of_string (Js.to_string lon_str))
          | _ -> (0.0, 0.0)
    with _ -> (0.0, 0.0)

(*
(* Add functions to handle GPS data *)
let update_gps_location lat lon =
  if secure_state.is_secure then
    set_gps_cookie lat lon
  else
    let storage = Dom_html.window##.localStorage in
    storage##setItem (Js.string "gps_lat") (Js.string (string_of_float lat));
    storage##setItem (Js.string "gps_lon") (Js.string (string_of_float lon))
    *)
