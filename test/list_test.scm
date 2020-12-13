(load "lib/assert.scm")
(load "lib/list.scm")

(test-all
 "lib/list.scm"
 (list
  (lambda ()
    (assert "pair? - empty"
	    (pair? (list))
	    :expects #f))
  (lambda ()
    (assert "pair? - not empty"
	    (pair? (list 1 2 3))
	    :expects #t))
  (lambda ()
    (assert "length - empty"
	    (length (list))
	    :expects 0))))






