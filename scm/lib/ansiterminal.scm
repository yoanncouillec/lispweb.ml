(define style
  (lambda (s)
    (hostcall ANSITerminal.style s)))

(define style-print-string
  (lambda (style string)
    (hostcall ANSITerminal.print_string style string)))

(define style-prerr-string
  (lambda (style string)
    (hostcall ANSITerminal.prerr_string style string)))
