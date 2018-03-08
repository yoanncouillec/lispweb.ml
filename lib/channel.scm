(define open-out
  (lambda (s)
    (hostcall Pervasives.open_out s)))

(define open-out-bin
  (lambda (s)
    (hostcall Pervasives.open_out_bin s)))

(define flush
  (lambda (channel)
    (hostcall Pervasives.flush channel)))

(define output-char
  (lambda (channel c)
    (hostcall Pervasives.output_char channel c)))

(define output-string
  (lambda (channel s)
    (hostcall Pervasives.output_string channel s)))

(define output-newline
  (lambda (out)
    (output-char out '\n')))

(define output-line
  (lambda (channel s)
    (output-string channel s)
    (output-char channel '\n')))

(define output-lines
  (lambda (out lines)
    (if (pair? lines)
	(begin 
	  (output-line out (car lines))
	  (output-lines out (cdr lines)))
	(list))))

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
    (let* ((s (hostcall Pervasives.input_line channel)))
      (sub-string s 0 (- (string-length s) 1)))))

(define close-in
  (lambda (channel)
    (hostcall Pervasives.close_in channel)))
