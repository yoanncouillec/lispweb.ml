(load "lib/stdout.scm")
(load "lib/string.scm")

(define hello (lambda (:name "World!") (concat " " (list "Hello" name))))
