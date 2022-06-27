(import "file.scm")
(import "string.scm")
(import "parse.scm")

(define load-string
  (lambda (string)
    (eval (parse-scheme string))))

(define load-file
  (lambda (filename
	   :handle-sys-error (lambda () #f)
	   :handle-wrong-arguments (lambda () #f))
    (import-string
     (input-lines
      (open-in filename
	       :handle-sys-error handle-sys-error)))))


  
