open Cohttp
open Cohttp_lwt_jsoo
open Altaz
open Lwt.Infix
open Geolocate

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
