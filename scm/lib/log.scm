(import "time.scm")

(define log
  (lambda (msg)
    (print (concat "" (list "[" (time->string (gettimeofday)) "] " msg)))))
