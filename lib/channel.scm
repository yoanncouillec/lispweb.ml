(load "lib/string.scm")

(define stdin
  (lambda ()
    (hostcall Pervasives.stdin)))

(define stdout
  (lambda ()
    (hostcall Pervasives.stdout)))

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
  (lambda (s :handle-sys-error (lambda () #f)
	     :handle-wrong-arguments (lambda () #f))
    (let ((result (hostcall Pervasives.open_in s)))
      (if (equal? result "sys-error")
	  (throw sys-error
		 (handle-sys-error))
	  (if (equal? result "wrong-arguments")
	      (throw wrong-arguments
		     (handle-wrong-arguments))
	      result)))))

(define open-in-bin
  (lambda (s)
    (hostcall Pervasives.open_in_bin s)))

(define input-char
  (lambda (channel)
    (hostcall Pervasives.input_char channel)))

(define input-line
  (lambda (channel
	   :handle-end-of-file (lambda () ""))
    (let* ((s (hostcall Pervasives.input_line channel)))
      (if (equal? s "end-of-file")
	  (throw end-of-file
		 (handle-end-of-file))
	  (sub-string s 0 (string-length s))))))

(define input-lines
  (lambda (channel)
    (catch end-of-file
	   (cons
	    (input-line channel :handle-end-of-file (lambda () (list)))
	    (input-lines channel)))))

(define close-in
  (lambda (channel)
    (hostcall Pervasives.close_in channel)))
      
