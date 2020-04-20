(<html>
 (list (list "lang" "en"))
 (list
  (load "test/http/head.scm")
  (<body>
   (list)
   (list
    (<div>
     (list) 
     (list
      (load "test/http/header.scm")
      ((load "test/http/menu.scm") "Home")
      (<div>
       (list)
       (list
	(bootstrap-badge-primary "Primary")
	(bootstrap-badge-secondary "Secondary")
	(bootstrap-badge-success "Success")
	(bootstrap-badge-danger "Danger")
	(bootstrap-badge-warning "Warning")
	(bootstrap-badge-info "Info")
	(bootstrap-badge-light "Light")
	(bootstrap-badge-dark "Dark")

	(bootstrap-badge-pill-primary "Primary")
	(bootstrap-badge-pill-secondary "Secondary")
	(bootstrap-badge-pill-success "Success")
	(bootstrap-badge-pill-danger "Danger")
	(bootstrap-badge-pill-warning "Warning")
	(bootstrap-badge-pill-info "Info")
	(bootstrap-badge-pill-light "Light")
	(bootstrap-badge-pill-dark "Dark")

	(bootstrap-badge-link-primary   "Primary" "#")
	(bootstrap-badge-link-secondary "Secondary" "#")
	(bootstrap-badge-link-success   "Success" "#")
	(bootstrap-badge-link-danger    "Danger" "#")
	(bootstrap-badge-link-warning   "Warning" "#")
	(bootstrap-badge-link-info      "Info" "#")
	(bootstrap-badge-link-light     "Light" "#")
	(bootstrap-badge-link-dark      "Dark" "#")

	;;(bootstrap-button-valued "Notifications" "4");;
	;;(boostrap-card "https://www.top5reviewed.com/wp-content/uploads/2018/03/pikachu.png" "" "Pikachu" "Pika! Pika!");;
	))
      ))
    (load "test/http/footer.scm")))))
