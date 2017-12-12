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
    (let* ((l (read-line fd)))
      (if (equal? (list) l)
	  l
	  (cons (map list->string (split ':' l)) (http-parse-headers fd))))))

(define read-all
  (lambda (fd)
    (let* ((s (make-empty-string 1)))
      (if (equal? (read fd s 0 1) 0)
	  (list)
	  (cons s (read-all fd))))))
