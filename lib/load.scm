(load "lib/file.scm")
(load "lib/wget.scm")

(define load-string
  (lambda (string)
    (eval (string->expr string))))

(define load-file
  (lambda (filename)
    (load-string (openfile filename "O_RDONLY" "0666"))))

(define load-url
  (lambda (scheme host port path)
    (load-string (wget scheme host port path))))
