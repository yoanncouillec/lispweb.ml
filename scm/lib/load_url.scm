(import "wget.scm")

(define load-url
  (lambda (scheme host port path file)
    (import-string (wget scheme host port (concat "" (list path file))))))

(define load-url-with-cache
  (lambda (scheme host port path file :cache-path "")
    (catch sys-error
	   (import-file (concat "" (list cache-path file))
		      :handle-sys-error
		      (lambda () (import-url scheme host port path file))))))
