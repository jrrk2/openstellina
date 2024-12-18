(*
<HEADER>
#
#         TABLE: heasarc_ngc2000
#      LOCATION: dbms1.gsfc.nasa.gov:heasarcprod
#    TOTAL ROWS: 13226
#
# CREATION DATE: 2020-09-28 16:48:10
# LAST MODIFIED: 2022-02-05 14:48:15
#   EXGEST DATE: 2022-02-05 14:50:06
#
table_name = heasarc_ngc2000
table_description = "NGC2000.0: Complete New General Catalog and Index Catalog"
table_document_url = http://heasarc.gsfc.nasa.gov/W3Browse/general-catalog/ngc2000.html
table_security = public
#
# Table Parameters
#
field[name] = char8  [meta.id;meta.main] (index) // Object Identification
field[source_type] = char3  [src.class] (index) // Object Classification
field[ra] = float8:.2f_degree [pos.eq.ra;meta.main] (key) // Right Ascension
field[dec] = float8:.2f_degree [pos.eq.dec;meta.main] (key) // Declination
field[lii] = float8:.2f_degree [pos.galactic.lon] (index) // Galactic Longitude
field[bii] = float8:.2f_degree [pos.galactic.lat] (index) // Galactic Latitude
field[ref_revision] = char2  [meta.ref] (index) // Reference Code for Modern Revision Information
field[constellation] = char3  [meta.id.part] (index) // Constellation of Source
field[limit_ang_diameter] = char1  [meta.code;phys.angSize;phys.size.smajAxis] (index) // Flag Indicates Angular Diameter Is Upper Limit
field[ang_diameter] = float4:5.1f_arcmin [phys.angSize;phys.size.smajAxis] (index) // Angular Diameter (arcmin)
field[app_mag] = float4:5.1f_mag [phot.mag] (index) // Integrated Magnitude, Visual or Photographic
field[app_mag_flag] = char1  [meta.code;phot.mag] (index) // Flag [p] Indicates Magnitude Is Photographic (Blue)
field[description] = char50  [meta.note;src.class] (index) // Description of Object by Dreyer
field[class] = int2  [src.class] (index) // Browse Object Classification
#
parameter_defaults = name ra dec app_mag app_mag_flag limit_ang_diameter ang_diameter source_type
#
# Virtual Parameters
#
catalog_bibcode = <VII/118/ngc2000.dat>
declination = @dec
default_search_radius = 15
equinox = 2000
frequency_regime = Optical
observatory_name = GENERAL CATALOG
right_ascension = @ra
row_type = Galaxy
row_type = Nebula
row_type = Star Cluster
table_author = Dreyer; Sinnott
table_priority = 3
table_type = Object
target_name = @name
unique_key = name
#
# Relationship Definitions
#
relate[class] = heasarc_class(class_id)
#
# Data Format Specification
#
*)

type ngc = {name:string;
source_type: string;
ra: string;
dec: string;
lii: string;
bii: string;
ref_revision: string;
constellation: string;
limit_ang_diameter: string;
ang_diameter: string;
app_mag: string;
app_mag_flag: string;
description: string;
classification: string;
}

let ngclst = ref []

let process cnt lin = let open Target in
  let (name,source_type,ra,dec,lii,bii,ref_revision,constellation,limit_ang_diameter,ang_diameter,app_mag,app_mag_flag,description,classification) =
  Scanf.sscanf lin "(\"%[^\"]\",\"%[^\"]\",\"%[^\"]\",\"%[^\"]\",\"%[^\"]\",\"%[^\"]\",\"%[^\"]\",\"%[^\"]\",\"%[^\"]\",\"%[^\"]\",\"%[^\"]\",\"%[^\"]\",\"%[^\"]\",\"%[^\"]\",\"\")" (fun name source_type ra dec lii bii ref_revision constellation limit_ang_diameter ang_diameter app_mag app_mag_flag description classification ->
  (name,source_type,ra,dec,lii,bii,ref_revision,constellation,limit_ang_diameter,ang_diameter,app_mag,app_mag_flag,description,classification)) in
let ang = try float_of_string ang_diameter with _ -> print_endline ang_diameter; nan in
let mag = try float_of_string app_mag with _ -> print_endline app_mag; nan in
let contents = {name;
  ra=float_of_string ra;
  dec=float_of_string dec;
  mag;
  category=DeepSky;
  desc=description;
  debug=Printf.sprintf "From NGC catalog: ra=%s dec=%s mag=%f" ra dec mag} in
ignore (lii,bii,ref_revision,limit_ang_diameter,app_mag_flag,classification);
match source_type with "-" | "OC" -> () | _ -> ngclst := contents :: !ngclst

let cache() =
  let fil = "data/ngc2000.dat" in
  let fd = open_in fil in
  let cnt = ref 0 in
  (try while true do
    let lin = input_line fd in
    process cnt lin;
    done with End_of_file -> close_in fd)
