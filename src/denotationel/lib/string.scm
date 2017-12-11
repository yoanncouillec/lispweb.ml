(define make-string
  (lambda (n c)
    (hostcall String.make n c)))

(define make-empty-string
  (lambda (n)
    (hostcall String.make n 'a')))

(define string->list
  (lambda (s)
    (if (equal? 1 (string-length s))
	(get-char s 0)
	(cons (get-char s 0) (string->list (sub-string s 1 (- (string-length s) 1)))))))

(define list->string
  (lambda (l)
    (if (pair? l)
	(hostcall String.concat "" (list (make-string 1 (car l)) (list->string (cdr l))))
	(make-string 0 'a'))))

(define string-length
  (lambda (s)
    (hostcall String.length s)))

(define get-char
  (lambda (s n)
    (hostcall String.get s n)))
    
(define sub-string
  (lambda (s ofs len)
    (hostcall String.sub s ofs len)))

(define sub-string
  (lambda (s ofs len)
    (hostcall String.sub s ofs len)))
