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
      (hostcall Unix.bind server sockaddr)))
  (define listen
    (lambda (server n)
      (hostcall Unix.listen server n)))
  (define accept
    (lambda (server)
      (hostcall Unix.accept server)))
  (define in_channel_of_descr
    (lambda (fd)
      (hostcall Unix.in_channel_of_descr fd)))
  (define out_channel_of_descr
    (lambda (fd)
      (hostcall Unix.out_channel_of_descr fd)))
  (define input_line
    (lambda (channel)
      (hostcall Pervasives.input_line channel)))
  (define output_string
    (lambda (channel string)
      (hostcall Pervasives.output_string channel string)))
  (define flush
    (lambda (channel)
      (hostcall Pervasives.flush channel)))
  (define close_out
    (lambda (channel)
      (hostcall Pervasives.close_out channel)))
  (define close
    (lambda (fd)
      (hostcall Unix.close fd)))
  (define shutdown
    (lambda (fd cmd)
      (hostcall Unix.shutdown fd cmd)))
  (define write
    (lambda (fd buff ofs len)
      (hostcall Unix.write fd buff ofs len)))
  (define stdout
    (lambda ()
      (hostcall Unix.stdout)))
  (define length
    (lambda (string)
      (hostcall String.length string)))
)
