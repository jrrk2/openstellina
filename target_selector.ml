open Js_of_ocaml
open Js_of_ocaml_tyxml
open Js_of_ocaml_lwt
open Tyxml_js.Html
open Printf
open Str
open Altaz
open Astro_utils
open Utils
open Xml
open Geolocate
open Target

let accstr = ref "alt_calc > 30.0 & (az_calc > 300.0 | az_calc < 60.0)"
let acceptance = ref (Calc.Bool false)
let simbad_targets = ref []
let recent_targets = ref []
(*
 let horizon_targets = ref []
 *)

let get_filtered_targets update_target_list selected_category search_text =
  let debug_msg msg = 
    !set_debug_value ("Target selector: " ^ msg) in

  let filt all_targets = 
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
  end in
  
  match selected_category with
  | SolarSystem -> 
      debug_msg "Loading solar system objects...";
      let objects = ["Sun"; "Moon"; "Mercury"; "Venus"; "Mars"; "Jupiter"; "Saturn"; "Uranus"; "Neptune"] in
      let get_body_pos name =
        let jd = jd_now() in
        let ra, dec, mag = ephem name "" "" jd in
        debug_msg (sprintf "%s calculated position: ra=%.2f dec=%.2f" name ra dec);
        (ra, dec, mag)
      in
      
      let lst = List.map (fun name ->
        let ra, dec, mag = get_body_pos name in
        {
          name = name;
          ra = ra;
          dec = dec; 
          mag = mag;
          desc = sprintf "Solar System object";
          category = SolarSystem;
          debug = sprintf "Position from ephemeral calculation: ra=%.2f dec=%.2f" ra dec
        }
      ) objects in update_target_list (filt lst)

  | Comets ->
     debug_msg (sprintf "Loading %d comets..." (List.length Comets.comets));
     let regexp' = Str.regexp (String.lowercase_ascii search_text) in
     let matching_comets = List.filter (fun (name, sequence, discoverer) ->
        let fullname = sprintf "%s %s (%s)" name sequence discoverer in
        Str.string_match regexp' (String.lowercase_ascii fullname) 0
      ) Comets.comets in
     debug_msg (sprintf "Found %d matching comets" (List.length matching_comets));
     let lst = List.map (fun (name, sequence, discoverer) -> 
        let fullname = sprintf "%s %s (%s)" name sequence discoverer in
        debug_msg (sprintf "Processing comet: %s" fullname);
	let jd = jd_now() in
        let ra, dec, mag = ephem name sequence discoverer jd in
        {
          name = fullname;
          ra = ra;
          dec = dec;
          mag = mag;
          desc = discoverer;
          category = Comets;
          debug = sprintf "From Comets.comets, calculated position: ra=%.2f dec=%.2f" ra dec
        }
      ) matching_comets in update_target_list (filt lst)

  | DeepSky ->
      debug_msg "Loading Messier catalog...";
      let lst = Array.to_list (Array.mapi (fun i (name, ra, dec, mag) -> 
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
      ) Messier_catalogue.messier_array) in update_target_list (filt lst)

  | Simbad ->
      debug_msg "Loading Simbad catalog...";
      let callback = function
        | Simbad.Error errmsg -> Utils.show_info ("SIMBAD: "^errmsg)
        | Unmatched xml -> Simbad.dump show_info xml
        | Found (ident, ra_flt, dec_flt, mag_flt) ->
        Utils.show_info ("Found callback for: "^ident);
        simbad_targets := {
          name = ident;
          ra = ra_flt;
          dec = dec_flt;
          mag = mag_flt;
          desc = "Simbad" ^ search_text;
          category = DeepSky;
          debug = sprintf "From Simbad online catalog: ra=%f dec=%f mag=%f" ra_flt dec_flt mag_flt
        } :: !simbad_targets;
        update_target_list (List.sort_uniq compare !simbad_targets);
        | _ -> Utils.show_info "unhandled simbad response" in
      Simbad.simbad_main show_info callback search_text;
