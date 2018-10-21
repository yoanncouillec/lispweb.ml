(load "lib/stdout.scm")

(define bar
  (lambda (x)
    (print (string-concat "bar" x))))
