(let* ((server (socket "PF_INET" "SOCK_STREAM" 0))
       (sockaddr (addr_inet (inet_addr_loopback) 8080)))
  (bind server sockaddr)
  (listen server 10)
  (let* ((client (car (accept server)))
	(ic (in_channel_of_descr client))
	(s (input_line ic)))
    (write client s 0 (- (length s) 1))))


