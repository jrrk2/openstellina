open Js_of_ocaml
open Js_of_ocaml_tyxml
open Tyxml_js.Html
open Printf
open Str
open Altaz
open Astro_utils
open Utils

open Js_of_ocaml
open Js_of_ocaml_tyxml
open Tyxml_js.Html
open Printf
open Str
open Altaz
open Astro_utils

external _myFunction : int -> float = "_myFunction"

type target_category = 
  | SolarSystem
  | Comets 
  | DeepSky
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

let get_filtered_targets selected_category search_text =
  let debug_msg msg = 
    !set_debug_value ("Target selector: " ^ msg) in
  
  let all_targets = match selected_category with
  | SolarSystem -> 
      debug_msg "Loading solar system objects...";
      let objects = ["Sun"; "Moon"; "Mercury"; "Venus"; "Mars"; "Jupiter"; "Saturn"; "Uranus"; "Neptune"] in
      let get_body_pos name =
        send 0 name;
        let ra = (_myFunction 3) *. 180. /. Float.pi in 
        let dec = (_myFunction 4) *. 180. /. Float.pi in
        debug_msg (sprintf "%s calculated position: ra=%.2f dec=%.2f" name ra dec);
        (ra, dec)
      in
      
      List.map (fun name ->
        let ra, dec = get_body_pos name in
        let mag = match name with
        | "Sun" -> -26.7
        | "Moon" -> -12.6 
        | "Mercury" -> 0.0
        | "Venus" -> -4.4
        | "Mars" -> -2.9
        | "Jupiter" -> -2.2
        | "Saturn" -> 0.6
        | "Uranus" -> 5.7
        | "Neptune" -> 7.8
        | _ -> 0.0
        in
        {
          name = name;
          ra = ra;
          dec = dec; 
          mag = mag;
          desc = sprintf "Solar System object";
          category = SolarSystem;
          debug = sprintf "Position from ephemeral calculation: ra=%.2f dec=%.2f" ra dec
        }
      ) objects

  | Comets ->
      debug_msg (sprintf "Loading %d comets..." (List.length Comets.comets));
      List.map (fun (name, sequence, discoverer) -> 
        let fullname = sprintf "%s %s (%s)" name sequence discoverer in
        debug_msg (sprintf "Processing comet: %s" fullname);
        send 1 name;
        send 2 sequence;
        send 3 discoverer;
        let ra = (_myFunction 3) *. 180. /. Float.pi in
        let dec = (_myFunction 4) *. 180. /. Float.pi in
        {
          name = fullname;
          ra = ra;
          dec = dec;
          mag = 0.0;
          desc = discoverer;
          category = Comets;
          debug = sprintf "From Comets.comets, calculated position: ra=%.2f dec=%.2f" ra dec
        }
      ) Comets.comets

  | DeepSky ->
      debug_msg "Loading Messier catalog...";
      Array.to_list (Array.mapi (fun i (name, ra, dec, mag) -> 
        debug_msg (sprintf "Processing M%d: %s" (i+1) name);
        {
          name = name;
          ra = cnv_ra ra;
          dec = cnv_dec dec;
          mag = float_of_string mag;
          desc = sprintf "Messier %d" (i+1);
          category = DeepSky;
          debug = sprintf "From Messier catalog: ra=%s dec=%s mag=%s" ra dec mag
        }
      ) Messier_catalogue.messier_array)

  | RecentTargets ->
      debug_msg "Loading recent targets (not implemented)";
      [] in

  (* Apply search filter *)
  if search_text = "" then begin
    debug_msg "No search filter applied";
    all_targets
  end else begin
    let regexp' = Str.regexp (String.lowercase_ascii search_text) in
    let filtered = List.filter (fun t -> 
      Str.string_match regexp' (String.lowercase_ascii t.name) 0
    ) all_targets in
    debug_msg (sprintf "Found %d matches" (List.length filtered));
    filtered
  end

