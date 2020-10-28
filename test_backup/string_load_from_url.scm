(load "lib/load.scm")

(let* ((scheme "https")
       (host "raw.githubusercontent.com")
       (port 443)
       (path "/yoanncouillec/lispweb.ml/master/lib/string.scm"))
  (load-url scheme host port path)
  (let (s "hello world")
    (string->list s)))
