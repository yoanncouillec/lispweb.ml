(import "time.scm")
(import "ansiterminal.scm")

(define log
  (lambda (level s msg)
    (style-print-string (list (style "green")) (time->string (gettimeofday)))
    (print-string " ")
    (style-print-string (list (style "black") (style "bold")) level)
    (print-string " ")
    (style-print-string s msg)
    (print " ")))


(define debug (lambda (msg) (log "DEBUG" (list (style "green")) msg)))
(define info (lambda (msg) (log "INFO" (list) msg)))
(define warning (lambda (msg) (log "WARNING" (list (style "yellow")) msg)))
(define success (lambda (msg) (log "SUCCESS" (list (style "yellow") (style "bold")) msg)))
(define error (lambda (msg) (log "ERROR" (list (style "red")) msg)))
(define critical (lambda (msg) (log "CRITICAL" (list (style "red") (style "bold")) msg)))


