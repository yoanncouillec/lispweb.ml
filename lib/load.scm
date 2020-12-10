(load "lib/file.scm")
(load "lib/wget.scm")

(define load-string
  (lambda (string)
    (eval (string->expr string))))

(define load-file
  (lambda (filename
	   :handle-sys-error (lambda () #f)
	   :handle-wrong-arguments (lambda () #f))
    (load-string
     (input-lines
      (open-in filename
	       :handle-sys-error handle-sys-error)))))

(define load-url
  (lambda (scheme host port path file)
    (load-string (wget scheme host port (concat "" (list path file))))))

(define load-url-with-local-cache
  (lambda (scheme host port path file :cache-path "./")
    (catch sys-error
	   (load-file file
		      :handle-sys-error
		      (lambda () (load-url scheme host port path file))))))

  
