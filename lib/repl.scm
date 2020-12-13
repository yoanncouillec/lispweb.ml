(load "lib/channel.scm")
(load "lib/stdout.scm")
(load "lib/load.scm")

(define repl
  (lambda ()
    (print (load-string (input-line (stdin))))
    (repl)))

(repl)
