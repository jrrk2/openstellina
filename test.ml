open Lwt

let verbose = ref false

let main serve = Lwt_main.run (
        (* Initializes GTK. *)
        ignore (GMain.init ());

        (* Install Lwt<->Glib integration. *)
        Lwt_glib.install ();

       (* start TCP server *)
        serve ();

        while true do
            Thread.delay 0.01;
            Lwt_engine.iter true;
            done;

         Lwt.return_unit
      )

let hms_of_float x =
    let x15 = x /. 15.0 in
    let h = floor (x15) in
    let m' = (x15 -. h) *. 60.0 in
    let m = floor (m') in
    let s = (m' -. m) *. 60.0 in
    Printf.sprintf "%dh%dm%ds" (int_of_float h) (int_of_float m) (int_of_float s)

let dms_of_float x' =
    let neg = x' < 0.0 in
    let x = if neg then -. x' else x' in
    let d = floor (x) in
    let m' = (x -. d) *. 60.0 in
    let m = floor (m') in
    let s = (m' -. m) *. 60.0 in
    Printf.sprintf "%c%dh%dm%ds" (if neg then '-' else '+') (int_of_float d) (int_of_float m) (int_of_float s)

let goto_received ra_int dec_int =
        let scal = 180. /. float_of_int(1 lsl 31) in
        let ra = float_of_int ra_int *. scal in
        let dec' = float_of_int dec_int *. scal in
        let dec = if dec' > 180.0 then dec' -. 360.0 else dec' in
        print_endline ("ra="^hms_of_float ra^", dec="^dms_of_float dec)

let goto_rslt = ref None

let rec radix_256 buf ix wid = 
    buf.(ix) + (if wid > 1 then ((radix_256 buf (ix+1) (wid-1)) lsl 8) else 0)

let handle_message buf ix msg =
    if !verbose then print_endline ("msg["^string_of_int !ix^"] : "^string_of_int (int_of_char (msg)));
    buf.(!ix) <- int_of_char (msg);
    incr ix;
    if (!ix >= 2) then
        begin
        let len = radix_256 buf 0 2 in
        if false then print_endline ("msg len : "^string_of_int len);
        if (!ix >= len) then
            begin
            let typ = radix_256 buf 2 2 in
            if !verbose then print_endline ("msg complete, typ = "^string_of_int typ);
            ix := 0;
            match typ with
               | 0 -> (* goto *)
                      let client_micros = radix_256 buf 4 8 in
                      let ra_int = radix_256 buf 12 4 in
                      let dec_int = radix_256 buf 16 4 in
                      if !verbose then print_endline ("ra="^string_of_int ra_int^", dec="^string_of_int dec_int^", us="^string_of_int client_micros);
                      goto_rslt := Some (goto_received ra_int dec_int);
               | oth -> print_endline ("Unknown typ: "^string_of_int oth);
            ix := 0;
            end;
        end;
    ""

let rec handle_connection ix buf ic oc () =
    if !verbose then print_endline "handle_conn";
    Lwt_io.read_char_opt ic >>=
    (function Some msg ->
            let reply = handle_message buf ix msg in
            Lwt_io.write_line oc reply >>= handle_connection ix buf ic oc
              | None -> Logs_lwt.info (fun m -> m "Connection closed") >>= return)

let accept_connection conn =
    if !verbose then print_endline "accept_conn";
    let ix = ref 0 in
    let buf = Array.init 256 (fun ix -> 0) in
    let fd, _ = conn in
    let ic = Lwt_io.of_fd Lwt_io.Input fd in
    let oc = Lwt_io.of_fd Lwt_io.Output fd in
    Lwt.on_failure (handle_connection ix buf ic oc ()) (fun e -> Logs.err (fun m -> m "%s" (Printexc.to_string e) ));
    Logs_lwt.info (fun m -> m "New connection") >>= return
 
let create_socket () =
    let open Lwt_unix in
    let sock = socket PF_INET SOCK_STREAM 0 in
    let listen_address = Unix.inet_addr_loopback in
    let port = 10000 in
    let backlog = 10 in
    let rslt = bind sock @@ ADDR_INET(listen_address, port) in
    listen sock backlog;
    sock, rslt

let create_server sock =
    let rec serve () =
        let rslt = Lwt_unix.accept sock >>= accept_connection >>= serve in
        print_endline "end of serve";
        rslt
    in serve

let _ =
    let () = Logs.set_reporter (Logs.format_reporter ()) in
    let () = Logs.set_level (Some Logs.Info) in
    let sock, rslt = create_socket () in
    let serve = create_server sock in
    main serve
