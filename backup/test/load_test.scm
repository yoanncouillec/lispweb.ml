(import "lib/assert.scm")
(import "lib/load_url.scm")

(test-all
 "lib/load.scm"
 (list
  
  (lambda ()
    (assert "load-string"
	    (begin
	      (import-string "(+ 1 2)"))
	    :expects 3))

  (lambda ()
    (assert "load-string"
	    (begin
	      (import-string "(define foo (lambda (x) (* x x)))")
	      (foo 12))
	    :expects 144))

  
  (lambda ()
    (assert "load-file"
	    (begin
	      (import-file "lib/hello.scm")
	      (hello :name "Jim"))
	    :expects "Hello Jim"))

  (lambda ()
    (assert "load-url"
	    (begin
	      (import-url "https" "raw.githubusercontent.com" 443 "/yoanncouillec/lispweb.ml/master/" "lib/hello.scm")
	      (hello))
	    :expects "Hello World!"))

  (lambda ()
    (assert "load-url-with-cache"
	    (begin
	      (import-url-with-cache "https" "raw.githubusercontent.com" 443 "/yoanncouillec/lispweb.ml/master/" "hello.scm")
	      (hello :name "Tim"))
	    :expects "Hello Tim"))))

