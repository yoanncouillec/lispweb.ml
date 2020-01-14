(load "lib/file.scm")
(load "lib/http.scm")
(load "lib/string.scm")
(load "lib/html.scm")

(print "this is http test")

(define service
  (lambda (fd method path queryparams protocol headers)
    (if (equal? path "/")
	(http-send-response 
	 fd 
	 "200" 
	 "text/html" 
	 (html-page->string
	  (<html>
	   (list (list "lang" "en"))
	   (list
	    (<head>
	     (list)
	     (list
	      (<meta> (list (list "name" "viewport") (list "content" "width=device-width, initial-scale=1, shrink-to-fit=no")) (list))
	      (<link> (list (list "rel" "stylesheet") (list "href" "https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css")) (list))))
	    (<body>
	     (list)
	     (list
	      (<div>
	       (list) 
	       (list
		(<div>
		 (list (list "class" "jumbotron"))
		 (list
		  (<h1> (list) (list (list "string" "Welcome to LispWeb Server 1.0")))
		  (<p> (list) (list (list "string" "A revolutionary web programming language")))))
		(<form>
		 (list (list "action" "/eval") (list "class" "p-3"))
		 (list
		  (<div>
		   (list (list "class" "form-group"))
		   (list
		    (<label>
		     (list (list "for" "expr"))
		     (list (list "string" "Expression")))
		    (<input> (list (list "class" "form-control") (list "type" "text") (list "id" "expr") (list "name" "expr") (list "placeholder" "Enter a lisp expression")) (list))))
		  (<button> (list (list "type" "submit") (list "class" "btn btn-primary")) (list (list "string" "Eval")))))))
	      (<script> (list (list "src" "https://code.jquery.com/jquery-3.4.1.slim.min.js")) (list))
	      (<script> (list (list "src" "https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/poppxer.min.js")) (list))
	      (<script> (list (list "src" "https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js")) (list))))))))
	(if (equal? path "/eval")
	    (let* ((expr (assoc queryparams "expr")))
	      (let* ((v (eval expr)))
		(print "eval")
		(http-send-response fd "200" "text/html" (html->string (<h1> (list) (list (list "string" (val->string v))))))))
	    (http-send-response fd "404" "text/html" (html->string (<h1> (list) (list (list "string" path)))))))))


(http-server 8081
	     service)
