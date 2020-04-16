(define tag
  (lambda (name attributes children)
    (list name children)))

(define <html>
  (lambda (attributes children)
    (list "tag" "html" attributes children)))

(define <head>
  (lambda (attributes children)
    (list "tag" "head" attributes children)))

(define <meta>
  (lambda (attributes children)
    (list "tag" "meta" attributes children)))

(define <link>
  (lambda (attributes children)
    (list "tag" "link" attributes children)))

(define <script>
  (lambda (attributes children)
    (list "tag" "script" attributes children)))

(define <title>
  (lambda (attributes children)
    (list "tag" "title" attributes children)))

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

(define <p>
  (lambda (attributes children)
    (list "tag" "p" attributes children)))

(define <a>
  (lambda (attributes children)
    (list "tag" "a" attributes children)))

(define <ul>
  (lambda (attributes children)
    (list "tag" "ul" attributes children)))

(define <li>
  (lambda (attributes children)
    (list "tag" "li" attributes children)))

(define <label>
  (lambda (attributes children)
    (list "tag" "label" attributes children)))

(define <button>
  (lambda (attributes children)
    (list "tag" "button" attributes children)))

(define html-page->string
  (lambda (page)
    (concat "" (list "<!doctype html>" (html->string page)))))

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
