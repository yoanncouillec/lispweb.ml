(define tag
  (lambda (name attributes child)
    (list name child)))

(define <html>
  (lambda (attributes child)
    (list "tag" "html" attributes child)))

(define <body>
  (lambda (attributes child)
    (list "tag" "body" attributes child)))

(define <h1>
  (lambda (attributes child)
    (list "tag" "h1" attributes child)))

(define html->string
  (lambda (element)
    (let* ((type (car element)))
      (if (equal? type "tag")
	  (concat "" (list "<" (car (cdr element)) ">" (html->string (car (cdr (cdr (cdr element))))) "</" (car (cdr element)) ">"))
	  (if (equal? type "string")
	      (car (cdr element))
	      (throw error 'wrong-type-element))))))
