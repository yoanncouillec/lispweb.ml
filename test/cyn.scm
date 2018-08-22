(load "lib/stdout.scm")
(load "lib/list.scm")
(load "lib/string.scm")

(let (l0 (list (list "yoann" "cynthia") (list "kukuye" "umbii")))
  (map (lambda (e) (print e)) (map (lambda (l) (concat " " (list (car l) "aime" (car (cdr l))))) l0)))
