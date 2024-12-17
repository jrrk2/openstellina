open Lwt
open Version
open Astro_utils

let smdb_entries = ref [||]

let load_prog_entries () =
    try let fd = open_in (tmpdir^"prog_entries.json") in
    (match (*yojson_of_yojson_basic*) (Yojson.Safe.from_channel fd) with `List lst -> List.rev lst | _ -> []);
    with Sys_error _ -> []

let dump_prog_entries prog_entries =
    let fd = open_out (tmpdir^"prog_entries.json") in
    output_string fd (Yojson.Safe.pretty_to_string (`List (List.rev prog_entries)));
    close_out fd

let clearprog() =
    dump_prog_entries [];
    show_prog_entries [];
    Lwt.return_unit

let app_quit' () = print_endline "quit flagged"; quit' := true; Lwt.return_unit

let startprog fn =
    let pth = pth2'^"/v1/automator/startObservationProgram" in
    let lat_flt = latitude() in
    let long_flt = longitude() in
    let f = (fun s -> fn (cnv s)) in
    let lst = List.rev (load_prog_entries()) in
    dump_prog_entries [];
    print_endline ("Entries in program: "^string_of_int (List.length lst));
    List.iteri (fun ix (itm:Yojson.Safe.t) -> print_endline ("observation["^string_of_int ix^"]: "^Yojson.Safe.to_string itm)) lst;
    let (prog':Yojson.Safe.t) = `Assoc
        [("skipAutoInit", `Bool false);
         ("latitude", `Float lat_flt);
         ("longitude", `Float long_flt);
         ("startTime", `Intlit (time_ms()));
         ("observations", `List lst)] in
    print_endline !mos_id;
    Astro_utils.post' proto server [] (auth' ()) pth ((Yojson.Safe.to_string prog')) (cnv' f)

and smdb'' sentries lbl' = 
  List.iteri (fun ix loc -> if loc=lbl' then
      begin
      let {des;orb;jd;cd;dist;dist_min;dist_max;v_rel;v_inf;t_sigma_f;h} = !smdb_entries.(ix) in
      dump_smdb stderr ({des;orb;jd;cd;dist;dist_min;dist_max;v_rel;v_inf;t_sigma_f;h});
      let scan = Scanf.sscanf cd " %d-%[A-Za-z]-%d %d:%d"
                        (fun yr mon dy hr min ->
                            (yr,mon,dy,hr,min)) in
      let (yr,mon,dy,hr,min) = scan in
      update_date yr (Altaz.month mon) dy hr min 0;
      tim_6_set_text (Printf.sprintf "%8.0f" (1.496e8 *. float_of_string dist_min));
      tim_7_set_text (string_of_float h);
      targ_entry_set_text lbl';
      end) sentries

and smdb' () = if approach then
    begin
    print_endline "Flyby/closest approach calculation";
    let hdrs = ref [] in
    let server =  "ssd-api.jpl.nasa.gov" in
    let pth = "/cad.api" in
    let datum = Unix.gettimeofday() in
    let t = Unix.gmtime datum in
    let t' = Unix.gmtime (datum +. 86400.0 *. 365.2425) in
    let f = (fun s ->
        let lst = smdb_decode (Yojson.Safe.from_string s) in
        let dbgfile = open_out (tmpdir^"smdba1.txt") in
        List.iter (dump_smdb dbgfile) lst;
        close_out dbgfile;
        let srt = List.sort compare lst in
        let dbgfile = open_out (tmpdir^"smdba2.txt") in
        List.iter (dump_smdb dbgfile) srt;
        close_out dbgfile;
        smdb_entries := Array.sub (Array.of_list srt) 0 20;
        let sentries = List.map (fun {des;_} -> des) (Array.to_list !smdb_entries) in
        ()
         ) in
    let req = [
     ("date-min", Printf.sprintf "%d-%.2d-%.2d" (t.tm_year+1900) (t.tm_mon+1) t.tm_mday);
     ("date-max", Printf.sprintf "%d-%.2d-%.2d" (t'.tm_year+1900) (t'.tm_mon+1) t'.tm_mday);
    ] in
    if true then List.iter (fun (k,x) -> print_endline (k^": "^x)) req;
    Astro_utils.get' "https://" server req [] pth f hdrs
    end
 else
    begin
    let yr,mon,dy,hr,min,sec = split_date() in
    let latitude = latitude() in
    let longitude = longitude() in
    let lst = ref [] in
    Expr.dump stdout [] acceptance;
    let skiplst = ["DN" ; "CL" ; "YSO" ; "MoC"; "*"; "ISM"; "CGb"] in
    let srt = match defcat with
      | 3 -> Array.iter (fun (sel, ra, dec, mag) ->
        let mag = float_of_string mag in
        let diam = nan in
        let cnst = "" in
        let ra_flt = Altaz.cnv_ra ra in
        let dec_flt = Altaz.cnv_dec dec in
        let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
        let acclst = ("alt_calc", Calc.Num alt_calc) :: ("az_calc", Calc.Num az_calc) :: ("mag", Calc.Num mag) :: ("ang_diam", Calc.Num diam) :: [] in
        match Expr.simplify acclst acceptance with
          | Calc.Bool true ->
            if mag <> nan then lst := (sel, (ra_flt,dec_flt,cnst,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) :: !lst;
          | Calc.Bool false -> ()
          | oth -> Expr.dump stderr acclst oth
        ) Messier_catalogue.messier_array;
        List.rev !lst
      | 5 -> Hashtbl.iter (fun sel (ra_flt,dec_flt,cnst,diam,mag,desc)  ->
        let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
        ignore (cnst,diam,mag,desc);
        let acclst = ("alt_calc", Calc.Num alt_calc) :: ("az_calc", Calc.Num az_calc) :: ("mag", Calc.Num mag) :: ("ang_diam", Calc.Num diam) :: [] in
        match Expr.simplify acclst acceptance with
          | Calc.Bool true ->
            if mag <> nan then lst := (sel, (ra_flt,dec_flt,cnst,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) :: !lst;
          | Calc.Bool false -> ()
          | oth -> Expr.dump stderr acclst oth
        ) Ngc2000.ngchash;
       List.sort sort_mag !lst
      | 6 -> Hashtbl.iter (fun sel -> function (aco :: rah :: ram :: des :: ded :: dem :: bmtype :: count :: ra2000h :: ra2000m :: de2000s :: de2000d :: de2000m :: xpos :: ypos :: glon :: glat :: redshift :: rich :: dclass :: m10 :: []) ->
        let mag = nan in
        let diam = nan in
        let cnst = "" in
    let ra_flt = float_of_string ra2000h *. 15.0 +. float_of_string ra2000m /. 4.0 in
    let dec_flt = float_of_string de2000d +. float_of_string de2000m /. 60.0 in
    let dec_flt = if de2000s.[0] = '-' then -. dec_flt else dec_flt in
        let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
        ignore (aco,rah,ram,des,ded,dem,bmtype,count,xpos,ypos,glon,glat,redshift,rich,dclass,m10);
        let acclst = ("alt_calc", Calc.Num alt_calc) :: ("az_calc", Calc.Num az_calc) :: ("mag", Calc.Num mag) :: ("ang_diam", Calc.Num diam) :: [] in
        (match Expr.simplify acclst acceptance with
          | Calc.Bool true ->
            if mag <> nan then lst := (sel, (ra_flt,dec_flt,cnst,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) :: !lst;
          | Calc.Bool false -> ()
          | oth -> Expr.dump stderr acclst oth)
        | _ -> ()) Abell_cnv.abellh;
       List.sort sort_mag !lst
      | 7 -> Hashtbl.iter (fun _ (num,ra_flt,dec_flt,magb,mag,typ,morph,major,minor,orient,redshift,eredshift,parallax,eparallax,dist,edist,_,_,sel) ->
        let diam = major in
        let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
        ignore (num,magb,morph,major,minor,orient,redshift,eredshift,parallax,eparallax,dist,edist);
        let acclst = ("alt_calc", Calc.Num alt_calc) :: ("az_calc", Calc.Num az_calc) :: ("mag", Calc.Num mag) :: ("ang_diam", Calc.Num diam) :: [] in
        match Expr.simplify acclst acceptance with
          | Calc.Bool true ->
            if mag <> nan && not (List.mem typ skiplst) then lst := (List.hd sel, (ra_flt,dec_flt,typ,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) :: !lst;
          | Calc.Bool false -> ()
          | oth -> Expr.dump stderr acclst oth
        ) Dso_read.dsoh;
       if pairing then
         begin
         let lst' = ref [] in
         List.iteri (fun ix' (sel', (ra_flt',dec_flt',_,_,mag',_,_,_,_,_,_,_) as a) ->
            List.iteri (fun ix'' (sel'', (ra_flt'',dec_flt'',_,_,mag'',_,_,_,_,_,_,_) as b) ->
               let diam = sqrt ((ra_flt' -. ra_flt'') *. (ra_flt' -. ra_flt'') +. (dec_flt' -. dec_flt'') *. (dec_flt' -. dec_flt'')) in
               if ix' < ix'' && (diam < 0.9) && (mag' < 10.) && (mag'' < 10.) then
                  begin
                  let mag = if mag' < mag'' then mag' else mag'' in
                  let cnst = "" in
                  let ra_flt = (ra_flt' +. ra_flt'') /. 2. in
                  let dec_flt = (dec_flt' +. dec_flt'') /. 2. in
                  let jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc = Altaz.altaz_calc yr mon dy hr min sec ra_flt dec_flt latitude longitude in
                  lst' := (sel'^" + "^sel'', (ra_flt,dec_flt,cnst,diam,mag,jd_calc, ra_now, dec_now, alt_calc, az_calc, lst_calc, hour_calc)) :: !lst';
                  dump_cat stdout a;
                  dump_cat stdout b;
                  print_newline ();
                  end;
            ) !lst
         ) !lst;
         lst := !lst';
         end;
       List.sort sort_mag !lst
       | _ -> print_endline "That catalogue does not support searching by alt/az"; [] in
    print_endline ("selected catalogue objects = "^string_of_int (List.length !lst));
    let dbgfile = open_out (tmpdir^"cat1.txt") in
    List.iter (dump_cat dbgfile) !lst;
    close_out dbgfile;
    let dbgfile = open_out (tmpdir^"cat2.txt") in
    List.iter (dump_cat dbgfile) srt;
    close_out dbgfile;
    let entries = 20 in (* hardwired for now *)
    let entries = if entries > List.length srt then List.length srt else entries in
    let cat_entries = Array.sub (Array.of_list srt) 0 entries in
    let nentries = List.map (fun (des,_) -> des) (Array.to_list cat_entries) in
    Lwt.return_unit
    end

and add_prog_entry () =
    let ra_flt = Altaz.cnv_ra (entry_ra'()) in
    let dec_flt = Altaz.cnv_dec (entry_dec'()) in
    let duration = int_of_string (entry_duration'()) in
    let obs = `Assoc
         [("duration", `Int duration);
          ("params",
           `Assoc
             [("objectId", `String ( entry_nam'() ));
              ("ra", `Float ra_flt);
              ("de", `Float dec_flt);
              ("rot", `Int 0);
              ("gain", `Int (Astro_utils.gain_int()));
              ("histogramEnabled", `Bool true);
              ("histogramLow", `Int (-1));
              ("histogramMedium", `Int 5);
              ("histogramHigh", `Int 0);
              ("backgroundEnabled", `Bool true);
              ("exposureMicroSec", `Int (expos_us()));
              ("doStacking", `Bool true);
              ("debayerInterpolation", `String "VNG")])] in
    let prog_entries = obs :: load_prog_entries() in
    dump_prog_entries prog_entries;
    show_prog_entries prog_entries;
    Lwt.return_unit

let update_status () = ()
