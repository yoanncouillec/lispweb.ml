(load "lib/stdout.scm")

(define pair?
  (lambda (l)
    (not (equal? (length l) 0))))

(define length
  (lambda (l)
    (if (equal? (list) l)
	0
	(+ 1 (length (cdr l))))))

(define index-of
  (lambda (e l)
    (if (pair? l)
	(begin
	  (if (equal? e (car l))
	      0
	      (begin
		(+ 1 (index-of e (cdr l))))))
	(throw not-found 'not-found))))

(define first-slice
  (lambda (c l)
    (if (equal? c (car l))
	(list)
	(cons (car l) (first-slice c (cdr l))))))

(define split-into-2
  (lambda (c l)
    (if (pair? l)
	(if (equal? c (car l))
	    (begin
	      (list (list) (cdr l))
	      )
	    (let* ((res (split-into-2 c (cdr l)))
		   (fst (car res))
		   (snd (car (cdr res))))
	      (list (cons (car l) fst) snd)))
	(list (list) (list)))))

(define is-begin-of?
  (lambda (l0 l)
    (if (pair? l)
	(if (pair? l0)
	    (if (equal? (car l) (car l0))
		(is-begin-of? (cdr l0) (cdr l))
		#f)
	    #t)
	(if (pair? l0)
	    #f
	    #t))))

(define drop
  (lambda (l n)
    (if (equal? n 0)
	l
	(drop (cdr l) (- n 1)))))

(define split-into-two
  (lambda (l0 l)
    (if (pair? l)
	(if (is-begin-of? l0 l)
	    (list (list) (drop l (length l0)))
	    (let (sub (split-into-two l0 (cdr l)))
	      (list (cons (car l) (car sub)) (car (cdr sub)))))
	(list (list) (list)))))

(define split
  (lambda (c l)
    (if (pair? l)
	(let* ((a (split-into-2 c l))
	       (b (split c (car (cdr a)))))
	  (cons (car a) b))
	(list))))

(define map
  (lambda (f l)
    (if (pair? l)
	(cons (f (car l)) (map f (cdr l)))
	(list))))

(define trim-left
  (lambda (e l)
    (if (equal? (car l) e)
	(trim-left e (cdr l))
	l)))

(define append
  (lambda (l1 l2)
    (if (pair? l1)
	(cons (car l1) (append (cdr l1) l2))
	l2)))

(define reverse
  (lambda (l)
    (if (pair? l)
	(append (reverse (cdr l)) (list (car l)))
	(list))))

(define trim-right
  (lambda (e l)
    (reverse (trim-left e (reverse l)))))

(define trim
  (lambda (e l)
    (trim-right e (trim-left e l))))

(define assoc
  (lambda (l k0)
    (let* ((fst (car l)))
      (let* ((k (car fst))
	     (v (car (cdr fst))))
	(if (equal? k k0)
	    (begin
	      v)
	    (begin
	      (assoc (cdr l) k0)))))))

(define replace-first
  (lambda (l l0 l1)
    (let (res (split-into-two l0 l))
      (append (car res) (append l1 (car (cdr res)))))))
