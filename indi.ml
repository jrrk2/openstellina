let setoth = ref []
let xmlst = ref []

let xmlstr' x = xmlst := x :: !xmlst

let time_stamp () = "2022-01-01T00:00:00"

let devxml dev = Xml.Element
 ("defSwitchVector",
  [("device", dev); ("name", "CONNECTION");
   ("label", "Connection"); ("group", "Main Control"); ("state", "Idle");
   ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
   ("timestamp", time_stamp() )],
  [Xml.Element
    ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
     [Xml.PCData "Off"]);
   Xml.Element
    ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
     [Xml.PCData "On"])])

let blob mr = Xml.Element
 ("defTextVector",
  [("device", mr); ("name", "DRIVER_INFO");
   ("label", "Driver Info"); ("group", "Connection"); ("state", "Idle");
   ("perm", "ro"); ("timeout", "60"); ("timestamp", time_stamp() )],
  [Xml.Element
    ("defText", [("name", "DRIVER_NAME"); ("label", "Name")],
     [Xml.PCData mr]);
   Xml.Element
    ("defText", [("name", "DRIVER_EXEC"); ("label", "Exec")],
     [Xml.PCData "indi_simulator"]);
   Xml.Element
    ("defText", [("name", "DRIVER_VERSION"); ("label", "Version")],
     [Xml.PCData "1.0"]);
   Xml.Element
    ("defText", [("name", "DRIVER_INTERFACE"); ("label", "Interface")],
     [Xml.PCData "4096"])])

