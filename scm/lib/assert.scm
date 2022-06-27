(import "string.scm")
(import "stdout.scm")
(import "list.scm")
(import "ansiterminal.scm")

(define assert-true
  (lambda (value)
    value))

(define assert
  (lambda (name value :expects #t)
    (if (not (equal? value expects))
	(begin
	  (style-print-string (list (style "red") (style "bold")) "FAILED ")
	  (style-print-string (list (style "bold")) name)
	  (style-print-string (list (style "bold"))  (concat "" (list ": expecting " (val->string expects) " got " (val->string value))))
	  (print-newline)
	  #f)
	(begin
	  (style-print-string (list (style "green")) "PASSED ")
	  (print name)
	  #t))))

(define test-aux
  (lambda (l)
    (if (pair? l)
	(if (equal? ((car l)) #t)
	    (test-aux (cdr l))
	    #f)
	#t)))

(define test-all-aux
  (lambda (c n l)
    (if (pair? l)
	(let ((t (car l)))
	  (if (t)
	      (begin
		(test-all-aux (+ c 1) (+ n 1) (cdr l)))
	      (begin
		(test-all-aux c (+ n 1) (cdr l)))))
	c)))

(define test-all
  (lambda (name l)
    (style-print-string (list (style "inverse") (style "bold")) (concat " " (list " TEST" name " ")))
    (print-newline)
    (let* ((c (test-all-aux 0 1 l)))
      (style-print-string
       (list (style "bold") (if (equal? c (length l)) (style "green") (style "red")) (style "inverse"))
       (concat "" (list " "
			(int->string c)
			"/"
			(int->string (length l))
			" "))))
    (print-newline)))

(define begin-test
  (lambda (name)
    (define logger (logger (getenv "LEVEL")))
    (logger "INFO" name)    
    (define tests-success 0)
    (define tests-total 0)))

(define assert
  (lambda (name result expected)
    (set! tests-total (+ 1 tests-total))
    (if (equal? expected result)
	(begin
	  (logger "SUCCESS" name)
	  (set! tests-success (+ 1 tests-success)))
	(begin
	  (logger "FAIL" name)
	  (logger "FAIL" (string-concat-sep " " (list "expected:" (val->string expected))))
	  (logger "FAIL" (string-concat-sep " " (list "result:" (val->string result))))))))

(define end-test
  (lambda ()
    (if (equal? tests-success tests-total)
	(logger "SUCCESS" (string-concat-sep " " (list (val->string tests-success) "/" (val->string tests-total))))
	(begin
	  (logger "SUCCESS" (string-concat-sep " " (list (val->string tests-success) "/" (val->string tests-total))))
	  (logger "FAIL" (string-concat-sep " " (list (val->string (- tests-total tests-success)) "/" (val->string tests-total))))))))
