OBJECT ?= 0
E = example.ml
F = Request.mli stellinapp_session_full.ml cnv_session.ml
G = Request.mli filtered.ml replay_session.ml messier_catalogue.ml server.ml
T = filtered.ml messier_catalogue.ml replay_session.ml server.ml graph.ml test.ml
U = base_locations.ml messier_catalogue.ml gui.ml

status: filtered.top
	env STATUS=1 OCAMLRUNPARAM=b ./$<

expert: filtered.top
	env EXPERT_ACQUISITION=1 OCAMLRUNPARAM=b ./$<

openarm: filtered.top
	env OPEN_ARM=1 OCAMLRUNPARAM=b ./$<

init: filtered.top
	env AUTO_INIT=1 OCAMLRUNPARAM=b ./$<

observe: filtered.top
	env OBSERVE=$(OBJECT) OCAMLRUNPARAM=b ./$<

refocus: filtered.top
	env REFOCUS=1 OCAMLRUNPARAM=b ./$<

stopobs: filtered.top
	env STOP_OBSERVATION=1 OCAMLRUNPARAM=b ./$<

park: filtered.top
	env PARK=1 OCAMLRUNPARAM=b ./$<

shutdown: filtered.top
	env SHUT_DOWN=1 OCAMLRUNPARAM=b ./$<

filtered.top: $G
	ocamlfind ocamlmktop -linkpkg -thread -package xml-light,yojson,cohttp-lwt-unix,logs,logs.lwt -g $G -o $@

stellinapp_session_full.top: $F
	ocamlfind ocamlmktop -linkpkg -thread -package yojson,cohttp-lwt-unix -g $F -o $@

stellinapp_session_full.ml: stellinapp_session_full.ml.xz
	xz -d < $< >$@

toaltaz1.top: toaltaz1.ml
	ocamlfind ocamlmktop -package lymp -thread -linkpkg -g $< -o $@

graphtest.top: $T
	ocamlfind ocamlmktop -linkpkg -thread -package xml-light,lablgtk2,cohttp-lwt-unix,lwt_glib,yojson -g $T -o $@

graphtest: $T
	ocamlfind ocamlopt -linkpkg -thread -package xml-light,lablgtk2,cohttp-lwt-unix,lwt_glib,yojson -g $T -o $@

example.top: $E
	ocamlfind ocamlmktop -g -linkpkg -thread -package yojson,cohttp-lwt-unix,zeit,ppx_let,quests,ppx_yojson,lwt $E -o $@

gui: $U
	ocamlfind ocamlc -g -linkpkg -thread -package lablgtk2,lwt_glib,yojson,cohttp-lwt-unix,zeit,ppx_let,quests,ppx_yojson,lwt $U -o $@

gui.opt: $U
	ocamlfind ocamlopt -g -linkpkg -thread -package lablgtk2,lwt_glib,yojson,cohttp-lwt-unix,zeit,ppx_let,quests,ppx_yojson,lwt $U -o $@