let ccdxml = Xml.Element
 ("defNumberVector",
  [("device", "CCD Simulator"); ("name", "SIMULATOR_SETTINGS");
   ("label", "Settings"); ("group", "Simulator Config"); ("state", "Idle");
   ("perm", "rw"); ("timeout", "60"); ("timestamp", time_stamp() )],
  [Xml.Element
    ("defNumber",
     [("name", "SIM_XRES"); ("label", "CCD X resolution");
      ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
     [Xml.PCData "1280"]);
   Xml.Element
    ("defNumber",
     [("name", "SIM_YRES"); ("label", "CCD Y resolution");
      ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
     [Xml.PCData "1024"]);
   Xml.Element
    ("defNumber",
     [("name", "SIM_XSIZE"); ("label", "CCD X Pixel Size");
      ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
     [Xml.PCData "5.2000000000000001776"]);
   Xml.Element
    ("defNumber",
     [("name", "SIM_YSIZE"); ("label", "CCD Y Pixel Size");
      ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
     [Xml.PCData "5.2000000000000001776"]);
   Xml.Element
    ("defNumber",
     [("name", "SIM_MAXVAL"); ("label", "CCD Maximum ADU");
      ("format", "%4.0f"); ("min", "255"); ("max", "65000");
      ("step", "1000")],
     [Xml.PCData "65000"]);
   Xml.Element
    ("defNumber",
     [("name", "SIM_SATURATION"); ("label", "Saturation Mag");
      ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
     [Xml.PCData "1"]);
   Xml.Element
    ("defNumber",
     [("name", "SIM_LIMITINGMAG"); ("label", "Limiting Mag");
      ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
     [Xml.PCData "17"]);
   Xml.Element
    ("defNumber",
     [("name", "SIM_NOISE"); ("label", "CCD Noise"); ("format", "%4.0f");
      ("min", "0"); ("max", "6000"); ("step", "500")],
     [Xml.PCData "10"]);
   Xml.Element
    ("defNumber",
     [("name", "SIM_SKYGLOW"); ("label", "Sky Glow (magnitudes)");
      ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
     [Xml.PCData "19.5"]);
   Xml.Element
    ("defNumber",
     [("name", "SIM_OAGOFFSET"); ("label", "Oag Offset (arcminutes)");
      ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
     [Xml.PCData "0"]);
   Xml.Element
    ("defNumber",
     [("name", "SIM_POLAR"); ("label", "PAE (arcminutes)");
      ("format", "%4.1f"); ("min", "-600"); ("max", "600"); ("step", "100")],
     [Xml.PCData "0"]);
   Xml.Element
    ("defNumber",
     [("name", "SIM_POLARDRIFT"); ("label", "PAE Drift (minutes)");
      ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
     [Xml.PCData "0"]);
   Xml.Element
    ("defNumber",
     [("name", "SIM_PEPERIOD"); ("label", "PE Period (minutes)");
      ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
     [Xml.PCData "0"]);
   Xml.Element
    ("defNumber",
     [("name", "SIM_PEMAX"); ("label", "PE Max (arcsec)");
      ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
     [Xml.PCData "0"]);
   Xml.Element
    ("defNumber",
     [("name", "SIM_TIME_FACTOR"); ("label", "Time Factor (x)");
      ("format", "%.2f"); ("min", "0.010000000000000000208"); ("max", "100");
      ("step", "10")],
     [Xml.PCData "1"]);
   Xml.Element
    ("defNumber",
     [("name", "SIM_ROTATION"); ("label", "CCD Rotation");
      ("format", "%.2f"); ("min", "0"); ("max", "360"); ("step", "10")],
     [Xml.PCData "0"])])

let ccdactivexml = Xml.Element
 ("defTextVector",
  [("device", "CCD Simulator"); ("name", "ACTIVE_DEVICES");
   ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
   ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-06-14T15:21:31")],
  [Xml.Element
    ("defText", [("name", "ACTIVE_TELESCOPE"); ("label", "Telescope")],
     [Xml.PCData "Telescope Simulator"]);
   Xml.Element
    ("defText", [("name", "ACTIVE_ROTATOR"); ("label", "Rotator")],
     [Xml.PCData "Rotator Simulator"]);
   Xml.Element
    ("defText", [("name", "ACTIVE_FOCUSER"); ("label", "Focuser")],
     [Xml.PCData "Focuser Simulator"]);
   Xml.Element
    ("defText", [("name", "ACTIVE_FILTER"); ("label", "Filter")], []);
   Xml.Element
    ("defText", [("name", "ACTIVE_SKYQUALITY"); ("label", "Sky Quality")],
     [Xml.PCData "SQM"])])

let ccdinfoxml = Xml.Element
 ("defNumberVector",
  [("device", "CCD Simulator"); ("name", "CCD_INFO");
   ("label", "CCD Information"); ("group", "Image Info"); ("state", "Idle");
   ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-06-15T12:48:05")],
  [Xml.Element
    ("defNumber",
     [("name", "CCD_MAX_X"); ("label", "Max. Width"); ("format", "%.f");
      ("min", "1"); ("max", "16000"); ("step", "0")],
     [Xml.PCData "1280"]);
   Xml.Element
    ("defNumber",
     [("name", "CCD_MAX_Y"); ("label", "Max. Height"); ("format", "%.f");
      ("min", "1"); ("max", "16000"); ("step", "0")],
     [Xml.PCData "1024"]);
   Xml.Element
    ("defNumber",
     [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
      ("format", "%.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
     [Xml.PCData "5.1999998092651367188"]);
   Xml.Element
    ("defNumber",
     [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
      ("format", "%.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
     [Xml.PCData "5.1999998092651367188"]);
   Xml.Element
    ("defNumber",
     [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
      ("format", "%.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
     [Xml.PCData "5.1999998092651367188"]);
   Xml.Element
    ("defNumber",
     [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
      ("format", "%.f"); ("min", "8"); ("max", "64"); ("step", "0")],
     [Xml.PCData "16"])])

let ccd1xml = Xml.Element
 ("defBLOBVector",
  [("device", "CCD Simulator"); ("name", "CCD1"); ("label", "Image Data");
   ("group", "Image Info"); ("state", "Ok"); ("perm", "ro");
   ("timeout", "60"); ("timestamp", "2022-06-15T12:48:05")],
  [Xml.Element ("defBLOB", [("name", "CCD1"); ("label", "Image")], [])])

let ccdtypxml = Xml.Element
 ("defSwitchVector",
  [("device", "CCD Simulator"); ("name", "CCD_FRAME_TYPE");
   ("label", "Type"); ("group", "Image Settings"); ("state", "Idle");
   ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
   ("timestamp", "2022-06-15T12:48:05")],
  [Xml.Element
    ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
     [Xml.PCData "On"]);
   Xml.Element
    ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
     [Xml.PCData "Off"]);
   Xml.Element
    ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
     [Xml.PCData "Off"]);
   Xml.Element
    ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
     [Xml.PCData "Off"])])

let mountxml =
              Xml.Element
               ("defNumberVector",
                [("device", "Telescope Simulator"); ("name", "TELESCOPE_INFO");
                 ("label", "Scope Properties"); ("group", "Options"); ("state", "Ok");
                 ("perm", "rw"); ("timeout", "60"); ("timestamp", time_stamp() )],
                [Xml.Element
                  ("defNumber",
                   [("name", "TELESCOPE_APERTURE"); ("label", "Aperture (mm)");
                    ("format", "%g"); ("min", "10"); ("max", "5000"); ("step", "0")],
                   [Xml.PCData "120"]);
                 Xml.Element
                  ("defNumber",
                   [("name", "TELESCOPE_FOCAL_LENGTH"); ("label", "Focal Length (mm)");
                    ("format", "%g"); ("min", "10"); ("max", "10000"); ("step", "0")],
                   [Xml.PCData "900"]);
                 Xml.Element
                  ("defNumber",
                   [("name", "GUIDER_APERTURE"); ("label", "Guider Aperture (mm)");
                    ("format", "%g"); ("min", "10"); ("max", "5000"); ("step", "0")],
                   [Xml.PCData "120"]);
                 Xml.Element
                  ("defNumber",
                   [("name", "GUIDER_FOCAL_LENGTH"); ("label", "Guider Focal Length (mm)");
                    ("format", "%g"); ("min", "10"); ("max", "10000"); ("step", "0")],
                   [Xml.PCData "900"])])

let coordxml = Xml.Element
 ("defNumberVector",
  [("device", "Telescope Simulator"); ("name", "EQUATORIAL_EOD_COORD");
   ("label", "Eq. Coordinates"); ("group", "Main Control");
   ("state", "Idle"); ("perm", "rw"); ("timeout", "60");
   ("timestamp", "2022-06-15T12:48:03")],
  [Xml.Element
    ("defNumber",
     [("name", "RA"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
      ("min", "0"); ("max", "24"); ("step", "0")],
     [Xml.PCData "0.39213112734852678676"]);
   Xml.Element
    ("defNumber",
     [("name", "DEC"); ("label", "DEC (dd:mm:ss)"); ("format", "%010.6m");
      ("min", "-90"); ("max", "90"); ("step", "0")],
     [Xml.PCData "90"])])

let abortxml = Xml.Element
 ("defSwitchVector",
  [("device", "Telescope Simulator"); ("name", "TELESCOPE_ABORT_MOTION");
   ("label", "Abort Motion"); ("group", "Main Control"); ("state", "Idle");
   ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
   ("timestamp", "2022-06-15T12:48:05")],
  [Xml.Element
    ("defSwitch", [("name", "ABORT"); ("label", "Abort")],
     [Xml.PCData "Off"])])

let scopexml = Xml.Element
 ("defTextVector",
  [("device", "Telescope Simulator"); ("name", "SCOPE_CONFIG_NAME");
   ("label", "Scope Name"); ("group", "Options"); ("state", "Ok");
   ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-06-15T12:48:05")],
  [Xml.Element
    ("defText", [("name", "SCOPE_CONFIG_NAME"); ("label", "Config Name")],
     [])])

let pierxml = Xml.Element
 ("defSwitchVector",
  [("device", "Telescope Simulator"); ("name", "TELESCOPE_PIER_SIDE");
   ("label", "Pier Side"); ("group", "Main Control"); ("state", "Ok");
   ("perm", "ro"); ("rule", "AtMostOne"); ("timeout", "60");
   ("timestamp", "2022-06-15T12:48:05")],
  [Xml.Element
    ("defSwitch", [("name", "PIER_WEST"); ("label", "West (pointing east)")],
     [Xml.PCData "Off"]);
   Xml.Element
    ("defSwitch", [("name", "PIER_EAST"); ("label", "East (pointing west)")],
     [Xml.PCData "On"])])

let trackmodexml = Xml.Element
 ("defSwitchVector",
  [("device", "Telescope Simulator"); ("name", "TELESCOPE_TRACK_MODE");
   ("label", "Track Mode"); ("group", "Main Control"); ("state", "Ok");
   ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
   ("timestamp", "2022-06-15T12:48:05")],
  [Xml.Element
    ("defSwitch", [("name", "TRACK_SIDEREAL"); ("label", "Sidereal")],
     [Xml.PCData "On"]);
   Xml.Element
    ("defSwitch", [("name", "TRACK_SOLAR"); ("label", "Solar")],
     [Xml.PCData "Off"]);
   Xml.Element
    ("defSwitch", [("name", "TRACK_LUNAR"); ("label", "Lunar")],
     [Xml.PCData "Off"]);
   Xml.Element
    ("defSwitch", [("name", "TRACK_CUSTOM"); ("label", "Custom")],
     [Xml.PCData "Off"])])

let trackstatexml = Xml.Element
 ("defSwitchVector",
  [("device", "Telescope Simulator"); ("name", "TELESCOPE_TRACK_STATE");
   ("label", "Tracking"); ("group", "Main Control"); ("state", "Idle");
   ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
   ("timestamp", "2022-06-15T12:48:05")],
  [Xml.Element
    ("defSwitch", [("name", "TRACK_ON"); ("label", "On")],
     [Xml.PCData "Off"]);
   Xml.Element
    ("defSwitch", [("name", "TRACK_OFF"); ("label", "Off")],
     [Xml.PCData "On"])])

let trackratexml = Xml.Element
 ("defNumberVector",
  [("device", "Telescope Simulator"); ("name", "TELESCOPE_TRACK_RATE");
   ("label", "Track Rates"); ("group", "Main Control"); ("state", "Ok");
   ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-06-15T12:48:05")],
  [Xml.Element
    ("defNumber",
     [("name", "TRACK_RATE_RA"); ("label", "RA (arcsecs/s)");
      ("format", "%.6f"); ("min", "-16384"); ("max", "16384");
      ("step", "9.9999999999999995475e-07")],
     [Xml.PCData "15.04106717867020393"]);
   Xml.Element
    ("defNumber",
     [("name", "TRACK_RATE_DE"); ("label", "DE (arcsecs/s)");
      ("format", "%.6f"); ("min", "-16384"); ("max", "16384");
      ("step", "9.9999999999999995475e-07")],
     [Xml.PCData "0"])])

let eodcoordxml = Xml.Element
 ("defNumberVector",
  [("device", "Telescope Simulator"); ("name", "TARGET_EOD_COORD");
   ("label", "Slew Target"); ("group", "Motion Control"); ("state", "Idle");
   ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-06-15T12:48:05")],
  [Xml.Element
    ("defNumber",
     [("name", "RA"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
      ("min", "0"); ("max", "24"); ("step", "0")],
     [Xml.PCData "0"]);
   Xml.Element
    ("defNumber",
     [("name", "DEC"); ("label", "DEC (dd:mm:ss)"); ("format", "%010.6m");
      ("min", "-90"); ("max", "90"); ("step", "0")],
     [Xml.PCData "0"])])

let geogcoordxml = Xml.Element
 ("defNumberVector",
  [("device", "Telescope Simulator"); ("name", "GEOGRAPHIC_COORD");
   ("label", "Scope Location"); ("group", "Site Management");
   ("state", "Ok"); ("perm", "rw"); ("timeout", "60");
   ("timestamp", "2022-06-15T12:48:05")],
  [Xml.Element
    ("defNumber",
     [("name", "LAT"); ("label", "Lat (dd:mm:ss.s)"); ("format", "%012.8m");
      ("min", "-90"); ("max", "90"); ("step", "0")],
     [Xml.PCData "52.189722222222215464"]);
   Xml.Element
    ("defNumber",
     [("name", "LONG"); ("label", "Lon (dd:mm:ss.s)"); ("format", "%012.8m");
      ("min", "0"); ("max", "360"); ("step", "0")],
     [Xml.PCData "0.16999999999999998446"]);
   Xml.Element
    ("defNumber",
     [("name", "ELEV"); ("label", "Elevation (m)"); ("format", "%g");
      ("min", "-200"); ("max", "10000"); ("step", "0")],
     [Xml.PCData "13.75"])])

let parkxml = Xml.Element
 ("defSwitchVector",
  [("device", "Telescope Simulator"); ("name", "TELESCOPE_PARK");
   ("label", "Parking"); ("group", "Main Control"); ("state", "Ok");
   ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
   ("timestamp", "2022-06-15T12:48:05")],
  [Xml.Element
    ("defSwitch", [("name", "PARK"); ("label", "Park(ed)")],
     [Xml.PCData "Off"]);
   Xml.Element
    ("defSwitch", [("name", "UNPARK"); ("label", "UnPark(ed)")],
     [Xml.PCData "On"])])

let parkposxml = Xml.Element
 ("defNumberVector",
  [("device", "Telescope Simulator"); ("name", "TELESCOPE_PARK_POSITION");
   ("label", "Park Position"); ("group", "Site Management");
   ("state", "Idle"); ("perm", "rw"); ("timeout", "60");
   ("timestamp", "2022-06-15T12:48:05")],
  [Xml.Element
    ("defNumber",
     [("name", "PARK_HA"); ("label", "HA (hh:mm:ss)"); ("format", "%010.6m");
      ("min", "-12"); ("max", "12"); ("step", "0")],
     [Xml.PCData "-6"]);
   Xml.Element
    ("defNumber",
     [("name", "PARK_DEC"); ("label", "DEC (dd:mm:ss)");
      ("format", "%010.6m"); ("min", "-90"); ("max", "90"); ("step", "0")],
     [Xml.PCData "0"])])

let parkoptxml = Xml.Element
 ("defSwitchVector",
  [("device", "Telescope Simulator"); ("name", "TELESCOPE_PARK_OPTION");
   ("label", "Park Options"); ("group", "Site Management");
   ("state", "Idle"); ("perm", "rw"); ("rule", "AtMostOne");
   ("timeout", "60"); ("timestamp", "2022-06-15T12:48:05")],
  [Xml.Element
    ("defSwitch", [("name", "PARK_CURRENT"); ("label", "Current")],
     [Xml.PCData "Off"]);
   Xml.Element
    ("defSwitch", [("name", "PARK_DEFAULT"); ("label", "Default")],
     [Xml.PCData "Off"]);
   Xml.Element
    ("defSwitch", [("name", "PARK_WRITE_DATA"); ("label", "Write Data")],
     [Xml.PCData "Off"]);
   Xml.Element
    ("defSwitch", [("name", "PARK_PURGE_DATA"); ("label", "Purge Data")],
     [Xml.PCData "Off"])])

let connxml dev = Xml.Element
 ("setSwitchVector",
  [("device", dev); ("name", "CONNECTION"); ("state", "Ok");
   ("timeout", "60"); ("timestamp", time_stamp() )],
  [Xml.Element ("oneSwitch", [("name", "CONNECT")], [Xml.PCData "On"]);
   Xml.Element ("oneSwitch", [("name", "DISCONNECT")], [Xml.PCData "Off"])])

let disconnxml dev = Xml.Element
 ("setSwitchVector",
  [("device", dev); ("name", "CONNECTION"); ("state", "Idle");
   ("timeout", "60"); ("timestamp", time_stamp() )],
  [Xml.Element ("oneSwitch", [("name", "CONNECT")], [Xml.PCData "Off"]);
   Xml.Element ("oneSwitch", [("name", "DISCONNECT")], [Xml.PCData "On"])])

let debugxml dev = Xml.Element
 ("setSwitchVector",
  [("device", dev); ("name", "DEBUG"); ("state", "ENABLE");
   ("timeout", "60"); ("timestamp", time_stamp() )],
  [Xml.Element ("oneSwitch", [("name", "ENABLE")], [Xml.PCData "On"]);
   Xml.Element ("oneSwitch", [("name", "DISABLE")], [Xml.PCData "Off"])])

let nodebugxml dev = Xml.Element
 ("setSwitchVector",
  [("device", dev); ("name", "DEBUG"); ("state", "DISABLE");
   ("timeout", "60"); ("timestamp", time_stamp() )],
  [Xml.Element ("oneSwitch", [("name", "ENABLE")], [Xml.PCData "Off"]);
   Xml.Element ("oneSwitch", [("name", "DISABLE")], [Xml.PCData "On"])])

let sort_name a b =
  match a,b with
  | Xml.Element (_, ("device", _) :: ("name", nam1) :: _, _),
    Xml.Element (_, ("device", _) :: ("name", nam2) :: _, _) -> compare nam1 nam2
  | _ -> compare a b

let defswxmlfun dev = List.sort_uniq sort_name (List.filter (function Xml.Element (("defSwitchVector"|"defNumberVector"), ("device", dev') :: _, _) -> dev=dev' | _ -> false) Captured.captured);;
let defblobfun dev = List.sort_uniq sort_name (List.filter (function Xml.Element ("defBLOBVector", ("device", dev') :: _, _) -> dev=dev' | _ -> false) Captured.captured);;

let msg dev txt =
Xml.Element
 ("message",
  [("device", dev); ("timestamp", time_stamp() );
   ("message", txt)],
  [])

let options dev =
  let a = Array.of_list (List.rev (defswxmlfun dev)) in
  let len = Array.length a in
  let max = 20 in (* was 20 *)
  let trunc = if len < max then len else max in
  Array.to_list (Array.sub a 0 trunc)

let setxml = function
             | Xml.Element ("oneNumber", [("name", "TELESCOPE_APERTURE")], [Xml.PCData "      1  "]) -> ()
             | Xml.Element ("oneNumber", [("name", "TELESCOPE_FOCAL_LENGTH")], [Xml.PCData "      1  "]) -> ()
             | Xml.Element ("oneNumber", [("name", "GUIDER_APERTURE")], [Xml.PCData "      1  "]) -> ()
             | Xml.Element ("oneNumber", [("name", "GUIDER_FOCAL_LENGTH")], [Xml.PCData "      1  "]) -> ()
             | Xml.Element ("oneNumber", [("name", "LAT")], [Xml.PCData "      52.189722222222215464  "]) -> ()
             | Xml.Element ("oneNumber", [("name", "LONG")], [Xml.PCData "      0.16999999999999998446  "]) -> ()
             | Xml.Element ("oneNumber", [("name", "ELEV")], [Xml.PCData "      13.75  "]) -> ()
             | Xml.Element ("oneText", [("name", "UTC")], [Xml.PCData utc]) -> ignore utc
             | Xml.Element ("oneText", [("name", "OFFSET")], [Xml.PCData offset]) -> ignore offset
             | Xml.Element ("oneNumber", [("name", "PARK_HA")], [Xml.PCData ha]) -> ignore ha
             | Xml.Element ("oneNumber", [("name", "PARK_DEC")], [Xml.PCData dec]) -> ignore dec
             | Xml.Element ("oneSwitch", [("name", "PARK")], [Xml.PCData onoff]) -> ignore onoff
             | Xml.Element ("oneSwitch", [("name", "UNPARK")], [Xml.PCData onoff]) -> ignore onoff
             | Xml.Element ("oneText", [("name", "ACTIVE_TELESCOPE")], [Xml.PCData telescopeSimulator]) -> ignore telescopeSimulator
             | Xml.Element ("oneText", [("name", "ACTIVE_ROTATOR")], [Xml.PCData rotatorSimulator]) -> ignore rotatorSimulator
             | Xml.Element ("oneText", [("name", "ACTIVE_FOCUSER")], [Xml.PCData focuserSimulator]) -> ignore focuserSimulator
             | Xml.Element ("oneText", [("name", "ACTIVE_FILTER")], []) -> ()
             | Xml.Element ("oneText", [("name", "ACTIVE_SKYQUALITY")], [Xml.PCData sqm]) -> ignore sqm
             | Xml.Element ("oneText", [("name", "ACTIVE_GPS")], [Xml.PCData gpsSimulator]) -> ignore gpsSimulator
             | Xml.Element ("oneText", [("name", "ACTIVE_DOME")], [Xml.PCData domeSimulator]) -> ignore domeSimulator
             | Xml.Element ("oneNumber", [("name", "CCD_MAX_X")], [Xml.PCData ccdMaxX]) -> ignore ccdMaxX
             | Xml.Element ("oneNumber", [("name", "CCD_MAX_Y")], [Xml.PCData ccdMaxY]) -> ignore ccdMaxY
             | Xml.Element ("oneNumber", [("name", "CCD_PIXEL_SIZE")], [Xml.PCData ccdPixelSize]) -> ignore ccdPixelSize
             | Xml.Element ("oneNumber", [("name", "CCD_PIXEL_SIZE_X")], [Xml.PCData ccdPixelSizeX]) -> ignore ccdPixelSizeX
             | Xml.Element ("oneNumber", [("name", "CCD_PIXEL_SIZE_Y")], [Xml.PCData ccdPixelSizeY]) -> ignore ccdPixelSizeY
             | Xml.Element ("oneNumber", [("name", "CCD_BITSPERPIXEL")], [Xml.PCData ccdBitsPerPixel]) -> ignore ccdBitsPerPixel
             | Xml.Element ("oneSwitch", [("name", "CONNECT")], [Xml.PCData on]) -> ignore on
             | Xml.Element ("oneSwitch", [("name", "DISCONNECT")], [Xml.PCData off]) -> ignore off
             | Xml.Element ("oneSwitch", [("name", "CONFIG_SAVE")], [Xml.PCData on_off]) -> ignore on_off
             | Xml.Element ("oneSwitch", [("name", "CONFIG_LOAD")], [Xml.PCData on_off]) -> ignore on_off
             | Xml.Element ("oneSwitch", [("name", "ENABLE")], [Xml.PCData on]) -> ignore on
             | Xml.Element ("oneSwitch", [("name", "CONFIG_PURGE")], [Xml.PCData off]) -> ignore off
             | Xml.Element ("oneSwitch", [("name", "CONFIG_DEFAULT")], [Xml.PCData off]) -> ignore off
             | Xml.Element ("oneSwitch", [("name", "PS_OFF")], [Xml.PCData on]) -> ignore on
             | Xml.Element ("oneSwitch", [("name", "ALTAZ")], [Xml.PCData on]) -> ignore on
             | Xml.Element ("oneSwitch", [("name", "CONNECTION_SERIAL")], [Xml.PCData on]) -> ignore on
             | Xml.Element ("oneSwitch", [("name", "CONNECTION_TCP")], [Xml.PCData on]) -> ignore on
             | Xml.Element ("oneSwitch", [("name", "All")], [Xml.PCData on]) -> ignore on
             | Xml.Element ("oneSwitch", [("name", "Timer")], [Xml.PCData on]) -> ignore on
             | Xml.Element ("oneSwitch", [("name", "Relative")], [Xml.PCData on]) -> ignore on
             | Xml.Element ("oneSwitch", [("name", "Absolute")], [Xml.PCData on]) -> ignore on
             | oth -> if not (List.mem oth !setoth) then (setoth := oth :: !setoth; print_endline ("setxml: "^Xml.to_string oth))

let prop dev = function
| "FWHM" ->
 [Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD1"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-06-17T12:56:39")],
   [Xml.Element
     ("defBLOB", [("name", "CCD1"); ("label", "Image")], [])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD2"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-06-17T12:56:39")],
   [Xml.Element
     ("defBLOB", [("name", "CCD2"); ("label", "Guider Image")], [])])]
| oth -> print_endline ("[INFO] device "^dev^" has no property "^oth); []

let xmlstr = function
          | Xml.Element ("getProperties", [("version", _)], []) -> ccd1xml :: List.map (fun itm -> (devxml (itm^" Simulator"))) ["Telescope"; "CCD"; "Focuser"; "Rotator"]
          | Xml.Element ("getProperties", [("version", _); ("device", "0")], []) -> List.map (fun itm -> (devxml (itm^" Simulator"))) ["Telescope"; "CCD"; "Focuser"; "Rotator"]
          | Xml.Element ("getProperties", [("version", _); ("device", "Simple CCD")], []) -> options "CCD Simulator"
          | Xml.Element ("getProperties", [("version", _); ("device", dev)], []) -> options dev
          | Xml.Element ("getProperties", [("version", _); ("device", dev); ("name", nam)], []) -> prop dev nam
          | Xml.Element ("enableBLOB", [("device", dev)], [Xml.PCData _]) -> blob dev :: (options dev)
          | Xml.Element ("enableBLOB", [("device", dev); ("name", ccd)], [Xml.PCData "Only"]) -> ignore ccd; defblobfun dev
          | Xml.Element ("newSwitchVector", [("device", dev); ("name", ("DEBUG"|"CONFIG_PROCESS"|"SIM_PIER_SIDE"|"MOUNT_TYPE"|"CONNECTION_MODE"|"Mode" as name))], lst) -> List.iter (setxml) lst; print_endline (dev^": "^name); []
          | Xml.Element ("newSwitchVector", [("device", dev); ("name", "CONNECTION")], lst) ->
              List.iter (setxml) lst; [
 Xml.Element
  ("setSwitchVector",
   [("device", dev); ("name", "CONNECTION"); ("state", "Ok");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneSwitch", [("name", "CONNECT")], [Xml.PCData "On"]);
    Xml.Element
     ("oneSwitch", [("name", "DISCONNECT")], [Xml.PCData "Off"])]);
 Xml.Element
  ("defSwitchVector",
   [("device", dev); ("name", "CONNECTION");
    ("label", "Connection"); ("group", "Main Control"); ("state", "Ok");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
      [Xml.PCData "On"]);
    Xml.Element
     ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
      [Xml.PCData "Off"])]);
]
          | Xml.Element ("newNumberVector",  [("device", dev); ("name", "TELESCOPE_INFO")], lst) -> List.iter (setxml) lst; [msg dev "newNumVec info"]
          | Xml.Element ("newNumberVector",  [("device", dev); ("name", "GEOGRAPHIC_COORD")], lst) -> List.iter (setxml) lst; [msg dev "newNumVec coord"]
          | Xml.Element ("newTextVector", [("device", dev); ("name", "ACTIVE_DEVICES")], lst) -> List.iter (setxml) lst; [msg dev "newTextVec active"]
          | Xml.Element ("setTextVector", [("device", dev); ("name", "ACTIVE_DEVICES"); ("state", "Ok"); ("timeout", _); ("timestamp", _)], lst) -> List.iter (setxml) lst; [msg dev "setTextVec active"]
          | Xml.Element ("setTextVector", [("device", dev); ("name", "TIME_UTC"); ("state", "Ok"); ("timeout", _); ("timestamp", _)], lst) -> List.iter (setxml) lst; [msg dev "setTextVec info"]
          | Xml.Element ("setNumberVector", [("device", dev); ("name", "TELESCOPE_PARK_POSITION"); ("state", "Idle"); ("timeout", _); ("timestamp", _)], lst) -> List.iter (setxml) lst; [msg dev "setNumberVec _"]
          | Xml.Element ("setNumberVector", [("device", dev); ("name", "GUIDER_INFO"); ("state", "Idle"); ("timeout", _); ("timestamp", _)], lst) -> List.iter (setxml) lst; [msg dev "setNumberVec _"]
          | Xml.Element ("setNumberVector", [("device", dev); ("name", ("GUIDE_RATE"|"GUIDER_FRAME"|"FLIP_HA"|"MOUNT_MODEL")); ("state", ("Idle"|"Ok")); ("timeout", _); ("timestamp", _)], _) -> [msg dev "setNumberVec _"]
          | Xml.Element ("setNumberVector", [("device", dev); ("name", "CCD_STREAM_FRAME"); ("state", "Ok"); ("timeout", _); ("timestamp", _)], _) -> [msg dev "setNumberVec _"]
          | Xml.Element ("setSwitchVector", [("device", dev); ("name", "TELESCOPE_PARK"); ("state", "Ok"); ("timeout", _); ("timestamp", _)], lst) -> List.iter (setxml) lst; [msg dev "setSwitchVec _"]
          | Xml.Element ("setSwitchVector", [("device", dev); ("name", "CONNECTION"); ("state", "Ok"); ("timeout", _); ("timestamp", _)], lst) -> List.iter (setxml) lst; [msg dev "setSwitchVec _"]
          | Xml.Element ("setSwitchVector", [("device", dev); ("name", ("CONFIG_PROCESS"|"SIM_PIER_SIDE"|"MOUNT_TYPE"|"DEBUG"|"CONNECTION_MODE"|"Mode")); ("state", "Ok"); ("timeout", _); ("timestamp", _)], _) -> [msg dev "setSwitchVec _"]
          | Xml.Element ("defBLOBVector", _, _) as x -> [x]
          | Xml.Element ("defNumberVector", _, _) as x -> [x]
          | Xml.Element ("defSwitchVector", _, _) as x -> [x]
          | Xml.Element ("defTextVector", _, _) as x -> [x]
          | Xml.Element ("delProperty", _, _) as x -> [x]
          | Xml.Element ("message", [("device", dev); ("timestamp", _); ("message", _)], _) as x -> ignore dev;[x]
          | oth -> xmlstr' oth; [msg "unknown" "unknown cmd"]

