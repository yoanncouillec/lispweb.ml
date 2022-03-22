(import "string.scm")
(import "socket.scm")
(import "channel.scm")
(import "stdout.scm")
(import "ssl.scm")
(import "file.scm")

(define http-parse-queryparams
  (lambda (queryparams)
      (map (lambda (p)
	     (let (res (split '=' p))
	       (list
		(list->string (car res))
		(list->string (car (cdr res)))))
	     )
	   (split '&' queryparams))))

(define http-parse-method
  (lambda (read fd)
    (let* ((fst-line (map list->string (split ' ' (string->list (read-line read fd)))))
	   (method (car fst-line))
	   (path (car (cdr fst-line)))
	   (pathqueryparams (split-into-2 '?' (string->list path)))
	   (path (list->string (car pathqueryparams)))
	   (queryparams (http-parse-queryparams (car (cdr pathqueryparams))))
	   (protocol (car (cdr (cdr fst-line)))))
      (list method path queryparams protocol))))

(define http-parse-response-status
  (lambda (l)
    (let* ((fst-line (map list->string (split ' ' (string->list l))))
	   (version (car fst-line))
	   (code (car (cdr fst-line)))
	   (phrase (car (cdr (cdr fst-line)))))
      (list version code phrase))))

(define http-parse-header
  (lambda (in)
    (map list->string (split ':' (string->list (input-line in))))))

(define http-parse-headers
  (lambda (read fd)
    (let* ((l (read-line read fd)))
      (if (equal? "" l)
	    l
	    (let* ((header (split-into-2 ':' (string->list l)))
		   (len (length header)))
	      (cons (map list->string 
			 header)
		    (http-parse-headers read fd)))))))

(define http-parse-headers-light
  (lambda (read fd)
    (let* ((l (read-line read fd)))
      (if (equal? "" l)
	  l
	  (cons l (http-parse-headers-light read fd))))))

(define http-send-response
  (lambda (fd code type content)
    (write-lines
     fd
     (list
      (concat " " (list "HTTP/1.1" code "OK"))
      (concat " " (list "Content-Length:" (int->string (string-length content))))
      (concat " " (list "Content-Type:" type))))
    (write-char fd '\n')
    (write-string fd content)
    (shutdown fd "SHUTDOWN_ALL")))

(define read-all
  (lambda (fd)
    (let* ((s (make-empty-string 1)))
      (if (equal? (read fd s 0 1) 0)
	  (list)
	  (cons s (read-all fd))))))

(define serve
  (lambda (client saddr service)
    (let* ((first-line (http-parse-method read client))
	   (method (car first-line))
	   (path (car (cdr first-line)))
	   (queryparams (car (cdr (cdr first-line))))
	   (protocol (car (cdr (cdr (cdr first-line)))))
	   (headers (http-parse-headers-light read client)))
      (service client saddr method path queryparams protocol headers))))
    
(define accept-client
  (lambda (server service)
    (let* ((client_saddr (accept server))
	   (client (car client_saddr))
	   (saddr (car (cdr client_saddr))))
      (serve client saddr service)
      (accept-client server service))))

(define http-run-server
  (lambda (port service)
    (let* ((server-socket (socket "PF_INET" "SOCK_STREAM" 0))
	   (sockaddr (addr_inet (inet_addr_any) port)))
      (bind server-socket sockaddr)
      (listen server-socket 10)
      (accept-client server-socket service))))
