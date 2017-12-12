(load "lib/string.scm")

(define http-parse-method
  (lambda (l)
    (let* ((fst-line (map list->string (split ' ' l)))
	   (method (car fst-line))
	   (path (car (cdr fst-line)))
	   (protocol (car (cdr (cdr fst-line)))))
      (if (equal? "GET" method)
	  (list method path protocol)
	  (throw error 'wrong-http-first-line)))))

(define http-parse-header
  (lambda (l)
    (map list->string (split ':' l))))

(define http-parse-headers
  (lambda (fd)
    (let* ((header (read-one-line fd)))
      (if (equal? "" header)
	  (list)
	  (cons (map list->string (split ' ' (string->list header))) (http-parse-headers fd))))))
