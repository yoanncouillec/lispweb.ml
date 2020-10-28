(define factorial
  (lambda (n)
    (if (equal? n 0)
	1
	(* n (factorial (- n 1))))))
(list
 (factorial 6)
 (factorial 7))
