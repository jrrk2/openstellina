open Cohttp
open Cohttp_lwt_jsoo
open Altaz
open Lwt.Infix
open Geolocate
open Js_of_ocaml_lwt

type err =
| Error of string
| Found of string * float * float * float

let simbad_cnv (callback:err->unit) = function
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
    let ra_flt = cnv_ra ra in
    let dec_flt = cnv_dec dec in
    let mag_flt = float_of_string mag in
    callback (Found (ident, ra_flt, dec_flt, mag_flt))
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
callback (Error errmsg);
| _ -> callback (Error "simbad XML error")

let simbad' callback target =
    let hdrs = ref [] in
    let server =  "simbad.u-strasbg.fr" in
    let pth = "/simbad/sim-id" in
    Utils.show_info ("simbad called: "^target);
    let params = [ ("output.format", "VOTABLE"); ("output.params", "main_id,ra,dec,flux(V),flux_unit(mag)"); ("Ident", target) ] in
    let f = (fun s -> simbad_cnv callback (
                                  let m = XmlParser.make() in
                                      XmlParser.prove m false;
                                      try
                                        let rslt = XmlParser.parse m (SString s) in
                                        rslt
                                      with _ ->
                                      callback (Error "Xml.parse_string"); Xml.PCData "")) in
    Astro_utils.get' "http://" server params [] pth f hdrs

let timeout seconds =
  let%lwt () = Lwt_js.sleep seconds in
  Lwt.return_unit

let wait_or_timeout event_promise seconds =
	 let promise = Lwt.pick [
	   event_promise;
	   timeout seconds
	 ] in let%lwt () = promise in Lwt.return_unit

let simbad_main callback search_text =
      if search_text <> "" then
      begin
      let _ = wait_or_timeout (simbad' callback search_text) 0.5 in
      Utils.show_info ("ending simbad");
      end
