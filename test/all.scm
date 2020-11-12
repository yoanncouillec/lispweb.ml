(list
 1
 #t
 #f
 "asd"
 (+ 1 2)
 (let (x 12) x)
 (let (x 0) (begin (set! x 12) x))
 (let (x 1) (if (equal? x 0) 10 11))
 ((lambda (x) x) 12)
 (let (f (lambda (x) x)) (f 12))
 (letrec (fact (lambda (n) (if (equal? n 0) 1 (* (fact (- n 1)) n))))
   (* 2 (fact 3)))
 )
