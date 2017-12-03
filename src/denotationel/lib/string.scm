(define make
  (lambda (n c)
    (hostcall String.make n c)))

(define length
  (lambda (s)
    (hostcall String.length s)))
