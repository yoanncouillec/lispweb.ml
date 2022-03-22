(define getpid
  (lambda ()
    (hostcall Unix.getpid)))
