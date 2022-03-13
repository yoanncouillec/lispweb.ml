(define foo
  (lambda (x :y 12)
    (+ x y)))

(foo :y 50 12)
