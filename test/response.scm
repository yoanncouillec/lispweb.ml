(lambda (v)
  (<html>
   (list (list "lang" "en"))
   (list
    (load "test/head.scm")
    (<body>
     (list)
     (list
      (<div>
       (list) 
       (list
	(load "test/header.scm")
	(<h1> (list) (list (list "string" (val->string v))))
	(load "test/form.scm")))
      (load "test/footer.scm"))))))
