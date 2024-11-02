
type field = {
mutable field_1 : int;    (* deep-sky object identificator *)
mutable field_2 : float;  (* RA (decimal degrees) *)
mutable field_3 : float;  (* Dec (decimal degrees) *)
mutable field_4 : float;  (* B magnitude *)
mutable field_5 : float;  (* V magnitude *)
mutable field_6 : string; (* Object type (G, GX, GC, OC, NB, PN, DN, RN, C+N, HA, HII, SNR, BN, EN, SA, SC, RG, CL, IG, QSO or empty) *)
mutable field_7 : string; (* Morphological type of object *)
mutable field_8 : float;  (* Major axis size or radius (arcmin) *)
mutable field_9 : float;  (* Minor axis size (arcmin) *)
mutable field_10 : float;  (* Orientation angle (degrees) *)
mutable field_11 : float;  (* Redshift *)
mutable field_12 : float;  (* Error of redshift *)
mutable field_13 : float;  (* Parallax (mas) *)
mutable field_14 : float;  (* Error of parallax (mas) *)
mutable field_15 : float;  (* Non-redshift distance (kpc) *)
mutable field_16 : float;  (* Error of non-redsift distance (kpc) *)
(* Cross-index columns *)
mutable field_17 : int;    (* NGC number (New General Catalogue) *)
mutable field_18 : int;    (* IC number (Index Catalogue) *)
mutable field_19 : int;    (* M number (Messier Catalog) *)
mutable field_20 : int;    (* C number (Caldwell Catalogue) *)
mutable field_21 : int;    (* B number (Barnard Catalogue) *)
mutable field_22 : int;    (* Sh2 number (Sharpless Catalogue) *)
mutable field_23 : int;    (* VdB number (Van den Bergh Catalogue of reflection nebulae) *)
mutable field_24 : int;    (* RCW number (A catalogue of Hα-emission regions in the southern Milky Way) *)
mutable field_25 : int;    (* LDN number (Lynds' Catalogue of Dark Nebulae) *)
mutable field_26 : int;    (* LBN number (Lynds' Catalogue of Bright Nebulae) *)
mutable field_27 : int;    (* Cr number (Collinder Catalogue) *)
mutable field_28 : string; (* Mel number (Melotte Catalogue of Deep Sky Objects) *)
mutable field_29 : string; (* PGC number (HYPERLEDA. I. Catalog of galaxies) *)
mutable field_30 : string; (* UGC number (The Uppsala General Catalogue of Galaxies) *)
mutable field_31 : string; (* Ced number (Cederblad Catalog of bright diffuse Galactic nebulae) *)
mutable field_32 : string; (* Arp number (Atlas of Peculiar Galaxies) *)
mutable field_33 : string; (* VV number (The catalogue of interacting galaxies by Vorontsov-Velyaminov) *)
mutable field_34 : string; (* PK identificator (Catalogue of Galactic Planetary Nebulae) *)
mutable field_35 : string; (* PN G identificator (Strasbourg-ESO Catalogue of Galactic Planetary Nebulae) *)
mutable field_36 : string; (* SNR G identificator (A catalogue of Galactic supernova remnants) *)
mutable field_37 : string; (* ACO number (Rich Clusters of Galaxies by Abell et. al.) *)
mutable field_38 : string; (* HCG identificator (Hickson Compact Group by Hickson P.) *)
mutable field_39 : string; (* ESO identificator (ESO/Uppsala survey of the ESO(B; atlas by Lauberts) *)
mutable field_40 : string; (* VdBH identificator (Van den Bergh and Herbst; Catalogue of southern stars embedded in nebulosity) *)
mutable field_41 : int;    (* DWB number (Catalogue and distances of optically visible H II regions) *)
mutable field_42 : int;    (* Tr number (Trumpler Catalogue) *)
mutable field_43 : int;    (* St number (Stock Catalogue) *)
mutable field_44 : int;    (* Ru number (Ruprecht Catalogue) *)
mutable field_45 : int;    (* VdB-Ha number (van den Bergh-Hagen Catalogue) *)
}

let logfile = open_out "dso_cnv_logfile.txt"

let myfloat_of_string itm' =
  let itm = String.trim itm' in
  match itm.[0] with
    | '0' when String.length itm > 1 -> float_of_string (String.sub itm 1 (String.length itm - 1))
    | _ -> float_of_string itm

let dump' fd field nam =
  output_string fd ("let _ = Hashtbl.add maph \""^nam^"\" "^string_of_int field.field_1^"\n")

let dump fd verbose field nam =
  output_string fd ("let _ = Hashtbl.add dsoh "^string_of_int nam^" ( ") ;
  for ix = 1 to (if verbose then 45 else 18) do match ix with
    | 1 -> output_string fd (string_of_int field.field_1^", ")
    | 2 -> output_string fd (string_of_float field.field_2^", ")
    | 3 -> output_string fd (string_of_float field.field_3^", ")
    | 4 -> output_string fd (string_of_float field.field_4^", ")
    | 5 -> output_string fd (string_of_float field.field_5^", ")
    | 6 -> output_string fd ("\""^field.field_6^"\", ")
    | 7 -> output_string fd ("\""^field.field_7^"\", ")
    | 8 -> output_string fd (string_of_float field.field_8^", ")
    | 9 -> output_string fd (string_of_float field.field_9^", ")
    | 10 -> output_string fd (string_of_float field.field_10^", ")
    | 11 -> output_string fd (string_of_float field.field_11^", ")
    | 12 -> output_string fd (string_of_float field.field_12^", ")
    | 13 -> output_string fd (string_of_float field.field_13^", ")
    | 14 -> output_string fd (string_of_float field.field_14^", ")
    | 15 -> output_string fd (string_of_float field.field_15^", ")
    | 16 -> output_string fd (string_of_float field.field_16^", ")
    | 17 -> output_string fd (string_of_int field.field_17^", ")
    | 18 -> output_string fd (string_of_int field.field_18^", ")
    | 19 -> output_string fd (string_of_int field.field_19^", ")
    | 20 -> output_string fd (string_of_int field.field_20^", ")
    | 21 -> output_string fd (string_of_int field.field_21^", ")
    | 22 -> output_string fd (string_of_int field.field_22^", ")
    | 23 -> output_string fd (string_of_int field.field_23^", ")
    | 24 -> output_string fd (string_of_int field.field_24^", ")
    | 25 -> output_string fd (string_of_int field.field_25^", ")
    | 26 -> output_string fd (string_of_int field.field_26^", ")
    | 27 -> output_string fd (string_of_int field.field_27^", ")
    | 28 -> output_string fd ("\""^field.field_28^"\", ")
    | 29 -> output_string fd ("\""^field.field_29^"\", ")
    | 30 -> output_string fd ("\""^field.field_30^"\", ")
    | 31 -> output_string fd ("\""^field.field_31^"\", ")
    | 32 -> output_string fd ("\""^field.field_32^"\", ")
    | 33 -> output_string fd ("\""^field.field_33^"\", ")
    | 34 -> output_string fd ("\""^field.field_34^"\", ")
    | 35 -> output_string fd ("\""^field.field_35^"\", ")
    | 36 -> output_string fd ("\""^field.field_36^"\", ")
    | 37 -> output_string fd ("\""^field.field_37^"\", ")
    | 38 -> output_string fd ("\""^field.field_38^"\", ")
    | 39 -> output_string fd ("\""^field.field_39^"\", ")
    | 40 -> output_string fd ("\""^field.field_40^"\", ")
    | 41 -> output_string fd (string_of_int field.field_41^", ")
    | 42 -> output_string fd (string_of_int field.field_42^", ")
    | 43 -> output_string fd (string_of_int field.field_43^", ")
    | 44 -> output_string fd (string_of_int field.field_44^", ")
    | 45 -> output_string fd (string_of_int field.field_45^", ")
    | oth -> failwith (string_of_int oth)
    done;
    output_string fd "[";
    if field.field_19 > 0 then output_string fd ("\"M"^string_of_int field.field_19^"\"; ");
    if field.field_17 > 0 then output_string fd ("\"NGC"^string_of_int field.field_17^"\"; ");
    if field.field_18 > 0 then output_string fd ("\"IC"^string_of_int field.field_18^"\"; ");
    if field.field_20 > 0 then output_string fd ("\"C "^string_of_int field.field_20^"\"; ");
    if field.field_21 > 0 then output_string fd ("\"B"^string_of_int field.field_21^"\"; ");
    if field.field_22 > 0 then output_string fd ("\"SH2-"^string_of_int field.field_22^"\"; ");
    if field.field_23 > 0 then output_string fd ("\"VDB"^string_of_int field.field_23^"\"; ");
    if field.field_24 > 0 then output_string fd ("\"RCW"^string_of_int field.field_24^"\"; ");
    if field.field_25 > 0 then output_string fd ("\"LDN"^string_of_int field.field_25^"\"; ");
    if field.field_26 > 0 then output_string fd ("\"LBN"^string_of_int field.field_26^"\"; ");
    if field.field_27 > 0 then output_string fd ("\"CR"^string_of_int field.field_27^"\"; ");
    if field.field_28 <> "0" then output_string fd ("\"MEL"^field.field_28^"\"; ");
    if field.field_29 <> "0" then output_string fd ("\"PGC"^field.field_29^"\"; ");
    if field.field_30 <> "0" then output_string fd ("\"UGC"^field.field_30^"\"; ");
    if field.field_31 <> "0" then output_string fd ("\"CED"^field.field_31^"\"; ");
    if field.field_32 <> "0" then output_string fd ("\"ARP"^field.field_32^"\"; ");
    if field.field_33 <> "0" then output_string fd ("\"VV"^field.field_33^"\"; ");
    if field.field_34 <> "0" then output_string fd ("\"PK"^field.field_34^"\"; ");
    if field.field_35 <> "0" then output_string fd ("\"PNG"^field.field_35^"\"; ");
    if field.field_36 <> "" && field.field_36 <> "0" then output_string fd ("\"SNR"^field.field_36^"\"; ");
    if field.field_37 <> "" && field.field_37 <> "0" then output_string fd ("\"ACO"^field.field_37^"\"; ");
    if field.field_38 <> "" then output_string fd ("\"HCG"^field.field_38^"\"; ");
    if field.field_39 <> "" then output_string fd ("\"ESO"^field.field_39^"\"; ");
    if field.field_40 <> "" then output_string fd ("\"VDBH"^field.field_40^"\"; ");
    if field.field_41 > 0 then output_string fd ("\"DWB"^string_of_int field.field_41^"\"; ");
    if field.field_42 > 0 then output_string fd ("\"TR"^string_of_int field.field_42^"\"; ");
    if field.field_43 > 0 then output_string fd ("\"ST"^string_of_int field.field_43^"\"; ");
    if field.field_44 > 0 then output_string fd ("\"RU"^string_of_int field.field_44^"\"; ");
    if field.field_45 > 0 then output_string fd ("\"VDBHA"^string_of_int field.field_45^"\"; ");
    output_string fd ("\"\"])\n")

let process fd fd' fd'' fd''' lin' =
  let rslt = List.filter (function "" -> false | _ -> true) (String.split_on_char '\t' lin') in
  let field = {field_1=0; field_2=0.; field_3=0.; field_4=0.; field_5=0.; field_6=""; field_7=""; field_8=0.; field_9=0.; field_10=0.;
               field_11=0.; field_12=0.; field_13=0.; field_14=0.; field_15=0.; field_16=0.; field_17=0; field_18=0; field_19=0; field_20=0;
               field_21=0; field_22=0; field_23=0; field_24=0; field_25=0; field_26=0; field_27=0; field_28=""; field_29=""; field_30="";
               field_31=""; field_32=""; field_33=""; field_34=""; field_35=""; field_36=""; field_37=""; field_38=""; field_39=""; field_40="";
               field_41=0; field_42=0; field_43=0; field_44=0; field_45=0} in
  if (List.hd rslt).[0] <> '#' && myfloat_of_string (List.nth rslt 4) < 15. then 
   begin
   List.iteri (fun ix itm -> if false then print_endline ("\""^itm^"\""); match (ix+1) with
    | 1 -> field.field_1 <- int_of_string itm
    | 2 -> field.field_2 <- myfloat_of_string itm
    | 3 -> field.field_3 <- myfloat_of_string itm
    | 4 -> field.field_4 <- myfloat_of_string itm
    | 5 -> field.field_5 <- myfloat_of_string itm
    | 6 -> field.field_6 <-  itm
    | 7 -> field.field_7 <-  itm
    | 8 -> field.field_8 <- myfloat_of_string itm
    | 9 -> field.field_9 <- myfloat_of_string itm
    | 10 -> field.field_10 <- myfloat_of_string itm
    | 11 -> field.field_11 <- myfloat_of_string itm
    | 12 -> field.field_12 <- myfloat_of_string itm
    | 13 -> field.field_13 <- myfloat_of_string itm
    | 14 -> field.field_14 <- myfloat_of_string itm
    | 15 -> field.field_15 <- myfloat_of_string itm
    | 16 -> field.field_16 <- myfloat_of_string itm
    | 17 -> field.field_17 <- int_of_string itm
    | 18 -> field.field_18 <- int_of_string itm
    | 19 -> field.field_19 <- int_of_string itm
    | 20 -> field.field_20 <- int_of_string itm
    | 21 -> field.field_21 <- int_of_string itm
    | 22 -> field.field_22 <- int_of_string itm
    | 23 -> field.field_23 <- int_of_string itm
    | 24 -> field.field_24 <- int_of_string itm
    | 25 -> field.field_25 <- int_of_string itm
    | 26 -> field.field_26 <- int_of_string itm
    | 27 -> field.field_27 <- int_of_string itm
    | 28 -> field.field_28 <-  itm
    | 29 -> field.field_29 <-  itm
    | 30 -> field.field_30 <-  itm
    | 31 -> field.field_31 <-  itm
    | 32 -> field.field_32 <-  itm
    | 33 -> field.field_33 <-  itm
    | 34 -> field.field_34 <-  itm
    | 35 -> field.field_35 <-  itm
    | 36 -> field.field_36 <-  itm
    | 37 -> field.field_37 <-  itm
    | 38 -> field.field_38 <-  itm
    | 39 -> field.field_39 <-  itm
    | 40 -> field.field_40 <-  itm
    | 41 -> field.field_41 <- int_of_string itm
    | 42 -> field.field_42 <- int_of_string itm
    | 43 -> field.field_43 <- int_of_string itm
    | 44 -> field.field_44 <- int_of_string itm
    | 45 -> field.field_45 <- int_of_string itm
    | oth -> failwith (string_of_int oth)
    ) rslt;
   dump fd false field field.field_1;
   dump fd''' true field field.field_1;
   if field.field_17 > 0 then dump' fd'' field ("NGC"^string_of_int field.field_17);
      if field.field_18 > 0 then dump' fd'' field ("IC"^string_of_int field.field_18);
      if field.field_19 > 0 then dump' fd'' field ("M"^string_of_int field.field_19);
      if field.field_20 > 0 then dump' fd' field ("C "^string_of_int field.field_20);
      if field.field_21 > 0 then dump' fd'' field ("B"^string_of_int field.field_21);
      if field.field_22 > 0 then dump' fd' field ("SH2-"^string_of_int field.field_22);
      if field.field_23 > 0 then dump' fd' field ("VDB"^string_of_int field.field_23);
      if field.field_24 > 0 then dump' fd'' field ("RCW"^string_of_int field.field_24);
      if field.field_25 > 0 then dump' fd'' field ("LDN"^string_of_int field.field_25);
      if field.field_26 > 0 then dump' fd'' field ("LBN"^string_of_int field.field_26);
      if field.field_27 > 0 then dump' fd'' field ("CR"^string_of_int field.field_27);
      if field.field_28 <> "0" then dump' fd' field ("MEL"^field.field_28);
      if field.field_29 <> "0" then dump' fd'' field ("PGC"^field.field_29);
      if field.field_30 <> "0" then dump' fd' field ("UGC"^field.field_30);
      if field.field_31 <> "0" then dump' fd' field ("CED"^field.field_31);
      if field.field_32 <> "0" then dump' fd' field ("ARP"^field.field_32);
      if field.field_33 <> "0" then dump' fd' field ("VV"^field.field_33);
      if field.field_34 <> "0" then dump' fd' field ("PK"^field.field_34);
      if field.field_35 <> "0" then dump' fd' field ("PNG"^field.field_35);
      if field.field_36 <> "" && field.field_36 <> "0" then dump' fd' field ("SNR"^field.field_36);
      if field.field_37 <> "" && field.field_37 <> "0" then dump' fd' field ("ACO"^field.field_37);
      if field.field_38 <> "" then dump' fd' field ("HCG"^field.field_38);
      if field.field_39 <> "" then dump' fd' field ("ESO"^field.field_39);
      if field.field_40 <> "" then dump' fd' field ("VDBH"^field.field_40);
      if field.field_41 > 0 then dump' fd' field ("DWB"^string_of_int field.field_41);
      if field.field_42 > 0 then dump' fd' field ("TR"^string_of_int field.field_42);
      if field.field_43 > 0 then dump' fd' field ("ST"^string_of_int field.field_43);
      if field.field_44 > 0 then dump' fd' field ("RU"^string_of_int field.field_44);
      if field.field_45 > 0 then dump' fd' field ("VDBHA"^string_of_int field.field_45);
  end

let _ =
  let fd = open_in "..//stellarium/nebulae/default/catalog.txt" in
  let fd' = ref (open_out "dso.ml") in
  let fd'' = ref (open_out "dsomap0.ml") in
  let fd''' = ref (open_out "dsomap1.ml") in
  let fd'''' = open_out "dso_cnv_logfile.txt" in
  output_string !fd' "let dsoh = Hashtbl.create 255\n";
  output_string !fd'' "open Dsomaph\n";
  output_string !fd''' "open Dsomaph\n";
  (try while true do
    let lin = input_line fd in
    process !fd' !fd'' !fd''' fd'''' lin;
    done with End_of_file -> close_in fd);
  output_string !fd' "let hlen = Hashtbl.length dsoh\n";
  output_string !fd'' "let hlen = Hashtbl.length maph\n";
  output_string !fd''' "let hlen = Hashtbl.length maph\n";
  close_out !fd';
  close_out !fd'';
  close_out !fd''';
  close_out fd''''
