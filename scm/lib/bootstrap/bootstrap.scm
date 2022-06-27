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
