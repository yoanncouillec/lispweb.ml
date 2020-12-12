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

  (list "make-regexp"
	(list
	 #f))

  (list "global-replace"
	(list
	 #f))

  (list "global-replace-list"
	(list
	 #f))

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

  (list "string-length"
	(list
	 (assert
	  (string-length "qwerty")
	  :expects 6)))

  (list "get-char"
	(list
	 (assert
	  (get-char "qwerty" 3)
	  :expects 'r')))
  
  (list "sub-string"
	(list
	 (assert
	  (sub-string "qwerty" 1 2)
	  :expects "we")))
  
  (list "char->string"
	(list
	 (assert
	  (char->string 'q')
	  :expects "q")))

  (list "char->byte"
	(list
	 #f))

  (list "concat"
	(list
	 (assert
	  (concat "_" (list "a" (int->string 1)))
	  :expects "a_1")))

  (list "string-concat"
	(list
	 (assert
	  (string-concat (list "a" (int->string 1)))
	  :expects "a1")))

    (list "string-concat-sep"
	(list
	 (assert
	  (string-concat-sep "x" (list "a" (int->string 1)))
	  :expects "ax1")))
    
  ))
