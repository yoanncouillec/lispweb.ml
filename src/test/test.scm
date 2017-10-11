(let ()
  (list
   1
   "abc"
   (make-string 10)
   '(+ 1 2)
   #t
   #f
   (+ 1 2)
   (if #t 0 1)
   (if #f 0 1)
   (lambda (x) x)
   (lambda (x y) x)
   (let ((x 12)) x)
   (let ((fst (lambda (x y) x))
	 (snd (lambda (x y) y)))
     (fst (snd 1 2) 3))
   (dyn-let ((x 42)) (dyn x))
   (dyn-let ((x 42))
     (let ((fst (lambda (x y) x)))
       (fst 1 2)))
   (dyn-let ((x 42))
     (let ((fst (lambda (x y) (dyn x))))
       (fst 1 2)))
   )
  )  
