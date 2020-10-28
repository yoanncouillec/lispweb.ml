(load "lib/ssl.scm")

(let* ((server (ssl-make-server 9898 "toto" "cert.pem" "privkey.pem" 100)))
  0)
