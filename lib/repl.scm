(load "lib/channel.scm")
(load "lib/stdout.scm")
(load "lib/load.scm")

(define repl
  (lambda ()
    (print (val->string (load-string (input-line (stdin)))))
    (repl)))

(catch end-of-file
       (repl))
(print "Bye!")
