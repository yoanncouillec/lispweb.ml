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
	    :expects 0))
  (lambda ()
    (assert "length - not empty"
	    (length (list 1 2 3))
	    :expects 3))
  (lambda ()
    (assert "index-of"
	    (index-of 2 (list 1 2 3))
	    :expects 1))
  (lambda ()
    (assert "first-slice"
	    (first-slice 9 (list 1 2 3 9 4 5))
	    :expects (list 1 2 3)))
  (lambda ()
    (assert "split-into-2"
	    (split-into-2 9 (list 1 2 3 9 4 5))
	    :expects (list (list 1 2 3) (list 4 5))))
  (lambda ()
    (assert "is-begin-of?"
	    (is-begin-of? (list 1 2) (list 1 2 3 9 4 5))
	    :expects #t))
  (lambda ()
    (assert "is-begin-of?"
	    (is-begin-of? (list 9 2) (list 1 2 3 9 4 5))
	    :expects #f))
  (lambda ()
    (assert "drop"
	    (drop (list 1 2 3 9 4 5) 4)
	    :expects (list 4 5)))
  (lambda ()
    (assert "split-into-two"
	    (split-into-two (list 2 3) (list 1 2 3 9 4 5))
	    :expects (list (list 1) (list 9 4 5))))
  (lambda ()
    (assert "split"
	    (split 9 (list 1 2 3 9 4 5 9 6))
	    :expects (list (list 1 2 3) (list 4 5) (list 6))))
  (lambda ()
    (assert "map"
	    (map (lambda (e) (< e 0)) (list -1 2 0 3 -9))
	    :expects (list #t #f #f #f #t)))
  (lambda ()
    (assert "trim-left"
	    (trim-left 0 (list 0 0 0 3 -9))
	    :expects (list 3 -9)))
  (lambda ()
    (assert "append"
	    (append (list 1 2 3) (list 4 5 6))
	    :expects (list 1 2 3 4 5 6)))
  (lambda ()
    (assert "reverse"
	    (reverse (list 1 2 3))
	    :expects (list 3 2 1)))
  (lambda ()
    (assert "trim-right"
	    (trim-right 9 (list 1 2 3 9 9 9))
	    :expects (list 1 2 3)))
  (lambda ()
    (assert "trim"
	    (trim 9 (list 9 9 1 2 3 9 9 9))
	    :expects (list 1 2 3)))
  (lambda ()
    (assert "assoc"
	    (assoc (list (list 'a' 1) (list 'b' 2) (list 'c' 3)) 'b')
	    :expects 2))
  (lambda ()
    (assert "replace-first"
	    (replace-first (list 'a' 1 'b' 2 'c' 3) (list 1 'b' 2) (list 9 9 9))
	    :expects (list 'a' 9 9 9 'c' 3)))
  ))






