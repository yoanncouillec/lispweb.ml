(load "lib/load.scm")

(load-url-with-local-cache "https" "raw.githubusercontent.com" 443 "/yoanncouillec/lispweb.ml/master/" "lib/hello.scm" "./")

(hello)
