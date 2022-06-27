(import "standard.scm")
(import "list.scm")
(import "assert.scm")

(begin-test "list.scm")

(assert "length 1" (length (list 1 2 3)) 3)
(assert "length 2" (length (list)) 0)
(assert "length 3" (length (list 'q')) 1)

(assert "pair 1" (pair? (list)) #f)
(assert "pair 2" (pair? (list 1)) #t)

(assert "index-of 1" (index-of 2 (list 1 2 3)) 1)
(assert "index-of 2" (index-of "coucou" (list "coucou" 2 3)) 0)

(assert "first-slice 1" (first-slice 4 (list 1 2 3 4 5 6 7 8 9)) (list 1 2 3))
(assert "first-slice 2" (first-slice 1 (list 1 2 3 4 5 6 7 8 9)) (list))

(assert "split-into-2 1" (split-into-2 5 (list 1 2 3 4 5 6 7 8 9)) (list (list 1 2 3 4) (list 6 7 8 9)))
(assert "split-into-2 2" (split-into-2 9 (list 1 2 3 4 5 6 7 8 9)) (list (list 1 2 3 4 5 6 7 8) (list)))

(assert "is-begin-of 1" (is-begin-of? (list 1) (list 1 2 3 4 5 6 7 8 9)) #t)
(assert "is-begin-of 2" (is-begin-of? (list 1 2 3 4) (list 1 2 3 4 5 6 7 8 9)) #t)
(assert "is-begin-of 3" (is-begin-of? (list 1 2 3 99) (list 1 2 3 4 5 6 7 8 9)) #f)

(assert "drop 1" (drop (list 1 2 3 4 5 6 7 8 9) 8) (list 9))

(assert "split-into-two 1" (split-into-two (list 3 3 3) (list 1 2 3 3 3 3 4 5)) (list (list 1 2) (list 3 4 5)))

(assert "split 1" (split 5 (list 1 2 3 4 5 6 7 5 9)) (list (list 1 2 3 4) (list 6 7) (list 9)))

(assert "map 1" (map (lambda (x) (+ x 1)) (list 1 2 3 4 5 6 7 5 9)) (list 2 3 4 5 6 7 8 6 10))

(assert "trim-left 1" (trim-left 1 (list 1 1 1 1 2 3 4 5 6 7 8 9)) (list 2 3 4 5 6 7 8 9))

(assert "append 1" (append (list 1 2 3) (list 4 5 6)) (list 1 2 3 4 5 6))

(assert "reverse 1" (reverse (list 1 2 3)) (list 3 2 1))

(assert "trim-right 1" (trim-right 9 (list 6 7 8 9 9 9 9)) (list 6 7 8))

(assert "trim 1" (trim 1 (list 1 1 1 6 7 8 1 1 1)) (list 6 7 8))

(assert "assoc 1" (assoc (list (list 1 'a') (list 2 'b') (list 3 'c')) 2) 'b')

(assert "replace-first 1" (replace-first (list 1 2 3 4 5 6) (list 3 4) (list 9 9)) (list 1 2 9 9 5 6))

(end-test)    
