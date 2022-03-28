(* Graph widget test program. *)

open GMain
open GdkKeysyms
open Graph
open Lwt
open Replay_session

let font = Printexc.print Pango.Font.from_string "Sans 12"

let quit' = ref false

let app_quit' () = quit' := true

let main serve = Lwt_main.run (
        (* Initializes GTK. *)
        ignore (GMain.init ());

        (* Install Lwt<->Glib integration. *)
        Lwt_glib.install ();

  let window = GWindow.window ~width:640 ~height:480
      ~title:"LablGtk graph widget demo" () in
  let vbox = GPack.vbox ~packing:window#add () in

  (* Menu bar *)
  let menubar = GMenu.menu_bar ~packing:vbox#pack () in
  let factory = new GMenu.factory menubar in
  let accel_group = factory#accel_group in
  let file_menu = factory#add_submenu "File" in
  let stell_menu = factory#add_submenu "Stellina" in

  (* File menu *)
  let factory_fil = new GMenu.factory file_menu ~accel_group in
  ignore @@ factory_fil#add_item "Quit" ~callback: app_quit';

  (* Stellina menu *)
  let factory_stell = new GMenu.factory stell_menu ~accel_group in
  ignore @@ factory_stell#add_item "Status" ~callback: app_status';

  (* Data. *)
  let array = Array.init 100 (fun _ -> Random.int 10) in

  (* Create a graph in the main area. *)
  let graph = new graph font ~packing:vbox#add array in
  graph#set_title "Random data";

        (* Quit when the window is closed. *)
        ignore (window#connect#destroy app_quit');

        (* Show the window. *)
        window#show ();

       (* start TCP server *)
        serve ();

        (* Wait for window to be closed. *)
        let status' = ref ( { success=false; attr=new_attr() } ) in

        let cnt = ref 0 in
        app_status' ();
        while (match !quit' with true -> false | _ -> true) do
            Thread.delay 0.01;
            Lwt_engine.iter true;
            (match !status'' with
              | Lwt.Return x -> status' := get_status x; print_endline "return"; app_status' ()
              | Lwt.Sleep -> incr cnt; print_endline ("sleep: "^string_of_int !cnt));
            done;

        fst (Lwt.wait())
      )

let goto_received sid ra_int dec_int =
        let pi = 3.1415926536 in
        let scal = 180. /. float_of_int(1 lsl 31) in
        let ra = float_of_int ra_int *. scal in
        let dec = float_of_int dec_int *. scal in
        let cdec = cos(dec) in
(*
        desired_pos.(0) <- cos(ra) *. cdec;
        desired_pos.(1) <- sin(ra) *. cdec;
        desired_pos.(2) <- sin(dec);
*)
        print_endline ("ra="^string_of_float ra^", dec="^string_of_float dec);
        Server.prep_obs sid "Stellarium" ra dec >>= fun(resp) -> print_endline resp; return resp

let goto_rslt = ref None

let rec radix_256 buf ix wid = 
    buf.(ix) + (if wid > 1 then ((radix_256 buf (ix+1) (wid-1)) lsl 8) else 0)

let handle_message sid buf ix msg =
    print_endline ("msg["^string_of_int !ix^"] : "^string_of_int (int_of_char (msg)));
    buf.(!ix) <- int_of_char (msg);
    incr ix;
    if (!ix >= 2) then
        begin
        let len = radix_256 buf 0 2 in
        if false then print_endline ("msg len : "^string_of_int len);
        if (!ix >= len) then
            begin
            let typ = radix_256 buf 2 2 in
            print_endline ("msg complete, typ = "^string_of_int typ);
            match typ with
               | 0 -> (* goto *)
                      let client_micros = radix_256 buf 4 8 in
                      let ra_int = radix_256 buf 12 4 in
                      let dec_int = radix_256 buf 16 4 in
                      
                      print_endline ("ra="^string_of_int ra_int^", dec="^string_of_int dec_int);
                      goto_rslt := Some (goto_received sid ra_int dec_int);
               | oth -> print_endline ("Unknown typ: "^string_of_int oth);
            ix := 0;
            end;
        end;
    ""

let rec handle_connection sid ic oc () =
    let ix = ref 0 in
    let buf = Array.init 256 (fun ix -> 0) in
    Lwt_io.read_char_opt ic >>=
    (function Some msg ->
            let reply = handle_message sid buf ix msg in
            Lwt_io.write_line oc reply >>= handle_connection sid ic oc
              | None -> Logs_lwt.info (fun m -> m "Connection closed") >>= return)

let accept_connection sid conn =
    let fd, _ = conn in
    let ic = Lwt_io.of_fd Lwt_io.Input fd in
    let oc = Lwt_io.of_fd Lwt_io.Output fd in
    Lwt.on_failure (handle_connection sid ic oc ()) (fun e -> Logs.err (fun m -> m "%s" (Printexc.to_string e) ));
    Logs_lwt.info (fun m -> m "New connection") >>= return
 
let create_socket () =
    let open Lwt_unix in
    let sock = socket PF_INET SOCK_STREAM 0 in
    let listen_address = Unix.inet_addr_loopback in
    let port = 10000 in
    let backlog = 10 in
    bind sock @@ ADDR_INET(listen_address, port);
    listen sock backlog;
    sock

let create_server sid sock =
    let rec serve () =
        let rslt = Lwt_unix.accept sock >>= accept_connection sid >>= serve in
        print_endline "end of serve";
        rslt
    in serve

let _ =
    let () = Logs.set_reporter (Logs.format_reporter ()) in
    let () = Logs.set_level (Some Logs.Info) in
    let sock = create_socket () in
    let sid = Server.connect_stellina () in
    let serve = create_server sid sock in
    main serve

let lwtstat = function None -> failwith "None" | Some st -> (match Lwt.state st with Lwt.Return y -> y);;
