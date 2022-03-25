(import "repl.scm")

(print "Welcome to Lispw")

(print
 (val->string
  (catch 'end-of-file
	 (repl))))