let create_target_item target =
  let currently_visible = ref true in
  let latitude = latitude() in
  let longitude = longitude() in
  let yr,mon,dy,hr,min,sec = split_date() in
  
  let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = 
    altaz_calc yr mon dy hr min sec target.ra target.dec latitude longitude in
    
  let visible = alt_calc > 0.0 in

  if (not !currently_visible) || visible then
    div ~a:[a_class ["target-item"]] [
      div ~a:[a_class ["target-info"]] [
        h3 ~a:[a_class ["target-name"]] [txt target.name];
        p ~a:[a_class ["target-details"]] [
          txt (sprintf "RA: %s DEC: %s Mag: %.1f" 
            (hms_of_float target.ra) 
            (dms_of_float target.dec) 
            target.mag)
        ];
        p ~a:[a_class ["target-visibility"]] [
          txt (sprintf "Alt: %.1f° Az: %.1f°" alt_calc az_calc)
        ];
        p ~a:[a_class ["target-debug"]] [
          txt (sprintf "Debug: %s" target.debug)
        ]
      ];
      button ~a:[
        a_class ["select-target"];
        a_onclick (fun _ ->
          entry_ra_set_text (hms_of_float target.ra);
          entry_dec_set_text (dms_of_float target.dec);
          entry_nam_set_text target.name;
          true)
      ] [txt "Select"]
    ]
  else
div ~a:[] []

let create_target_selector () =
  let currently_visible = ref true in
  let selected_category = ref SolarSystem in
  let search_text = ref "" in
  let target_list_div = ref None in
  let target_container = div ~a:[a_class ["target-list-container"]] [] in

  let update_target_list () =
    (* Remove existing target list if present *)
    Option.iter (fun div ->
      let dom_div = Tyxml_js.To_dom.of_element div in
      Js.Opt.iter dom_div##.parentNode (fun parent ->
        Dom.removeChild parent dom_div)
    ) !target_list_div;
    
    (* Create new target list *)
    let new_list = div ~a:[a_class ["target-list"]] (
      List.map create_target_item (get_filtered_targets !selected_category !search_text)
    ) in
    target_list_div := Some new_list;
    
    (* Add to container *)
    Dom.appendChild 
      (Tyxml_js.To_dom.of_element target_container)
      (Tyxml_js.To_dom.of_element new_list) in

let visibility_filter =
  let checkbox = input ~a:[
    a_input_type `Checkbox;
    a_onclick (fun _ ->
      currently_visible := not !currently_visible;
      update_target_list ();  (* Call update when visibility changes *)
      true)
  ] () in
  
  let dom_checkbox = Tyxml_js.To_dom.of_input checkbox in
  dom_checkbox##.checked := Js.bool !currently_visible;

  div ~a:[a_class ["visibility-filter"]] [
    label [
      checkbox;
      txt " Show only currently visible targets"
    ]
] in

  let main_div = div ~a:[
    a_class ["target-selector"];
    a_id "target-selector-main"
  ] [
    (* Category buttons *)
    div ~a:[a_class ["category-buttons"]] [
      button ~a:[
        a_class ["category-button"; if !selected_category = SolarSystem then "active" else ""];
        a_onclick (fun _ -> 
          selected_category := SolarSystem;
          update_target_list ();
          true)
      ] [txt "Solar System"];
      button ~a:[
        a_class ["category-button"; if !selected_category = Comets then "active" else ""];
        a_onclick (fun _ -> 
          selected_category := Comets;
          update_target_list ();
          true)
      ] [txt "Comets"];
      button ~a:[
        a_class ["category-button"; if !selected_category = DeepSky then "active" else ""];
        a_onclick (fun _ -> 
          selected_category := DeepSky;
          update_target_list ();
          true)
      ] [txt "Deep Sky Objects"];
      button ~a:[
        a_class ["category-button"; if !selected_category = RecentTargets then "active" else ""];
        a_onclick (fun _ -> 
          selected_category := RecentTargets;
          update_target_list ();
          true)
      ] [txt "Recent Targets"]
    ];
    
    (* Search and filters *)
    div ~a:[a_class ["filters"]] [
      div ~a:[a_class ["search-box"]] [
        input ~a:[
          a_input_type `Text;
          a_placeholder "Search targets...";
          a_oninput (fun e ->
            let target = Dom_html.CoerceTo.input (Dom.eventTarget e) in
            Js.Opt.iter target (fun t ->
              search_text := Js.to_string t##.value;
              update_target_list ());
            true)
        ] ()
      ];
      visibility_filter
    ];
    
    (* Target list container *)
    target_container
  ] in

main_div
