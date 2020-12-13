(load "lib/assert.scm")
(load "lib/load.scm")

(test-all
 "lib/string.scm"
 (list
  
  (lambda ()
    (assert "load-string"
	    (begin
	      (load-string "(+ 1 2)"))
	    :expects 3))

  (lambda ()
    (assert "load-string"
	    (begin
	      (load-string "(define foo (lambda (x) (* x x)))")
	      (foo 12))
	    :expects 144))

  
  (lambda ()
    (assert "load-file"
	    (begin
	      (load-file "lib/hello.scm")
	      (hello :name "Jim"))
	    :expects "Hello Jim"))

  (lambda ()
    (assert "load-url"
	    (begin
	      (load-url "https" "raw.githubusercontent.com" 443 "/yoanncouillec/lispweb.ml/master/" "lib/hello.scm")
	      (hello))
	    :expects "Hello World!"))

  (lambda ()
    (assert "load-url-with-cache"
	    (begin
	      (load-url-with-cache "https" "raw.githubusercontent.com" 443 "/yoanncouillec/lispweb.ml/master/" "hello.scm")
	      (hello :name "Tim"))
	    :expects "Hello Tim"))))

