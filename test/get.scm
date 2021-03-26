(import "lib/string.scm")

(define xyxy 123123)

(let ((x 12)(xx 122)(xy 123)(xyx 1234)(zzz 111))
  (list
   (start-with "x")
   (start-with "xy")
   (start-with "xyx")
   (start-with "abc")
   (start-with "zzz")
   (get (car (start-with "x")))
   (get (car (cdr (start-with "x"))))
   (start-with "g")
   ))
		  
