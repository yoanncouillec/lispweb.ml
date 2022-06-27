(let* ((scheme "https")
       (host "raw.githubusercontent.com")
       (port 443)
       (path "/yoanncouillec/lispweb.ml/master/test/test.scm"))
  (import-url scheme host port path)
  (foo))

(import-url
 "https" "raw.githubusercontent.com" 443 "/yoanncouillec/lispweb.ml/master/test/test2.scm")
(remote-print "hello whole world")
