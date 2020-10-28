(define foo
  (lambda (:x 12 a)
    (+ a x)))

(foo :x 1 0)
