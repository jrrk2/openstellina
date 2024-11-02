open Js_of_ocaml
open Js_of_ocaml_lwt
open Js_of_ocaml_tyxml

let create_database () =
  (* Open a connection to the database *)
  let open_request = IndexedDB.openDB "my_db" 1 in

  (* Define the structure of the database *)
  let on_upgrade db _old_version new_version transaction =
    let store
