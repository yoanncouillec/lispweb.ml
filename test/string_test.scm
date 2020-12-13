(define lib "lib/string.scm")

(load "lib/assert.scm")
(load lib)

(test-all
 lib
 (list
  
  (list "make-string"
	(list
	 (lambda ()
	   (assert "make-string-1"
	    (make-string 3 'b')
	    :expects "bbb"))
	 (lambda ()
	   (assert "make-string-2"
	    (make-string 4 'w')
	    :expects "wwww"))))
  
  (list "make-empty-string"
	(list
	 (lambda ()
	   (assert "make-empty-string-1"
	    (string-length (make-empty-string 1))
	    :expects 1))))

  (list "make-regexp"
	(list
	 (lambda () (assert "make-regexp-1" #f))))

  (list "global-replace"
	(list
	 (lambda () (assert "global-replace-1" #f))))

  (list "global-replace-list"
	(list
	 (lambda ()(assert "global-replace-list-1" #f))))

  (list "string->list"
	(list
	 (lambda ()
	   (assert "string->list-1"
	    (string->list "qwerty")
	    :expects (list 'q' 'w' 'e' 'r' 't' 'y')))))

  (list "list->string"
	(list
	 (lambda ()
	   (assert "list->string-1"
	    (list->string (list 'q' 'w' 'e' 'r' 't' 'y'))
	    :expects "qwerty"))))

  (list "string-length"
	(list
	 (lambda ()
	   (assert "string-length-1"
	    (string-length "qwerty")
	    :expects 6))))

  (list "get-char"
	(list
	 (lambda ()
	   (assert "get-char-1"
	    (get-char "qwerty" 3)
	    :expects 'r'))))
  
  (list "sub-string"
	(list
	 (lambda ()
	   (assert "sub-string-1"
	    (sub-string "qwerty" 1 2)
	    :expects "we"))))
  
  (list "char->string"
	(list
	 (lambda ()
	   (assert "char->string-1"
	    (char->string 'q')
	    :expects "q"))))

  (list "char->byte"
	(list
	 (lambda () (assert "char->byte-1" #f))))

  (list "concat"
	(list
	 (lambda ()
	   (assert "concat-1"
	    (concat "_" (list "a" (int->string 1)))
	    :expects "a_1"))))

  (list "string-concat"
	(list
	 (lambda ()
	   (assert "string-concat-1"
	    (string-concat (list "a" (int->string 1)))
	    :expects "a1"))))

  (list "string-concat-sep"
	(list
	 (lambda ()
	   (assert "string-concat-sep-1"
	    (string-concat-sep "x" (list "a" (int->string 1)))
	    :expects "ax1"))))
  
  ))
