(load "lib/string.scm")
(load "lib/stdout.scm")

(define assert
  (lambda (value expected_value)
    (if (not (equal? value expected_value))
	(concat " " (list
		     "FAILED: expected value is"
		     (val->string expected_value)
		     "but found"
		     (val->string value)))
	"SUCCESS")))
