(begin
  (define socket
    (lambda (domain type protocol)
      (hostcall Unix.socket domain type protocol)))
  (define addr_inet
    (lambda (addr port)
      (hostcall Unix.addr_inet addr port)))
  (define inet_addr_loopback
    (lambda ()
      (hostcall Unix.inet_addr_loopback)))
  (define bind
    (lambda (server sockaddr)
      (hostcall Unix.bin server sockaddr)))
  (define listen
    (lambda (server n)
      (hostcall Unix.listen server n)))
  (define accept
    (lambda (server)
      (hostcall Unix.accept server))))
