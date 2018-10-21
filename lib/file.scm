(load "lib/bytes.scm")
(load "lib/stdout.scm")
(load "lib/string.scm")

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

(define read-file
  (lambda (fd)
    (let* ((b (bytes-create 1024))
	   (n (read fd b 0 1024)))
      (if (equal? 0 n)
	  ""
	  (string-concat 
	   (list
	    (bytes-to-string b)
	    (read-file fd)))))))

(define read-line 
  (lambda (read fd)
    (let* ((b (bytes-create 1))
	   (n (read fd b 0 1))
	   (c (bytes-get b 0)))
      (if (equal? '\r' c)
	  (let* ((n2 (read fd b 0 1))
		 (c2 (bytes-get b 0)))
	    (if (equal? '\n' c2)
		""
		(concat "" (list (make-string 1 c) (read-line read fd)))))
	  (concat "" (list (make-string 1 c) (read-line read fd)))))))

(define write
  (lambda (fd buff ofs len)
    (hostcall Unix.write fd buff ofs len)))

(define in_channel_of_descr
  (lambda (fd)
    (hostcall Unix.in_channel_of_descr fd)))

(define out_channel_of_descr
  (lambda (fd)
    (hostcall Unix.out_channel_of_descr fd)))
