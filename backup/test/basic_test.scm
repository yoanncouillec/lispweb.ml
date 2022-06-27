(import "lib/assert.scm")

(test-all
 "basic"
 (list
  
  (lambda ()
    (assert "integer"
	    (begin
	      1)
	    :expects 1))
  
  (lambda ()
    (assert "boolean"
	    (begin
	      #t)
	    :expects #t))
  
  (lambda ()
    (assert "boolean"
	    (begin
	      #f)
	    :expects #f))

  (lambda ()
    (assert "string"
	    (begin
	      "asd")
	    :expects "asd"))

  (lambda ()
    (assert "add"
	    (begin
	      (+1 2))
	    :expects 3))
    
  (lambda ()
    (assert "add"
	    (begin
	      (let (a 1)
		(let (b 2)
		  (+ a b))))
	    :expects 3))
  
  (lambda ()
    (assert "first"
	    (begin
	      (let (first (lambda (x) (lambda (y) x)))
		(let (second (lambda (x) (lambda (y) y)))
		  (list
		   ((first 1) 2)
		   ((second 1) 2)))))
	    :expects (list 1 2)))

  (lambda ()
    (assert "let"
	    (begin
	      (let (x 12) x))
	    :expects 12))

  (lambda ()
    (assert "set!"
	    (begin
	      (let (x 0) (begin (set! x 12) x)))
	    :expects 12))

  (lambda ()
    (assert "equal?"
	    (begin
	      (let (x 1) (if (equal? x 0) 10 11)))
	    :expects 11))

  (lambda ()
    (assert "application"
	    (begin
	      ((lambda (x) x) 12))
	    :expects 12))

  (lambda ()
    (assert "application"
	    (begin
	      (let (f (lambda (x) x)) (f 12)))
	    :expects 12))

  (lambda ()
    (assert "letrec"
	    (begin
	      (letrec (fact (lambda (n) (if (equal? n 0) 1 (* (fact (- n 1)) n)))) (* 2 (fact 3))))
	    :expects 12))

  (lambda ()
    (assert "let"
	    (begin
	      (let (f (lambda (x) (+ x x)))
		(let (a 12)
		  (f a)))
	      )
	    :expects 24))

  (lambda ()
    (assert "catch/throw"
	    (begin
	      (catch e
		     (throw e 12))
	      (let (f (lambda (x) (throw exn 13)))
		(catch exn (f 11)))
	      )
	    :expects 13))

  (lambda ()
    (assert "block/return-from"
	    (begin
	      (block funny-error
		     (return-from funny-error 12))
	      )
	    :expects 12))

  (lambda ()
    (assert "define"
	    (begin
	      (define inc (lambda (n) (+ n 1)))
	      (inc 11)
	      )
	    :expects 12))

  (lambda ()
    (assert "define - mutually recursive"
	    (begin
	      (define odd? (lambda (n) (if (equal? n 0) #f (even? (- n 1)))))
	      (define even? (lambda (n) (if (equal? n 0) #t (odd? (- n 1)))))
	      (and (even? 0) (odd? 1))
	      )
	    :expects #t))

  (lambda ()
    (assert "callcc"
	    (begin
	      (call/cc exit 
		       (let (zero? 
			     (lambda (x)
			       (if (equal? x 0)
				   (exit 123)
				   (exit 999))))
			 (zero? 0)))
	      )
	    :expects 123))

  ))
