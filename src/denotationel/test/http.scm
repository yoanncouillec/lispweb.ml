(load "lib/file.scm")
(load "lib/http.scm")
(load "lib/string.scm")

(define service
  (lambda (out method path protocol headers)
    (if (equal? path "/")
	(http-send-response out "200" "text/html" "<h1>Welcome to LispWeb Server 1.0<h1>")
	(http-send-response out "404" "text/html" "<h1>Page not found</h1><h2>404</h2>"))
    (flush out)))

(http-server 8080 service)
