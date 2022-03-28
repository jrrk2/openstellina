(* Based on https://gist.github.com/matshofman/4145718 *)

let cnvRaDecToAltAz myRA myDec myLat myLong =
    (* <summary> *)
    (* Explenation of the calculations at http://www.stargazing.net/kepler/altaz.html *)
    (* </summary> *)

        (* <summary> *)
        (* DateTime will be set to current UTC time *)
        (* </summary> *)
        (* <param name="myRA">The right ascension in decimal value</param> *)
        (* <param name="Dec">The declination in decimal value</param> *)
        (* <param name="Lat">The latitude in decimal value</param> *)
        (* <param name="Long">The longitude in decimal value</param> *)
        (* <returns>The altitude and azimuth in decimal value</returns> *)

        (* <summary> *)
        (* </summary> *)
        (* <param name="myRA">The right ascension in decimal value</param> *)
        (* <param name="Dec">The declination in decimal value</param> *)
        (* <param name="Lat">The latitude in decimal value</param> *)
        (* <param name="Long">The longitude in decimal value</param> *)
        (* <param name="Date">The date(time) in UTC</param> *)
        (* <returns>The altitude and azimuth in decimal value</returns> *)

        let mod360 x = 
            let x360 = x /. 360. in
            let frac360 = x360 -. (floor x360) in
            frac360 *. 360.0 in

            (* Day offset and Local Siderial Time *)
            let epoch,_ = Unix.mktime {tm_sec=0; tm_min=0; tm_hour=0; tm_mday=1; tm_mon=0; tm_year=100; tm_wday=0; tm_yday=0; tm_isdst=false} in
            let myDate = Unix.gettimeofday() in
            let dayOffset = (myDate -. epoch) /. 86400.0 in
            let myDate = Unix.gmtime myDate in
            let myLST = mod360(100.46 +. 0.985647 *. dayOffset +. myLong +. 15.0 *. ((float_of_int myDate.tm_hour) +. (float_of_int myDate.tm_min) /. 60.0) +. 360.0) in

            (* Hour Angle *)
            let myHA = mod360(myLST -. myRA +. 360.0) in

            (* myHA, DEC, myLat to Alt, AZ *)
            let x = cos(myHA *. (Float.pi /. 180.0)) *. cos(myDec *. (Float.pi /. 180.0)) in
            let y = sin(myHA *. (Float.pi /. 180.0)) *. cos(myDec *. (Float.pi /. 180.0)) in
            let z = sin(myDec *. (Float.pi /. 180.0)) in

            let xhor = x *. cos((90.0 -. myLat) *. (Float.pi /. 180.0)) -. z *. sin((90.0 -. myLat) *. (Float.pi /. 180.0)) in
            let yhor = y in
            let zhor = x *. sin((90.0 -. myLat) *. (Float.pi /. 180.0)) +. z *. cos((90.0 -. myLat) *. (Float.pi /. 180.0)) in

            let az = (atan2 yhor xhor) *. (180.0 /. Float.pi) +. 180.0 in
            let alt = asin(zhor) *. (180.0 /. Float.pi) in
            alt, az


let cnv_ra a b c = a *. 15.0 +. b /. 4.0 +. c /. 240.0
let cnv_dec a b c = a +. b /. 60.0 +. c /. 3600.0

let example () =
        let myRA = cnv_ra 22. 36. 19. in
        let myDec = -. cnv_dec 2. 33. 41. in
        let myLat = float_of_string (Sys.getenv "LATITUDE") in
        let myLong = float_of_string (Sys.getenv "LONGITUDE") in
        cnvRaDecToAltAz myRA myDec myLat myLong
