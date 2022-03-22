(define time
  (lambda ()
    (hostcall Unix.time)))

(define gettimeofday
  (lambda ()
    (hostcall Unix.gettimeofday)))

(define gmtime
  (lambda (t)
    (hostcall Unix.gmtime t)))

(define time->string
  (lambda (t)
    (hostcall Unix.string_of_time t)))
