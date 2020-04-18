(load "lib/file.scm")
(load "lib/http.scm")
(load "lib/https.scm")
(load "lib/string.scm")
(load "lib/html.scm")
(load "lib/url.scm")
(load "lib/bootstrap.scm")

(define port 8081)

(define service
  (lambda (fd method path queryparams protocol headers)
    (print (concat "" (list "φ Query on http://127.0.0.1:" (int->string port) path)))
    (cond ((equal? path "/home")
	   (begin
	     (https-send-response 
	      fd 
	      "200" 
	      "text/html" 
	      (html-page->string
	       (load "test/http/home_page.scm")))))
	  ((equal? path "/eval")
	   (begin
	     (https-send-response 
	      fd 
	      "200" 
	      "text/html" 
	      (html-page->string
	       (load "test/http/eval_page.scm")))))
	  ((equal? path "/response")
	   (begin
	     (let* ((expr (assoc queryparams "expr")))
	       (let* ((v (eval (url-decode-light expr))))
		 (https-send-response
		  fd
		  "200"
		  "text/html"
		  (html->string
		   ((load "test/http/response_page.scm") v)))))))
	  (else
	   (begin
	     (https-send-response fd
				 "404"
				 "text/html"
				 (html->string
				  (load "test/http/error_page.scm"))))))))

(print "φ Serving app MySite")
(print (concat "" (list "φ Running on http://127.0.0.1:" (int->string port))))

(https-threaded-run-server port
			   ""
			   "/etc/letsencrypt/live/galaad.servebeer.com/cert.pem"
			   "/etc/letsencrypt/live/galaad.servebeer.com/privkey.pem"
			   100
			   service)
