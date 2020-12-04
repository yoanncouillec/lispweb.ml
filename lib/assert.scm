(load "lib/string.scm")
(load "lib/stdout.scm")

(define assert
  (lambda (value :expects #f)
    (if (not (equal? value expects))
	(concat " " (list
		     "FAILED: expected value is"
		     (val->string expects)
		     "but found"
		     (val->string value)))
	"SUCCESS")))
