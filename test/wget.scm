(load "lib/wget.scm")

(let* ((scheme "https")
       (host "raw.githubusercontent.com")
       (port 443)
       (path "/yoanncouillec/lispweb.ml/master/test/test.scm")
       (s (wget scheme host port path)))
  (eval s)
  (foo))
