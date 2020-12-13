(define lib "lib/list.scm")

(load "lib/assert.scm")
(load lib)

(test-all
 lib
 (list
  (list "pair?"
	(list
	 (lambda ()
	   (assert "pair?-1"
	    (pair? (list))
	    :expects #f))
	 (lambda ()
	   (assert "pair?-2"
	    (pair? (list 1 2 3))
	    :expects #t)
	   )))
  
  (list "length"
	(list
	 (lambda ()
	   (assert "length-1"
	    (pair? (list))
	    :expects 0))))))






