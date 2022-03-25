(import "channel.scm")
(import "stdout.scm")
(import "load.scm")

(define repl
  (lambda ()
    (print-string ">>> ")
    (flush (stdout))
    (print (val->string (load-string (input-line (stdin)))))
    (repl)))
