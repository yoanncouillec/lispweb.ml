(define string->bytes
  (lambda (s)
    (hostcall Bytes.of_string s)))

(define bytes->string
  (lambda (s)
    (hostcall Bytes.to_string s)))

(define bytes-create
  (lambda (n)
    (hostcall Bytes.create n)))

(define bytes-make
  (lambda (n c)
    (hostcall Bytes.make n c)))

(define bytes-length
  (lambda (b)
    (hostcall Bytes.length b)))

(define bytes-get
  (lambda (b n)
    (hostcall Bytes.get b n)))
