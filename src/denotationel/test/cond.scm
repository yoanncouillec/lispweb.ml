(let (math (lambda (msg)
	     (cond msg
		   (inc (lambda (n) (+ n 1)))
		   (dec (lambda (n) (- n 1)))
		   (else 
      
