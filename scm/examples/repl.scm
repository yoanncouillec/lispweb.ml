(import "repl.scm")

(print
 (val->string
  (catch 'end-of-file
	 (repl))))
