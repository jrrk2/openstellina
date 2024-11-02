open Cookie
open Cohttp
open Cohttp_lwt_jsoo
open Altaz
open Lwt.Infix

let authref' = ref "TBD"

let send_preflight_options_request uri callback =
  let headers = Header.init () in
  Client.call `OPTIONS uri ~headers >>= ( fun (resp, body) ->
  let hdrs = Cohttp.Header.to_list (Response.headers resp) in
  body |> Cohttp_lwt.Body.to_string >|= fun body -> callback body hdrs )

type sel' =
| Challenge
| Id
| Bootcnt
| Sid
| Auth

type env' =
| Latitude
| Longitude
| Exposure
| Spare1
| Spare2

let verbose = ref true
let verbose_flag = ref true

let ephem_data_lst = ref []

let set_target_value = ref (fun (x:string) -> ())
let get_target_value = ref (fun () -> "")
let set_ra_value_gui = ref (fun x -> ())
let set_dec_value_gui = ref (fun x -> ())
let set_status_value = ref (fun x -> ())
let set_debug_value = ref (fun x -> ())

let sel' = function
| Challenge -> 0
| Id -> 1
| Bootcnt -> 2
| Sid -> 3
| Auth -> 4

let env' = function
| Latitude -> 0
| Longitude -> 1
| Exposure -> 2
| Spare1 -> 3
| Spare2 -> 4

let set_dialog_value' = ref (fun (sel:sel') (x:string) -> ())
let set_dialog_value (sel:sel') x = !set_dialog_value' sel x

let set_environ_value' = ref (fun (env:env') (x:string) -> ())
let set_environ_value (env:env') x = !set_environ_value' env x

let split = List.map (fun itm -> let ix = String.index itm ':' in (String.sub itm 0 ix, String.sub itm (ix+2) (String.length itm - ix - 2)))

let get' proto server params headers pth f hdrs =
  let pth' = proto^server^pth in
  if !verbose then !set_debug_value pth';
  let uri' = Uri.of_string pth' in
  let uri = Uri.with_uri ~query:(Some (List.map (fun (a,b) -> a,[b]) params)) uri' in
  Client.get uri
    ~headers:(Cohttp.Header.of_list headers)
  >>= ( fun (resp,body) -> hdrs := Cohttp.Header.to_list (Response.headers resp);
  body |> Cohttp_lwt.Body.to_string >|= fun body -> f body )

let post' proto server params headers pth form f =
  let pth' = proto^server^pth in
  if !verbose then print_endline pth';
  if !verbose then List.iter (fun (k,x) -> print_endline (k^"="^x)) params;
  if !verbose then print_endline form;
  if !verbose then List.iter (fun (k,x) -> print_endline (k^": "^x)) headers;
  let hdrs = ref [] in
  let uri' = Uri.of_string pth' in
  let uri = Uri.with_uri ~query:(Some (List.map (fun (a,b) -> a,[b]) params)) uri' in
  Client.post uri
    ~body:(Cohttp_lwt.Body.of_string form)
    ~headers:(Cohttp.Header.of_list headers)
    ~chunked:(false)
  >>= ( fun (resp,body) -> hdrs := Cohttp.Header.to_list (Response.headers resp);
  let%lwt body_content = Cohttp_lwt.Body.to_string body in
  let result = f body_content in
  Lwt.return result
   )

let tmpdir = (Filename.get_temp_dir_name ())^"/"

let gain_int () = 200
(* hardwired until we get cookies going *)
let datum () = Unix.gettimeofday()
let update_date yr mon dy hr min sec = ()
let entry_darkcnt'() = "1"
let entry_alt'() = "0 0 0"
let entry_az'() = "0 0 0"
let entry_nam'() = let target = !get_target_value() in !set_debug_value target; target
let entry_gridw'() = "1"
let entry_gridh'() = "1"
let entry_numi'() = "1"
let entry_nump'() = "1"
let entry_wminov'() = "1"
let entry_hminov'() = "1"
let entry_wpassof'() = "1"
let entry_hpassof'() = "1"

let entry_ra_ref = ref ""
let entry_dec_ref = ref ""
let entry_exp_ref = ref ""
let entry_lat_ref = ref ""
let entry_long_ref = ref ""
let expos_flt () = try float_of_string !entry_exp_ref with _ -> 10.0
let expos_us () = int_of_float (1.0e6 *. expos_flt())
let entry_ra'() = !entry_ra_ref
let entry_dec'() = !entry_dec_ref
let entry_exp_set_text nam =
  entry_exp_ref := nam;
  set_environ_value Exposure ("Exposure " ^ mystring_of_float (expos_flt()))
let entry_nam_set_text nam = ()
let entry_ra_set_text x =
  entry_ra_ref := x;
  !set_ra_value_gui ("RA "^x)
let entry_dec_set_text x =
  entry_dec_ref := x;
  !set_dec_value_gui ("DEC "^x)
let entry_alt_ref = ref ""
let entry_alt_set_text nam = entry_alt_ref := nam
let entry_alt'() = !entry_alt_ref
let entry_az_ref = ref ""
let entry_az_set_text nam = entry_az_ref := nam
let entry_az'() = !entry_az_ref
let entry_mag_set_text nam = ()
let entry_ang_set_text nam = ()
let entry_darkcnt_set_text nam = ()
let targ_status_set_text = !set_status_value
let targ_entry_set_text nam = ()
let targ_entry'() = !get_target_value()
let ephem_set_active hr = ()
let tbuffer_set_text txt = ()
let tbuffer_insert ~tag_names txt = ()
let tbuffer_bounds'() = (0,99)
let tbuffer_apply_tag_by_name nam ~start ~stop = ()

let tim_6_set_text txt = ()
let tim_7_set_text txt = ()

let split_date () =
    let tm = Unix.gmtime (datum()) in
    tm.tm_year+1900,tm.tm_mon+1,tm.tm_mday,tm.tm_hour,tm.tm_min,tm.tm_sec

let show_entries nam jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc jd ra dec azi elev sidt apmag hour_ang ang_diam =
    if nam <> "" then entry_nam_set_text nam;
    entry_ra_set_text (hms_of_float ra);
    entry_dec_set_text (dms_of_float dec);
    entry_alt_set_text (dms_of_float (alt_calc));
    entry_az_set_text (dms_of_float (az_calc));
    entry_mag_set_text (Printf.sprintf "%.2f" apmag);
    entry_ang_set_text (Printf.sprintf "%.2f" ang_diam);
    ()

let simbad_cnv = function
    | Xml.Element
   ("VOTABLE",
    [("xmlns", "http://www.ivoa.net/xml/VOTable/v1.2");
     ("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
     ("xsi:schemaLocation",
      "http://www.ivoa.net/xml/VOTable/v1.2 http://www.ivoa.net/xml/VOTable/v1.2");
     ("version", "1.2")],
    [Xml.Element
      ("DEFINITIONS", [],
       [Xml.Element
         ("COOSYS",
          [("ID", "COOSYS"); ("equinox", "2000"); ("epoch", "J2000");
           ("system", "ICRS")],
          [])]);
     Xml.Element
      ("RESOURCE", [("name", "Simbad query"); ("type", "results")],
       [Xml.Element
         ("TABLE", [("ID", "simbad"); ("name", "simbad query")],
          [Xml.Element
            ("DESCRIPTION", [], [Xml.PCData "... query string ..."]);
           Xml.Element
            ("FIELD",
             [("ID", "MAIN_ID"); ("name", "MAIN_ID"); ("datatype", "char");
              ("width", "22"); ("ucd", "meta.id;meta.main");
              ("arraysize", "*")],
             [Xml.Element
               ("DESCRIPTION", [],
                [Xml.PCData "Main identifier for an object"]);
              Xml.Element
               ("LINK",
                [("value", "${MAIN_ID}");
                 ("href",
                  "http://simbad.u-strasbg.fr/simbad/sim-id?Ident=${MAIN_ID}&amp;NbIdent=1")],
                [])]);
           Xml.Element
            ("FIELD",
             [("ID", "RA"); ("name", "RA"); ("datatype", "char");
              ("precision", "8"); ("width", "13");
              ("ucd", "pos.eq.ra;meta.main"); ("arraysize", "13");
              ("unit", "&quot;h:m:s&quot;")],
             [Xml.Element ("DESCRIPTION", [], [Xml.PCData "Right ascension"])]);
           Xml.Element
            ("FIELD",
             [("ID", "DEC"); ("name", "DEC"); ("datatype", "char");
              ("precision", "8"); ("width", "13");
              ("ucd", "pos.eq.dec;meta.main"); ("arraysize", "13");
              ("unit", "&quot;d:m:s&quot;")],
             [Xml.Element ("DESCRIPTION", [], [Xml.PCData "Declination"])]);
           Xml.Element
              ("FIELD",
               [("ID", "FLUX_V"); ("name", "FLUX_V"); ("datatype", "float");
                ("ucd", "phot.mag;em.opt.V"); ("unit", "mag")],
               [Xml.Element ("DESCRIPTION", [], [Xml.PCData "Magnitude V"])]);
             Xml.Element
              ("FIELD",
               [("ID", "FLUX_UNIT_mag"); ("name", "FLUX_UNIT_mag");
                ("datatype", "char"); ("width", "3");
                ("ucd", "meta.unit;phot.flux")],
               [Xml.Element ("DESCRIPTION", [], [Xml.PCData "flux unit"])]);
             Xml.Element
            ("DATA", [],
             [Xml.Element
               ("TABLEDATA", [],
                [Xml.Element
                  ("TR", [],
                   [Xml.Element ("TD", [], [Xml.PCData ident]);
                    Xml.Element ("TD", [], [Xml.PCData ra]);
                    Xml.Element ("TD", [], [Xml.PCData dec]);
                    Xml.Element ("TD", [], [Xml.PCData mag]);
                    Xml.Element ("TD", [], [])])])])])])]) ->
    !set_debug_value (ident);
    let latitude = latitude() in
    let longitude = longitude() in
    let yr,mon,dy,hr,min,sec = split_date() in
    let ra_flt = cnv_ra ra in
    let dec_flt = cnv_dec dec in
    !set_ra_value_gui (string_of_float ra_flt);
    !set_dec_value_gui (string_of_float dec_flt);
    let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
    show_entries ident jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc nan ra_flt dec_flt nan nan nan (float_of_string mag) nan nan;
    targ_status_set_text ("SIMBAD found: "^ident)
| Xml.Element
     ("VOTABLE",
      [("xmlns", "http://www.ivoa.net/xml/VOTable/v1.2");
       ("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
       ("xsi:schemaLocation",
        "http://www.ivoa.net/xml/VOTable/v1.2 http://www.ivoa.net/xml/VOTable/v1.2");
       ("version", "1.2")],
      [Xml.Element
        ("INFO",
         [("name", "Error");
          ("value", errmsg)],
         [])]) ->
    !set_status_value errmsg;
entry_ra_set_text "";
entry_dec_set_text "";
entry_alt_set_text "";
entry_az_set_text "";
targ_status_set_text (errmsg)
| _ -> !set_status_value "simbad XML error"

let simbad' () =
    let hdrs = ref [] in
    let server =  "simbad.u-strasbg.fr" in
    let pth = "/simbad/sim-id" in
    let target = targ_entry'() in
    !set_debug_value ("simbad called: "^target);
    let params = [ ("output.format", "VOTABLE"); ("output.params", "main_id,ra,dec,flux(V),flux_unit(mag)"); ("Ident", target) ] in
    let dbg rslt s =
              if false then !set_debug_value "simbad returned";
              let dbgfile = tmpdir^target^".xml" in
              !set_status_value (rslt^": "^dbgfile);
              let fd = open_out dbgfile in
              output_string fd s;
              close_out fd in

    let f = (fun s -> simbad_cnv (
                                 !set_status_value "simbad_cnv called";
                                  let m = XmlParser.make() in
                                      XmlParser.prove m false;
                                      try
                                        let rslt = XmlParser.parse m (SString s) in
                                        dbg "succeeded" s;
                                        rslt
                                      with _ ->
                                      dbg "failed" s;
                                      failwith "Xml.parse_string")) in
    get' "http://" server params [] pth f hdrs

type attr =
  {
    mutable target: string;
    mutable ra: float;
    mutable dec: float;
    mutable ra_hms: string;
    mutable dec_dms: string;
    mutable ranow: float;
    mutable decnow: float;
    mutable ranow_hms: string;
    mutable decnow_dms: string;
    mutable alt: float;
    mutable az: float;
    mutable alt_dms: string;
    mutable az_dms: string;
    mutable rise: float;
    mutable transit: float;
    mutable set: float;
    mutable rise_hms: string;
    mutable transit_hms: string;
    mutable set_hms: string;
    mutable vis_mag: float;
    mutable sidt: float;
    mutable hour_ang: float;
    logfile: out_channel;
  }

let stellarium_enabled_active() = true

let rec descend' attr = function
| ("raJ2000", `Float f) -> attr.ra <- f; attr.ra_hms <- hms_of_float f
| ("decJ2000", `Float f) -> attr.dec <- f; attr.dec_dms <- dms_of_float f
| ("ra", `Float f) -> attr.ranow <- f; attr.ranow_hms <- hms_of_float f
| ("dec", `Float f) -> attr.decnow <- f; attr.decnow_dms <- dms_of_float f
| ("altitude", `Float f) -> attr.alt <- f; attr.alt_dms <- dms_of_float f
| ("azimuth", `Float f) -> attr.az <- f; attr.az_dms <- dms_of_float f
| ("rise-dhr", `Float f) -> attr.rise <- f; attr.rise_hms <- dms_of_float f
| ("transit-dhr", `Float f) -> attr.transit <- f; attr.transit_hms <- dms_of_float f
| ("set-dhr", `Float f) -> attr.set <- f; attr.set_hms <- dms_of_float f
| ("vmag", `Float f) -> attr.vis_mag <- f
| ("hourAngle-hms", `String s) -> attr.hour_ang <- mod_ha (cnv_hms s /. 15.)
| ("rise", `String _) -> ()
| ("set", `String _) -> ()
| ("appSidTm", `String s) -> attr.sidt <- cnv_hms s /. 15.
| (str, `Bool b) -> output_string attr.logfile (str^": "^string_of_bool b^"\n"); flush attr.logfile
| (str, `Float f) -> output_string attr.logfile (str^": "^string_of_float f^"\n"); flush attr.logfile
| (str, `Int n) -> output_string attr.logfile (str^": "^string_of_int n^"\n"); flush attr.logfile
| (str, `List lst) -> output_string attr.logfile (str^":\n"); List.iter (descend attr) lst; flush attr.logfile
| (str, `Null) -> output_string attr.logfile (str^": Null\n"); flush attr.logfile
| (str, `String s) -> output_string attr.logfile (str^": \""^s^"\"\n"); flush attr.logfile
| (str, `Assoc lst) -> output_string attr.logfile (str^":\n"); List.iter (descend' attr) lst; flush attr.logfile

and descend attr = function
| `Assoc lst -> List.iter (descend' attr) lst
| `List lst -> List.iter (descend attr) lst
| `Null
| `String _
| `Bool _
| `Float _
| `Int _ -> failwith "descend"

let debug attr =
    Printf.printf "target=%s: ra_hms=%s, dec_dms=%s\nalt_hms=%s, az_hms=%s\nrise_hms=%s, transit_hms=%s, set_hms=%s\n"
        attr.target
        attr.ra_hms attr.dec_dms
        attr.alt_dms attr.az_dms
        attr.rise_hms attr.transit_hms attr.set_hms;
    flush stdout

let stellarium' attr cb =
    let headers = split 
   ["Content-Type: application/json";
    "Accept: application/json"] in
    let server =  "127.0.0.1:8090" in
    let pth = "/api/objects/info" in
    let req = [("name", attr.target); ("format", "json")] in
    let hdrs = ref [] in
    get' "http://" server req headers pth cb hdrs

let focus resp target =
    let headers = split 
   ["Content-Type: application/json";
    "Accept: application/json"] in
    let server =  "127.0.0.1:8090" in
    let pth = "/api/main/focus" in
    let cb = "{}" in
    let params = [ ("target", target); ("mode", "center") ] in (* notice: American spelling *)
    let f = (fun s -> resp s) in
    post' "http://" server params headers pth cb f

(* only for testing
let stellarium attr =
  let f = (fun s -> descend attr (Yojson.Basic.from_string s); debug attr) in
  let _ = Lwt_main.run (stellarium' attr f) in
  attr
 *)

let attr logfile nam = {target=nam;
ra=0.; dec=0.; ra_hms=""; dec_dms="";
ranow=0.; decnow=0.; ranow_hms=""; decnow_dms="";
alt=0.; az=0.; alt_dms=""; az_dms="";
rise=0.; transit=0.; set=0.; rise_hms=""; transit_hms=""; set_hms=""; vis_mag=0.0;
sidt=0.0; hour_ang=0.0; logfile=logfile
 }

let cnv' iter = fun s -> let lst = fun s ->
    let l = String.split_on_char '\n' s in
    if!verbose_flag then List.iter (fun s ->
                   if s <> "{\"success\":true,\"result\":{\"message\":\"buffer is empty\"}}" then 
                     print_endline s) l;
    l in
    List.iter iter (lst s)

let focus_resp s =
  print_endline ("focus response: "^s);
  targ_status_set_text (if bool_of_string s then "Stellarium focussed" else "Stellarium not focussed")

let stellarium_focus sel = if stellarium_enabled_active() then
    begin
    print_endline "Focus ...";
    focus focus_resp sel
    end
    else Lwt.return_unit

let setfocus' () =
  let txt = String.trim (if String.contains (entry_nam'()) '+' then String.sub (entry_nam'()) 0 (String.index (entry_nam'()) '+') else (entry_nam'())) in
  stellarium_focus txt

let stellarium_logfile = open_out (tmpdir^"stellarium_logfile.txt")

let stellarium' () = if stellarium_enabled_active() then
    let sattr = ref (attr stellarium_logfile (targ_entry'())) in
    let debug (attr:attr) =
      let latitude = latitude() in
      let longitude = longitude() in
      let yr,mon,dy,hr,min,sec = split_date() in
      let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = altaz_calc yr mon dy hr min sec attr.ra attr.dec latitude longitude in
      show_entries attr.target jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc 0.0 attr.ra attr.dec attr.az attr.alt attr.sidt attr.vis_mag attr.hour_ang nan;
      targ_status_set_text ("Stellarium: "^attr.target) in
    let f = (fun s -> match s.[0] with '{' -> descend !sattr (Yojson.Basic.from_string s); debug !sattr | _ -> targ_status_set_text s ) in
    stellarium' !sattr (cnv' f)
    else Lwt.return_unit

let messier' () = 
    let sel = (targ_entry'()) in
    let len = Array.length Messier_catalogue.messier_array in
    let ix = ref (try int_of_string (String.sub sel 1 (String.length sel - 1)) with _ -> 0) in
    if sel.[0] <> 'M' || !ix = 0 || !ix > len then Array.iteri (fun i (a,_,_,_) -> if sel = a then ix := i+1) Messier_catalogue.messier_array;
    let (found,ra,dec,mag) = if !ix = 0 || !ix > len
    then (targ_status_set_text ("Messier: " ^ sel ^ ": not found"); ("","","",""))
    else (let (found,b,c,d) = Messier_catalogue.messier_array.(!ix - 1) in targ_status_set_text ("Messier found: " ^ found); (found,b,c,d)) in
    let latitude = latitude() in
    let longitude = longitude() in
    let ra_flt = cnv_ra ra in
    let dec_flt = cnv_dec dec in
    let mag = float_of_string mag in
    let yr,mon,dy,hr,min,sec = split_date() in
    let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
    show_entries found jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc nan ra_flt dec_flt nan nan nan mag nan nan;
    Lwt.return_unit

let ngc2000' () = 
    let sel = (targ_entry'()) in
    if Hashtbl.length Ngc2000.ngchash = 0 then Ngc2000.cache();
    (
    try (let (ra_flt,dec_flt,cnst,diam,mag,desc) = Hashtbl.find Ngc2000.ngchash sel in
    print_endline (string_of_float ra_flt^" : "^string_of_float dec_flt);
    targ_status_set_text ("NGC2000 found: " ^ sel);
    let yr,mon,dy,hr,min,sec = split_date() in
    let latitude = latitude() in
    let longitude = longitude() in
    let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
    ignore (cnst,diam,mag,desc);
    show_entries sel jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc nan ra_flt dec_flt nan nan nan mag nan nan);
    print_endline ("Focus: "^sel);
    stellarium_focus sel
    with _ ->
    targ_status_set_text ("NGC2000: " ^ sel ^ ": not found");
    show_entries " " nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan;
    Lwt.return_unit)

(*
Principal Galaxy cataloogue, biggest 25000 items out of ~1M

("PGC", 4750, "J", 1, 19, 24.2, "+", 12, 26, 49, "GM", "Sd", 1.01, "+/-", 0.07, 0.27, "+/-", 0.06, 116., "+/-", 4., 8)
*)

(*
let pgc' () = 
    let sel = (targ_entry'()) in
    (
    print_endline ("Search PGC for "^sel);
    if Hashtbl.length Pgc_cnv.pgch = 0 then Pgc_cnv.cache();
    try (match Hashtbl.find Pgc_cnv.pgch sel with
    |  _ :: _ :: _ :: rh :: rm :: rs :: decs :: dd :: dm :: ds :: _ :: _ :: a :: _ :: _ :: _ :: _ :: _ :: _ :: _ :: _ :: _ :: _ ->
    let a = float_of_string a in
    let mag = 20.0/.(a *. a) in
    let ra_flt = float_of_string rh *. 15.0 +. float_of_string rm /. 4.0 +. float_of_string rs /. 240.0 in
    let dec_flt = float_of_string dd +. float_of_string dm /. 60.0 +. float_of_string ds /. 3600.0 in
    let dec_flt = if decs.[0] = '-' then -. dec_flt else dec_flt in
    print_endline (string_of_float ra_flt^" : "^string_of_float dec_flt);
    targ_status_set_text ("PGC found: " ^ sel);
    let yr,mon,dy,hr,min,sec = split_date() in
    let latitude = latitude() in
    let longitude = longitude() in
    let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
    show_entries sel jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc nan ra_flt dec_flt nan nan nan mag nan a
    | _ ->
    targ_status_set_text ("PGC: " ^ sel ^ ": not found");
    show_entries " " nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan);
    print_endline ("Focus: "^sel);
    stellarium_focus sel
    with _ ->
    targ_status_set_text ("PGC: " ^ sel ^ ": not found");
    show_entries " " nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan;
    Lwt.return_unit)
*)

(* Abell catalogue of multiple galaxy clusters *)

let abell' () = 
    let sel = (targ_entry'()) in
    if Hashtbl.length Abell_cnv.abellh = 0 then Abell_cnv.cache();
    (
    print_endline ("Search "^string_of_int (Hashtbl.length Abell_cnv.abellh)^" for "^sel);
try (match Hashtbl.find Abell_cnv.abellh sel with 
  | (aco :: rah :: ram :: des :: ded :: dem :: bmtype :: count :: ra2000h :: ra2000m :: de2000s :: de2000d :: de2000m :: xpos :: ypos :: glon :: glat :: redshift :: rich :: dclass :: m10 :: []) ->
    let mag = nan in
    let ra_flt = float_of_string ra2000h *. 15.0 +. float_of_string ra2000m /. 4.0 in
    let dec_flt = float_of_string de2000d +. float_of_string de2000m /. 60.0 in
    let dec_flt = if de2000s.[0] = '-' then -. dec_flt else dec_flt in
    print_endline (string_of_float ra_flt^" : "^string_of_float dec_flt);
    ignore (aco,rah,ram,des,ded,dem,bmtype,count,xpos,ypos,glon,glat,redshift,rich,dclass,m10);
    targ_status_set_text ("Abell found: " ^ sel);
    let yr,mon,dy,hr,min,sec = split_date() in
    let latitude = latitude() in
    let longitude = longitude() in
    let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
    show_entries sel jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc nan ra_flt dec_flt nan nan nan mag nan nan
  | _ -> 
    targ_status_set_text ("Abell: " ^ sel ^ ": not found");
    show_entries " " nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan);
    print_endline ("Focus: "^sel);
    stellarium_focus sel
    with _ ->
    targ_status_set_text ("Abell: " ^ sel ^ ": not found");
    show_entries " " nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan;
    Lwt.return_unit)

let show_ephem ix =
    let lst = !ephem_data_lst in
    let (eph:string) = if List.length lst > ix then List.nth lst ix else String.make 80 ' ' in
    print_endline eph;
    try let scan = Scanf.sscanf eph " %d-%[A-Za-z]-%d %d:%d %f %[A-Za-z*] %f %f %f %f %f %f %f %f %[^ ] %[A-Za-z] %f"
                        (fun yr mon dy hr min jd sun ra dec azi elev daz delv sidt apmag sbrt cnst hour_ang ->
                            (yr,mon,dy,hr,min,jd,sun,ra,dec,azi,elev,daz,delv,sidt,apmag,sbrt,cnst,hour_ang)) in
    let (yr,mon,dy,hr,min,jd,sun,ra,dec,azi,elev,daz,delv,sidt,apmag,sbrt,cnst,hour_ang) = scan in
    let latitude = latitude() in
    let longitude = longitude() in
    let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = altaz_calc yr (month mon) dy hr min 0 ra dec latitude longitude in
    ignore (sun,daz,delv,sbrt,cnst); (* prevent complier error because we don't use these at the moment *)
    show_entries "" jd_calc ra_now dec_now alt_calc az_calc lst_calc hour_calc jd ra dec azi elev sidt apmag hour_ang nan
    with _ -> 
    show_entries "" nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan

let horizons' () =
    let hdrs = ref [] in
    let server =  "ssd.jpl.nasa.gov" in
    let pth = "/api/horizons.api?format=text" in
    let datum' = datum() in
    let t = Unix.gmtime datum' in
    let t' = Unix.gmtime (datum' +. 86400.0) in
    let f = (fun s ->
       let body = ref "" in
       ephem_data_lst := List.filter (fun x' ->
       let x = String.trim x' in
       let str = if String.length x > 5 then String.sub x 0 4 else "" in
       let trial = try (int_of_string str) with _ -> 0 in
       let use = trial = t.tm_year+1900 in
       let tok = Array.of_list (List.filter (function "" -> false | _ -> true) (String.split_on_char ' ' x)) in
       if Array.length tok > 0 && tok.(0) = "Revised:" then
          begin
          let ix = ref (Array.length tok - 1) in
          while (tok.(!ix).[0] >= '0' && tok.(!ix).[0] <= '9') || (tok.(!ix) = "/") do decr ix done;
(* *)
          print_endline ("last ix="^string_of_int !ix);
          if !verbose then Array.iteri (fun ix itm -> print_endline (string_of_int ix^": \""^itm^"\"")) tok;
(* *)
          body := String.concat " " (Array.to_list (Array.sub tok 4 (!ix - 3)));
          end
       else if Array.length tok > 0 && tok.(0) = "JPL/HORIZONS" then
          begin
(* *)
          if !verbose then Array.iteri (fun ix itm -> print_endline (string_of_int ix^": "^itm)) tok;
(* *)
          body := String.concat " " (Array.to_list (Array.sub tok 1 (Array.length tok - 3)));
          end;
       if !verbose then print_endline x;
       use) (String.split_on_char '\n' s);
       !set_debug_value ("horizons: "^ !body);
       entry_nam_set_text !body;
       ephem_set_active t.tm_hour;
       show_ephem t.tm_hour) in
    let lat_flt = latitude() in
    let long_flt = longitude() in
    let req = 
    [("COMMAND", "'"^ (targ_entry'()) ^"'");
     ("OBJ_DATA", "'YES'");
     ("MAKE_EPHEM", "'YES'");
     ("EPHEM_TYPE", "'OBS'");
     ("CENTER", "'coord'");
     ("APPARENT", "'REFRACTED'");
     ("CAL_FORMAT", "'BOTH'");
     ("ANG_FORMAT", "'DEG'");
     ("SITE_COORD", Printf.sprintf "'%f,%f,%f'" long_flt lat_flt 0.0);
     ("START_TIME", Printf.sprintf "%d-%d-%d" (t.tm_year+1900) (t.tm_mon+1) t.tm_mday);
     ("STOP_TIME", Printf.sprintf "%d-%d-%d" (t'.tm_year+1900) (t'.tm_mon+1) t'.tm_mday);
     ("STEP_SIZE", "'1 h'");
     ("QUANTITIES", "'1,4,5,7,9,29,42");
    ] in
    if !verbose then List.iter (fun (k,x) -> print_endline (k^": "^x)) req;
    get' "https://" server req [] pth f hdrs
