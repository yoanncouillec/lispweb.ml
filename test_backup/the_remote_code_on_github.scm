(load "lib/stdout.scm")

(define say-hey
  (lambda (x)
    (print-string "Hey ")
    (print-string x)
    (print-line "! I am a code downloaded on github :-)")))
