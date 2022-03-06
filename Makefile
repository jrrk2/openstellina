client_example.top: client_example.ml
	ocamlfind ocamlmktop -linkpkg -thread -package yojson,cohttp-lwt-unix $< -o $@
