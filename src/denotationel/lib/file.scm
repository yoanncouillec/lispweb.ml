(define stdin
  (lambda ()
    (hostcall Unix.stdin)))
       
(define stdout
  (lambda ()
    (hostcall Unix.stdout)))
       
(define stderr
  (lambda ()
    (hostcall Unix.stderr)))
       
(define openfile
  (lambda (name flags perm)
    (hostcall Unix.openfile name flags perm)))

(define close
  (lambda (fd)
    (hostcall Unix.close fd)))

(define read
  (lambda (fd buff ofs len)
    (hostcall Unix.read fd buff ofs len)))

(define write
  (lambda (fd buff ofs len)
    (hostcall Unix.write fd buff ofs len)))

(define in_channel_of_descr
  (lambda (fd)
    (hostcall Unix.in_channel_of_descr fd)))

(define out_channel_of_descr
  (lambda (fd)
    (hostcall Unix.out_channel_of_descr fd)))
