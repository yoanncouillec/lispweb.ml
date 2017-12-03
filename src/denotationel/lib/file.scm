(define openfile
  (lambda (name flags perm)
    (hostcall Unix.openfile name flags perm)))

(define close
  (lambda (fd)
    (hostcall Unix.close fd)))

(define read
  (lambda (fd buff ofs len)
    (hostcall Unix.read fd buff read len)))

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
       
