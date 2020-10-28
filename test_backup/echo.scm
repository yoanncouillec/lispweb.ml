(load "lib/socket.scm")
(load "lib/channel.scm")
(load "lib/file.scm")
(load "lib/string.scm")
(load "lib/list.scm")
(load "lib/stdout.scm")

(define echo
  (lambda (in out l)
    (let* ((s (input-line in)))
      (print-line s)
      (output-line out s)
      (flush out)
      (if (equal? "quit" s)
	  (reverse l)
	  (echo in out (cons s l))))))

(define echo-server
  (lambda (port)
    (let* ((server (socket "PF_INET" "SOCK_STREAM" 0))
	   (sockaddr (addr_inet (inet_addr_loopback) port)))
      (bind server sockaddr)
      (listen server 10)
      (let* ((client (car (accept server)))
	     (in (in_channel_of_descr client))
	     (out (out_channel_of_descr client)))
	(echo in out (list))))))

(echo-server 8081)
