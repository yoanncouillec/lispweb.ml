(load "lib/wget.scm")

(define load-url
  (lambda (scheme host port path file)
    (load-string (wget scheme host port (concat "" (list path file))))))

(define load-url-with-cache
  (lambda (scheme host port path file :cache-path "lib/")
    (catch sys-error
	   (load-file (concat "" (list cache-path file))
		      :handle-sys-error
		      (lambda () (load-url scheme host port path file))))))
