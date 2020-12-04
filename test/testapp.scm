(load "lib/assert.scm")

(assert
 :expects 12
 ((lambda (x :k1 10) (+ x k1)) 12 :k1 0))

