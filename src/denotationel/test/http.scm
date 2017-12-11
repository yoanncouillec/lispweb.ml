(http-parse-first-line (openfile "test/http.txt" (list "O_RDONLY") "0o660"))
(catch error (http-parse-first-line (openfile "test/http_err.txt" (list "O_RDONLY") "0o660")))
