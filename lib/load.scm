(define load-scheme-file
  (lambda (filename)
    (eval (hostcall Parse.parse_scheme (hostcall Core.In_channel.read_all filename)))))

(define load load-scheme-file)
(define load-file load-scheme-file)

(define load-scheme-string
  (lambda (string)
    (eval (hostcall Parse.parse_scheme string))))

(define load-string load-scheme-string)
