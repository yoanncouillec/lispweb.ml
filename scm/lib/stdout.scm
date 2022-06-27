(define stdout
  (lambda ()
    (hostcall Pervasives.stdout)))

(define print-char
  (lambda (c)
    (hostcall Pervasives.print_char c)))

(define print-string
  (lambda (s)
    (hostcall Pervasives.print_string s)))

(define prerr-string
  (lambda (s)
    (hostcall Pervasives.prerr_string s)))

(define print-line
  (lambda (s)
    (hostcall Pervasives.print_endline s)))

(define print print-line)

(define print-newline
  (lambda ()
    (hostcall Pervasives.print_newline)))

(define prerr-newline
  (lambda ()
    (hostcall Pervasives.prerr_newline)))

(define int->string
  (lambda (n)
    (hostcall Pervasives.string_of_int n)))

(define val->string
  (lambda (v)
    (hostcall Pervasives.string_of_val v)))

(define string->int
  (lambda (s)
    (hostcall Pervasives.int_of_string s)))

