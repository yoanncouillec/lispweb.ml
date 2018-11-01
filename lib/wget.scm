(load "lib/ssl.scm")
(load "lib/socket.scm")
(load "lib/string.scm")
(load "lib/bytes.scm")
(load "lib/stdout.scm")
(load "lib/file.scm")
(load "lib/http.scm")

(define url-get-content
  (lambda (fd read write host path)
    (let* ((s (concat 
	       "" 
	       (list "GET " path " HTTP/1.1" (make-string 1 '\n') 
		     "Host: " host 
		     (make-string 1 '\n') 
		     (make-string 1 '\n')))))
      (let* ((b (bytes-of-string s)))
	(write fd b 0 (bytes-length b))
	(let* ((status (http-parse-response-status (read-line read fd)))
	       (headers (http-parse-headers read fd))
	       (content-length-header (assoc headers "Content-Length"))
	       (l (string->int (list->string (trim-left ' ' (string->list content-length-header))))))
	  (let (content (bytes-create l))
	    (read fd content 0 l)
	    (let (s (bytes-to-string content))
	      s)))))))

(define wget
  (lambda (scheme host port path)
    (if (equal? scheme "https")
	(let* ((fd (ssl-make-client host port))
	       (read ssl-read)
	       (write ssl-write))
	  (url-get-content fd read write host path))
	(begin (print "error")))))
