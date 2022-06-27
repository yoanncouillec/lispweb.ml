(import "lib/file.scm")
(import "lib/http.scm")
(import "lib/https.scm")
(import "lib/string.scm")
(import "lib/html.scm")
(import "lib/url.scm")
(import "lib/bootstrap/bootstrap_badge.scm")

(define port 8081)

(define /home
  (lambda (client)
    (https-send-response 
     client 
     "200" 
     "text/html" 
     (html-page->string
      (import "test/http/home_page.scm")))))

(define /eval
  (lambda (client)
    (https-send-response 
     client 
     "200" 
     "text/html" 
     (html-page->string
      (import "test/http/eval_page.scm")))))

(define /response
  (lambda (client queryparams)
    (let* ((expr (assoc queryparams "expr")))
      (let* ((v (import-string (url-decode-light expr))))
	(https-send-response
	 client
	 "200"
	 "text/html"
	 (html->string
	  ((import "test/http/response_page.scm") v)))))))

(define /error
  (lambda (client)
    (https-send-response client
     "404"
     "text/html"
     (html->string
      (import "test/http/error_page.scm")))))

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
			   "toto"
			   "/etc/letsencrypt/live/mylittletarot.ddns.net/cert.pem"
			   "/etc/letsencrypt/live/mylittletarot.ddns.net/privkey.pem"
			   100
			   service)
