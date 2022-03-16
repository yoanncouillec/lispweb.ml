(letrec (fact (lambda (n)
		(if (equal? n 0)
		    1
		    (* n (fact (- n 1))))))
  (fact 3))
