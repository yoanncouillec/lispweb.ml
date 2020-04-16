(load "lib/file.scm")
(load "lib/http.scm")
(load "lib/string.scm")
(load "lib/html.scm")

(print "this is http test")

(define service
  (lambda (fd method path queryparams protocol headers)
    (if (equal? path "/home")
	(http-send-response 
	 fd 
	 "200" 
	 "text/html" 
	 (html-page->string
	  (load "test/http/home_page.scm")))
	(if (equal? path "/eval")
	    (http-send-response 
	     fd 
	     "200" 
	     "text/html" 
	     (html-page->string
	      (load "test/http/eval_page.scm")))
	    (if (equal? path "/response")
		(let* ((expr (assoc queryparams "expr")))
		  (print "expr")
		  (print expr)
		  (let* ((v (eval (url-decode-light expr))))
		    (print "eval")
		    (http-send-response
		     fd
		     "200"
		     "text/html"
		     (html->string
		      ((load "test/http/response_page.scm") v)
		      ))))
		(http-send-response fd
				    "404"
				    "text/html"
				    (load "test/http/error_page.scm")))))))

(http-server 8082
	     service)
