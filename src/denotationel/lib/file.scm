(define openfile
  (lambda (name flags perm)
    (hostcall Unix.openfile name flags perm)))

(define close
  (lambda (fd)
    (hostcall Unix.close fd)))

(define read
  (lambda (fd buff ofs len)
    (hostcall Unix.read fd buff ofs len)))

(define read-one-char
  (lambda (fd)
    (let* ((s (make-empty-string 1)))
      (read fd s 0 1)
      (get-char s 0))))

(define read-one-line
  (lambda (fd)
    (hostcall Pervasives.input_line (hostcall Unix.in_channel_of_descr fd))))

(define write
  (lambda (fd buff ofs len)
    (hostcall Unix.write fd buff ofs len)))

(define stdin
  (lambda ()
    (hostcall Unix.stdin)))
       
(define stdout
  (lambda ()
    (hostcall Unix.stdout)))
       
(define stderr
  (lambda ()
    (hostcall Unix.stderr)))
       
