(*

 For debugging purposes use this command line (and change astro_utils.ml from open Cohttp_lwt_jsoo to open Cohttp_lwt_unix

ocamlfind ocamlmktop -package yojson,cohttp,lwt_ppx,unix,xml-light,cohttp-lwt-unix,cohttp -linkpkg -thread altaz.ml astro_utils.ml horizons.ml debugh.ml -o debugh
 *)

 (*
  open Cohttp_lwt_unix
  *)
open Cohttp_lwt_jsoo
open Altaz
open Lwt.Infix
open Horizons;;
open Printf;;

type target_category = 
  | SolarSystem
  | Comets 
  | DeepSky
  | Horizons      
  | NgcCatalog
  | RecentTargets

type target_info = {
  name: string;
  ra: float;
  dec: float;
  mag: float;
  desc: string;
  category: target_category;
  debug: string;
}

let dbgxml = ref (Xml.PCData "")

let show_info = print_endline

let search_text = try Sys.getenv "ID" with _ -> "599"

let callback body rslt = Array.iteri (fun ix itm -> Printf.printf "\"%s\" " (match ix with
							 | 1 -> (Altaz.hms_of_float (float_of_string itm))
                                                         | 2 -> (Altaz.dms_of_float (float_of_string itm))
							 | 3 -> (Altaz.dms_of_float (float_of_string itm))
                                                         | 4 -> (Altaz.dms_of_float (float_of_string itm))
							 | 5 -> (Altaz.dms_of_float (float_of_string itm))
							 | _ -> itm)) rslt; print_endline body

let tasks = horizons' show_info callback search_text 2460662.983

let run () =
  Lwt_main.run tasks

let _ = run()
