open Js_of_ocaml

let create_button name main fn = 
  let doc = Dom_html.window##.document in
  let res = doc##createDocumentFragment in
  let input = Dom_html.createInput  ~_type:(Js.string "button") doc in
  input##.value := Js.string name;
  input##.onclick := Dom_html.handler fn;
  let button_text = doc##createTextNode (Js.string name) in
  Dom.appendChild input button_text;
  Dom.appendChild res input;
  Dom.appendChild main res

let create_row cols =
  let document = Dom_html.window##.document in
  let tr = Dom_html.(createTr document) in
  List.iter (fun col -> let td = Dom_html.(createTd document) in Dom.appendChild tr td) cols;
  Dom.appendChild tr (Dom_html.createBr document);
  tr

let create_table rows =
  let document = Dom_html.window##.document in
  let table = Dom_html.(createTable document) in
  List.iter (fun row -> Dom.appendChild table row) rows;
  table

let create_button_row label_list =
  let document = Dom_html.window##.document in
  let row = Dom_html.createTr document in
  List.iter (fun label ->
    let cell = Dom_html.createTd document in
    let button = Dom_html.createButton document in
    let button_text = document##createTextNode (Js.string label) in
    Dom.appendChild button button_text;
    Dom.appendChild cell button;
    Dom.appendChild row cell;
  ) label_list;
  row

let main main =
  let rows =
    List.init 5 (fun i ->
        let cols = List.init 5 (fun j ->
            let id = Printf.sprintf "button_%d_%d" i j in
            let label = Printf.sprintf "Button %d-%d" i j in
            create_button label main (fun _ -> Js._false);
            ) in
        create_row cols) in
  let table = create_table rows in
  Dom.appendChild Dom_html.window##.document##.body table
