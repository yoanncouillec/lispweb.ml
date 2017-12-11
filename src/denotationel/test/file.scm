(let* ((s (make-empty-string 10))
       (fd (openfile "test/http.txt" (list "O_RDONLY") "0o660")))
  (map list->string (split ' ' (string->list (read-one-line fd)))))
