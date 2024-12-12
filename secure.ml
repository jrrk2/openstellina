open Js_of_ocaml
open Lwt.Syntax
open Astro_utils
open Cookie
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

(* Create secure connection tab content *)
let create_secure_connection_tab () =
  let open Tyxml_js.Html in
  div ~a:[a_class ["secure-connection-panel"]] [
    div ~a:[a_class ["section-title"]] [txt "Secure Connection"];
    div ~a:[a_class ["connection-status"]] [
      div ~a:[
        a_id "secure-status";
        a_class ["status-pill"; if secure_state.is_secure then "connected" else "disconnected"]
      ] [txt (if secure_state.is_secure then "Secure (HTTPS)" else "Insecure (HTTP)")];
      
      (if not secure_state.is_secure then
        div ~a:[a_class ["secure-warning"]] [
          txt "You are currently using an insecure connection. Some features may be limited.";
          br ();
          button ~a:[
            a_class ["control-button"; "secure-redirect"];
            a_onclick (fun _ ->
              let current_url = Js.to_string Dom_html.window##.location##.href in
              let https_url = "https://" ^ 
              String.sub current_url 7 (String.length current_url - 7) in
	      print_endline https_url;
              Dom_html.window##.location##.href := Js.string https_url;
              true
            )
          ] [txt "Switch to HTTPS"]
        ]
      else
        div ~a:[a_class ["secure-info"]] [
          txt "You are using a secure connection.";
        ]
      )
    ]
  ]

