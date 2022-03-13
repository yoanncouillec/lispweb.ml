(import "lib/assert.scm")
(import "lib/string.scm")

(test-all
 "lib/string.scm"
 (list
  
  (lambda ()
    (assert "make-string"
	    (make-string 3 'b')
	    :expects "bbb"))
  (lambda ()
    (assert "make-string"
	    (make-string 4 'w')
	    :expects "wwww"))
  
  (lambda ()
    (assert "make-empty-string"
	    (string-length (make-empty-string 1))
	    :expects 1))

  (lambda () (assert "make-regexp" #f))

  (lambda () (assert "global-replace" #f))

  (lambda ()(assert "global-replace-list" #f))

  (lambda ()
    (assert "string->list"
	    (string->list "qwerty")
	    :expects (list 'q' 'w' 'e' 'r' 't' 'y')))

  (lambda ()
    (assert "list->string"
	    (list->string (list 'q' 'w' 'e' 'r' 't' 'y'))
	    :expects "qwerty"))

  (lambda ()
    (assert "string-length"
	    (string-length "qwerty")
	    :expects 6))

  (lambda ()
    (assert "get-char"
	    (get-char "qwerty" 3)
	    :expects 'r'))
  
  (lambda ()
    (assert "sub-string"
	    (sub-string "qwerty" 1 2)
	    :expects "we"))
  
  (lambda ()
    (assert "char->string"
	    (char->string 'q')
	    :expects "q"))

  (lambda () (assert "char->byte" #f))

  (lambda ()
    (assert "concat"
	    (concat "_" (list "a" (int->string 1)))
	    :expects "a_1"))

  (lambda ()
    (assert "string-concat"
	    (string-concat (list "a" (int->string 1)))
	    :expects "a1"))

  (lambda ()
    (assert "string-concat-sep"
	    (string-concat-sep "x" (list "a" (int->string 1)))
	    :expects "ax1"))
  
  ))
