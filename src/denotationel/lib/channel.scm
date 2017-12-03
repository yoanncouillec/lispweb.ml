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

