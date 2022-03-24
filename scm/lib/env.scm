(define getenv
  (lambda (s)
    (hostcall Env.getenv s)))
