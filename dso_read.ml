open Astro_utils

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
let dsoh = Hashtbl.create 65535
let maph = Hashtbl.create 65535

let myfloat_of_string itm' =
  let itm = String.trim itm' in
  match itm.[0] with
    | '0' when String.length itm > 1 -> float_of_string (String.sub itm 1 (String.length itm - 1))
    | _ -> float_of_string itm

let dump' field nam =
  Hashtbl.add maph nam (string_of_int field.field_1)

let dump field nam =
  Hashtbl.add dsoh (string_of_int nam) ( string_of_int field.field_1,
    (field.field_2),
    (field.field_3),
    (field.field_4),
    (field.field_5),
    (field.field_6),
    (field.field_7),
    (field.field_8),
    (field.field_9),
    (field.field_10),
    (field.field_11),
    (field.field_12),
    (field.field_13),
    (field.field_14),
    (field.field_15),
    (field.field_16),
    (string_of_int field.field_17),
    (string_of_int field.field_18), (
    if field.field_19 > 0 then  ["M"^string_of_int field.field_19] else [] @
    if field.field_17 > 0 then  ["NGC"^string_of_int field.field_17] else [] @
    if field.field_18 > 0 then  ["IC"^string_of_int field.field_18] else [] @
    if field.field_20 > 0 then  ["C "^string_of_int field.field_20] else [] @
    if field.field_21 > 0 then  ["B"^string_of_int field.field_21] else [] @
    if field.field_22 > 0 then  ["SH2-"^string_of_int field.field_22] else [] @
    if field.field_23 > 0 then  ["VDB"^string_of_int field.field_23] else [] @
    if field.field_24 > 0 then  ["RCW"^string_of_int field.field_24] else [] @
    if field.field_25 > 0 then  ["LDN"^string_of_int field.field_25] else [] @
    if field.field_26 > 0 then  ["LBN"^string_of_int field.field_26] else [] @
    if field.field_27 > 0 then  ["CR"^string_of_int field.field_27] else [] @
    if field.field_28 <> "0" then  ["MEL"^field.field_28] else [] @
    if field.field_29 <> "0" then  ["PGC"^field.field_29] else [] @
    if field.field_30 <> "0" then  ["UGC"^field.field_30] else [] @
    if field.field_31 <> "0" then  ["CED"^field.field_31] else [] @
    if field.field_32 <> "0" then  ["ARP"^field.field_32] else [] @
    if field.field_33 <> "0" then  ["VV"^field.field_33] else [] @
    if field.field_34 <> "0" then  ["PK"^field.field_34] else [] @
    if field.field_35 <> "0" then  ["PNG"^field.field_35] else [] @
    if field.field_36 <> "" && field.field_36 <> "0" then  ["SNR"^field.field_36] else [] @
    if field.field_37 <> "" && field.field_37 <> "0" then  ["ACO"^field.field_37] else [] @
    if field.field_38 <> "" then  ["HCG"^field.field_38] else [] @
    if field.field_39 <> "" then  ["ESO"^field.field_39] else [] @
    if field.field_40 <> "" then  ["VDBH"^field.field_40] else [] @
    if field.field_41 > 0 then  ["DWB"^string_of_int field.field_41] else [] @
    if field.field_42 > 0 then  ["TR"^string_of_int field.field_42] else [] @
    if field.field_43 > 0 then  ["ST"^string_of_int field.field_43] else [] @
    if field.field_44 > 0 then  ["RU"^string_of_int field.field_44] else [] @
    if field.field_45 > 0 then  ["VDBHA"^string_of_int field.field_45] else []))

