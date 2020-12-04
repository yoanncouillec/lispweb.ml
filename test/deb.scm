(load "lib/stdout.scm")

(define rec
  (lambda (a b)
    (if (equal? a 0)
	b
	(begin
	  (print "continue")
	  (rec (- a 1) b)))))

(rec 20 21)


