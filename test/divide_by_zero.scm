(define divide
  (lambda (a b)
    (if (equal? b 0)
	(throw division-by-zero "division by zero")
	(/ a b))))

(list
 (catch division-by-zero
	(divide 42 0))

 (block division-by-zero-from
	(let (divide
	      (lambda (a b)
		(if (equal? b 0)
		    (return-from division-by-zero-from "division by zero from")
		    (/ a b))))
	  (divide 42 0))))
