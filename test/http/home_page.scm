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
	(bootstrap-badge-info "Info")
	(bootstrap-badge-light "Light")
	(bootstrap-badge-dark "Dark")
	(bootstrap-badge-warning "Warning")
	(bootstrap-badge-success "Success")
	(bootstrap-button-valued "Notifications" "4")
	(boostrap-card "https://www.top5reviewed.com/wp-content/uploads/2018/03/pikachu.png" "" "Pikachu" "Pika! Pika!")
	))
      ))
    (load "test/http/footer.scm")))))
