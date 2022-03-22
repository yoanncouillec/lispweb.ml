(import "list.scm")

(define make-string
  (lambda (n c)
    (hostcall String.make n c)))

(define make-empty-string
  (lambda (n)
    (hostcall String.make n 'x')))

(define make-regexp
  (lambda (s)
    (hostcall Str.regexp s)))

(define global-replace
  (lambda (old niou s)
    (hostcall Str.global_replace old niou s)))

(define global-replace-list
  (lambda (l s)
    (if (pair? l)
	(let (fst (car l))
	  (let (old (car fst))
	    (let (niou (car (cdr fst)))
	      (global-replace-list (cdr l) (global-replace old niou s)))))
	s)))

(define string->list
  (lambda (s)
    (if (equal? 1 (string-length s))
	(list (get-char s 0))
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

(define char->string
  (lambda (c)
    (hostcall Char.char_to_string c)))

(define char->bytes
  (lambda (c)
    (bytes-make 1 c)))

(define concat
  (lambda (sep l)
    (hostcall String.concat sep l)))

(define string-concat 
  (lambda (l)
    (concat "" l)))

(define string-concat-sep 
  (lambda (sep l)
    (concat sep l)))

