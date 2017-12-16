(load "lib/file.scm")
(load "lib/http.scm")
(load "lib/string.scm")

(define service
  (lambda (out method path protocol headers)
    (if (equal? path "/")
	(let* ((content "<h1>Welcome to LispWeb Server 1.0<h1>"))
	  (output-lines
	   out
	   (list
	    "HTTP/1.1 200 OK"
	    (concat ""(list "Content-Length: " (int->string (string-length content))))
	    "Content-Type: text/html"))
	  (output-newline out)
	  (output-string out content))
	(output-string out ""))
    (flush out)))

(http-server 8081 service)
