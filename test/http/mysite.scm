(load "lib/file.scm")
(load "lib/http.scm")
(load "lib/string.scm")
(load "lib/html.scm")

(define service
  (lambda (fd method path queryparams protocol headers)
    (print (concat "" (list "φ Query on http://127.0.0.1:8082" path)))
    (cond ((equal? path "/home")
	   (begin
	     (http-send-response 
	      fd 
	      "200" 
	      "text/html" 
	      (html-page->string
	       (load "test/http/home_page.scm")))))
	  ((equal? path "/eval")
	   (begin
	     (http-send-response 
	      fd 
	      "200" 
	      "text/html" 
	      (html-page->string
	       (load "test/http/eval_page.scm")))))
	  ((equal? path "/response")
	   (begin
	     (let* ((expr (assoc queryparams "expr")))
	       (let* ((v (eval (url-decode-light expr))))
		 (http-send-response
		  fd
		  "200"
		  "text/html"
		  (html->string
		   ((load "test/http/response_page.scm") v)))))))
	  (else
	   (begin
	     (http-send-response fd
				 "404"
				 "text/html"
				 (html->string
				  (load "test/http/error_page.scm"))))))))

(print "φ Serving app MySite")
(print "φ Running on http://127.0.0.1:8082/")

(http-server 8082
	      service)
