(*

 For debugging purposes use this command line (and change astro_utils.ml from open Cohttp_lwt_jsoo to open Cohttp_lwt_unix

ocamlfind ocamlmktop -package cohttp,lwt_ppx,unix,xml-light,cohttp-lwt-unix,cohttp -linkpkg -thread altaz.ml astro_utils.ml simbad.ml debugs.ml -o debugs
 *)

open Cohttp_lwt_unix
open Altaz
open Lwt.Infix
open Simbad;;
open Printf;;

type target_category = 
  | SolarSystem
  | Comets 
  | DeepSky
  | Simbad      
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

let targets = ref []

let show_info = print_endline

let simbad_targets = ref []

let search_text = try Sys.getenv "ID" with _ -> "Barnard33"

let update_target_list lst = targets := lst

let callback = function
        | Simbad.Error errmsg -> show_info ("SIMBAD: "^errmsg)
        | Unmatched xml -> Simbad.dump show_info xml; dbgxml := xml
        | Found (ident, ra_flt, dec_flt, mag_flt) ->
        show_info ("Found callback for: "^ident);
        simbad_targets := {
          name = ident;
          ra = ra_flt;
          dec = dec_flt;
          mag = mag_flt;
          desc = "Simbad " ^ search_text;
          category = DeepSky;
          debug = sprintf "From Simbad online catalog: ra=%f dec=%f mag=%f" ra_flt dec_flt mag_flt
        } :: !simbad_targets;
        update_target_list (List.sort_uniq compare !simbad_targets)

let tasks = simbad' show_info callback search_text

let run () =
  Lwt_main.run tasks

let _ = run();
let tgt = List.hd !targets in  
print_endline ("{contents =
  [{name = \""^tgt.name^"; ra = "^string_of_float tgt.ra^";
    dec = "^string_of_float tgt.dec^"; mag = nan; desc = \""^tgt.desc^"\";
    category = "^(match tgt.category with DeepSky -> "DeepSky")^";
    debug = \""^tgt.debug^"\"}]}")
