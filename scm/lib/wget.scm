(import "ssl.scm")
(import "socket.scm")
(import "string.scm")
(import "bytes.scm")
(import "stdout.scm")
(import "file.scm")
(import "http.scm")

(define url-get-content
  (lambda (fd read write host path)
    (let* ((s (concat 
	       "" 
	       (list "GET " path " HTTP/1.1" (make-string 1 '\n') 
		     "Host: " host 
		     (make-string 1 '\n') 
		     (make-string 1 '\n')))))
      (let* ((b (string->bytes s)))
	(write fd b 0 (bytes-length b))
	(let* ((status (http-parse-response-status (read-line read fd)))
	       (headers (http-parse-headers read fd))
	       (content-length-header (assoc headers "Content-Length"))
	       (l (string->int (list->string (trim-left ' ' (string->list content-length-header))))))
	  (let (content (bytes-create l))
	    (read fd content 0 l)
	    (let (s (bytes->string content))
	      s)))))))

(define wget
  (lambda (scheme host port path)
    (begin
      (if (equal? scheme "https")
	  (begin
	    (let (fd (ssl-make-client host port))
	      (let (read ssl-read)
		(let (write ssl-write)
		  (url-get-content fd read write host path)))))
	  (begin
	    (print-string "wget|not implemented|scheme http|")
	    (print scheme))))))
