open Js_of_ocaml
open Js_of_ocaml_tyxml
open Utils
open Geolocate
open Astro_utils

let jd_start = ref 2451544.5
let jd_stop = ref 2451544.5
let txtdate_start = ref ""
let txtdate_stop = ref ""
let txttime_start = ref ""
let txttime_stop = ref ""
let mybody = ref "Sun"
let name = ref ""
let sequence = ref ""
let discoverer = ref ""

(* Get current date and tomorrow's date *)
let today = Unix.time()
let tomorrow = today +. 86400.0
    
let confirm_my_button msg = fun _ ->
  let element = Js_of_ocaml.Dom_html.getElementById msg in
  let ra, dec, mag = ephem !name !sequence !discoverer !jd_start in
  let lst_calc = Altaz.local_siderial_time' (longitude()) (!jd_start -. Altaz.jd_2000) in
  let ra_now, dec_now = Altaz.j2000_to_jnow ra dec in
  let alt_calc, az_calc, hour_calc = Altaz.raDectoAltAz ra_now dec_now (latitude()) (longitude()) lst_calc in

  Table_update.append_table_row 
(*
 ~index:0
 *)
    ~date_ut:(!txtdate_start^" "^ !txttime_start)
    ~date_jdut:(Printf.sprintf "%10.3f" !jd_start) 
    ~ra:(Altaz.hms_of_float (ra)) 
    ~dec:(Altaz.dms_of_float (dec)) 
    ~azi:(Altaz.dms_of_float (az_calc))
    ~elev:(Altaz.dms_of_float (alt_calc))
    ~l_ap_sid_time:(Altaz.dms_of_float (lst_calc)) ();
(*  
  set_static_text element (!mybody^
			 ": RA="^
			 Altaz.hms_of_float (ra)^
			 ", DEC="^
			 Altaz.dms_of_float (dec));
*)  
  true

let create_planet_picker () =
  let open Tyxml_js.Html in
  let message_div = div ~a:[a_id "planets-message"; a_style "padding-top: 15px; font-size: 16px; color: #333; display: none;"] [txt ""] in
  let select_div = div ~a:[a_id "planets-select"; a_style "padding-top: 15px; font-size: 16px; color: #333; display: none;"] [txt ""] in
  let button = button ~a:[ a_id "my-button"; a_onclick (confirm_my_button "planets-message") ] [ txt "Find Major body" ] in
  let input = input ~a:[ a_id "my-input"; a_placeholder "Type here" ; a_oninput (fun _ -> true) ] () in
  let dropdown =
    select
      ~a:[ 
        a_id "my-dropdown";
        a_onchange (fun ev ->
          Js.Opt.case (ev##.target)
            (fun () -> false)
            (fun target ->
              let select = Dom_html.CoerceTo.select target in
              Js.Opt.case select
                (fun () -> false)
                (fun select ->
                  let selected_value = Js.to_string (select##.value) in
		  let element = Js_of_ocaml.Dom_html.getElementById "planets-select" in
		  name := selected_value;
		  sequence := "";
		  discoverer := "";
		  set_static_text element ("Body selected: "^selected_value);
		  mybody := selected_value;
                  true
                )
            )
        )
      ]
      (List.map
         (fun opt -> option ~a:[ a_value opt ] (txt opt))
         ["Sun";"Moon";"Mercury";"Venus";"Earth";"Mars";"Jupiter";"Saturn";"Uranus";"Neptune"])
  in
  let output = div ~a:[ a_id "output"; a_style "margin-top: 20px;" ] [] in
  div [ button; br (); input; br (); dropdown; br (); output; message_div; select_div ]

let group_comets comets =
  List.fold_right (fun (name, sequence, discoverer) acc ->
    let year = String.sub name 2 4 in
    let current_year_group = 
      try List.assoc year acc 
      with Not_found -> [] 
    in
    let updated_acc = List.remove_assoc year acc in
    (year, (name, sequence, discoverer)::current_year_group)::updated_acc
  ) comets []  

let create_comet_picker () =
  let open Tyxml_js.Html in
  let grouped_comets = group_comets Comets.comets in
  
  let message_div = div ~a:[a_id "comet-message"; a_style "padding-top: 15px; font-size: 16px; color: #333; display: none;"] [txt ""] in
  let select_div = div ~a:[a_id "comet-select"; a_style "padding-top: 15px; font-size: 16px; color: #333; display: none;"] [txt ""] in
  let button = button ~a:[ a_id "comet-button"; a_onclick (confirm_my_button "comet-message") ] [ txt "Find Comet" ] in

  let year_dropdown =
    select
      ~a:[ 
        a_id "comet-year-dropdown";
        a_onchange (fun ev ->
          Js.Opt.case (ev##.target)
            (fun () -> false)
            (fun target ->
              let select = Dom_html.CoerceTo.select target in
              Js.Opt.case select
                (fun () -> false)
                (fun select ->
                  let selected_year = Js.to_string (select##.value) in
                  let comet_dropdown = Js_of_ocaml.Dom_html.getElementById "comet-specific-dropdown" in
                  let comet_options = 
                    List.find (fun (year, _) -> year = selected_year) grouped_comets 
                    |> snd 
                    |> List.mapi (fun idx (name, sequence, discoverer) -> 
                      option 
                        ~a:[a_value (string_of_int idx)] 
                        (txt (name ^ " " ^ sequence ^ " (" ^ discoverer ^ ")"))
                    )
                  in
                  
                  (* Clear existing options *)
                  Js.Opt.iter (comet_dropdown##.firstChild) (fun child ->
                    let _ = comet_dropdown##removeChild child in
                    ()
                  );
                  
                  (* Add new options *)
                  List.iter (fun opt -> 
                    let dom_opt = Tyxml_js.To_dom.of_option opt in
                    Dom.appendChild comet_dropdown dom_opt
                  ) comet_options;
                  
                  (* Show comet dropdown *)
                  comet_dropdown##.style##.display := Js.string "block";
                  
                  true
                )
            )
        )
      ]
      (List.map 
        (fun (year, _) -> 
          option 
            ~a:[a_value year] 
            (txt year)
        ) 
        grouped_comets)
  in
  
  let comet_dropdown =
    select
      ~a:[ 
        a_id "comet-specific-dropdown";
        a_style "display: none;";
        a_onchange (fun ev ->
          Js.Opt.case (ev##.target)
            (fun () -> false)
            (fun target ->
              let select = Dom_html.CoerceTo.select target in
              Js.Opt.case select
                (fun () -> false)
                (fun select ->
                  let selected_index = int_of_string (Js.to_string (select##.value)) in
                  let element = Js_of_ocaml.Dom_html.getElementById "comet-select" in
		  let selected_year =
		    let select_element = Js_of_ocaml.Dom_html.getElementById "comet-year-dropdown" in
		    Js.Opt.case (Dom_html.CoerceTo.select select_element)
		    ( fun () -> "")  (* Handle the case where the element is not a select *)
		    ( fun select -> Js.to_string select##.value) in
                  let (name', sequence', discoverer') = 
                    List.nth (snd (List.find (fun (year, _) -> year = selected_year) grouped_comets)) selected_index
                    in
		    name := name';
		    sequence := sequence';
		    discoverer := discoverer';
                  set_static_text element ("Comet selected: "^name'^" "^sequence'^" "^discoverer');
                  mybody := name'^" "^sequence';
                  true
                )
            )
        )
      ]
      []
  in
  
  let output = div ~a:[ a_id "comet-output"; a_style "margin-top: 20px;" ] [] in
  div [ button; year_dropdown; br (); comet_dropdown; br (); output; message_div; select_div ]

let handle_julian_date txtdate jd selected_date =
	  let yr,mon,dy = Scanf.sscanf selected_date "%d-%d-%d" (fun yr mon dy -> yr,mon,dy) in
          let element = Js_of_ocaml.Dom_html.getElementById "date-message" in
	  let jd_frac = !jd -. 0.5 -. floor (!jd -. 0.5) in
	  txtdate := selected_date;
	  jd := Altaz.computeTheJulianDay true yr mon dy +. jd_frac;
	  if !jd < !jd_start then jd_start := !jd;
	  if !jd > !jd_stop then jd_stop := !jd;
          set_static_text element ("Julian Date Start: "^string_of_float !jd_start^", Stop: "^ string_of_float !jd_stop);
          true

let handle_julian_time txttime jd selected_time =          
	  let hr,min = Scanf.sscanf selected_time "%d:%d" (fun hr min -> hr,min) in
          let element = Js_of_ocaml.Dom_html.getElementById "date-message" in
	  txttime := selected_time;
	  jd := floor (!jd -. 0.5) +. 0.5 +. float_of_int(hr*3600+min*60) /. 86400.0;
	  if !jd < !jd_start then jd_start := !jd;
	  if !jd > !jd_stop then jd_stop := !jd;
          set_static_text element ("Julian Date Start: "^string_of_float !jd_start^", Stop: "^ string_of_float !jd_stop);
          true

let handle_startend_date_change txtdate jd ev =
  Js.Opt.case (ev##.target)
    (fun () -> false)
    (fun target ->
      let input = Dom_html.CoerceTo.input target in
      Js.Opt.case input
        (fun () -> false)
        (fun input -> handle_julian_date txtdate jd (Js.to_string (input##.value)))
    )

let handle_startend_time_change txttime jd ev =
  Js.Opt.case (ev##.target)
    (fun () -> false)
    (fun target ->
      let input = Dom_html.CoerceTo.input target in
      Js.Opt.case input
        (fun () -> false)
        (fun input -> handle_julian_time txttime jd (Js.to_string (input##.value)))
    )

let create_date_picker () =
  let open Tyxml_js.Html in
  let message_div = div ~a:[a_id "date-message"; a_style "padding-top: 15px; font-size: 16px; color: #333; display: none;"] [txt ""] in

  let start_date_label = label ~a:[a_label_for "start-date-picker"] [txt "Start Date: "] in
  let start_date_input = input ~a:[
    a_id "start-date-picker"; 
    a_input_type `Date;
    a_value (format_date today);  (* Set default to current date *)
    a_oninput (handle_startend_date_change txtdate_start jd_start)
  ] () in
  
  let start_time_label = label ~a:[a_label_for "start-time-picker"] [txt "Start Time: "] in
  let start_time_input = input ~a:[
    a_id "start-time-picker"; 
    a_input_type `Time;
    a_value (format_time today);  (* Set default to current date *)
    a_oninput (handle_startend_time_change txttime_start jd_start)
  ] () in
  
  let end_date_label = label ~a:[a_label_for "end-date-picker"] [txt "End Date: "] in
  let end_date_input = input ~a:[
    a_id "end-date-picker"; 
    a_input_type `Date;
    a_value (format_date tomorrow);  (* Set default to current date *)
   a_oninput (handle_startend_date_change txtdate_stop jd_stop)
  ] () in
  
  let end_time_label = label ~a:[a_label_for "end-time-picker"] [txt "End Time: "] in
  let end_time_input = input ~a:[
    a_id "end-time-picker"; 
    a_input_type `Time;
    a_value (format_time tomorrow);  (* Set default to current date *)
    a_oninput (handle_startend_time_change txttime_stop jd_stop)
  ] () in
  
  div [
    start_date_label; br (); start_date_input; 
    br (); 
    start_time_label; br (); start_time_input;
    br (); 
    end_date_label; br (); end_date_input; 
    br (); 
    end_time_label; br (); end_time_input;
  message_div
  ]

let tz_local () =
    let dummy = (Js.Unsafe.obj [||]) in
    let intl = Js.Unsafe.global##.Intl in
    let date = intl##DateTimeFormat(dummy) in
    let options = date##resolvedOptions(dummy) in
    let tz = options##.timeZone in
    Js.to_string tz

let create_color_picker () =
  let open Tyxml_js.Html in
  let label = label ~a:[a_label_for "color-picker"] [txt "Pick a color: "] in
  let input = input ~a:[a_id "color-picker"; a_input_type `Color] () in
  div [label; br (); input]
