(let (server (hostcall Unix.socket (list "PF_INET" "SOCK_STREAM" 0)))
  (let (sockaddr (hostcall Unix.addr_inet (list (hostcall Unix.inet_addr_loopback (list)) 8080)))
    (begin
      (hostcall Unix.bind (list server sockaddr))
      (hostcall Unix.listen (list server 10))
      (let (client (hostcall Unix.accept (list server)))
	0))))
