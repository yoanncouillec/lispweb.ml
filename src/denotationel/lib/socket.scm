(define inet_addr_loopback
  (lambda ()
    (hostcall Unix.inet_addr_loopback)))

(define addr_inet
  (lambda (addr port)
    (hostcall Unix.addr_inet addr port)))

(define socket
  (lambda (domain type protocol)
    (hostcall Unix.socket domain type protocol)))

(define connect
  (lambda (server sockaddr)
    (hostcall Unix.connect server sockaddr)))

(define bind
  (lambda (server sockaddr)
    (hostcall Unix.bind server sockaddr)))

(define accept
  (lambda (server)
    (hostcall Unix.accept server)))

(define listen
  (lambda (server n)
    (hostcall Unix.listen server n)))

(define shutdown
  (lambda (fd cmd)
    (hostcall Unix.shutdown fd cmd)))
