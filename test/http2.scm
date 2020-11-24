(load "lib/http.scm")

(define hello
  (lambda (client)
    (http-send-response
     client
     "200"
     "text/html"
     (html-page->string
      (<html>
       (list)
       (list
	(<body>
	 (list)
	 (list
	  (<h1> (list) (list (list "string" "Hello World!")))))))))))

(define error
  (lambda (client)
    (http-send-response
     client
     "404"
     "text/html"
     (html-page->string
      (<html>
       (list)
       (list
	(<body>
	 (list)
	 (list
	  (<h1> (list) (list (list "string" "404!")))))))))))

(define service
  (lambda (client method path queryparams protocols headers)
    (if (equal? path "/")
	(hello client)
	(error client))))

(http-run-server (string->int --port) service)
