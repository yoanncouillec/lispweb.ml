(<html>
 (list)
 (list
  (<head>
   (list)
   (list
    (<script> (list (list "src" "https://code.jquery.com/jquery-3.5.1.js")) (list))
    (<link> (list (list "rel" "stylesheet") (list "href" "https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css")) (list))))
  (<body>
   (list)
   (list
    (<input>
     (list
      (list "id" "query")
      (list "onkeyup"
	    (js->string
	     (scheme->js
	      ((-> $ get) "https://jsonplaceholder.typicode.com/todos/1" (lambda (data) (print data)))))))
     (list))
    (<ul>
     (list (list "id" "response"))
     (list))))))
