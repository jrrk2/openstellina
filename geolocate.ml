open Js_of_ocaml
open Js_of_ocaml_lwt
open Js_of_ocaml_tyxml
open Tyxml_js.Html

let city = ref ""
let region = ref ""
let latitude = ref 0.0
let longitude = ref 0.0

module Geo = struct
  let set_cookie key value =
    let cookie_options = {|; SameSite=Lax; path=/; max-age=31536000|} in (* 1 year expiry *)
    Dom_html.document##.cookie := Js.string (Printf.sprintf "%s=%s%s" key value cookie_options)

  let get_cookie key =
    let cookies = Js.to_string Dom_html.document##.cookie in
    let cookie_list = String.split_on_char ';' cookies |> List.map String.trim in
    try 
      let cookie = List.find (fun s -> String.starts_with ~prefix:(key ^ "=") s) cookie_list in
      Some (String.sub cookie (String.length key + 1) (String.length cookie - String.length key - 1))
    with Not_found -> None

  (* UI Update Functions *)
  let update_ui city area tz lat long =
    Option.iter (fun container ->
      container##.innerHTML := Js.string (Printf.sprintf
        {|<div class="location-found">
           <p class="status-ok">Location found!</p>
           <p>City: %s</p>
           <p>Area: %s</p>
           <p>Time Zone: %s</p>
           <p class="coordinates">(%f, %f)</p>
         </div>|}
        city area tz lat long))
      (Dom_html.getElementById_opt "location-info")

  let update_error_ui status =
    Option.iter (fun container ->
      let message = match status with
        | "denied" -> "Location access denied"
        | "unavail" -> "Location unavailable"
        | "timeout" -> "Request timed out"
        | "unsupported" -> "Geolocation not supported"
        | _ -> "Error getting location"
      in
      container##.innerHTML := Js.string (Printf.sprintf
        {|<div class="location-error">
           <p class="status-error">%s</p>
         </div>|}
        message))
      (Dom_html.getElementById_opt "location-info")

  let geo () =
    if (Geolocation.is_supported()) then
      let success pos =
        let coords = pos##.coords in
        let latitude' = coords##.latitude in
        let longitude' = coords##.longitude in
        let city' = ref "" in
        let area' = ref "" in
        let tz' = ref "" in
        let dis = ref 90.0 in
        
        Hashtbl.iter (fun tz lst -> 
          List.iter (fun (city,area,lat,long) ->
            let dis' = (lat-.latitude')**2. +. (long-.longitude')**2. in
            if !dis > dis' then (
              dis := dis';
              city' := city;
              area' := area;
              tz' := tz
            )
          ) lst
        ) Base_locations.loch;
        
        set_cookie "latitude" (string_of_float latitude');
        set_cookie "longitude" (string_of_float longitude');
        set_cookie "city" !city';
        set_cookie "area" !area';
        set_cookie "TZ" !tz';
        set_cookie "status" "OK";
        
        update_ui !city' !area' !tz' latitude' longitude'
      in
      
      let error err =
        let status = 
          if err##._PERMISSION_DENIED_ = err##.code then "denied"
          else if err##._POSITION_UNAVAILABLE_ = err##.code then "unavail"
          else if err##._TIMEOUT = err##.code then "timeout"
          else "error"
        in
        set_cookie "status" status;
        update_error_ui status
      in

      let options = Geolocation.empty_position_options() in
      options##.enableHighAccuracy := true;
      options##.timeout := 5000;
      options##.maximumAge := 0;
      
      Geolocation.geolocation##getCurrentPosition 
        (Js.wrap_callback success)
        (Js.wrap_callback error)
        options
    else (
      set_cookie "status" "unsupported";
      update_error_ui "unsupported"
    )
end

let create_location_picker () =
  div ~a:[a_class ["location-panel"]] [
    div ~a:[a_class ["section-title"]] [txt "Location Settings"];
    
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
          Geo.geo ();
          true)
      ] [txt "Detect Location"]
    ];
    
    (* Manual location section *)
    div ~a:[
      a_class ["location-section"];
      a_style "margin-top: 20px;"
    ] [
      div ~a:[a_class ["section-subtitle"]] [txt "Manual Location"];
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
                Geo.update_ui "" "" "" lat_float long_float
              with _ -> ()
            ) (Dom_html.getElementById_opt "manual-longitude")
          ) (Dom_html.getElementById_opt "manual-latitude");
          true)
      ] [txt "Set Location"]
    ]
  ]

(* Initialize application *)
let init () =
  Geo.geo ()

let () = 
  Dom_html.window##.onload := Dom_html.handler (fun _ ->
    init ();
    Js._false)
