(load "lib/file.scm")
(load "lib/http.scm")

(let* ((fd (openfile "test/http.txt" (list "O_RDONLY") "0o660")))
  (http-parse-method (read-line fd))
  (http-parse-header (read-line fd)))
