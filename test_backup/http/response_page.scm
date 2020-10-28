(lambda (v)
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
	((load "test/http/menu.scm") "Response")))
      (<h1> (list) (list (list "string" (val->string v))))
      (load "test/http/footer.scm"))))))
