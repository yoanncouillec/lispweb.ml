(define bytes-of-string
  (lambda (s)
    (hostcall Bytes.of_string s)))

(define bytes-create
  (lambda (n)
    (hostcall Bytes.create n)))

(define bytes-to-string
  (lambda (b)
    (hostcall Bytes.to_string b)))

(define bytes-length
  (lambda (b)
    (hostcall Bytes.length b)))
