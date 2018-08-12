(load "lib/ssl.scm")
(load "lib/socket.scm")
(load "lib/string.scm")
(load "lib/bytes.scm")
(load "lib/stdout.scm")
(load "lib/file.scm")
(load "lib/http.scm")

(define read-all
  (lambda (ssl)
    (let* ((bufsize 1024)
	   (buff (bytes-create bufsize))
	   (r (ssl-read ssl buff 0 bufsize))
	   (s (bytes-to-string buff)))
      (print-line s)
      (read-all ssl))))

(let* ((scheme "https")
       (host "raw.githubusercontent.com")
       (port 443)
       (path "/yoanncouillec/lispweb.ml/master/test/test.scm"))
  (ssl-init)
  (let* ((he (gethostbyname host))
	 (sockaddr (addr_inet (inet_addr_of_host_entry he) port))
	 (ssl (ssl-open-connection (ssl-protocol-v23) sockaddr))
	 (cert (ssl-get-certificate ssl))
	 (cipher (ssl-get-cipher ssl))
	 (issuer(ssl-get-issuer cert))
	 (subject (ssl-get-subject cert))
	 (cipher_name (ssl-get-cipher-name cipher))
	 (cipher_version (ssl-get-cipher-version cipher))
	 (cipher_description (ssl-get-cipher-description cipher))
	 (s (concat "" (list "GET " path " HTTP/1.1" (make-string 1 '\n') "Host: " host (make-string 1 '\n') (make-string 1 '\n'))))
	 (b (bytes-of-string s)))
    (ssl-write ssl b 0 (bytes-length b))
    (let* ((status (http-parse-response-status (read-line ssl-read ssl)))
	   (headers (http-parse-headers ssl-read ssl))
	   (l (string->int (list->string (trim-left ' ' (string->list (assoc headers "Content-Length")))))))
      (print (car (cdr status)))
      (let (content (bytes-create l))
	(ssl-read ssl content 0 l)
	(let (s (bytes-to-string content))
	  (eval s)
	  (foo)
	  )))))




