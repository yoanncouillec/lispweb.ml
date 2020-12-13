(define lib "lib/list.scm")

(load "lib/assert.scm")
(load lib)



(test-all lib
 (list
  
  (list "pair?"
	(list
	 (assert
	  (pair? (list))
	  :expects #f)
	 (assert
	  (pair? (list 1 2 3))
	  :expects #t)
	 ))
  ))




