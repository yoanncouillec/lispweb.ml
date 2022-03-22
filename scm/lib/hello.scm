(import "stdout.scm")
(import "string.scm")

(define hello (lambda (:name "World!") (concat " " (list "Hello" name))))

(define welcome (lambda (:name "World!") (concat " " (list "Welcome" name))))
