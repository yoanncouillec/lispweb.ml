(define lib "lib/string.scm")

(load "lib/assert.scm")
(load lib)

(test-all
 lib
 (list
  
  (lambda ()
    (assert "make-string-1"
	    (make-string 3 'b')
	    :expects "bbb"))
  (lambda ()
    (assert "make-string-2"
	    (make-string 4 'w')
	    :expects "wwww"))
  
  (lambda ()
    (assert "make-empty-string-1"
	    (string-length (make-empty-string 1))
	    :expects 1))

  (lambda () (assert "make-regexp-1" #f))

  (lambda () (assert "global-replace-1" #f))

  (lambda ()(assert "global-replace-list-1" #f))

  (lambda ()
    (assert "string->list-1"
	    (string->list "qwerty")
	    :expects (list 'q' 'w' 'e' 'r' 't' 'y')))

  (lambda ()
    (assert "list->string-1"
	    (list->string (list 'q' 'w' 'e' 'r' 't' 'y'))
	    :expects "qwerty"))

  (lambda ()
    (assert "string-length-1"
	    (string-length "qwerty")
	    :expects 6))

  (lambda ()
    (assert "get-char-1"
	    (get-char "qwerty" 3)
	    :expects 'r'))
  
  (lambda ()
    (assert "sub-string-1"
	    (sub-string "qwerty" 1 2)
	    :expects "we"))
  
  (lambda ()
    (assert "char->string-1"
	    (char->string 'q')
	    :expects "q"))

  (lambda () (assert "char->byte-1" #f))

  (lambda ()
    (assert "concat-1"
	    (concat "_" (list "a" (int->string 1)))
	    :expects "a_1"))

  (lambda ()
    (assert "string-concat-1"
	    (string-concat (list "a" (int->string 1)))
	    :expects "a1"))

  (lambda ()
    (assert "string-concat-sep-1"
	    (string-concat-sep "x" (list "a" (int->string 1)))
	    :expects "ax1"))
  
  ))
