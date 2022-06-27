(import "standard.scm")
(import "repl.scm")

(print "Lispw 1.0.0")

(print
 (val->string
  (catch 'end-of-file
	 (repl))))
