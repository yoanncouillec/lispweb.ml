(import "lib/load.scm")

(import-url-with-cache "https" "raw.githubusercontent.com" 443 "/yoanncouillec/lispweb.ml/master/" "hello.scm")

(hello :name "Tim")
