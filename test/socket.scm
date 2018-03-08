(load "lib/socket.scm")
(load "lib/channel.scm")
(load "lib/file.scm")
(load "lib/string.scm")
(load "lib/list.scm")

(let* ((server (socket "PF_INET" "SOCK_STREAM" 0))
       (sockaddr (addr_inet (inet_addr_loopback) 8082)))
  (bind server sockaddr)
  (listen server 10)
  (let* ((client (car (accept server)))
	 (l (read-line client))
	 (s (list->string l)))
    (write client s 0 (length l))))
    

