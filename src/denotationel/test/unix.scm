(let (server (socket "PF_INET" "SOCK_STREAM" 0))
  (let (sockaddr (addr_inet (inet_addr_loopback) 8080))
    (begin
      (bind server sockaddr)
      (listen server 10)
      (accept server))))