let process lin' =
  let rslt = List.filter (function "" -> false | _ -> true) (String.split_on_char '\t' lin') in
  let field = {field_1=0; field_2=0.; field_3=0.; field_4=0.; field_5=0.; field_6=""; field_7=""; field_8=0.; field_9=0.; field_10=0.;
               field_11=0.; field_12=0.; field_13=0.; field_14=0.; field_15=0.; field_16=0.; field_17=0; field_18=0; field_19=0; field_20=0;
               field_21=0; field_22=0; field_23=0; field_24=0; field_25=0; field_26=0; field_27=0; field_28=""; field_29=""; field_30="";
               field_31=""; field_32=""; field_33=""; field_34=""; field_35=""; field_36=""; field_37=""; field_38=""; field_39=""; field_40="";
               field_41=0; field_42=0; field_43=0; field_44=0; field_45=0} in
  if (List.hd rslt).[0] <> '#' && myfloat_of_string (List.nth rslt 4) < 15. then 
   begin
   List.iteri (fun ix itm -> match (ix+1) with
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
   dump field field.field_1;
   dump field field.field_1;
   if field.field_17 > 0 then dump' field ("NGC"^string_of_int field.field_17);
      if field.field_18 > 0 then dump' field ("IC"^string_of_int field.field_18);
      if field.field_19 > 0 then dump' field ("M"^string_of_int field.field_19);
      if field.field_20 > 0 then dump' field ("C "^string_of_int field.field_20);
      if field.field_21 > 0 then dump' field ("B"^string_of_int field.field_21);
      if field.field_22 > 0 then dump' field ("SH2-"^string_of_int field.field_22);
      if field.field_23 > 0 then dump' field ("VDB"^string_of_int field.field_23);
      if field.field_24 > 0 then dump' field ("RCW"^string_of_int field.field_24);
      if field.field_25 > 0 then dump' field ("LDN"^string_of_int field.field_25);
      if field.field_26 > 0 then dump' field ("LBN"^string_of_int field.field_26);
      if field.field_27 > 0 then dump' field ("CR"^string_of_int field.field_27);
      if field.field_28 <> "0" then dump' field ("MEL"^field.field_28);
      if field.field_29 <> "0" then dump' field ("PGC"^field.field_29);
      if field.field_30 <> "0" then dump' field ("UGC"^field.field_30);
      if field.field_31 <> "0" then dump' field ("CED"^field.field_31);
      if field.field_32 <> "0" then dump' field ("ARP"^field.field_32);
      if field.field_33 <> "0" then dump' field ("VV"^field.field_33);
      if field.field_34 <> "0" then dump' field ("PK"^field.field_34);
      if field.field_35 <> "0" then dump' field ("PNG"^field.field_35);
      if field.field_36 <> "" && field.field_36 <> "0" then dump' field ("SNR"^field.field_36);
      if field.field_37 <> "" && field.field_37 <> "0" then dump' field ("ACO"^field.field_37);
      if field.field_38 <> "" then dump' field ("HCG"^field.field_38);
      if field.field_39 <> "" then dump' field ("ESO"^field.field_39);
      if field.field_40 <> "" then dump' field ("VDBH"^field.field_40);
      if field.field_41 > 0 then dump' field ("DWB"^string_of_int field.field_41);
      if field.field_42 > 0 then dump' field ("TR"^string_of_int field.field_42);
      if field.field_43 > 0 then dump' field ("ST"^string_of_int field.field_43);
      if field.field_44 > 0 then dump' field ("RU"^string_of_int field.field_44);
      if field.field_45 > 0 then dump' field ("VDBHA"^string_of_int field.field_45);
  end

let cache () =
  let fil = "catalog.txt" in
  !set_debug_value ("Cache "^fil);
  let fd = open_in fil in
  !set_debug_value ("Opened "^fil);
  (try while true do
    let lin = input_line fd in
    process lin;
    done with End_of_file -> close_in fd);
  print_endline ("dsoh items = "^string_of_int (Hashtbl.length dsoh));
  print_endline ("maph items = "^string_of_int (Hashtbl.length maph));
  ()

(* Merged DSO catalogue from Stellarium *)

let dso' () = 
    let dso = (targ_entry'()) in
    !set_debug_value ("Search "^dso);
    if Hashtbl.length maph = 0 then cache();
    !set_debug_value ("Search "^string_of_int (Hashtbl.length maph));
    match Hashtbl.find_opt maph dso with
    | Some ix ->
    (try (let (num,ra_flt,dec_flt,magb,mag,typ,morph,major,minor,orient,redshift,eredshift,parallax,eparallax,dist,edist,_,_,id) = Hashtbl.find dsoh ix in
    print_endline (string_of_float ra_flt^" : "^string_of_float dec_flt^": "^ List.hd id);
    ignore (num,magb,typ,morph,major,minor,orient,redshift,eredshift,parallax,eparallax,dist,edist);
    targ_status_set_text ("DSO found: " ^ List.hd id);
    let yr,mon,dy,hr,min,sec = split_date() in
    let latitude = latitude() in
    let longitude = longitude() in
    let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
    show_entries (List.hd id) jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc nan ra_flt dec_flt nan nan nan mag nan major;
    print_endline ("Focus: "^List.hd id);
    stellarium_focus (List.hd id))
    with _ ->
    targ_status_set_text ("DSO: " ^ dso ^ ": not found");
    show_entries " " nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan;
    Lwt.return_unit)
    | None ->
    targ_status_set_text ("DSO: " ^ dso ^ ": not found");
    show_entries " " nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan;
    Lwt.return_unit
