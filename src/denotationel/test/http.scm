(load "lib/file.scm")
(load "lib/http.scm")
(load "lib/string.scm")
(load "lib/html.scm")

(define service
  (lambda (out method path protocol headers)
    (if (equal? path "/")
	(http-send-response out "200" "text/html" (html->string (<h1> (list) (list "string" "Welcome to LispWeb Server 1.0"))))
	(http-send-response out "404" "text/html" (html->string (<h1> (list) (list "string" "Page not found")))))
    (flush out)))

(http-server 8081 service)
