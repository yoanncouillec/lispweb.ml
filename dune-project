(lang dune 3.0)

(name lispw)

(generate_opam_files true)

(source
 (gitlab 192.168.1.77:lisp-web/lisp-web.git))

(authors "galaad")

(maintainers "galaad")

(license LICENSE)

(documentation https://url/to/documentation)

(using menhir 2.0)

(package
 (name lispw)
 (synopsis "A flexible language to create modern web applications")
 (description "Use any syntax to create the web application of your dreams")
 (depends ocaml dune)
 (tags
  (web lisp)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
