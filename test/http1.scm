(load "lib/http.scm")
(load "lib/html.scm")

(print (concat " " (list "Server waiting on" --port)))

(define port (string->int --port))

(http-run-server
 port
 (lambda (client method path queryparams protocols headers)
   (print "New client")
   (if (equal? path "/")
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
	     (<h1> (list) (list (list "string" "Hello World!")))))))))
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
	     (<h1> (list) (list (list "string" "404!"))))))))))))
       
