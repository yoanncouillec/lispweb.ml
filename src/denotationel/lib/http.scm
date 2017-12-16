(load "lib/string.scm")
(load "lib/socket.scm")
(load "lib/channel.scm")
(load "lib/stdout.scm")

(define http-parse-method
  (lambda (l)
    (let* ((fst-line (map list->string (split ' ' (string->list (input-line l)))))
	   (method (car fst-line))
	   (path (car (cdr fst-line)))
	   (protocol (car (cdr (cdr fst-line)))))
      (if (equal? "GET" method)
	  (list method path protocol)
	  (throw error 'wrong-http-first-line)))))

(define http-parse-header
  (lambda (in)
    (map list->string (split ':' (string->list (input-line in))))))

(define http-parse-headers
  (lambda (in)
    (let* ((l (input-line in)))
      (print-line l)
      (if (equal? "" l)
	  l
	  (cons (map list->string (split ':' (string->list l))) (http-parse-headers in))))))

(define http-parse-headers-light
  (lambda (in)
    (let* ((l (input-line in)))
      (print-line l)
      (if (equal? "" l)
	  l
	  (cons l (http-parse-headers-light in))))))

(define read-all
  (lambda (fd)
    (let* ((s (make-empty-string 1)))
      (if (equal? (read fd s 0 1) 0)
	  (list)
	  (cons s (read-all fd))))))

(define serve
  (lambda (in out)
    (http-parse-method in)
    (http-parse-headers-light in)
    (output-string out "hello")
    (flush out)))
    
(define http-server
  (lambda (port)
    (let* ((server (socket "PF_INET" "SOCK_STREAM" 0))
	   (sockaddr (addr_inet (inet_addr_loopback) port)))
      (bind server sockaddr)
      (listen server 10)
      (accept-client server))))

(define accept-client
  (lambda (server)
    (let* ((client (car (accept server)))
	   (in (in_channel_of_descr client))
	   (out (out_channel_of_descr client)))
      (serve in out)
      (close-out out)
      (accept-client server))))
