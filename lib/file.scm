(load "lib/bytes.scm")
(load "lib/stdout.scm")
(load "lib/string.scm")

(define fstdin
  (lambda ()
    (hostcall Unix.stdin)))
       
(define fstdout
  (lambda ()
    (hostcall Unix.stdout)))
       
(define stderr
  (lambda ()
    (hostcall Unix.stderr)))
       
(define openfile
  (lambda (name :flags (list "O_RDONLY")
		:perm "0o660"
		:handle-no-such-file (lambda () #f)
		:handle-wrong-arguments (lambda () #f))
    (let ((result (hostcall Unix.openfile name flags perm)))
      (if (equal? result "no-such-file")
	  (throw no-such-file (handle-no-such-file))
	  (if (equal? result "wrong-arguments")
	      (throw wrong-arguments (handle-wrong-arguments))
	      result)))))

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
	    (bytes->string b)
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
	  (if (equal? '\n' c)
	      ""
	      (concat "" (list (make-string 1 c) (read-line read fd))))))))

(define read-all
  (lambda (ssl)
    (let* ((bufsize 1024)
	   (buff (bytes-create bufsize))
	   (r (ssl-read ssl buff 0 bufsize))
	   (s (bytes-to-string buff)))
      (read-all ssl))))

(define write
  (lambda (fd b ofs len)
    (hostcall Unix.write fd b ofs len)))

(define write-substring
  (lambda (fd s ofs len)
    (hostcall Unix.write_substring fd s ofs len)))

(define write-string
  (lambda (fd s)
    (write-substring fd s 0 (string-length s))))

(define write-char
  (lambda (fd c)
    (write fd (char->bytes c) 0 1)))

(define write-line
  (lambda (fd l)
    (write-string fd l)
    (write-char fd '\r')
    (write-char fd '\n')))

(define write-lines
  (lambda (fd lines)
    (if (pair? lines)
	(let* ((line (car lines))
	       (rest (cdr lines)))
	  (write-line fd line)
	  (write-lines fd rest))
	(list))))
	
(define file->in-channel
  (lambda (fd)
    (hostcall Unix.in_channel_of_descr fd)))

(define file->out-channel
  (lambda (fd)
    (hostcall Unix.out_channel_of_descr fd)))
