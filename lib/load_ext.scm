(load "lib/file.scm")
(load "lib/string.scm")
(load "lib/parse.scm")

(define load-string
  (lambda (string)
    (eval (parse-scheme string))))

(define load-file
  (lambda (filename
	   :handle-sys-error (lambda () #f)
	   :handle-wrong-arguments (lambda () #f))
    (load-string
     (input-lines
      (open-in filename
	       :handle-sys-error handle-sys-error)))))


  
