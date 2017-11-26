(call/cc exit 
	 (let (zero? 
	       (lambda (x)
		 (if (equal? x 0)
		     (exit #t)
		     (exit #f))))
	   (zero? 0)))

