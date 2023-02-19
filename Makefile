OBJECT ?= 0
#CATALOGUE ?= Uranus
#RAHMS ?= "02 38 19.72"
#DECDMS ?= "+15 03 00.8"
#EXPOSURE ?= 30.0
#CATALOGUE ?= Moon
#RAHMS ?= "11 35 53"
#DECDMS ?= "+7 02 19"
#EXPOSURE ?= 0.008
#CATALOGUE ?= M86
#RAHMS ?= "12 26 13"
#DECDMS ?= "+12 56 37"
#EXPOSURE ?= 30.0
CATALOGUE ?= "29P/SW"
RAHMS ?= "4 28 11"
DECDMS ?= "+29 06 11"
EXPOSURE ?= 30.0
F = Request.mli cnv_session.ml
G = Request.mli filtered.ml replay_session.ml messier_catalogue.ml

status: filtered.top
	env STATUS=1 OCAMLRUNPARAM=b ./$<

expert: filtered.top
	env EXPERT_ACQUISITION=1 OCAMLRUNPARAM=b ./$<

stopexpert: filtered.top
	env STOP_EXPERT=1 OCAMLRUNPARAM=b ./$<

openarm: filtered.top
	env OPEN_ARM=1 OCAMLRUNPARAM=b ./$<

init: filtered.top
	env AUTO_INIT=1 OCAMLRUNPARAM=b ./$<

observe: filtered.top
	env OBSERVE=$(OBJECT) EXPOSURE=$(EXPOSURE) OCAMLRUNPARAM=b ./$<

custom: filtered.top
	env OBSERVE="-1" CATALOGUE="$(CATALOGUE)" RAHMS=$(RAHMS) DECDMS=$(DECDMS) EXPOSURE=$(EXPOSURE) OCAMLRUNPARAM=b ./$<

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
