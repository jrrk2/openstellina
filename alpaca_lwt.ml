(** An example ASCOM alpaca API, somewhat as described in https://www.ascom-standards.org/Documentation/Index.htm#dev *)

let serv_id = ref 0
let (alpacah:(string*(string*string) list,Yojson.Basic.t)Hashtbl.t) = Hashtbl.create 255

let _ = Hashtbl.replace alpacah ("camera", [("connected","abortexposure")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("camera", [("connected","bayeroffsetx")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("camera", [("connected","bayeroffsety")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("camera", [("connected","binx")]) (`Int 1)
let _ = Hashtbl.replace alpacah ("camera", [("connected","biny")]) (`Int 1)
let _ = Hashtbl.replace alpacah ("camera", [("connected","camerastate")]) (`Bool false)
let _ = Hashtbl.replace alpacah ("camera", [("connected","cameraxsize")]) (let xsize = 3072 in `Int xsize)
let _ = Hashtbl.replace alpacah ("camera", [("connected","cameraysize")]) (let ysize = 2080 in `Int ysize)
let _ = Hashtbl.replace alpacah ("camera", [("connected","canfastreadout")]) (`Bool false)
let _ = Hashtbl.replace alpacah ("camera", [("connected","cangetcoolerpower")]) (`Bool false)
let _ = Hashtbl.replace alpacah ("camera", [("connected","cansetccdtemperature")]) (`Bool false)
let _ = Hashtbl.replace alpacah ("camera", [("connected","ccdtemperature")]) (`Float 20.0)
let _ = Hashtbl.replace alpacah ("camera", [("connected","connected")]) (`Bool true)
let _ = Hashtbl.replace alpacah ("camera", [("connected","cooleron")]) (`Bool false)
let _ = Hashtbl.replace alpacah ("camera", [("connected","coolerpower")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("camera", [("connected","driverinfo")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("camera", [("connected","driverversion")]) (`Int 1)
let _ = Hashtbl.replace alpacah ("camera", [("connected","exposuremax")]) (`Float 60.0)
let _ = Hashtbl.replace alpacah ("camera", [("connected","exposuremin")]) (`Float 0.001)
let _ = Hashtbl.replace alpacah ("camera", [("connected","exposureresolution")]) (`Float 0.000001)
let _ = Hashtbl.replace alpacah ("camera", [("connected","gain")]) (`Int 200)
let _ = Hashtbl.replace alpacah ("camera", [("connected","gainmax")]) (`Int 430)
let _ = Hashtbl.replace alpacah ("camera", [("connected","gainmin")]) (`Int 0)
let _ = Hashtbl.replace alpacah ("camera", [("connected","gains")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("camera", [("connected","imagearray")]) (`List [])
let _ = Hashtbl.replace alpacah ("camera", [("connected","imageready")]) (`Bool false)
let _ = Hashtbl.replace alpacah ("camera", [("connected","interfaceversion")]) (`Int 1)
let _ = Hashtbl.replace alpacah ("camera", [("connected","maxadu")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("camera", [("connected","binx")]) (`Int 1)
let _ = Hashtbl.replace alpacah ("camera", [("connected","biny")]) (`Int 1)
let _ = Hashtbl.replace alpacah ("camera", [("connected","maxbinx")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("camera", [("connected","maxbiny")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("camera", [("connected","name")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("camera", [("connected","numx")]) (let xsize = 3072 in `Int xsize)
let _ = Hashtbl.replace alpacah ("camera", [("connected","numy")]) (let ysize = 2080 in `Int ysize)
let _ = Hashtbl.replace alpacah ("camera", [("connected","pixelsizex")]) (`Float 1.23799)
let _ = Hashtbl.replace alpacah ("camera", [("connected","pixelsizey")]) (`Float 1.23799)
let _ = Hashtbl.replace alpacah ("camera", [("connected","sensorname")]) (`String "SONY")
let _ = Hashtbl.replace alpacah ("camera", [("connected","sensortype")]) (`String "CMOS")
let _ = Hashtbl.replace alpacah ("camera", [("connected","startexposure")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("camera", [("connected","startx")]) (`Int 0)
let _ = Hashtbl.replace alpacah ("camera", [("connected","starty")]) (`Int 0)
let _ = Hashtbl.replace alpacah ("camera", [("connected","readoutmodes")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","abortslew")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","slewtocoordinates")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","slewtocoordinatesasync")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("focuser", [("interfaceversion","absolute")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("focuser", [("interfaceversion","connected")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("focuser", [("interfaceversion","driverinfo")]) (`Int 1)
let _ = Hashtbl.replace alpacah ("focuser", [("interfaceversion","driverversion")]) (`Int 1)
let _ = Hashtbl.replace alpacah ("focuser", [("interfaceversion","interfaceversion")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("focuser", [("interfaceversion","name")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("focuser", [("interfaceversion","position")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("focuser", [("interfaceversion","temperature")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("focuser", [("interfaceversion","ismoving")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("focuser", [("interfaceversion","maxstep")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("focuser", [("interfaceversion","move")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("rotator", [("connected","connected")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("rotator", [("connected","driverinfo")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("rotator", [("connected","driverversion")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("rotator", [("connected","interfaceversion")]) (`Int 1)
let _ = Hashtbl.replace alpacah ("rotator", [("connected","position")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("rotator", [("connected","ismoving")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("rotator", [("connected","moveabsolute")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","atpark")]) (`Bool false)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","canpark")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","canpulseguide")]) (`Bool false)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","cansetpierside")]) (`Bool false)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","cansettracking")]) (`Bool true)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","canslew")]) (`Bool true)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","canslewasync")]) (`Bool true)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","cansync")]) (`Bool false)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","connected")]) (`Bool true)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","declination")]) (`Float 89.2641)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","driverinfo")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","driverversion")]) (`Int 1)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","equatorialsystem")]) (`String "Local")
let _ = Hashtbl.replace alpacah ("telescope", [("connected","focallength")]) (`Float 0.400)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","interfaceversion")]) (`Int 1)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","name")]) (`String "MyStellina")
let _ = Hashtbl.replace alpacah ("telescope", [("connected","rightascension")]) (`Float 37.95456)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","sideofpier")]) (`String "unknown")
let _ = Hashtbl.replace alpacah ("telescope", [("connected","siteelevation")]) (`Float 12.0)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","sitelatitude")]) (`Float 52.2451)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","sitelongitude")]) (`Float 0.0795)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","slewing")]) (`Bool false)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","tracking")]) (`Bool false)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","utcdate")]) (`Float 1655709051.0)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","unpark")]) (`Bool true)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","abortslew")]) (`Int 2)
let _ = Hashtbl.replace alpacah ("telescope", [("connected","slewtocoordinates")]) (`Int 2)

let image_ready bool = Hashtbl.replace alpacah ("camera", [("connected","imageready")]) (`Bool bool)

