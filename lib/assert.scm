(load "lib/string.scm")
(load "lib/stdout.scm")
(load "lib/list.scm")
(load "lib/ansiterminal.scm")

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
  (lambda (c l)
    (if (pair? l)
	(let ((t (car l)))
	  (if (test-aux (car (cdr t)))
	      (begin
		(style-print-string (style "green") "PASSED ")
		(print (car t))
		(test-all-aux (+ c 1) (cdr l)))
	      (begin
		(style-print-string (style "red") "FAILED ")
		(print (car t))
		(test-all-aux c (cdr l)))))
	c)))

(define test-all
  (lambda (name l)
    (print (concat " " (list "TEST" name)))
    (print
     (concat "" (list (int->string (test-all-aux 0 l))
		      "/"
		      (int->string (length l))
		      " (" name ")")))))

