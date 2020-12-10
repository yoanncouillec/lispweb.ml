(load "lib/file.scm")
(load "lib/wget.scm")

(define load-string
  (lambda (string)
    (eval (string->expr string))))

(define load-file
  (lambda (filename
	   :handle-no-such-file (lambda () #f)
	   :handle-wrong-arguments (lambda () #f))
    (load-string
     (input-line
      (open-in filename)))))

(define load-url
  (lambda (scheme host port path)
    (load-string (wget scheme host port path))))

(define load-url-with-local-cache
  (lambda (scheme host port path lib cache-path)
    (load-file lib)))

  
