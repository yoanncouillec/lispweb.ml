(define tag
  (lambda (name attributes children)
    (list name children)))

(define <html>
  (lambda (attributes children)
    (list "tag" "html" attributes children)))

(define <body>
  (lambda (attributes children)
    (list "tag" "body" attributes children)))

(define <div>
  (lambda (attributes children)
    (list "tag" "div" attributes children)))

(define <input>
  (lambda (attributes children)
    (list "tag" "input" attributes children)))

(define <form>
  (lambda (attributes children)
    (list "tag" "form" attributes children)))

(define <h1>
  (lambda (attributes children)
    (list "tag" "h1" attributes children)))

(define html->string
  (lambda (element)
    (let* ((type (car element)))
      (if (equal? type "tag")
	  (let* ((children (car (cdr (cdr (cdr element)))))
		 (attributes (car (cdr (cdr element)))))
	    (concat "" (list "<" (car (cdr element)) " " (concat "" (map (lambda (attribute) (concat "" (list (car attribute) "='" (car (cdr attribute)) "'"))) attributes)) ">" (concat "" (map html->string children)) "</" (car (cdr element)) ">")))
	  (if (equal? type "string")
	      (car (cdr element))
	      (throw error 'wrong-type-element))))))
