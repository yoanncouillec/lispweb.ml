(import "string.scm")
(import "socket.scm")
(import "channel.scm")
(import "stdout.scm")
(import "ssl.scm")
(import "http.scm")

(define https-serve
  (lambda (ssl-client-socket service)
    (let* ((first-line (http-parse-method ssl-read ssl-client-socket))
	   (method (car first-line))
	   (path (car (cdr first-line)))
	   (queryparams (car (cdr (cdr first-line))))
	   (protocol (car (cdr (cdr (cdr first-line)))))
	   (headers (http-parse-headers-light ssl-read ssl-client-socket)))
      (service ssl-client-socket method path queryparams protocol headers))))

(define https-accept-client
  (lambda (server-socket ctx service)
    (let* ((client-socket (car (accept server-socket)))
	   (ssl-client-socket (ssl-embed-socket client-socket ctx)))
      (ssl-accept ssl-client-socket)
      (https-serve ssl-client-socket service)
      (https-accept-client server-socket ctx service))))

(define https-run-server
  (lambda (port password certfile privkeyfile nbconn service)
    (let* ((ctx (ssl-create-context (ssl-protocol-v23) (ssl-context-type-server))))
      (ssl-set-password ctx password)
      (ssl-use-certificate ctx certfile privkeyfile)
      (let* ((server-socket (socket "PF_INET" "SOCK_STREAM" 0))
	     (sockaddr (addr_inet (inet_addr_any) port)))
	(bind server-socket sockaddr)
	(listen server-socket 10)
	(https-accept-client server-socket ctx service)))))

(define https-threaded-accept-client
  (lambda (server-socket ctx service)
    (let* ((client-socket (car (accept server-socket)))
	   (ssl-client-socket (ssl-embed-socket client-socket ctx)))
      (ssl-accept ssl-client-socket)
      (call-with-new-thread
       (lambda ()
	 (https-serve ssl-client-socket service)))
      (https-accept-client server-socket ctx service))))

(define https-threaded-run-server
  (lambda (port password certfile privkeyfile nbconn service)
    (let* ((ctx (ssl-create-context (ssl-protocol-v23) (ssl-context-type-server))))
      (ssl-set-password ctx password)
      (ssl-use-certificate ctx certfile privkeyfile)
      (let* ((server-socket (socket "PF_INET" "SOCK_STREAM" 0))
	     (sockaddr (addr_inet (inet_addr_any) port)))
	(bind server-socket sockaddr)
	(listen server-socket 10)
	(https-threaded-accept-client server-socket ctx service)))))

(define https-send-response
  (lambda (fd code type content)
    (ssl-write-lines
     fd
     (list
      (concat " " (list "HTTP/1.1" code "OK"))
      (concat " " (list "Content-Length:" (int->string (string-length content))))
      (concat " " (list "Content-Type:" type))))
    (ssl-write-char fd '\n')
    (ssl-write-string fd content)
    (ssl-shutdown fd)))
