(lang dune 3.0)

(name openstellina)
(version opam-publish-openstellina.0.0.3-dirty)

(generate_opam_files false)

(source
 (github jrrk2/openstellina.git))

(authors "Jonathan Kimmitt")

(maintainers "Jonathan Kimmitt")

(license Apache-2.0)

(documentation https://github.com/jrrk2/openstellina.git)

(package
 (name openstellina)
 (synopsis "A http client for Stellina smart telescope by Vaonis")
 (description "Mobile Stellina App does not provide access to telescope exposures > 20s (lights or darks). This software bypasses the App and talks to the telescope directly")
 (depends ocaml dune lablgtk lwt_glib yojson cohttp-lwt-unix zeit ppx_let quests ppx_yojson lwt)
 (tags (Vaonis Stellina long-exposure GUI)))
 
