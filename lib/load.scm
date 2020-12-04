(load "lib/file.scm")
(load "lib/wget.scm")

(define load-file
  (lambda (filename)
    (eval (string->expr (read-file (openfile filename "O_RDONLY" "0666"))))))

(define load-url
  (lambda (scheme host port path)
    (eval (string->expr (wget scheme host port path)))))
