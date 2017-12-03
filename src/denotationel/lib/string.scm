(define make
  (lambda (n c)
    (hostcall String.make n c)))

(define length
  (lambda (s)
    (hostcall String.length s)))

(define get
  (lambda (s n)
    (hostcall String.get s n)))
    
(define sub
  (lambda (s ofs len)
    (hostcall String.sub s ofs len)))

(define explode
  (lambda (s)
    (if (equal? 1 (length s))
	(get s 0)
	(cons (get s 0) (explode (sub s 1 (- (length s) 1)))))))
