OBJECT ?= 0
F = Request.mli stellinapp_session_full.ml cnv_session.ml
G = Request.mli filtered.ml replay_session.ml messier_catalogue.ml

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
	ocamlfind ocamlmktop -linkpkg -thread -package xml-light,yojson,cohttp-lwt-unix -g $G -o $@

stellinapp_session_full.top: $F
	ocamlfind ocamlmktop -linkpkg -thread -package yojson,cohttp-lwt-unix -g $F -o $@

stellinapp_session_full.ml: stellinapp_session_full.ml.xz
	xz -d < $< >$@
