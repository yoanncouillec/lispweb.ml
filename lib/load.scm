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
     (input-lines
      (open-in filename)))))

(define load-url
  (lambda (scheme host port path file)
    (load-string (wget scheme host port (concat "" (list path file))))))

(define load-url-with-local-cache
  (lambda (scheme host port path lib :cache-path "./")
    (load-file lib)))

  