(*
  | Horizons ->
      show_info "Calling Horizons ...";
      let jd = jd_now() in
      let callback body rslt = let debug = String.concat " " (Array.to_list (Array.mapi (fun ix itm -> ("\""^(match ix with
							 | 1 -> (Altaz.hms_of_float (float_of_string itm))
                                                         | 2 -> (Altaz.dms_of_float (float_of_string itm))
							 | 3 -> (Altaz.dms_of_float (float_of_string itm))
                                                         | 4 -> (Altaz.dms_of_float (float_of_string itm))
							 | 5 -> (Altaz.dms_of_float (float_of_string itm))
							 | _ -> itm^"\" "))) rslt)) in
        horizon_targets := {
          name = body;
          ra = float_of_string rslt.(1);
          dec = float_of_string rslt.(2);
          mag = float_of_string rslt.(6);
          desc = "Horizons" ^ search_text;
          category = DeepSky;
          debug = "From Horizons online catalog: "^debug
        } :: !horizon_targets in
      let _ = Horizons.horizons' print_endline callback search_text jd in ()
  | NgcCatalog ->
      debug_msg "(not implemented)"
*)
  | RecentTargets ->
        update_target_list (List.sort_uniq compare !recent_targets)

let create_target_selector () =
  let currently_visible = ref true in
  let selected_category = ref SolarSystem in
  let search_text = ref "" in
  let target_list_div = ref None in
  let target_container = div ~a:[a_class ["target-list-container"]] [] in
