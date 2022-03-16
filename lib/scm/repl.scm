(import "lib/channel.scm")
(import "lib/stdout.scm")
(import "lib/load.scm")

(define repl
  (lambda ()
    (print (val->string (import-string (input-line (stdin)))))
    (repl)))

(catch end-of-file
       (repl))
(print "Bye!")
