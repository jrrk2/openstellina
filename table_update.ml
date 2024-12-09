open Js_of_ocaml
open Js_of_ocaml_tyxml

let table_element =
  let open Tyxml_js.Html in
  let headers = [ "Date (UT) HR:MN"; "Date JDUT"; "R.A. (ICRF)"; "DEC"; "Azi (r-app)"; "Elev"; "L Ap Sid Time" ] in
  let hwidths = [ 150; 100; 100; 100; 100; 100; 100 ] in
  let header_row =
    tr (List.map2 (fun header wid -> th ~a:[a_style ("min-width: "^string_of_int wid^"px;")] [txt header]) headers hwidths)
  in
  tablex 
    ~a:[
      a_id "results-table";
      a_style "border-collapse: collapse; width: 100%;"
    ]
    ~thead:(thead [ header_row ])
[tbody []]

let update_table_row ?(index=0) ~date_ut ~date_jdut ~ra ~dec ~azi ~elev ~l_ap_sid_time () =
  try
    (* Debug: Print the index being updated *)
    Printf.printf "Attempting to update row at index %d\n" index;

    (* Attempt to get the table *)
    let table = 
      try Js_of_ocaml.Dom_html.getElementById "results-table" 
      with Not_found -> 
        Printf.printf "Table not found by ID\n";
        failwith "Table not found"
    in

    (* Debug: Check if table is found *)
    Printf.printf "Table found successfully\n";

    (* Try to get tbody *)
    let tbody = 
      Js.Opt.to_option (table##querySelector (Js.string "tbody"))
    in

    match tbody with
    | Some tbody_elem ->
        (* Debug: Print number of rows *)
        let rows = tbody_elem##querySelectorAll (Js.string "tr") in
        Printf.printf "Total rows: %d\n" rows##.length;

        if index < rows##.length then
          let row = rows##item index in
          Js.Opt.iter row (fun row ->
            let cells = row##querySelectorAll (Js.string "td") in
            
            (* Debug: Print number of cells *)
            Printf.printf "Total cells in row: %d\n" cells##.length;

            let update_cell idx value =
              if idx < cells##.length then
                Js.Opt.iter (cells##item idx) (fun cell ->
                  cell##.textContent := Js.some (Js.string value);
                  if false then Printf.printf "Updated cell %d with value: %s\n" idx value
                )
            in
            update_cell 0 date_ut;
            update_cell 1 date_jdut;
            update_cell 2 ra;
            update_cell 3 dec;
            update_cell 4 azi;
            update_cell 5 elev;
            update_cell 6 l_ap_sid_time
          )
        else 
          Printf.printf "Index %d is out of bounds\n" index
    | None -> 
        Printf.printf "No tbody found in table\n"
  with 
  | exn -> 
      Printf.printf "Exception occurred: %s\n" (Printexc.to_string exn)

let append_table_row ~date_ut ~date_jdut ~ra ~dec ~azi ~elev ~l_ap_sid_time () =
  try
    (* Get the table *)
    let table = Js_of_ocaml.Dom_html.getElementById "results-table" in

    (* Find the tbody *)
    let tbody_opt = Js.Opt.to_option (table##querySelector (Js.string "tbody")) in

    match tbody_opt with
    | Some tbody_elem ->
        (* Create a new table row *)
        let new_row = Js_of_ocaml.Dom_html.createTr Js_of_ocaml.Dom_html.document in

        (* Create and populate cells *)
        let cell_values = [
          date_ut; 
          date_jdut; 
          ra; 
          dec; 
          azi; 
          elev; 
          l_ap_sid_time
        ] in

        let maplst = List.mapi (fun i value ->
          let cell = Js_of_ocaml.Dom_html.createTd Js_of_ocaml.Dom_html.document in
          cell##.textContent := Js.some (Js.string value);
          new_row##appendChild (cell :> Dom.node Js.t)
        ) cell_values in

        (* Append the new row to the tbody *)
        let _ = tbody_elem##appendChild (new_row :> Dom.node Js.t) in ()

    | None -> 
        Printf.printf "No tbody found in table\n"
  with
  | exn -> 
Printf.printf "Exception occurred: %s\n" (Printexc.to_string exn)
