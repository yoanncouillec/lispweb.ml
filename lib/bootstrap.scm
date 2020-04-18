(define bootstrap-badge-primary
  (lambda (s)
    (<span> (list (list "class" "badge badge-primary")) (list (list "string" s)))))

(define bootstrap-badge-secondary
  (lambda (s)
    (<span> (list (list "class" "badge badge-secondary")) (list (list "string" s)))))

(define bootstrap-badge-success
  (lambda (s)
    (<span> (list (list "class" "badge badge-success")) (list (list "string" s)))))

(define bootstrap-badge-danger
  (lambda (s)
    (<span> (list (list "class" "badge badge-danger")) (list (list "string" s)))))

(define bootstrap-badge-warning
  (lambda (s)
    (<span> (list (list "class" "badge badge-warning")) (list (list "string" s)))))

(define bootstrap-badge-info
  (lambda (s)
    (<span> (list (list "class" "badge badge-info")) (list (list "string" s)))))

(define bootstrap-badge-light
  (lambda (s)
    (<span> (list (list "class" "badge badge-light")) (list (list "string" s)))))

(define bootstrap-badge-dark
  (lambda (s)
    (<span> (list (list "class" "badge badge-dark")) (list (list "string" s)))))

(define boostrap-card
  (lambda (src alt title text)
    (<div>
     (list (list "class" "card") (list "style" "width: 10rem"))
     (list
      (<img>
       (list (list "src" src) (list "class" "card-img-top") (list "alt" alt))
       (list))
      (<div>
       (list (list "class" "card-body"))
       (list
	(<h5>
	 (list (list "class" "card-title"))
	 (list (list "string" title)))
	(<p>
	 (list (list "class" "card-text"))
	 (list (list "string" text)))))))))

(define bootstrap-button-valued
  (lambda (s v)
    (<button>
     (list (list "type" "button") (list "class" "btn btn-primary"))
     (list
      (list "string" s)
      (<span>
       (list (list "class" "badge badge-light"))
       (list (list "string" v)))))))
