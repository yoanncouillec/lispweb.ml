(define bytes-of-string
  (lambda (s)
    (hostcall Bytes.of_string s)))

(define bytes-to-string
  (lambda (s)
    (hostcall Bytes.to_string s)))

(define bytes-create
  (lambda (n)
    (hostcall Bytes.create n)))

(define bytes-to-string
  (lambda (b)
    (hostcall Bytes.to_string b)))

(define bytes-length
  (lambda (b)
    (hostcall Bytes.length b)))

(define bytes-get
  (lambda (b n)
    (hostcall Bytes.get b n)))
