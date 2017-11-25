(let (first? (lambda (e) (lambda (l) (if (equal? l (list)) #f (if (equal? (car l) e) (throw exn #t) #f)))))
  (catch exn
	 ((first? 12) (list 12))))
