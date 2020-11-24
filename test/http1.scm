(load "lib/http.scm")

(http-run-server
 (string->int --port)
 (lambda (client method path queryparams protocols headers)
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
       
