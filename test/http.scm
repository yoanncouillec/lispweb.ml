(load "lib/file.scm")
(load "lib/http.scm")
(load "lib/string.scm")
(load "lib/html.scm")

(define service
  (lambda (fd method path protocol headers)
    (if (equal? path "/")
	(http-send-response 
	 fd 
	 "200" 
	 "text/html" 
	 (html->string 
	  (<div> (list) 
		 (list 
		  (<h1> (list) (list (list "string" "Welcome to LispWeb Server 1.0")))
		  (<form>
		   (list (list "action" "/eval"))
		   (list
		    (<input> (list (list "type" "text") (list "name" "expr")) (list))))))))
	(if (equal? path "/eval")
	    (let* ((expr "(+1 2)")
		   (v (eval expr)))
	      (http-send-response fd "200" "text/html" (html->string (<h1> (list) (list (list "string" (val->string v)))))))
	    (http-send-response fd "404" "text/html" (html->string (<h1> (list) (list (list "string" path)))))))))


(http-server 8080
	     service)
