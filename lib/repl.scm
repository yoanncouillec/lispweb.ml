(load "lib/channel.scm")
(load "lib/stdout.scm")
(load "lib/load.scm")

(define repl
  (lambda ()
    (print-string "> ")
    (flush (stdout))
    (print (concat " " (list "=" (val->string (load-string (input-line (stdin)))))))
    (print-newline)
    (repl)))

(repl)
