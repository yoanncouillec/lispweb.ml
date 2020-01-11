(load "lib/stdout.scm")

(define foo
  (lambda (x)
    (print-string "Hey ")
    (print-string x)
    (print-endline "! I am a code downloaded on github :-)")))
