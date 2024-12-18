open Js_of_ocaml
open Js_of_ocaml_tyxml
open Tyxml_js.Html

let create_target_selector () =
  let category_section = div ~a:[
    a_class ["section"; "mb-6"]; 
    a_style "padding: 15px; background: #f8f9fa; border-radius: 8px;"
  ] [
    h3 ~a:[a_class ["text-lg"; "font-bold"; "mb-4"]] [txt "Select Category"];
    
    div ~a:[a_class ["category-buttons"; "space-y-2"]] [
      (* First set of radio buttons for main categories *)
      div [
        input ~a:[
          a_input_type `Radio; 
          a_name "category";
          a_value "messier";
          a_class ["category-button"];
          a_onclick (fun _ -> true)
        ] ();
        label [txt " Messier"]
      ];
      
      div [
        input ~a:[
          a_input_type `Radio;
          a_name "category";  
          a_value "ngc2000";
          a_class ["category-button"];
          a_onclick (fun _ -> true)
        ] ();
        label [txt " NGC2000"]
      ];
      
      div [
        input ~a:[
          a_input_type `Radio;
          a_name "category";
          a_value "caldwell";
          a_class ["category-button"]; 
          a_onclick (fun _ -> true)
        ] ();
        label [txt " Caldwell"]
      ];

      (* Added new options *)
      div [
        input ~a:[
          a_input_type `Radio;
          a_name "category";
          a_value "simbad";
          a_class ["category-button"];
          a_onclick (fun _ -> true)
        ] ();
        label [txt " SIMBAD Database"]
      ];

      div [
        input ~a:[
          a_input_type `Radio;
          a_name "category";
          a_value "horizons";
          a_class ["category-button"];
          a_onclick (fun _ -> true)
        ] ();
        label [txt " JPL Horizons"]
      ]
    ]
  ] in

  let search_section = div ~a:[a_class ["search-section"; "mb-6"]] [
    div ~a:[a_class ["flex"; "gap-2"]] [
      input ~a:[
        a_id "target-search";
        a_input_type `Text;
        a_placeholder "Enter target name...";
        a_class ["flex-1"; "p-2"; "border"; "rounded"];
        a_onkeyup (fun ev ->
          if ev##.keyCode = 13 then begin
            let search_input = Dom_html.getElementById "target-search" in
            Js.Opt.iter (Dom_html.CoerceTo.input search_input) (fun input ->
              let search_term = Js.to_string input##.value in
              (* Get selected category *)
              let category_buttons = Dom_html.document##getElementsByName (Js.string "category") in
              let selected_category = ref None in
              for i = 0 to category_buttons##.length - 1 do
                Js.Opt.iter (category_buttons##item(i)) (fun button ->
                  let input = Dom_html.CoerceTo.input button in
                  Js.Opt.iter input (fun input ->
                    if Js.to_bool input##.checked then
                      selected_category := Some (Js.to_string input##.value)
                  )
                )
              done;
              
              (* Execute appropriate search based on category *)
              (match !selected_category with
              | Some "messier" -> ignore (Messier_catalogue.messier' ())
              | Some "ngc2000" -> ignore (Ngc2000.ngc2000' ())
              | Some "simbad" -> 
                  !Astro_utils.set_target_value search_term;
                  ignore (Simbad.simbad' ())
              | Some "horizons" ->
                  !Astro_utils.set_target_value search_term;
                  ignore (Astro_utils.horizons' ())
              | _ -> ())
            );
            true
          end else true
        )
      ] ();
      
      button ~a:[
        a_class ["px-4"; "py-2"; "bg-blue-500"; "text-white"; "rounded"; "hover:bg-blue-600"];
        a_onclick (fun _ ->
          let search_input = Dom_html.getElementById "target-search" in
          Js.Opt.iter (Dom_html.CoerceTo.input search_input) (fun input ->
            let search_term = Js.to_string input##.value in
            let selected_category = ref None in
            let category_buttons = Dom_html.document##getElementsByName (Js.string "category") in
            for i = 0 to category_buttons##.length - 1 do
              Js.Opt.iter (category_buttons##item(i)) (fun button ->
                let input = Dom_html.CoerceTo.input button in
                Js.Opt.iter input (fun input ->
                  if Js.to_bool input##.checked then
                    selected_category := Some (Js.to_string input##.value)
                )
              )
            done;
            
            match !selected_category with
            | Some "messier" -> ignore (Messier_catalogue.messier' ())
            | Some "ngc2000" -> ignore (Ngc2000.ngc2000' ())
            | Some "simbad" -> 
                !Astro_utils.set_target_value search_term;
                ignore (Simbad.simbad' ())
            | Some "horizons" ->
                !Astro_utils.set_target_value search_term;
                ignore (Astro_utils.horizons' ())
            | _ -> ()
          );
          true
        )
      ] [txt "Search"]
    ]
  ] in

  let message_div = div ~a:[
    a_id "target-message";
    a_style "padding-top: 15px; font-size: 16px; color: #333; display: none;"
  ] [txt ""] in

  let select_div = div ~a:[
    a_id "target-select";
    a_style "padding-top: 15px; font-size: 16px; color: #333; display: none;"
  ] [txt ""] in

  div ~a:[a_class ["target-selector"; "p-4"]] [
    category_section;
    search_section;
    message_div;
    select_div
  ]
