(load "lib/file.scm")
(load "lib/http.scm")
(load "lib/string.scm")
(load "lib/html.scm")

(print "this is http test")

(define service
  (lambda (fd method path queryparams protocol headers)
    (if (equal? path "/")
	(http-send-response 
	 fd 
	 "200" 
	 "text/html" 
	 (html-page->string
	  (load "test/home.scm")))
	(if (equal? path "/eval")
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
		  ((load "test/response.scm") v)
		  ))))
	    (http-send-response fd
				"404"
				"text/html"
				(load "test/error.scm"))))))

(http-server 8080
	     service)
