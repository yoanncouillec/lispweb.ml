(load "lib/string.scm")
(load "lib/stdout.scm")
(load "lib/list.scm")

(define assert
  (lambda (value :expects #f)
    (if (not (equal? value expects))
	#f
	#t)))

(define test-aux
  (lambda (l)
    (if (pair? l)
	(if (equal? (car l) #t)
	    (test-aux (cdr l))
	    #f)
	#t)))

(define test-all-aux
  (lambda (c n l)
    (if (pair? l)
	(let ((t (car l)))
	  (if (test-aux (car (cdr t)))
	      (begin
		(print
		 (concat " "
			 (list "PASSED"
			       (car t))))
		(test-all-aux (+ c 1) (+ n 1) (cdr l)))
	      (begin
		(print
		 (concat " "
			 (list "FAILED"
			       (car t))))
		(test-all-aux c (+ n 1) (cdr l)))))
	(print
	 (concat "" (list (int->string c)
			  "/"
			  (int->string (+ n (length l)))))))))

(define test-all
  (lambda (l)
    (test-all-aux 0 0 l)))

