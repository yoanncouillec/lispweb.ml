(let (math (lambda (msg)
	     (if (equal? msg 'inc) (lambda (n) (+ n 1))
		 0)))
  ((math 'inc) 99))