type image_bytes = {
    _MetadataVersion: int;         (* Bytes 0..3 - Metadata version = 1 *)
    _ErrorNumber: int;             (* Bytes 4..7 - Alpaca error number or zero for success *)
    _ClientTransactionID: int;     (* Bytes 8..11 - Client's transaction ID *)
    _ServerTransactionID: int;     (* Bytes 12..15 - Device's transaction ID *)
    _DataStart: int;               (* Bytes 16..19 - Offset of the start of the data bytes = 36 for version 1 *)
    _ImageElementType: int;        (* Bytes 20..23 - Element type of the source image array *)
    _TransmissionElementType: int; (* Bytes 24..27 - Element type as sent over the network *)
    _Rank: int;                    (* Bytes 28..31 - Image array rank *)
    _Dimension1: int;              (* Bytes 32..35 - Length of image array first dimension *)
    _Dimension2: int;              (* Bytes 36..39 - Length of image array second dimension *)
    _Dimension3: int;              (* Bytes 40..43 - Length of image array third dimension (0 for 2D array) *)
}

let rs = ref ""
let read_image image =
    let fd = open_in_bin image in
    try rs := really_input_string fd (in_channel_length fd) with End_of_file -> close_in fd

let _ = read_image "stellina_default.fits"

let read_pixel xsize row col =
  let off = row * xsize + col in
  let byte0 = (255 land int_of_char (try (!rs).[off*2 + 2880] with _ -> ' ')) in
  let byte1 = (255 land int_of_char (try (!rs).[off*2 + 2881] with _ -> ' ')) in
  let bayer = byte0 * 256 + byte1 in
  if byte0 < 128 then bayer + 32768 else bayer - 32768

let image_bytes_extract xsize ysize image_bytes = function
   | 0 -> image_bytes._MetadataVersion         (* Bytes 0..3 - Metadata version = 1 *)
   | 1 -> image_bytes._ErrorNumber;            (* Bytes 4..7 - Alpaca error number or zero for success *)
   | 2 -> image_bytes._ClientTransactionID     (* Bytes 8..11 - Client's transaction ID *)
   | 3 -> image_bytes._ServerTransactionID     (* Bytes 12..15 - Device's transaction ID *)
   | 4 -> image_bytes._DataStart               (* Bytes 16..19 - Offset of the start of the data bytes = 36 for version 1 *)
   | 5 -> image_bytes._ImageElementType        (* Bytes 20..23 - Element type of the source image array *)
   | 6 -> image_bytes._TransmissionElementType (* Bytes 24..27 - Element type as sent over the network *)
   | 7 -> image_bytes._Rank                    (* Bytes 28..31 - Image array rank *)
   | 8 -> image_bytes._Dimension1              (* Bytes 32..35 - Length of image array first dimension *)
   | 9 -> image_bytes._Dimension2              (* Bytes 36..39 - Length of image array second dimension *)
   | 10 -> image_bytes._Dimension3             (* Bytes 40..43 - Length of image array third dimension (0 for 2D array) *)
   | n -> let off = n-11 in
          let row = (ysize-1) - (off*2) mod ysize in
          let col = (off*2) / ysize in
          let pix = read_pixel xsize row col in
          let row' = (ysize-1) - (off*2+1) mod ysize in
          let col' = (off*2+1) / ysize in
          let pix' = read_pixel xsize row' col' in
          pix + pix' * 65536

let dump_bytes xsize ysize =
  for row = 0 to ysize-1 do
    for col = 0 to xsize-1 do
       let pixel = read_pixel xsize row col in
       Printf.printf "%4d, %4d, 0x%4X\n" row col pixel
    done
  done

let image_string () =
   let xsize = match Hashtbl.find alpacah ("camera", [("connected","numx")]) with `Int size -> size | _ -> 1 in
   let ysize = match Hashtbl.find alpacah ("camera", [("connected","numy")]) with `Int size -> size | _ -> 1 in
   let image_bytes = 
      {
          _MetadataVersion=1;         (* Bytes 0..3 - Metadata version = 1 *)
          _ErrorNumber=0;             (* Bytes 4..7 - Alpaca error number or zero for success *)
          _ClientTransactionID=0;     (* Bytes 8..11 - Client's transaction ID *)
          _ServerTransactionID=0;     (* Bytes 12..15 - Device's transaction ID *)
          _DataStart=44;              (* Bytes 16..19 - Offset of the start of the data bytes = 36 for version 1 *)
          _ImageElementType=2;        (* Bytes 20..23 - Element type of the source image array *)
          _TransmissionElementType=8; (* Bytes 24..27 - Element type as sent over the network *)
          _Rank=2;                    (* Bytes 28..31 - Image array rank *)
          _Dimension1=xsize;          (* Bytes 32..35 - Length of image array first dimension *)
          _Dimension2=ysize;          (* Bytes 36..39 - Length of image array second dimension *)
          _Dimension3=0;              (* Bytes 40..43 - Length of image array third dimension (0 for 2D array) *)
      } in
   String.init (image_bytes._DataStart + xsize*ysize*2) (fun ix -> char_of_int ( (255 land (image_bytes_extract xsize ysize image_bytes (ix/4)) lsr ((ix mod 4)*8))))
