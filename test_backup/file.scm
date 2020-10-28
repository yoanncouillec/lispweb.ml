(load "lib/string.scm")
(load "lib/file.scm")
(load "lib/stdout.scm")

(let* ((s (make-empty-string 10))
       (fd (openfile "test/http.txt" (list "O_RDONLY") "0o660")))
  (read fd s 0 10)
  (print-line s))
