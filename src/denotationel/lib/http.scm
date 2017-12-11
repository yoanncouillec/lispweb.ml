(define http-parse-first-line
  (lambda (fd)
    (let* ((fst-line (map list->string (split ' ' (string->list (read-one-line fd)))))
	   (method (car fst-line))
	   (path (car (cdr fst-line)))
	   (protocol (car (cdr (cdr fst-line)))))
      (if (equal? "GET" method)
	  (list method path protocol)
	  (throw error 'wrong-http-first-line)))))
