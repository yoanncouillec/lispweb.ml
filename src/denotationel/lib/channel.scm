(define open-out
  (lambda (s)
    (hostcall Pervasives.open_out s)))

(define open-out-bin
  (lambda (s)
    (hostcall Pervasives.open_out_bin s)))

(define cflush
  (lambda (channel)
    (hostcall Pervasives.flush channel)))

(define output-char
  (lambda (channel c)
    (hostcall Pervasives.output_char channel c)))

(define output-string
  (lambda (channel s)
    (hostcall Pervasives.output_string channel s)))

(define close-out
  (lambda (channel)
    (hostcall Pervasives.close_out channel)))

(define open-in
  (lambda (s)
    (hostcall Pervasives.open_in s)))

(define open-in-bin
  (lambda (s)
    (hostcall Pervasives.open_in_bin s)))

(define input-char
  (lambda (channel)
    (hostcall Pervasives.input_char channel)))

(define input-line
  (lambda (channel)
    (hostcall Pervasives.input_line channel)))

(define close-in
  (lambda (channel)
    (hostcall Pervasives.close_in channel)))
