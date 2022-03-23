(import "time.scm")
(import "ansiterminal.scm")
(import "process.scm")

(define log
  (lambda (level spaces ss s msg)
    (style-print-string (list (style "green")) (time->string (gettimeofday)))
    (print-string " ")
    (style-print-string (list (style "cyan")) (gethostname))
    (print-string " ")
    (style-print-string (list (style "blue")) (val->string (getpid)))
    (print-string spaces)
    (style-print-string ss level)
    (print-string " ")
    (style-print-string s msg)
    (print " ")))


(define debug (lambda (msg) (log "DEBUG" "   " (list (style "bold") (style "white") (style "on-green")) (list (style "green") (style "bold")) msg)))
(define info (lambda (msg) (log "INFO" "    " (list (style "bold")) (list) msg)))
(define warning (lambda (msg) (log "WARNING" " " (list (style "blue") (style "bold")) (list (style "blue") (style "bold")) msg)))
(define success (lambda (msg) (log "SUCCESS" " " (list (style "green") (style "bold")) (list (style "green")) msg)))
(define error (lambda (msg) (log "ERROR" "   " (list (style "white") (style "on-red") (style "bold")) (list (style "red")) msg)))
(define fatal (lambda (msg) (log "FATAL" "   " (list (style "white") (style "on-red") (style "bold")) (list (style "red") (style "bold")) msg)))


