type field =
  | Nul
  | Str of string
  | Int of int
  | Flt of float
  | Lst of string list

let fields = [
(   1,  4, "I4      ---      ACO      [1,2712]+ \"Abell\" number");
(   7,  8, "I2      h        RAh      right ascension (hours)   (B1950)");
(  10, 13, "F4.1    min      RAm      [0,60.0] right ascension (minutes)");
(  15, 15, "A1      ---      DE-      declination sign");
(  16, 17, "I2      deg      DEd      declination (degrees)     (B1950)");
(  19, 20, "I2      arcmin   DEm      [0,60.0] declination (minutes)");
(  43, 49, "A7      ---      BMtype   [- I:] cluster classification in the Bautz-Morgan system");
(  53, 55, "I3      ct       Count    [0,] number of cluster members between m3 and m3+2, corrected for background");
(  87, 88, "I2      h        RA2000h  right ascension (hours)   (J2000)");
(  90, 93, "F4.1    min      RA2000m  [0,60.0] right ascension (minutes)");
(  95, 95, "A1      ---      DE2000-  declination sign");
(  96, 97, "I2      deg      DE2000d  declination (degrees)     (J2000)");
(  99,100, "I2      arcmin   DE2000m  [0,60.0] declination (minutes)");
( 109,111, "I3      mm       Xpos     rectangular coordinates of the apparent cluster center, referred to the south-east (lower left) edge of the Palomar Sky Survey prints (x coordinate)");
( 114,116, "I3      mm       Ypos     same with above (y coordinate)");
( 119,124, "F6.2    deg      GLON     galactic longitude l2");
( 126,131, "F6.2    deg      GLAT     galactic latitude b2");
( 134,138, "F5.4    ---      z        ? cluster redshift from Struble and Rood (1987ApJS...63..555S)");
( 141,141, "I1      ---      Rich     richness, from Abell (1958ApJS....3..211A)");
( 143,143, "I1      ---      Dclass   distance class, from Abell (1958)");
( 145,148, "F4.1    mag      m10      red magnitude of the tenth brightest cluster member, from Abell (1958)");
];;

let process fd ocnt lin' =
  let cnt = List.length fields in
  let lin = lin' ^ String.init 341 (fun _ -> ' ') in
  let rslt = Array.init cnt (fun _ -> Nul) in
  List.iteri (fun ix (lft,rght,desc) ->
    let str = String.trim (String.sub lin (lft-1) (rght-lft+1)) in
    match desc.[0] with
      | 'A' -> rslt.(ix) <- Str str
      | 'I' -> rslt.(ix) <- Int (int_of_string str)
      | 'F' -> rslt.(ix) <- Flt (try float_of_string str with _ -> 0.0)
      | _ -> print_string ("\""^str^"\", ");
    ) fields;
  incr ocnt;
  let delim' = ref (match rslt.(0) with Int n -> "\"ACO"^string_of_int n^"\" (" | _ -> "(") in
  output_string fd "let _ = Hashtbl.add abellh " ;
  Array.iter (function
    | Nul -> ()
    | Str s -> output_string fd (!delim'^"\""^s^"\""); delim' := ", "
    | Int n -> output_string fd (!delim'^string_of_int n); delim' := ", "
    | Flt f -> output_string fd (!delim'^string_of_float f); delim' := ", "
    | Lst l -> let delim = ref ")) [" in
               List.iter (fun itm -> output_string fd (!delim^"\""^itm^"\""); delim := "; ") [List.hd l];
               output_string fd "]"
    ) rslt;
  output_string fd ")\n"

let _ =
  let fd = open_in "../abell_catalogue/table3.dat" in
  let fd' = ref (open_out "abell0.ml") in
  let cnt = ref 0 in
  output_string !fd' "let abellh = Hashtbl.create 255\n";
  (try while true do
    let lin = input_line fd in
    process !fd' cnt lin;
    done with End_of_file -> close_in fd);
  output_string !fd' "let hlen = Hashtbl.length abellh\n";
  close_out !fd';
