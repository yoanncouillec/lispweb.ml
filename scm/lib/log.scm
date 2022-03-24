(import "time.scm")
(import "ansiterminal.scm")
(import "process.scm")

(define logger
  (lambda (min-level)
    (lambda (level msg)
      (cond
       ((equal? min-level "DEBUG")
	(begin
	  (if (equal? level "DEBUG") (debug msg)
	      (if (equal? level "INFO") (info msg)	      
		  (if (equal? level "WARNING") (warning msg)
		      (if (equal? level  "ERROR") (error msg)
			  (if (equal? level "FATAL") (fatal msg))))))))
       ((equal? min-level "INFO")
	(begin
	  (if (equal? level "INFO") (info msg)
	      (if (equal? level "WARNING") (warning msg)
		  (if (equal? level  "ERROR") (error msg)
		      (if (equal? level "FATAL") (fatal msg)))))))
       ((equal? min-level "WARNING")
	(if (equal? level "WARNING") (warning msg)
	    (if (equal? level  "ERROR") (error msg)
		(if (equal? level "FATAL") (fatal msg)))))
       ((equal? min-level  "ERROR")
	(if (equal? level  "ERROR") (error msg)
	    (if (equal? level "FATAL") (fatal msg))))
       ((equal? min-level "FATAL")
	(if (equal? level "FATAL") (fatal msg)))))))

(define log
  (lambda (level spaces ss s msg)
    (let ((style-print (if (or (equal? level "ERROR") (equal? level "FATAL")) style-prerr-string style-print-string))
	  (regular-print (if (or (equal? level "ERROR") (equal? level "FATAL")) prerr-string print-string))
	  (regular-print-nl (if (or (equal? level "ERROR") (equal? level "FATAL")) prerr-newline print-newline))	  
	  )
      (style-print (list (style "green")) (time->string (gettimeofday)))
      (regular-print " ")
      (style-print (list (style "cyan")) (gethostname))
      (regular-print " ")
      (style-print (list (style "blue")) (val->string (getpid)))
      (regular-print spaces)
      (style-print ss level)
      (regular-print " ")
      (style-print s msg)
      (regular-print-nl))))

(define debug (lambda (msg) (log "DEBUG" "   " (list (style "bold") (style "white") (style "on-green")) (list (style "green") (style "bold")) msg)))
(define info (lambda (msg) (log "INFO" "    " (list (style "bold")) (list) msg)))
(define warning (lambda (msg) (log "WARNING" " " (list (style "blue") (style "bold")) (list (style "blue") (style "bold")) msg)))
(define error (lambda (msg) (log "ERROR" "   " (list (style "white") (style "on-red") (style "bold")) (list (style "red")) msg)))
(define fatal (lambda (msg) (log "FATAL" "   " (list (style "white") (style "on-red") (style "bold")) (list (style "red") (style "bold")) msg)))

(define success (lambda (msg) (log "SUCCESS" " " (list (style "green") (style "bold")) (list (style "green")) msg)))
