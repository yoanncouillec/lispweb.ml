(load "lib/load.scm")

(let* ((scheme "https")
       (host "raw.githubusercontent.com")
       (port 443)
       (path "/yoanncouillec/lispweb.ml/master/test/test.scm"))
  (load-url scheme host port path)
  (foo))
