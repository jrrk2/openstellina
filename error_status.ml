open Js_of_ocaml
open Dom_html

(* Create or get error status container *)
let get_error_container () =
  match Dom_html.document##getElementById(string "error-status") with
  | None ->
      let container = createDiv document in
      container##.id := string "error-status";
      container##.className := string "status-panel";
      
      (* Add title *)
      let title = createDiv document in
      title##.className := string "status-title";
      title##.textContent := string "Error Status";
      Dom.appendChild container title;
      
      (* Add content div *)
      let content = createDiv document in
      content##.id := string "error-content";
      content##.className := string "status-content";
      Dom.appendChild container content;
      
      container
  | Some container -> container

(* Update error status *)
let update_error_status err_obj =
  let container = get_error_container () in
  let content = Js.Opt.get 
    (document##getElementById(string "error-content"))
    (fun () -> failwith "Error content div not found") in
  
  (* Format error message *)
  let error_type = Js.to_string (err_obj##.type_) in
  let error_name = Js.to_string (err_obj##.error##.name) in
  
  (* Update content *)
  content##.innerHTML := string (
    Printf.sprintf
      "Type: %s<br/>Error: %s<br/>Time: %s"
      error_type
      error_name
      (Js.to_string (new%js Js.date_now)##toLocaleTimeString)
  );
  
  (* Add to control window if not already present *)
  let control_window = 
    Js.Opt.get (document##getElementById(string "control-window"))
      (fun () -> failwith "Control window not found") in
  
  if not (Dom_html.element_contains control_window container) then
    Dom.appendChild control_window container

(* CSS styles *)
let _ =
  let style = createStyle document in
  style##.textContent := string {|
    .status-panel {
      margin: 10px;
      padding: 10px;
      border: 1px solid #ccc;
      background: #f5f5f5;
    }
    .status-title {
      font-weight: bold;
      margin-bottom: 5px;
    }
    .status-content {
      font-family: monospace;
      white-space: pre-wrap;
    }
  |};
  Dom.appendChild document##.head style

(* Function to start monitoring errors *)
let start_error_monitoring callback_interval =
  let _ = Dom_html.window##setInterval (Js.wrap_callback (fun () ->
    (* Add your error checking logic here *)
    (* For example, check an error status endpoint *)
    (* Then call update_error_status with any new errors *)
    ()
  )) callback_interval in
  ()
