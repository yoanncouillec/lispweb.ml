(define load-scheme-file
  (lambda (filename :path "/usr/local/lib/lispweb/")
    (eval (hostcall Parse.parse_scheme (hostcall Core.In_channel.read_all (hostcall String.concat "" (list path filename)))))))

(define load load-scheme-file)
(define load-file load-scheme-file)

(define load-scheme-string
  (lambda (string)
    (eval (hostcall Parse.parse_scheme string))))

(define load-string load-scheme-string)
