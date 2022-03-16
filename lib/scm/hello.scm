(import "lib/stdout.scm")
(import "lib/string.scm")

(define hello (lambda (:name "World!") (concat " " (list "Hello" name))))
