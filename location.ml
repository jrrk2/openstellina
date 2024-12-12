open Js_of_ocaml
open Js_of_ocaml_lwt
open Js_of_ocaml_tyxml
open Tyxml_js.Html
open Utils
open Geolocate

(* Move related functions together *)
let get_cities_for_tz tz =
  try Hashtbl.find Base_locations.loch tz
  with Not_found -> []

let get_cities_for_tz_and_region tz reg =
  let cities = get_cities_for_tz tz in
  List.filter (fun (_, reg', _, _) -> reg' = reg) cities

let get_cities_for_letter tz reg letter =
  let cities = get_cities_for_tz_and_region tz reg in
  List.filter (fun (city, _, _, _) -> 
    Char.uppercase_ascii city.[0] = letter.[0]
  ) cities

let get_continent tz =
  (match String.split_on_char '/' tz with
  | continent :: _ -> continent
  | [] -> "Other")

let get_unique_continents () =
  Hashtbl.fold (fun tz _ acc ->
    let continent = get_continent tz in
    if List.mem continent acc then acc
    else continent :: acc
  ) Base_locations.loch []
  |> List.sort String.compare

let get_timezones_for_continent continent =
  Hashtbl.fold (fun tz _ acc ->
    if get_continent tz = continent then tz :: acc
    else acc
  ) Base_locations.loch []
  |> List.sort String.compare

let get_regions_for_tz tz =
  let cities = get_cities_for_tz tz in
  let regions = List.fold_left (fun acc (_, reg, _, _) ->
    if List.mem reg acc then acc
    else reg :: acc
  ) [] cities in
  List.sort String.compare regions

let get_city_first_letters tz reg =
  let cities = get_cities_for_tz_and_region tz reg in
  List.fold_left (fun acc (city, _, _, _) ->
    let first = String.make 1 (Char.uppercase_ascii city.[0]) in
    if List.mem first acc then acc
    else first :: acc
  ) [] cities
  |> List.sort String.compare

let select_element element =
  let default = "unknown" in
  (match Dom_html.getElementById_opt element with
  | None -> default
  | Some element -> 
      Js.Opt.case (Dom_html.CoerceTo.select element)
        (fun () -> default)
        (fun select -> Js.to_string select##.value))

(* Add to existing helper functions *)
let set_select_value id value =
  Option.iter (fun select ->
    let sel = Js.Unsafe.coerce select in
    sel##.value := Js.string value
  ) (Dom_html.getElementById_opt id)

let get_default_selections () =
  (match Geo.get_cookie "TZ" with
  | Some tz ->
      let continent = get_continent tz in
      let maybe_reg = Geo.get_cookie "area" in
      let maybe_city = Geo.get_cookie "city" in
      Some (continent, tz, maybe_reg, maybe_city)
  | None -> None)

let populate_and_select_cities tz reg letter_select city_select =
  let cities = get_cities_for_tz_and_region tz reg in
  if List.length cities > 20 then begin
    print_endline "many cities";
    (* Populate letter select *)
    let letter_sel = Js.Unsafe.coerce letter_select in
    letter_sel##.style##.display := Js.string "inline";
    letter_sel##.innerHTML := Js.string "";
    let default_option = Dom_html.createOption Dom_html.document in
    default_option##.value := Js.string "";
    default_option##.textContent := Js.some (Js.string "Select First Letter");
    ignore (letter_sel##appendChild (default_option :> Dom.node Js.t));
    
    let letters = get_city_first_letters tz reg in
    List.iter (fun letter ->
      let option = Dom_html.createOption Dom_html.document in
      option##.value := Js.string letter;
      let count = List.length (get_cities_for_letter tz reg letter) in
      option##.textContent := Js.some (Js.string (Printf.sprintf "%s (%d)" letter count));
      ignore (letter_sel##appendChild (option :> Dom.node Js.t))
    ) letters;

    (* If we have a stored city, select its letter and show filtered cities *)
    (match Geo.get_cookie "city" with
    | Some city when String.length city > 0 ->
        let letter = String.make 1 (Char.uppercase_ascii city.[0]) in
        letter_sel##.value := Js.string letter;
        
        let city_sel = Js.Unsafe.coerce city_select in
        city_sel##.style##.display := Js.string "inline";
        city_sel##.innerHTML := Js.string "";
        let default_option = Dom_html.createOption Dom_html.document in
        default_option##.value := Js.string "";
        default_option##.textContent := Js.some (Js.string "Select City");
        ignore (city_sel##appendChild (default_option :> Dom.node Js.t));
        
        let filtered_cities = get_cities_for_letter tz reg letter in
        List.iter (fun (city_name, _, _, _) ->
          let option = Dom_html.createOption Dom_html.document in
          option##.value := Js.string city_name;
          option##.textContent := Js.some (Js.string city_name);
          ignore (city_sel##appendChild (option :> Dom.node Js.t))
        ) (List.sort (fun (a,_,_,_) (b,_,_,_) -> String.compare a b) filtered_cities);
        
        city_sel##.value := Js.string city
    | _ -> 
        let city_sel = Js.Unsafe.coerce city_select in
        city_sel##.style##.display := Js.string "none")
  end else begin
    let letter_sel = Js.Unsafe.coerce letter_select in
    letter_sel##.style##.display := Js.string "none";
    
    let city_sel = Js.Unsafe.coerce city_select in
    city_sel##.style##.display := Js.string "inline";
    city_sel##.innerHTML := Js.string "";
    let default_option = Dom_html.createOption Dom_html.document in
    default_option##.value := Js.string "";
    default_option##.textContent := Js.some (Js.string "Select City");
    ignore (city_sel##appendChild (default_option :> Dom.node Js.t));
    
    List.iter (fun (city_name, _, _, _) ->
      let option = Dom_html.createOption Dom_html.document in
      option##.value := Js.string city_name;
      option##.textContent := Js.some (Js.string city_name);
      ignore (city_sel##appendChild (option :> Dom.node Js.t))
    ) (List.sort (fun (a,_,_,_) (b,_,_,_) -> String.compare a b) cities);
    
    (match Geo.get_cookie "city" with
    | Some city -> city_sel##.value := Js.string city
    | None -> ())
  end

let populate_and_trigger_select select_id value =
  Option.iter (fun select ->
    let sel = Js.Unsafe.coerce select in
    sel##.value := Js.string value;
    let event = Js.Unsafe.fun_call (Js.Unsafe.js_expr "new Event")
      [|Js.Unsafe.inject (Js.string "change")|] in
    ignore (sel##dispatchEvent event)
  ) (Dom_html.getElementById_opt select_id);
  Lwt.return_unit  (* Make it return a Lwt type *)

let populate_cascading_selects () =
  let%lwt () = Lwt_js.sleep 0.1 in
  (match Geo.get_cookie "TZ" with
  | Some tz ->
      let continent = get_continent tz in
      let%lwt () = populate_and_trigger_select "continent-select" continent in
      
      let%lwt () = Lwt_js.sleep 0.1 in
      let%lwt () = populate_and_trigger_select "timezone-select" tz in
      
      (match Geo.get_cookie "area" with
      | Some area ->
          let%lwt () = Lwt_js.sleep 0.1 in
          let%lwt () = populate_and_trigger_select "region-select" area in
          
          (match Geo.get_cookie "city" with
          | Some city when String.length city > 0 ->
              let cities = get_cities_for_tz_and_region tz area in
              if List.length cities > 20 then begin
                let letter = String.make 1 (Char.uppercase_ascii city.[0]) in
                let%lwt () = Lwt_js.sleep 0.1 in
                let%lwt () = populate_and_trigger_select "city-letter-select" letter in
                let%lwt () = Lwt_js.sleep 0.1 in
                let%lwt () = populate_and_trigger_select "city-select" city in
                Lwt.return_unit
              end else begin
                let%lwt () = Lwt_js.sleep 0.1 in
                let%lwt () = populate_and_trigger_select "city-select" city in
                Lwt.return_unit
              end
          | _ -> Lwt.return_unit)
      | None -> Lwt.return_unit)
  | None -> Lwt.return_unit)

let populate_location_selects () =
  ignore (populate_cascading_selects ())

let populate_manual_coordinates () =
  (match Geo.get_cookie "latitude", Geo.get_cookie "longitude" with
  | Some lat, Some lon ->
      Option.iter (fun lat_el ->
        (Js.Unsafe.coerce lat_el)##.value := Js.string lat
      ) (Dom_html.getElementById_opt "manual-latitude");
      Option.iter (fun lon_el ->
        (Js.Unsafe.coerce lon_el)##.value := Js.string lon
      ) (Dom_html.getElementById_opt "manual-longitude")
  | _ -> ())

let default_tz = Geo.get_cookie "TZ" |> Option.value ~default:""

let create_location_picker () =
  let default_continent = if default_tz <> "" then get_continent default_tz else "" in
  let default_reg = Geo.get_cookie "area" |> Option.value ~default:"" in
  let default_city = Geo.get_cookie "city" |> Option.value ~default:"" in
  let default_letter = 
    if default_city <> "" && default_reg <> "" && default_tz <> "" then
      let letter = String.sub default_city 0 1 in 
      let count = List.length (get_cities_for_letter default_tz default_reg letter) in
      if count > 0 then letter else ""
  else "" in
  let city_list = 
    if default_tz <> "" && default_reg <> "" then
      let all_cities = get_cities_for_tz_and_region default_tz default_reg in
      if List.length all_cities > 20 && default_letter <> "" then
	get_cities_for_letter default_tz default_reg default_letter
      else 
	all_cities
  else [] in
  let timezones = Hashtbl.fold (fun tz _ acc -> tz :: acc) Base_locations.loch [] 
                 |> List.sort String.compare in
  let defoption label default_arg lst = (option ~a:[a_value ""] (txt label)) ::
            List.map (fun arg -> 
              option ~a:[a_value arg; (if arg = default_arg then a_selected () else a_class [])] (txt arg)
            ) lst in
  
  div ~a:[a_class ["location-panel"]] [
    div ~a:[a_class ["section-title"]] [txt "Location Settings"];
    
    (* Manual city picker section with hierarchy *)
    div ~a:[a_class ["location-section"]] [
      div ~a:[a_class ["section-subtitle"]] [txt "Select Location"];
      div ~a:[a_class ["select-group"]] [
        (* Continent select *)
        select ~a:[
          a_id "continent-select";
          a_class ["location-select"];
          a_onchange (fun _ ->
            let continent = select_element "continent-select" in
            Option.iter (fun tz_select ->
              let timezones = get_timezones_for_continent continent in
              let tz_sel = Js.Unsafe.coerce tz_select in
              tz_sel##.innerHTML := Js.string "";
              let default_option = Dom_html.createOption Dom_html.document in
              default_option##.value := Js.string "";
              default_option##.textContent := Js.some (Js.string "Select Timezone");
              ignore (tz_sel##appendChild (default_option :> Dom.node Js.t));
              List.iter (fun tz ->
                let option = Dom_html.createOption Dom_html.document in
                option##.value := Js.string tz;
                option##.textContent := Js.some (Js.string tz);
                ignore (tz_sel##appendChild (option :> Dom.node Js.t))
              ) timezones;
              (* Clear dependent selects *)
              List.iter (fun id ->
                Option.iter (fun sel ->
                  let sel = Js.Unsafe.coerce sel in
                  sel##.innerHTML := Js.string "";
                  let default_option = Dom_html.createOption Dom_html.document in
                  default_option##.value := Js.string "";
                  default_option##.textContent := Js.some (Js.string ("Select " ^ id));
                  ignore (sel##appendChild (default_option :> Dom.node Js.t))
                ) (Dom_html.getElementById_opt (id ^ "-select"))
              ) ["region"; "city-letter"; "city"]
            ) (Dom_html.getElementById_opt "timezone-select");
            true)
        ] (defoption "Select Continent" default_continent (get_unique_continents()));

        (* Timezone select *)
        select ~a:[
          a_id "timezone-select";
          a_class ["location-select"];
          a_onchange (fun _ ->
            let tz = select_element "timezone-select" in
            Geo.set_cookie "TZ" tz;
            Option.iter (fun region_select ->
              let regions = get_regions_for_tz tz in
              let region_sel = Js.Unsafe.coerce region_select in
              region_sel##.innerHTML := Js.string "";
              let default_option = Dom_html.createOption Dom_html.document in
              default_option##.value := Js.string "";
              default_option##.textContent := Js.some (Js.string "Select Region");
              ignore (region_sel##appendChild (default_option :> Dom.node Js.t));
              List.iter (fun reg ->
                let option = Dom_html.createOption Dom_html.document in
                option##.value := Js.string reg;
                option##.textContent := Js.some (Js.string reg);
                ignore (region_sel##appendChild (option :> Dom.node Js.t))
              ) regions;
              (* Clear city-related selects *)
              List.iter (fun sel_id ->
                Option.iter (fun sel ->
                  let sel = Js.Unsafe.coerce sel in
                  sel##.innerHTML := Js.string "";
                  sel##.style##.display := Js.string "none"
                ) (Dom_html.getElementById_opt sel_id)
              ) ["city-letter-select"; "city-select"]
            ) (Dom_html.getElementById_opt "region-select");
            true)
        ] (defoption "Select Timezone" default_tz (timezones));
        
        (* Region select *)
        select ~a:[
          a_id "region-select";
          a_class ["location-select"];
          a_onchange (fun _ ->
            let tz = select_element "timezone-select" in
            let reg = select_element "region-select" in
            Geo.set_cookie "area" reg;
            
            (* Handle city letter selection *)
            let cities = get_cities_for_tz_and_region tz reg in
            Option.iter (fun letter_select ->
              let letter_sel = Js.Unsafe.coerce letter_select in
              if List.length cities > 20 then begin
                (* Show and populate letter select *)
                letter_sel##.style##.display := Js.string "inline";
                letter_sel##.innerHTML := Js.string "";
                let default_option = Dom_html.createOption Dom_html.document in
                default_option##.value := Js.string "";
                default_option##.textContent := Js.some (Js.string "Select First Letter");
                ignore (letter_sel##appendChild (default_option :> Dom.node Js.t));
                
                List.iter (fun letter ->
                  let option = Dom_html.createOption Dom_html.document in
                  option##.value := Js.string letter;
                  let filtered_cities = get_cities_for_letter tz reg letter in
                  let count = List.length filtered_cities in
                  option##.textContent := Js.some (Js.string (Printf.sprintf "%s (%d)" letter count));
                  ignore (letter_sel##appendChild (option :> Dom.node Js.t))
                ) (get_city_first_letters tz reg);
                
                (* Hide city select until letter is chosen *)
                Option.iter (fun city_select ->
                  let city_sel = Js.Unsafe.coerce city_select in
                  city_sel##.style##.display := Js.string "none";
                  city_sel##.innerHTML := Js.string ""
                ) (Dom_html.getElementById_opt "city-select")
              end else begin
                (* Hide letter select and show all cities *)
                letter_sel##.style##.display := Js.string "none";
                Option.iter (fun city_select ->
                  let city_sel = Js.Unsafe.coerce city_select in
                  city_sel##.style##.display := Js.string "inline";
                  city_sel##.innerHTML := Js.string "";
                  let default_option = Dom_html.createOption Dom_html.document in
                  default_option##.value := Js.string "";
                  default_option##.textContent := Js.some (Js.string "Select City");
                  ignore (city_sel##appendChild (default_option :> Dom.node Js.t));
                  List.iter (fun (city_name, _, _, _) ->
                    let option = Dom_html.createOption Dom_html.document in
                    option##.value := Js.string city_name;
                    option##.textContent := Js.some (Js.string city_name);
                    ignore (city_sel##appendChild (option :> Dom.node Js.t))
                  ) (List.sort (fun (a,_,_,_) (b,_,_,_) -> String.compare a b) cities)
                ) (Dom_html.getElementById_opt "city-select")
              end
            ) (Dom_html.getElementById_opt "city-letter-select");
            true)
        ] (defoption "Select Region" default_reg (get_regions_for_tz default_tz));

        (* City letter select *)
        select ~a:[
          a_id "city-letter-select";
          a_class ["location-select"];
          a_style "display: none";
          a_onchange (fun _ ->
            let tz = select_element "timezone-select" in
            let reg = select_element "region-select" in
            let letter = select_element "city-letter-select" in
            
            Option.iter (fun city_select ->
              let city_sel = Js.Unsafe.coerce city_select in
              city_sel##.style##.display := Js.string "inline";
              city_sel##.innerHTML := Js.string "";
              let default_option = Dom_html.createOption Dom_html.document in
              default_option##.value := Js.string "";
              default_option##.textContent := Js.some (Js.string "Select City");
              ignore (city_sel##appendChild (default_option :> Dom.node Js.t));
              
              List.iter (fun (city_name, _, _, _) ->
                let option = Dom_html.createOption Dom_html.document in
                option##.value := Js.string city_name;
                option##.textContent := Js.some (Js.string city_name);
                ignore (city_sel##appendChild (option :> Dom.node Js.t))
              ) (List.sort (fun (a,_,_,_) (b,_,_,_) -> String.compare a b) 
                  (get_cities_for_letter tz reg letter))
            ) (Dom_html.getElementById_opt "city-select");
            true)
        ] (defoption "Select First Letter" default_letter (get_city_first_letters default_tz default_reg));
(* Replace the city select onChange handler in create_location_picker *)
select ~a:[
  a_id "city-select";
  a_class ["location-select"];
  a_style "display: none";
  a_onchange (fun _ ->
    let tz = select_element "timezone-select" in
    let reg = select_element "region-select" in
    let city_name = select_element "city-select" in
    let cities = get_cities_for_tz_and_region tz reg in
    (match List.find_opt (fun (c, _, _, _) -> c = city_name) cities with
    | Some (_, _, lat, lon) ->
        (* Set cookies first *)
        Geo.set_cookie "latitude" (string_of_float lat);
        Geo.set_cookie "longitude" (string_of_float lon);
        Geo.set_cookie "city" city_name;
        Geo.set_cookie "area" reg;
        Geo.set_cookie "TZ" tz;
        Geo.set_cookie "status" "OK";
        
        (* Update UI *)
        Geo.update_ui city_name reg tz lat lon;
        Option.iter (fun status ->
          status##.innerHTML := Js.string 
            (Printf.sprintf "City selected: %s, %s (latitude=%f, longitude=%f)"
              city_name reg lat lon)
        ) (Dom_html.getElementById_opt "location-state")
    | None -> ());
    true)
] (defoption "Select City" default_city (List.map (fun (a,_,_,_) -> a) (List.sort (fun (a,_,_,_) (b,_,_,_) -> String.compare a b) city_list)))
 ];
      p ~a:[a_id "location-state"] [txt "No city selected"]
     ];   
    (* Auto-location section *)
    div ~a:[a_class ["location-section"]] [
      div ~a:[a_class ["section-subtitle"]] [txt "Automatic Location"];
      div ~a:[
        a_id "location-info";
        a_class ["location-info"]
      ] [txt "Detecting location..."];
      button ~a:[
        a_class ["location-button"];
        a_onclick (fun _ -> 
          Geo.geo (fun _ -> ());
          true)
      ] [txt "Detect Location"]
    ];
    
    (* Manual coordinates section *)
    div ~a:[
      a_class ["location-section"];
      a_style "margin-top: 20px;"
    ] [
      div ~a:[a_class ["section-subtitle"]] [txt "Manual Coordinates"];
      div ~a:[a_class ["input-group"]] [
        label ~a:[a_label_for "manual-latitude"] [txt "Latitude:"];
        input ~a:[
          a_id "manual-latitude";
          a_input_type `Text;
          a_class ["location-input"];
          a_placeholder "Enter latitude"
        ] ()
      ];
      div ~a:[a_class ["input-group"]] [
        label ~a:[a_label_for "manual-longitude"] [txt "Longitude:"];
        input ~a:[
          a_id "manual-longitude";
          a_input_type `Text;
          a_class ["location-input"];
          a_placeholder "Enter longitude"
        ] ()
      ];
      button ~a:[
        a_class ["location-button"];
        a_onclick (fun _ ->
          Option.iter (fun lat_el ->
            Option.iter (fun long_el ->
              let lat = Js.to_string (Js.Unsafe.coerce lat_el)##.value in
              let long = Js.to_string (Js.Unsafe.coerce long_el)##.value in
              try
                let lat_float = float_of_string lat in
                let long_float = float_of_string long in
                Geo.set_cookie "latitude" lat;
                Geo.set_cookie "longitude" long;
                Geo.set_cookie "status" "OK";
                Geo.update_ui "" "" "" lat_float long_float;
                (* Update status text for manual coordinates *)
                Option.iter (fun status ->
                  status##.innerHTML := Js.string 
                    (Printf.sprintf "Manual coordinates set: latitude=%s, longitude=%s"
                      lat long)
                ) (Dom_html.getElementById_opt "location-state")
              with _ -> ()
            ) (Dom_html.getElementById_opt "manual-longitude")
          ) (Dom_html.getElementById_opt "manual-latitude");
          true)
      ] [txt "Set Location"]
    ]
  ]

let populate_defaults () =
  if default_tz <> "" then begin
    let tz_sel = (Dom_html.getElementById_opt "timezone-select") in
    let reg_sel = (Dom_html.getElementById_opt "region-select") in
    Option.iter (fun sel ->
      let event = Js.Unsafe.fun_call (Js.Unsafe.js_expr "new Event")
        [|Js.Unsafe.inject (Js.string "change")|] in
      ignore ((Js.Unsafe.coerce sel)##dispatchEvent event)
    ) tz_sel;
    Option.iter (fun sel ->
      let event = Js.Unsafe.fun_call (Js.Unsafe.js_expr "new Event")
        [|Js.Unsafe.inject (Js.string "change")|] in
      ignore ((Js.Unsafe.coerce sel)##dispatchEvent event)
    ) reg_sel
  end

let populate_from_cookies () =
  (match Geo.get_cookie "TZ" with
  | Some tz ->
      let continent = get_continent tz in
      (* Set continent *)
      let%lwt () = populate_and_trigger_select "continent-select" continent in
      
      let%lwt () = Lwt_js.sleep 0.1 in (* Wait for continent change to process *)
      let%lwt () = populate_and_trigger_select "timezone-select" tz in
      
      (* If we have a region, set it *)
      (match Geo.get_cookie "area" with
      | Some area ->
          let%lwt () = Lwt_js.sleep 0.1 in
          let%lwt () = populate_and_trigger_select "region-select" area in
          
          (* If we have a city *)
          (match Geo.get_cookie "city" with
          | Some city when String.length city > 0 ->
              let%lwt () = Lwt_js.sleep 0.1 in
              let cities = get_cities_for_tz_and_region tz area in
              if List.length cities > 20 then begin
                let letter = String.make 1 (Char.uppercase_ascii city.[0]) in
                let%lwt () = populate_and_trigger_select "city-letter-select" letter in
                let%lwt () = Lwt_js.sleep 0.1 in
                let%lwt () = populate_and_trigger_select "city-select" city in
                Lwt.return_unit
              end else begin
                let%lwt () = populate_and_trigger_select "city-select" city in
                Lwt.return_unit
              end
          | _ -> Lwt.return_unit)
      | None -> Lwt.return_unit)
  | None -> Lwt.return_unit)

(* Modify init function to properly populate from cookies *)
let init () =
  let%lwt () = populate_from_cookies () in
  (match Geo.get_cookie "status" with
  | Some "OK" -> Lwt.return_unit
  | _ -> 
      Geo.geo (fun () -> ignore (populate_from_cookies()));
      Lwt.return_unit)
