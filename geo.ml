open Js_of_ocaml

let geo () =
  if (Geolocation.is_supported()) then
    let geo = Geolocation.geolocation in
    let options = Geolocation.empty_position_options() in
    let () = options##.enableHighAccuracy := true in
    let f_success pos =
      let coords = pos##.coords in
      let latitude' = coords##.latitude in
      let longitude' = coords##.longitude in
      let city' = ref "" in
      let area' = ref "" in
      let tz' = ref "" in
      let dis = ref 90.0 in
      Hashtbl.iter (fun tz lst -> List.iter (fun (city,area,lat,long) ->
                        let dis' = (lat-.latitude')**2. +. (long-.longitude')**2. in
                        if !dis > dis' then (dis := dis'; city' := city; area' := area; tz' := tz)) lst
                        ) Base_locations.loch;
      Cookie.set "latitude" (string_of_float latitude');
      Cookie.set "longitude" (string_of_float longitude');
      Cookie.set "city" !city';
      Cookie.set "area" !area';
      Cookie.set "TZ" !tz';
      Cookie.set "status" "OK"
    in
    let f_error err =
      let code = err##.code in
      let msg = err##.message in
      Cookie.set "status" (match msg with
        | _TIMEOUT -> "timeout"
        | _POSITION_UNAVAILABLE_ -> "unavail"
        | _PERMISSION_DENIED_ -> "denied") in
    ignore (geo##getCurrentPosition (Js.wrap_callback f_success) (Js.wrap_callback f_error) options)
  else Cookie.set "status" "unsupported"
