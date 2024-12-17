open Js_of_ocaml
open Dom_html

(* SVG namespace *)
let svg_ns = "http://www.w3.org/2000/svg"

(* Create SVG element with namespace *)
let create_svg_element name =
  document##createElementNS (string svg_ns) (string name)

(* Convert degrees to radians *)
let to_radians deg =
  deg *. Float.pi /. 180.

(* Create the Alt/Az display *)
let create_alt_az_display parent_id =
  let size = 160 in
  let center = size / 2 in
  let radius = (size / 2) - 10 in
  
  (* Create main SVG element *)
  let svg = create_svg_element "svg" in
  svg##.setAttribute (string "width") (string (string_of_int size));
  svg##.setAttribute (string "height") (string (string_of_int size));
  svg##.setAttribute (string "class") (string "bg-black rounded");
  
  (* Create base circle *)
  let circle = create_svg_element "circle" in
  circle##.setAttribute (string "cx") (string (string_of_int center));
  circle##.setAttribute (string "cy") (string (string_of_int center));
  circle##.setAttribute (string "r") (string (string_of_int radius));
  circle##.setAttribute (string "stroke") (string "#4a5568");
  circle##.setAttribute (string "stroke-width") (string "2");
  circle##.setAttribute (string "fill") (string "none");
  Dom.appendChild svg circle;
  
  (* Create cross lines *)
  let create_line x1 y1 x2 y2 =
    let line = create_svg_element "line" in
    line##.setAttribute (string "x1") (string (string_of_int x1));
    line##.setAttribute (string "y1") (string (string_of_int y1));
    line##.setAttribute (string "x2") (string (string_of_int x2));
    line##.setAttribute (string "y2") (string (string_of_int y2));
    line##.setAttribute (string "stroke") (string "#4a5568");
    line##.setAttribute (string "stroke-width") (string "2");
    Dom.appendChild svg line in
  
  create_line center (center - radius) center (center + radius);
  create_line (center - radius) center (center + radius) center;
  
  (* Create cardinal points *)
  let directions = [("N", 0); ("E", 90); ("S", 180); ("W", 270)] in
  List.iter (fun (dir, angle) ->
    let text = create_svg_element "text" in
    let rad = to_radians (float_of_int angle) in
    let x = float_of_int center +. (float_of_int (radius + 8)) *. sin rad in
    let y = float_of_int center -. (float_of_int (radius + 8)) *. cos rad in
    text##.setAttribute (string "x") (string (string_of_float x));
    text##.setAttribute (string "y") (string (string_of_float y));
    text##.setAttribute (string "text-anchor") (string "middle");
    text##.setAttribute (string "dominant-baseline") (string "middle");
    text##.setAttribute (string "fill") (string "#a0aec0");
    text##.setAttribute (string "font-size") (string "12");
    text##.textContent := string dir;
    Dom.appendChild svg text
  ) directions;
  
  (* Create position indicator (will be updated) *)
  let position_dot = create_svg_element "circle" in
  position_dot##.setAttribute (string "r") (string "3");
  position_dot##.setAttribute (string "fill") (string "#63b3ed");
  Dom.appendChild svg position_dot;
  
  (* Create position text (will be updated) *)
  let position_text = create_svg_element "text" in
  position_text##.setAttribute (string "x") (string (string_of_int center));
  position_text##.setAttribute (string "y") (string (string_of_int (size - 8)));
  position_text##.setAttribute (string "text-anchor") (string "middle");
  position_text##.setAttribute (string "fill") (string "#a0aec0");
  position_text##.setAttribute (string "font-size") (string "12");
  position_text##.setAttribute (string "font-family") (string "monospace");
  Dom.appendChild svg position_text;
  
  (* Add to parent *)
  let parent = Js.Opt.get (document##getElementById (string parent_id))
    (fun () -> failwith "Parent element not found") in
  Dom.appendChild parent svg;
  
  (* Return update function *)
  fun ~altitude ~azimuth ->
    let rad_az = to_radians azimuth in
    let rad_alt = to_radians altitude in
    let x = float_of_int center +. float_of_int radius *. sin rad_az in
    let y = float_of_int center -. float_of_int radius *. cos rad_az *. sin rad_alt in
    
    position_dot##.setAttribute (string "cx") (string (string_of_float x));
    position_dot##.setAttribute (string "cy") (string (string_of_float y));
    position_text##.textContent := string (Printf.sprintf "%.1f° / %.1f°" altitude azimuth)

(* Usage example *)
let () =
  let update_position = create_alt_az_display "control-window" in
  
  (* Example: Update every second with new values *)
  let _ = window##setInterval (Js.wrap_callback (fun () ->
    (* Replace with actual telescope position values *)
    update_position ~altitude:45.0 ~azimuth:180.0
  )) 1000 in
  ()
