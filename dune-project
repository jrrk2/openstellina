(lang dune 3.0)

(name openstellina)
(version opam-publish-openstellina.0.0.3-dirty)

(generate_opam_files true)

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
 (depends ocaml {>= "4.11.0"}
  "ocaml" {>= "4.11.0"}
  "dune" {>= "3.0"}
  "lablgtk" {>= "2.8.12" }
  "lwt_glib" {>= "1.1.1" }
  "yojson" {>= "1.7.0" }
  "cohttp-lwt-unix" {>= "5.0.0" }
  "zeit" {>= "0.1.0" }
  "ppx_let" {>= "0.15.0" }
  "quests" {>= "0.1.3" }
  "ppx_yojson" {>= "1.2.0" }
  "lwt" {>= "5.5.0" }
  "odoc" {with-doc}
)
 (tags (Vaonis Stellina long-exposure GUI)))
 
