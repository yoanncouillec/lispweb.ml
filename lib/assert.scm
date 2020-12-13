(load "lib/string.scm")
(load "lib/stdout.scm")
(load "lib/list.scm")
(load "lib/ansiterminal.scm")

(define assert-true
  (lambda (value)
    value))

(define assert
  (lambda (value :expects #f)
    (if (not (equal? value expects))
	(begin
	  #f)
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
		(style-print-string (list (style "green")) (concat "" (list "  " (if (< n 10) " " "") (int->string n) ".PASSED ")))
		(print (car t))
		(test-all-aux (+ c 1) (+ n 1) (cdr l)))
	      (begin
		(style-print-string (list (style "red") (style "bold")) (concat "" (list "  " (if (< n 10) " " "") (int->string n) ".FAILED ")))
		(style-print-string (list (style "bold")) (car t))
		(print-newline)
		(test-all-aux c (+ n 1) (cdr l)))))
	c)))

(define test-all
  (lambda (name l)
    (style-print-string (list (style "inverse") (style "bold")) (concat " " (list "TEST" name)))
    (print-newline)
    (let ((c (test-all-aux 0 1 l)))
      (style-print-string
       (list (style "bold") (if (equal? c (length l)) (style "green") (style "red")) (style "inverse"))
       (concat "" (list ""
			(int->string c)
			"/"
			(int->string (length l))
			""))))
    (print-newline)))

