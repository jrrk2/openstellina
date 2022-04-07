(lang dune 3.0)

(name openstellina)

(generate_opam_files true)

(source
 (github jrrk2/openstellina.git))

(authors "Jonathan Kimmitt")

(maintainers "Jonathan Kimmitt")

(license Apache-2)

(documentation https://url/to/documentation)

(package
 (name openstellina)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml dune lablgtk2 lwt_glib yojson cohttp-lwt-unix zeit ppx_let quests ppx_yojson lwt)
 (tags
  (topics "to describe" your project)))

