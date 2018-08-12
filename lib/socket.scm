(define inet_addr_any
  (lambda ()
    (hostcall Unix.inet_addr_any)))

(define inet_addr_loopback
  (lambda ()
    (hostcall Unix.inet_addr_loopback)))

(define inet6_addr_any
  (lambda ()
    (hostcall Unix.inet6_addr_any)))

(define inet6_addr_loopback
  (lambda ()
    (hostcall Unix.inet6_addr_loopback)))

(define addr_unix
  (lambda (addr port)
    (hostcall Unix.addr_unix addr port)))

(define addr_inet
  (lambda (addr port)
    (hostcall Unix.addr_inet addr port)))

(define gethostbyname
  (lambda (name)
    (hostcall Misc.gethostbyname name)))

(define inet_addr_of_host_entry
  (lambda (hostentry)
    (hostcall Misc.inet_addr_of_host_entry hostentry)))

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
