(load "lib/ssl.scm")
(load "lib/socket.scm")
(load "lib/string.scm")
(load "lib/bytes.scm")
(load "lib/stdout.scm")
(load "lib/file.scm")
(load "lib/http.scm")
(load "lib/wget.scm")

(define read-all
  (lambda (ssl)
    (let* ((bufsize 1024)
	   (buff (bytes-create bufsize))
	   (r (ssl-read ssl buff 0 bufsize))
	   (s (bytes-to-string buff)))
      (read-all ssl))))

(define load-url
  (lambda (scheme host port path)
    (let (content (wget scheme host port path))
      (load-string content))))
