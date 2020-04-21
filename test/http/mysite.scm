(load "lib/file.scm")
(load "lib/http.scm")
(load "lib/https.scm")
(load "lib/string.scm")
(load "lib/html.scm")
(load "lib/url.scm")
(load "lib/bootstrap/bootstrap_badge.scm")

(define port 8080)

(define /home
  (lambda (client)
    (https-send-response 
     client 
     "200" 
     "text/html" 
     (html-page->string
      (load "test/http/home_page.scm")))))

(define /eval
  (lambda (client)
    (https-send-response 
     client 
     "200" 
     "text/html" 
     (html-page->string
      (load "test/http/eval_page.scm")))))

(define /response
  (lambda (client queryparams)
    (let* ((expr (assoc queryparams "expr")))
      (let* ((v (load-string (url-decode-light expr))))
	(https-send-response
	 client
	 "200"
	 "text/html"
	 (html->string
	  ((load "test/http/response_page.scm") v)))))))

(define /error
  (lambda (client)
    (https-send-response client
     "404"
     "text/html"
     (html->string
      (load "test/http/error_page.scm")))))

(define service
  (lambda (client method path queryparams protocol headers)
    (print (concat "" (list "φ Query on http://127.0.0.1:" (int->string port) path)))
    (cond ((equal? path "/home") (/home client))
	  ((equal? path "/eval") (/eval client))
	  ((equal? path "/response") (/response client queryparams))
	  (else (/error client)))))

(print "φ Serving app MySite")
(print (concat "" (list "φ Running on http://127.0.0.1:" (int->string port))))

(https-threaded-run-server port
			   ""
			   "/etc/letsencrypt/live/galaad.servebeer.com/cert.pem"
			   "/etc/letsencrypt/live/galaad.servebeer.com/privkey.pem"
			   100
			   service)