let create_target_item target =
  let latitude = latitude() in
  let longitude = longitude() in
  let yr,mon,dy,hr,min,sec = split_date() in
  
  let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = 
    altaz_calc yr mon dy hr min sec target.ra target.dec latitude longitude in
    
  let visible = 
    let acclst = [
      ("alt_calc", Calc.Num alt_calc);
      ("az_calc", Calc.Num az_calc);
      ("mag", Calc.Num target.mag);
      ("ang_diam", Calc.Num nan)
    ] in
    match Expr.simplify acclst !acceptance with
    | Calc.Bool true -> true
    | Calc.Bool false -> false
    | other -> 
        !set_debug_value (sprintf "Unexpected acceptance result for %s: " target.name);
        Expr.dump stderr acclst other;
        false 
  in

  if (not !currently_visible) || visible then
    div ~a:[a_class ["target-item"; if visible then "visible" else "not-visible"]] [
      div ~a:[a_class ["target-info"]] [
        h3 ~a:[a_class ["target-name"]] [txt target.name];
        p ~a:[a_class ["target-details"]] [
          txt (sprintf "RA: %s DEC: %s Mag: %.1f" 
            (hms_of_float target.ra) 
            (dms_of_float target.dec) 
            target.mag)
        ];
        p ~a:[a_class ["target-visibility"]] [
          txt (sprintf "Alt: %.1f° Az: %.1f° %s" 
            alt_calc 
            az_calc
            (if visible then "(Visible)" else "(Not visible)"))
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
	  update_display_value "status-Target RA" (hms_of_float target.ra);
	  update_display_value "status-Target DEC" (dms_of_float target.dec);
	  update_display_value "status-Target Name" target.name;
	  recent_targets := target :: !recent_targets;
          true)
      ] [txt "Select"]
    ]
  else
    div ~a:[] [] in

  let update_target_list filtered =
    (* Remove existing target list if present *)
    Option.iter (fun div ->
      let dom_div = Tyxml_js.To_dom.of_element div in
      Js.Opt.iter dom_div##.parentNode (fun parent ->
        Dom.removeChild parent dom_div)
    ) !target_list_div;
    
    (* Create new target list *)
    let new_list = div ~a:[a_class ["target-list"]] (
      List.map create_target_item filtered
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
        get_filtered_targets update_target_list !selected_category !search_text;
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

let make_radio category label_text =
  let radio_id = match category with 
    | SolarSystem -> "radio-solar" 
    | Comets -> "radio-comets"
    | DeepSky -> "radio-deep"
    | Simbad -> "radio-simbad"
(*
    | Horizons -> "radio-horizons"
    | NgcCatalog -> "radio-ngc"
*)    
    | RecentTargets -> "radio-recent" in

  let radio = input ~a:[
    a_input_type `Radio;
    a_name "category";
    a_id radio_id;
    a_value (match category with 
      | SolarSystem -> "solar" 
      | Comets -> "comets"
      | DeepSky -> "deep"
      | Simbad -> "simbad"
(*
      | Horizons -> "horizons"
      | NgcCatalog -> "ngc"
*)
      | RecentTargets -> "recent");
    a_onclick (fun _ ->
      selected_category := category;
      get_filtered_targets update_target_list !selected_category !search_text;
      true)
  ] () in

  let dom_radio = Tyxml_js.To_dom.of_input radio in
  dom_radio##.checked := Js.bool (category = !selected_category);

  div ~a:[a_class ["radio-item"]] [
    radio;
    label ~a:[a_label_for radio_id] [txt label_text]
  ] in

  let styles = {|
    .radio-group {
      display: flex;
      gap: 16px;
      margin-bottom: 16px;
    }

    .radio-item {
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .radio-item input[type="radio"] {
      margin: 0;
    }

    .radio-item label {
      cursor: pointer;
    }

    .target-list {
      margin-top: 20px;
    }

    .target-item {
      padding: 12px;
      border: 1px solid #ddd;
      margin-bottom: 8px;
      border-radius: 4px;
    }

    .target-info {
      margin-bottom: 8px;
    }

    .target-name {
      margin: 0 0 4px 0;
      font-size: 16px;
    }

    .target-details, .target-visibility {
      margin: 2px 0;
      color: #666;
    }

    .target-debug {
      font-size: 12px;
      color: #999;
    }

    .select-target {
      padding: 6px 12px;
      background: #007bff;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .select-target:hover {
      background: #0056b3;
    }

  .target-item.visible {
    border-left: 4px solid #28a745;
  }

  .target-item.not-visible {
    border-left: 4px solid #dc3545;
    opacity: 0.7;
}

  .acceptance-box {
    margin: 10px 0;
  }

  .acceptance-box input[type="text"] {
    width: 100%;  /* Full width of container */
    padding: 8px;
    margin-top: 4px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-family: monospace;  /* Better for equations */
  }

  /* Make the search box match width */
  .search-box input[type="text"] {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
  }

  .filters {
    width: 100%;  /* Ensure container uses full width */
    margin-bottom: 16px;
  }

  |} in

  let style_elem = Dom_html.createStyle Dom_html.document in
  style_elem##.innerHTML := Js.string styles;
  Dom.appendChild Dom_html.document##.head style_elem;
  let search_timeout = ref None in

  div ~a:[
    a_class ["target-selector"];
    a_id "target-selector-main"
  ] [
    (* Category buttons *)
    div ~a:[a_class ["category-buttons"]] [
      div ~a:[a_class ["radio-group"]] [
        make_radio SolarSystem "Solar System";
        make_radio Comets "Comets";
        make_radio DeepSky "Messier Deep Sky Objects";
        make_radio Simbad "Simbad";
(*
        make_radio Horizons "Horizons";
        make_radio NgcCatalog "NGC";
*)
        make_radio RecentTargets "Recent Targets"
      ]
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
	    (* Clear any pending timeout *)
	    Option.iter (fun tid -> Dom_html.window##clearTimeout tid) !search_timeout;

	    (* Set new timeout *)
	    search_timeout := Some (Dom_html.window##setTimeout
	      (Js.wrap_callback (fun () ->
		search_text := Js.to_string t##.value;
		get_filtered_targets update_target_list !selected_category !search_text;
	      ))
	      2000.  (* 2 second delay *)
	    )
	  );
	  true)
      ] ()
    ];

    div ~a:[a_class ["acceptance-box"]] [
      label [txt "Visibility condition: "];
      input ~a:[
	a_input_type `Text;
	a_placeholder "e.g. alt_calc > 30.0 & (az_calc > 300.0 | az_calc < 60.0)";
	a_value !accstr;
	a_oninput (fun e ->
	  let input = Dom_html.CoerceTo.input (Dom.eventTarget e) in
	  Js.Opt.iter input (fun t ->
	    try
	      let equation = Js.to_string t##.value in
              accstr := equation;
	      acceptance := Expr.simplify [] (Expr.expr equation);
	      get_filtered_targets update_target_list !selected_category !search_text;
	      t##.style##.backgroundColor := Js.string "#ffffff"
	    with _ ->
	      t##.style##.backgroundColor := Js.string "#ffeeee"
	  );
	  true)
      ] ()
    ];
      visibility_filter
    ];
    
    (* Target list container *)
    target_container
]
