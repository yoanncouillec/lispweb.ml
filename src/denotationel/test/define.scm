(begin
  (define abc (lambda (n) (inc (inc n))))
  (define inc (lambda (n) (+ n 1)))
  (define dec (lambda (n) (- n 1)))
  (define inc2 (lambda (n) (+ n 2)))
  (define odd? (lambda (n) (if (equal? n 0) #f (even? (- n 1)))))
  (define even? (lambda (n) (if (equal? n 0) #t (odd? (- n 1)))))
  (odd? 11))
  
