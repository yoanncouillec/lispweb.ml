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
    (define tests-total 0)
    (define tests-fail 0)
    (define tests-todo 0)))    

(define assert
  (lambda (name result expected)
    (set! tests-total (+ 1 tests-total))
    (if (equal? expected result)
	(begin
	  (logger "SUCCESS" name)
	  (set! tests-success (+ 1 tests-success)))
	(begin
	  (set! tests-fail (+ 1 tests-fail))
	  (logger "FAIL" name)
	  (logger "FAIL" (string-concat-sep " " (list "expected:" (val->string expected))))
	  (logger "FAIL" (string-concat-sep " " (list "result:" (val->string result))))))))

(define assert
  (lambda (name result expected)
    (set! tests-total (+ 1 tests-total))
    (if (equal? expected result)
	(begin
	  (logger "SUCCESS" name)
	  (set! tests-success (+ 1 tests-success)))
	(begin
	  (logger "FAIL"
		  (string-concat-sep ", "
				     (list name
					   (string-concat-sep " " (list "expected:" (val->string expected)))
					   (string-concat-sep " " (list "result:" (val->string result))))))))))

(define assert-todo
  (lambda (name)
    (begin
      (set! tests-todo (+ 1 tests-todo))
      (set! tests-total (+ 1 tests-total))      
      (logger "WARNING" (string-concat-sep " " (list name "TODO"))))))

(define end-test
  (lambda ()
    (begin
      (logger "SUCCESS" (string-concat-sep " " (list (val->string tests-success) "/" (val->string tests-total))))
      (if (not (equal? tests-todo 0)) (logger "WARNING" (string-concat-sep " " (list (val->string tests-todo) "/" (val->string tests-total)))))
      (if (not (equal? tests-fail 0)) (logger "FAIL" (string-concat-sep " " (list (val->string tests-fail) "/" (val->string tests-total))))))))

