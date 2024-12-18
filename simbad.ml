open Cohttp
open Altaz
open Lwt.Infix
open Xml

type err =
| Error of string
| Found of string * float * float * float
| Unmatched of xml

let rec dump show_info = function
        | Xml.Element (kw, attr, lst) ->
            show_info ("Xml.Element \""^kw^"\"");
            List.iter (fun (k,x) -> show_info ("(\""^k^"\", \""^x^"\")")) attr;
            List.iter (dump show_info) lst
        | PCData str -> show_info ("PCData \""^str^"\"")

let rec simbad_cnv show_info (callback:err->unit) = function
|  Element
   ("VOTABLE",
    [("xmlns", "http://www.ivoa.net/xml/VOTable/v1.2");
     ("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
     ("xsi:schemaLocation",
      "http://www.ivoa.net/xml/VOTable/v1.2 http://www.ivoa.net/xml/VOTable/v1.2");
     ("version", "1.2")],
    [Element
      ("DEFINITIONS", [],
       [Element
         ("COOSYS",
          [("ID", "COOSYS"); ("equinox", "2000"); ("epoch", "J2000");
           ("system", "ICRS")],
          [])]);
     Element
      ("RESOURCE", [("name", "Simbad query"); ("type", "results")],
       [Element
         ("TABLE", [("ID", "simbad"); ("name", "simbad query")],
          [Element ("DESCRIPTION", [], [PCData "... query string ..."]);
           Element
            ("FIELD",
             [("ID", "MAIN_ID"); ("name", "MAIN_ID"); ("datatype", "char");
              ("width", "22"); ("ucd", "meta.id;meta.main");
              ("arraysize", "*")],
             [Element
               ("DESCRIPTION", [], [PCData "Main identifier for an object"]);
              Element
               ("LINK",
                [("value", "${MAIN_ID}");
                 ("href",
                  "http://simbad.u-strasbg.fr/simbad/sim-id?Ident=${MAIN_ID}&amp;NbIdent=1")],
                [])]);
           Element
            ("FIELD",
             [("ID", "RA"); ("name", "RA"); ("datatype", "char");
              ("precision", "8"); ("width", "13");
              ("ucd", "pos.eq.ra;meta.main"); ("arraysize", "13");
              ("unit", "&quot;h:m:s&quot;")],
             [Element ("DESCRIPTION", [], [PCData "Right ascension"])]);
           Element
            ("FIELD",
             [("ID", "DEC"); ("name", "DEC"); ("datatype", "char");
              ("precision", "8"); ("width", "13");
              ("ucd", "pos.eq.dec;meta.main"); ("arraysize", "13");
              ("unit", "&quot;d:m:s&quot;")],
             [Element ("DESCRIPTION", [], [PCData "Declination"])]);
           Element
            ("FIELD",
             [("ID", "FLUX_V"); ("name", "FLUX_V"); ("datatype", "float");
              ("ucd", "phot.mag;em.opt.V"); ("unit", "mag")],
             [Element ("DESCRIPTION", [], [PCData "Magnitude V"])]);
           Element
            ("FIELD",
             [("ID", "FLUX_UNIT_mag"); ("name", "FLUX_UNIT_mag");
              ("datatype", "char"); ("width", "3");
              ("ucd", "meta.unit;phot.flux")],
             [Element ("DESCRIPTION", [], [PCData "flux unit"])]);
           Element
            ("DATA", [],
             [Element
               ("TABLEDATA", [],
                [Element
                  ("TR", [],
                   [Element ("TD", [], [PCData ident]);
                    Element ("TD", [], [PCData ra]);
                    Element ("TD", [], [PCData dec]);
                    Element ("TD", [], []);
		    Element ("TD", [], [])])])])])])]) ->
    print_endline ("RA: "^ra);
    print_endline ("DEC: "^dec);
    let ra_flt = cnv_ra ra in
    let dec_flt = cnv_dec dec in
    let mag_flt = nan in
    callback (Found (ident, ra_flt, dec_flt, mag_flt))

    | Element
   ("VOTABLE",
    [("xmlns", "http://www.ivoa.net/xml/VOTable/v1.2");
     ("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
     ("xsi:schemaLocation",
      "http://www.ivoa.net/xml/VOTable/v1.2 http://www.ivoa.net/xml/VOTable/v1.2");
     ("version", "1.2")],
    [Element
      ("DEFINITIONS", [],
       [Element
         ("COOSYS",
          [("ID", "COOSYS"); ("equinox", "2000"); ("epoch", "J2000");
           ("system", "ICRS")],
          [])]);
     Element
      ("RESOURCE", [("name", "Simbad query"); ("type", "results")],
       [Element
         ("TABLE", [("ID", "simbad"); ("name", "simbad query")],
          [Element
            ("DESCRIPTION", [], [PCData "... query string ..."]);
           Element
            ("FIELD",
             [("ID", "MAIN_ID"); ("name", "MAIN_ID"); ("datatype", "char");
              ("width", "22"); ("ucd", "meta.id;meta.main");
              ("arraysize", "*")],
             [Element
               ("DESCRIPTION", [],
                [PCData "Main identifier for an object"]);
              Element
               ("LINK",
                [("value", "${MAIN_ID}");
                 ("href",
                  "http://simbad.u-strasbg.fr/simbad/sim-id?Ident=${MAIN_ID}&amp;NbIdent=1")],
                [])]);
           Element
            ("FIELD",
             [("ID", "RA"); ("name", "RA"); ("datatype", "char");
              ("precision", "8"); ("width", "13");
              ("ucd", "pos.eq.ra;meta.main"); ("arraysize", "13");
              ("unit", "&quot;h:m:s&quot;")],
             [Element ("DESCRIPTION", [], [PCData "Right ascension"])]);
           Element
            ("FIELD",
             [("ID", "DEC"); ("name", "DEC"); ("datatype", "char");
              ("precision", "8"); ("width", "13");
              ("ucd", "pos.eq.dec;meta.main"); ("arraysize", "13");
              ("unit", "&quot;d:m:s&quot;")],
             [Element ("DESCRIPTION", [], [PCData "Declination"])]);
           Element
              ("FIELD",
               [("ID", "FLUX_V"); ("name", "FLUX_V"); ("datatype", "float");
                ("ucd", "phot.mag;em.opt.V"); ("unit", "mag")],
               [Element ("DESCRIPTION", [], [PCData "Magnitude V"])]);
             Element
              ("FIELD",
               [("ID", "FLUX_UNIT_mag"); ("name", "FLUX_UNIT_mag");
                ("datatype", "char"); ("width", "3");
                ("ucd", "meta.unit;phot.flux")],
               [Element ("DESCRIPTION", [], [PCData "flux unit"])]);
             Element
            ("DATA", [],
             [Element
               ("TABLEDATA", [],
                [Element
                  ("TR", [],
                   [Element ("TD", [], [PCData ident]);
                    Element ("TD", [], [PCData ra]);
                    Element ("TD", [], [PCData dec]);
                    Element ("TD", [], [PCData mag]);
                    Element ("TD", [], [])])])])])])]) ->
    let ra_flt = cnv_ra ra in
    let dec_flt = cnv_dec dec in
    let mag_flt = float_of_string mag in
    callback (Found (ident, ra_flt, dec_flt, mag_flt))
| Element
     ("VOTABLE",
      [("xmlns", "http://www.ivoa.net/xml/VOTable/v1.2");
       ("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
       ("xsi:schemaLocation",
        "http://www.ivoa.net/xml/VOTable/v1.2 http://www.ivoa.net/xml/VOTable/v1.2");
       ("version", "1.2")],
      [Element
        ("INFO",
         [("name", "Error");
          ("value", errmsg)],
         [])]) ->
callback (Error errmsg);
(*
| Element
     ("VOTABLE",
      [("xmlns", "http://www.ivoa.net/xml/VOTable/v1.2");
       ("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
       ("xsi:schemaLocation",
        "http://www.ivoa.net/xml/VOTable/v1.2 http://www.ivoa.net/xml/VOTable/v1.2");
       ("version", "1.2")], lst) -> List.iter (descend show_info callback) lst;
*)
| oth -> callback (Unmatched oth)

and descend show_info callback = function
        | Element
               ("TABLEDATA", [],
                [Element
                  ("TR", [],
                   [Element ("TD", [], [PCData ident]);
                    Element ("TD", [], [PCData ra]);
                    Element ("TD", [], [PCData dec]);
                    Element ("TD", [], [PCData mag]);
                    Element ("TD", [], [])])]) ->
    let ra_flt = cnv_ra ra in
    let dec_flt = cnv_dec dec in
    let mag_flt = float_of_string mag in
    callback (Found (ident, ra_flt, dec_flt, mag_flt))
        | Element (kw, attr, lst) -> show_info kw; List.iter (descend show_info callback) lst
        | PCData str -> ()

let simbad' show_info callback target =
    let hdrs = ref [] in
    let server =  "simbad.u-strasbg.fr" in
    let pth = "/simbad/sim-id" in
    show_info ("simbad called: "^target);
    let params = [ ("output.format", "VOTABLE"); ("output.params", "main_id,ra,dec,flux(V),flux_unit(mag)"); ("Ident", target) ] in
    let f = (fun s -> simbad_cnv show_info callback (
                                  let m = XmlParser.make() in
                                      XmlParser.prove m false;
                                      try
                                        let rslt = XmlParser.parse m (SString s) in
                                        rslt
                                      with _ ->
                                      callback (Error "parse_string"); PCData "")) in
    Astro_utils.get' "http://" server params [] pth f hdrs

let simbad_main show_info callback search_text =
      if search_text <> "" then
      begin
      ignore(simbad' show_info callback search_text);
      end
