open Js_of_ocaml
open Js_of_ocaml_tyxml
open Utils

external _myFunction : int -> float = "_myFunction"
external _myFloat : float -> float -> float = "_myFloat"
external _myAscii : int -> float -> unit = "_myAscii"

let jd_start = ref 2451544.5
let jd_stop = ref 2451544.5
let txtdate_start = ref ""
let txtdate_stop = ref ""
let txttime_start = ref ""
let txttime_stop = ref ""
let mybody = ref "Sun"

(* Get current date and tomorrow's date *)
let today = Unix.time()
let tomorrow = today +. 86400.0

let send idx str = _myAscii idx (string_to_float str)
    
let confirm_my_button msg = fun _ ->
  let element = Js_of_ocaml.Dom_html.getElementById msg in
  let _ = _myFloat !jd_start !jd_stop in
  let ra = (_myFunction 3) *. 180. /. Float.pi in
  let dec = (_myFunction 4) *. 180. /. Float.pi in
  let lst_calc = Altaz.local_siderial_time' !(Location.longitude) (!jd_start -. Altaz.jd_2000) in
  let ra_now, dec_now = Altaz.j2000_to_jnow ra dec in
  let alt_calc, az_calc, hour_calc = Altaz.raDectoAltAz ra_now dec_now !(Location.latitude) !(Location.longitude) lst_calc in

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
		  send 0 selected_value;
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
                  let (name, sequence, discoverer) = 
                    List.nth (snd (List.find (fun (year, _) -> year = selected_year) grouped_comets)) selected_index
                  in
                  send 1 name;
                  send 2 sequence;
                  send 3 discoverer;
                  set_static_text element ("Comet selected: "^name^" "^sequence^" "^discoverer);
                  mybody := name^" "^sequence;
                  true
                )
            )
        )
      ]
      []
  in
  
  let output = div ~a:[ a_id "comet-output"; a_style "margin-top: 20px;" ] [] in
  div [ button; year_dropdown; br (); comet_dropdown; br (); output; message_div; select_div ]

