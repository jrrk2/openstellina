let connect_horizons () =
  let host = "137.78.251.144" in
  let port = 6775 in

  let ic, oc = Unix.open_connection (Unix.ADDR_INET (Unix.inet_addr_of_string host, port)) in
  
  (* Handle initial welcome message *)
  let welcome = input_line ic in
  Printf.printf "Connected: %s\n" welcome;

  (* Send commands *)
  output_string oc "MB Mars\n";  (* Major Body selection *)
  flush oc;
  
  (* Read response *)
  let rec read_until_prompt () =
    let line = input_line ic in
    Printf.printf "%s\n" line;
    if line = "Horizons> " then ()
    else read_until_prompt ()
  in
  
  read_until_prompt ();

  Unix.shutdown_connection ic;
  close_in ic

(* *)
let _ = connect_horizons()
(* *)
