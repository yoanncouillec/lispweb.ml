(define lib "lib/string.scm")

(load "lib/assert.scm")
(load lib)

(test-all lib
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
	  :expects 1)))

  (list "string-length"
	(list
	 (assert
	  (string-length "qwerty")
	  :expects 6)))

  (list "string->list"
	(list
	 (assert
	  (string->list "qwerty")
	  :expects (list 'q' 'w' 'e' 'r' 't' 'y'))))

  (list "list->string"
	(list
	 (assert
	  (list->string (list 'q' 'w' 'e' 'r' 't' 'y'))
	  :expects "qwerty")))

  (list "get-char"
	(list
	 (assert
	  (get-char "qwerty" 3)
	  :expects 'r')))
  
  ))
