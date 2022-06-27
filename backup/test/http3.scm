(import "lib/http.scm")

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
	  (<input>
	   (list
	    (list
	     "onkeyup"
	     (js->string
	      (scheme->js
	       ((->
		 ((-> (fetch "https://jsonplaceholder.typicode.com/todos/1") then)
		  (lambda (response) ((-> response json))))
		 then)
		(lambda (data) (print data)))))))
	   (list))))))))))

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
