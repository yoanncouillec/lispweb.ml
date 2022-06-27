(import "http.scm")

(define /home
  (lambda (client)
    (http-send-response 
     client 
     "200" 
     "text/html" 
     --port)))

(define service
  (lambda (client method path queryparams protocol headers)
    (/home client)))

(http-run-server (string->int --port)
		 service)
