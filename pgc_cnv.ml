type field =
  | Nul
  | Str of string
  | Int of int
  | Flt of float
  | Lst of string list

let fields = [
(   1,  3,"A3    --,          --,     [PCG]");
(   4, 10,"I7    --,          PGC     [1/3099300] PGC number");
(  12, 12,"A1    --,          --,     [J]");
(  13, 14,"I2    h            RAh     Right ascension (J2000)");
(  15, 16,"I2    min          RAm     Right ascension (J2000)");
(  17, 20,"F4.1  s            RAs     Right ascension (J2000)");
(  21, 21,"A1    --,          DE,     Declination sign (J2000)");
(  22, 23,"I2    deg          DEd     Declination (J2000)");
(  24, 25,"I2    arcmin       DEm     Declination (J2000)");
(  26, 27,"I2    arcsec       DEs     Declination (J2000)");
(  29, 30,"A2    --,          OType   [GM ] Object type (1)");
(  32, 36,"A5    --,          MType   Provisional morphological type from LEDA according to the RC2 code.");
(  37, 41,"F5.2 [0.1arcmin]   logD25  ?=9.99 Apparent diameter (2)");
(  42, 44,"A3    --,          --,     [+/-]");
(  45, 48,"F4.2 [0.1arcmin] e_logD25  ?=9.99 Actual error of logD25");
(  51, 54,"F4.2  [---]        logR25  ?=9.99 Axis ratio in log scale (log of major axis to minor axis)");
(  55, 57,"A3    --,          --,     [+/-]");
(  58, 61,"F4.2  [---]      e_logR25  ?=9.99 Actual error on logR25");
(  64, 67,"F4.0  deg          PA      ?=999. Adopted 1950-position angle (3)");
(  68, 70,"A3    --,          --,     [+/-]");
(  71, 74,"F4.0  deg        e_PA      ?=999. rms uncertainty on PA");
(  76, 77,"I2    --,        o_ANames  Number of alternate names.");
(  79,341,"A263  --,          ANames  Alternate names (4)");
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
      | 'F' -> rslt.(ix) <- Flt (float_of_string str)
      | _ -> print_string ("\""^str^"\", ");
    ) fields;
  rslt.(cnt-1) <- Lst (List.filter (function "" -> false | _ -> true) (String.split_on_char ' ' (match rslt.(1),rslt.(cnt-1) with Int n, Str s -> "PGC"^string_of_int n^" "^s | _ -> "")));
  match rslt.(12) with
  | Flt diam when diam > 1.0 && diam <> 9.99 -> 
  incr ocnt;
  let delim' = ref "(" in
  output_string fd "let _ = List.iter (fun itm -> Hashtbl.add pgch itm ";
  Array.iter (function
    | Nul -> ()
    | Str s -> output_string fd (!delim'^"\""^s^"\""); delim' := ", "
    | Int n -> output_string fd (!delim'^string_of_int n); delim' := ", "
    | Flt f -> output_string fd (!delim'^string_of_float f); delim' := ", "
    | Lst l -> let delim = ref ")) [" in
               List.iter (fun itm -> output_string fd (!delim^"\""^itm^"\""); delim := "; ") l;
               output_string fd "]"
    ) rslt;
  output_string fd "\n"
  | _ -> ()

let _ =
  let fd = open_in "../Downloads/table5.dat" in
  let fd' = ref (open_out "pgc0.ml") in
  let cnt = ref 0 and cnt' = ref 0 in
  output_string !fd' "open Pgchash\n";
  (try while true do
    let lin = input_line fd in
    process !fd' cnt lin;
    if !cnt >= 11000 then
      begin
      cnt := 0;
      incr cnt';
      output_string !fd' "let hlen = Hashtbl.length pgch\n";
      close_out !fd';
      fd' := open_out ("pgc"^string_of_int (!cnt')^".ml"); 
      output_string !fd' "open Pgchash\n";
      end
    done with _ -> close_in fd);
  output_string !fd' "let hlen = Hashtbl.length pgch\n";
  close_out !fd';
