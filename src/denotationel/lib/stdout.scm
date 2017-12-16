(define stdout
  (lambda ()
    (hostcall Pervasives.stdout)))

(define print-char
  (lambda (c)
    (hostcall Pervasives.print_char c)))

(define print-string
  (lambda (s)
    (hostcall Pervasives.print_string s)))

(define print-endline
  (lambda (s)
    (hostcall Pervasives.print_endline s)))

(define print-newline
  (lambda ()
    (hostcall Pervasives.print_newline)))
