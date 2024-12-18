
let mystring_of_float x =
  let str = string_of_float x in
  if str.[String.length str - 1] = '.' then str^"0" else str

let hms_of_float x' =
    let neg = x' < 0.0 in
    let x = if neg then x' +. 360.0 else x' in
    let x15 = x /. 15.0 in
    let h = floor (x15) in
    let m' = (x15 -. h) *. 60.0 in
    let m = floor (m') in
    let s = (m' -. m) *. 60.0 in
    if Float.is_nan x' then "nan" else Printf.sprintf "%.2d %.2d %.2d" (int_of_float h) (int_of_float m) (int_of_float s)

let dms_of_float x' =
    let neg = x' < 0.0 in
    let x = if neg then -. x' else x' in
    let d = floor (x) in
    let m' = (x -. d) *. 60.0 in
    let m = floor (m') in
    let s = (m' -. m) *. 60.0 in
    if Float.is_nan x' then "nan" else Printf.sprintf "%c%.2d %.2d %.2d" (if neg then '-' else '+') (int_of_float d) (int_of_float m) (int_of_float s)

let cnv_ra fmt =
    try Scanf.sscanf fmt "%f %f %f" (fun a b c -> a *. 15.0 +. b /. 4.0 +. c /. 240.0)
    with _ -> try Scanf.sscanf fmt "%f %f" (fun a b -> a *. 15.0 +. b /. 4.0) with _ -> 0.0

let cnv_hms fmt =
    try Scanf.sscanf fmt "%fh%fm%fs" (fun a b c -> a *. 15.0 +. b /. 4.0 +. c /. 240.0) with _ -> 0.0

let cnv_dec fmt =
    let neg = fmt <> "" && fmt.[0] = '-' in
    try Scanf.sscanf fmt "%f %f %f" (fun a b c -> if neg then a -. b /. 60.0 -. c /. 3600.0 else a +. b /. 60.0 +. c /. 3600.0)
    with _ -> try Scanf.sscanf fmt "%f %f" (fun a b -> if neg then a -. b /. 60.0 else a +. b /. 60.0)
    with _ -> try float_of_string fmt with _ -> 0.0

let (%.) = mod_float

let computeTheJulianDay checked year month day =
begin
(*
	let leap = (
		if (checked == false) && (year mod 4 == 0) then 1 else
		if year mod 4 != 0 then 0 else 
		if year mod 400 == 0 then 1 else
		if year mod 100==0 then 0 else
		1) in
*)
	let _D = day in
	let _M = month in
	let _Y,_M = if (month<3) then
		year - 1, month+12
        else year, month in

	let _C = if(checked == true) then	begin
		let _A = (_Y/100) in
		let _B = (_A/4) in
		2 - _A + _B
	end
	else
		0 in
	let _E = floor(365.25 *. float_of_int (_Y + 4716)) in
	let _F = floor(30.6001 *. float_of_int(_M + 1)) in
	let julianday = float_of_int (_C + _D) +. _E +. _F -. 1524.5 in
 	julianday
end

let mygmst jd =
let midnight = floor(jd) +. 0.5 in
let days_since_midnight = jd -. midnight in
let hours_since_midnight = days_since_midnight *. 24. in
let days_since_epoch = jd -. 2451545.0 in
let centuries_since_epoch = days_since_epoch /. 36525.0 in
let whole_days_since_epoch = midnight -. 2451545.0 in

let _GMST = 6.697374558 
     +. 0.06570982441908 *. whole_days_since_epoch 
     +. 1.00273790935 *. hours_since_midnight
     +. 0.000026 *. centuries_since_epoch *. 2. in

    let gmst = (_GMST %. 24.) /. 24. in
    let gmst = gmst *. 2. *. Float.pi in
    if gmst < 0. then gmst +. 2. *. Float.pi else gmst

let local_siderial_time' _Long dayOffset =
(* Day offset and Local Siderial Time *)
let day_frac = (dayOffset -. floor dayOffset) *. 360.0 in
let _LST = (100.46 +. 0.985647 *. dayOffset +. _Long +. day_frac +. 360.0 -. 0.495 +. 0.00085386) %. 360.0 in
_LST /. 15.0

let local_siderial_time _Long _Date =
let date,_ = Unix.mktime _Date in
let datum,_ = Unix.mktime {tm_sec=0; tm_min=0; tm_hour=12; tm_mday=1; tm_mon=0; tm_year = 100; tm_wday=0; tm_yday=0; tm_isdst=false} in
let dayOffset = (date -. datum) /. 86400.0 in
local_siderial_time' _Long dayOffset

let mod_ha ha =
  let _HA = ha %. 24.0 -. 24.0 in
  if _HA < -12.0 then _HA +. 24.0 else _HA

(* <summary> *)
(* Explanation of the calculations at http://www.stargazing.net/kepler/altaz.html *)
(* <param name="RA">The right ascension in decimal value</param> *)
(* <param name="Dec">The declination in decimal value</param> *)
(* <param name="Lat">The latitude in decimal value</param> *)
(* <param name="Long">The longitude in decimal value</param> *)
(* <param name="Date">The date(time) in UTC</param> *)
(* <returns>The altitude and azimuth in decimal value</returns> *)
let raDectoAltAz _RA _Dec _Lat _Long _LST =

(* Hour Angle *)
let fiddle_factor = 0.0 in (* 0.00189 simulate refraction(?) and other errors *)
let _HA = mod_ha (_LST -. _RA /. 15.0 +. 24.0 +. fiddle_factor ) in
let _HA' = _HA *. (Float.pi /. 12.) in
(* HA, DEC, _Lat to Alt, AZ *)
let x = cos(_HA') *. cos(_Dec *. (Float.pi /. 180.)) in
let y = sin(_HA') *. cos(_Dec *. (Float.pi /. 180.)) in
let z = sin(_Dec *. (Float.pi /. 180.)) in
let xhor = x *. cos((90. -. _Lat) *. (Float.pi /. 180.)) -. z *. sin((90. -. _Lat) *. (Float.pi /. 180.)) in
let yhor = y in
let zhor = x *. sin((90. -. _Lat) *. (Float.pi /. 180.)) +. z *. cos((90. -. _Lat) *. (Float.pi /. 180.)) in
let az = atan2 yhor xhor *. (180. /. Float.pi) +. 180. in
let alt = asin(zhor) *. (180. /. Float.pi) in
alt, az, _HA

let j2000_to_jnow ra2000 dec2000 =
    let date = Unix.gettimeofday() in
    let datum,_ = Unix.mktime {tm_sec=0; tm_min=0; tm_hour=12; tm_mday=1; tm_mon=0; tm_year = 100; tm_wday=0; tm_yday=0; tm_isdst=false} in
    let _T = (date -. datum) /. 86400.0 /. 36525.0 in
    let _M = 1.2812323 *. _T +. 0.0003879 *. _T *. _T +. 0.0000101 *. _T *. _T *. _T in
    let _N = 0.5567530 *. _T -. 0.0001185 *. _T *. _T +. 0.0000116 *. _T *. _T *. _T in
    let delta_ra = _M +. _N *. sin (ra2000 *. (Float.pi /. 180.)) *. tan (dec2000 *. (Float.pi /. 180.)) in
    let delta_dec = _N *. cos (ra2000 *. (Float.pi /. 180.)) in
    ra2000 +. delta_ra, dec2000 +. delta_dec

let month = function
| "Jan" -> 1
| "Feb" -> 2
| "Mar" -> 3
| "Apr" -> 4
| "May" -> 5
| "Jun" -> 6
| "Jul" -> 7
| "Aug" -> 8
| "Sep" -> 9
| "Oct" -> 10
| "Nov" -> 11
| "Dec" -> 12
| oth -> try int_of_string oth with _ -> failwith "month conversion"

let from_month = function
|  1 -> "Jan"
|  2 -> "Feb"
|  3 -> "Mar"
|  4 -> "Apr"
|  5 -> "May"
|  6 -> "Jun"
|  7 -> "Jul"
|  8 -> "Aug"
|  9 -> "Sep"
| 10 -> "Oct"
| 11 -> "Nov"
| 12 -> "Dec"
| oth -> string_of_int oth

let jd_2000 = 2451544.5

let altaz_calc yr mon dy hr min sec ra dec latitude longitude =
    let jd_calc = computeTheJulianDay true yr mon dy +. float_of_int(hr*3600+min*60+sec) /. 86400.0 in
    let lst_calc = local_siderial_time' longitude (jd_calc -. jd_2000) in
    let ra_now, dec_now = j2000_to_jnow ra dec in
    let alt_calc, az_calc, hour_calc = raDectoAltAz ra_now dec_now latitude longitude lst_calc in
    jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc

let jd_now () =
    let tm = Unix.gmtime (Unix.gettimeofday ()) in
    computeTheJulianDay true (tm.tm_year+1900) (tm.tm_mon+1) tm.tm_mday +. float_of_int(tm.tm_hour*3600+tm.tm_min*60+tm.tm_sec) /. 86400.0

let test (source,lat,long,date,dec,ra,azimuth,altitude,lst_hours,hour_angle) =
    let yr,mon,dy,hr,min,sec = try Scanf.sscanf date "%d-%[A-Za-z]-%d %d:%d:%d" (fun yr mon dy hr min sec -> yr,mon,dy,hr,min,sec) with _ ->
                                   Scanf.sscanf date "%d-%[A-Za-z]-%d %d:%d" (fun yr mon dy hr min -> yr,mon,dy,hr,min,0) in

    let m = month mon in
(*
    let jd_ut = julian_CalcFromDate m dy yr hr min sec in
*)
    let jd_ut = computeTheJulianDay true yr m dy +. float_of_int(hr*3600+min*60+sec) /. 86400.0 in
    let lst = local_siderial_time long 
          {tm_sec=sec; tm_min=min; tm_hour=hr; tm_mday=dy; tm_mon=m; tm_year = yr-1900; tm_wday=0; tm_yday=0; tm_isdst=false} in
    let azimuth', altitude', hour_angle' = raDectoAltAz ra dec lat long lst in
    Printf.printf "%s lat=%8.2f long=%8.2f date=\"%s\" dec=%8.2f ra=%8.2f az=%8.2f alt=%8.2f lst=%8.2f hour_angle=%8.2f JD=%8.2f hour_angle'=%8.2f az'=%8.2f alt'=%8.2f siderial=%8.2f\n" 
                   source lat long date dec ra azimuth altitude lst_hours hour_angle jd_ut hour_angle' (azimuth'*.180.0 /. Float.pi) (altitude'*.180.0 /. Float.pi) lst
