(load "lib/load.scm")

(load-url-with-cache "https" "raw.githubusercontent.com" 443 "/yoanncouillec/lispweb.ml/master/" "hello.scm")

(hello :name "Tim")
