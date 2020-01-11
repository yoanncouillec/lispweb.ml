(load-url
 "https" "raw.githubusercontent.com" 443 "/yoanncouillec/lispweb.ml/master/test/the_remote_code_on_github.scm")
(print-line "What is your name?")
(foo (read-line read (stdin)))
