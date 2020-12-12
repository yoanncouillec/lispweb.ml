(load "lib/assert.scm")
(load "lib/string.scm")

(test-all
 (list
  
  (list "make-string"
	(list
	 (assert
	  (make-string 3 'b')
	  :expects "bbb")
	 (assert
	  (make-string 4 'w')
	  :expects "wwww")))
  
  (list "make-empty-string"
	(list
	 (assert
	  (string-length (make-empty-string 1))
	  :expects 1)))))