(*      
let create_comet_picker () =
  let open Tyxml_js.Html in
  let grouped_comets = group_comets Comets.comets in
  
  let message_div = div ~a:[a_id "comet-message"; a_style "padding-top: 15px; font-size: 16px; color: #333; display: none;"] [txt ""] in
  let select_div = div ~a:[a_id "comet-select"; a_style "padding-top: 15px; font-size: 16px; color: #333; display: none;"] [txt ""] in
  
  let dropdown =
    select
      ~a:[ 
        a_id "comet-dropdown";
        a_onchange (fun ev ->
          Js.Opt.case (ev##.target)
            (fun () -> false)
            (fun target ->
              let select = Dom_html.CoerceTo.select target in
              Js.Opt.case select
                (fun () -> false)
                (fun select ->
                  let selected_index = select##.selectedIndex in
                  let element = Js_of_ocaml.Dom_html.getElementById "comet-select" in
                  let value1,value2,value3 = List.nth Comets.comets selected_index in
                  send 1 value1;
                  send 2 value2;
                  send 3 value3;
                  set_static_text element ("Comet was selected: "^value1^" "^value2^" "^value3);
                  comet := selected_index;
                  true
                )
            )
        )
      ]
      (List.flatten (
        List.map (fun (year, year_comets) ->
          (* Add a disabled option for the year as a group header *)
          let year_header = 
            option 
              ~a:[a_value year; a_disabled ()] 
              (txt ("--- " ^ year ^ " ---")) 
          in
          
          (* Create options for each comet in the year *)
          let comet_options = 
            List.map 
              (fun (name, sequence, discoverer) -> 
                option 
                  ~a:[a_value (name^" "^sequence^" "^discoverer)] 
                  (txt (name ^ " " ^ sequence ^ " (" ^ discoverer ^ ")"))
              ) 
              year_comets
          in
          
          year_header :: comet_options
        ) grouped_comets
      ))
  in
  
  let output = div ~a:[ a_id "comet-output"; a_style "margin-top: 20px;" ] [] in
  div [ dropdown; br (); output; message_div; select_div ]      
  *)

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

(* Previous helper functions remain the same *)

(* Tab configuration type *)
type tab_config = {
  id: string;
  label: string;
  description: string;  (* New field for hover description *)
  content: Html_types.div Tyxml_js.Html.elt;
}

let switch_tab tab_id =
  let headers = Dom_html.document##getElementsByClassName (Js.string "3d-card-index-tab") in
  let contents = Dom_html.document##getElementsByClassName (Js.string "3d-card-index-content") in
  
  for i = 0 to headers##.length - 1 do
    let header = headers##item i in
    let content = contents##item i in
    match Js.Opt.to_option header, Js.Opt.to_option content with
    | Some h, Some c ->
        if Js.to_string h##.id = (tab_id ^ "-tab") then begin
          h##.style##.transform := Js.string "rotateX(-5deg)";
          Js.Unsafe.set (h##.style) (Js.string "boxShadow") (Js.string "0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23)");
          h##.style##.backgroundColor := Js.string "white";
          h##.style##.zIndex := Js.string "10";
          c##.style##.display := Js.string "block"
        end else begin
          h##.style##.transform := Js.string "rotateX(0deg) translateY(15px)";
          Js.Unsafe.set (h##.style) (Js.string "boxShadow") (Js.string "0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24)");
          h##.style##.backgroundColor := Js.string "#f0f0f0";
          h##.style##.zIndex := Js.string "1";
          c##.style##.display := Js.string "none"
        end
    | _ -> ()
  done;
  send 0 !mybody; (* make sure body not empty *)  
  true

let create_tab_headers tabs =
  let open Tyxml_js.Html in
  let base_style = 
    "padding: 10px 15px; margin-right: 5px; " ^
    "border: 1px solid #ddd; " ^
    "border-bottom: none; " ^
    "border-radius: 8px 8px 0 0; " ^
    "transition: all 0.3s cubic-bezier(.25,.8,.25,1); " ^
    "position: relative;"
  in
  div ~a:[
    a_class ["3d-card-index-headers"]; 
    a_style "display: flex; perspective: 1000px; margin-bottom: -1px;"
  ] (
    List.mapi (fun index tab ->
      let is_first = (index = 0) in
      button ~a:[
        a_class ["3d-card-index-tab"; if is_first then "active" else ""];
        a_id (tab.id ^ "-tab");
        a_onclick (fun _ -> switch_tab tab.id);
        a_style (base_style ^ 
                 (if is_first then 
                   "transform: rotateX(-5deg);" ^
                   "box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);" ^
                   "background-color: white;"
                 else 
                   "transform: rotateX(0deg) translateY(" ^ string_of_int ((index + 1) * 5) ^ "px);" ^
                   "box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);" ^
                   "background-color: #f0f0f0;") ^
                 (* Tooltip styles embedded in the button's style *)
                 "position: relative;" ^
                 "group");
        a_onmouseover (fun _ ->
          let tooltip = Js_of_ocaml.Dom_html.getElementById (tab.id ^ "-tooltip") in
          tooltip##.style##.display := Js.string "block";
          true
        );
        a_onmouseout (fun _ ->
          let tooltip = Js_of_ocaml.Dom_html.getElementById (tab.id ^ "-tooltip") in
          tooltip##.style##.display := Js.string "none";
          true
        )
      ] [txt tab.label];
    ) tabs @
    (* Create separate tooltip divs *)
    List.mapi (fun index tab ->
      div ~a:[
        a_id (tab.id ^ "-tooltip");
        a_style ("display: none; " ^
                 "position: absolute; " ^
                 "bottom: 100%; " ^
                 "left: 50%; " ^
                 "transform: translateX(-50%); " ^
                 "background-color: #333; " ^
                 "color: white; " ^
                 "padding: 5px 10px; " ^
                 "border-radius: 4px; " ^
                 "z-index: 10; " ^
                 "white-space: nowrap;")
      ] [txt tab.description]
    ) tabs
  )

let create_tab_container () =
  let open Tyxml_js.Html in
  let tabs = [
    { 
      id = "location"; 
      label = "Location"; 
      description = "Select and pick the nearest city";
      content = Location.create_location_picker (); 
      };
    { 
      id = "date"; 
      label = "Date"; 
      description = "Select and pick a specific date";
      content = create_date_picker (); 
      };
    { 
      id = "planets"; 
      label = "Planets"; 
      description = "Planet picker";
      content = create_planet_picker (); 
    };
    { 
      id = "comets"; 
      label = "Comets"; 
      description = "Comet picker";
      content = create_comet_picker (); 
    };
    { 
      id = "color"; 
      label = "Color"; 
      description = "Pick a color from the palette";
      content = create_color_picker (); 
    }
  ] in
  
  let tab_headers = create_tab_headers tabs in
  let tab_contents = 
    div ~a:[
      a_class ["3d-card-index-contents"]; 
      a_style ("border: 2px solid #ddd; " ^
              "padding: 20px; " ^
              "background-color: white;" ^
              "box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);" ^
              "transform: translateY(-10px);")
    ] (
      List.mapi (fun index tab ->
        div ~a:[
          a_class ["3d-card-index-content"; if index = 0 then "active" else ""];
          a_id (tab.id ^ "-content");
          a_style (if index = 0 then "" else "display: none;")
        ] [tab.content]
      ) tabs
    )
  in
  div [tab_headers; tab_contents]
    
let create_ui () =
  let open Tyxml_js.Html in
  div ~a:[a_style "max-width: 600px; margin: 0 auto; padding: 20px;"] [
    create_tab_container ();
    br ();
    Table_update.table_element;
    div ~a:[a_id "output"; a_style "margin-top: 20px; padding: 10px; background-color: #f9f9f9;"] []
  ]

let () =
  let root = Dom_html.getElementById "app" in
  Dom.appendChild root (Tyxml_js.To_dom.of_div (create_ui ()));

  (* we need to update the julian dates with the dialog defaults (now and 24 hours time) *)
  let _ = handle_julian_date txtdate_start jd_start (format_date today) in
  let _ = handle_julian_time txttime_start jd_start (format_time today) in
  let _ = handle_julian_date txtdate_stop jd_stop (format_date tomorrow) in
  let _ = handle_julian_time txttime_stop jd_stop (format_time tomorrow) in
  ()
