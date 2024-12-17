open Js_of_ocaml
open Dom_html

(* Error type definition *)
type error_info = {
  error_type : string;
  name : string;
  details : string;
}

(* Create error dialog element *)
let create_error_dialog error =
  let dialog = createDiv document in
  dialog##.className := string "error-dialog";
  
  (* Create header *)
  let header = createDiv document in
  header##.className := string "error-dialog-header";
  let title = document##createElement (string "h3") in
  title##.textContent := string ("Error: " ^ error.error_type);
  Dom.appendChild header title;
  
  (* Create content *)
  let content = createDiv document in
  content##.className := string "error-dialog-content";
  let error_name = createP document in
  error_name##.textContent := string ("Name: " ^ error.name);
  let error_details = createP document in
  error_details##.textContent := string ("Details: " ^ error.details);
  Dom.appendChild content error_name;
  Dom.appendChild content error_details;
  
  (* Create close button *)
  let close_btn = createButton document in
  close_btn##.className := string "error-dialog-close";
  close_btn##.textContent := string "Close";
  let _ = close_btn##.onclick := handler (fun _ ->
    dialog##.style##.display := string "none";
    Js._false
  ) in
  
  (* Assemble dialog *)
  Dom.appendChild dialog header;
  Dom.appendChild dialog content;
  Dom.appendChild dialog close_btn;
  dialog

(* Function to show error dialog *)
let show_error err_obj =
  try
    let error_type = Js.to_string (err_obj##.type_) in
    let error_name = Js.to_string (err_obj##.error##.name) in
    let error_info = {
      error_type;
      name = error_name;
      details = "Additional error details can be parsed here";
    } in
    let dialog = create_error_dialog error_info in
    
    (* Add dialog to control window *)
    let control_window = 
      Js.Opt.get (document##getElementById(string "control-window"))
        (fun () -> failwith "Control window not found") in
    
    Dom.appendChild control_window dialog;
    dialog##.style##.display := string "block"
  with
  | e -> 
      Firebug.console##log(string ("Error creating dialog: " ^ Printexc.to_string e))

(* CSS styles for the dialog *)
let _ =
  let style = createStyle document in
  style##.textContent := string {|
    .error-dialog {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      z-index: 1000;
      display: none;
    }
    .error-dialog-header {
      margin-bottom: 15px;
    }
    .error-dialog-content {
      margin-bottom: 20px;
    }
    .error-dialog-close {
      padding: 8px 16px;
      background: #e53e3e;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    .error-dialog-close:hover {
      background: #c53030;
    }
  |};
  Dom.appendChild document##.head style
