(lambda (s)
  (<div>
   (list (list "class" "navbar"))
   (list
    (<div>
     (list (list "class" "navbar-inner"))
     (list
      (<div>
       (list (list "class" "container"))
       (list
	(<ul>
	 (list (list "class" "nav nav-pills"))
	 (list
	  (<li>
	   (list (list "class" "nav-item"))
	   (list
	    (<a>
	     (list (if (equal? s "Home")
		       (list "class" "nav-link active")
		       (list "class" "nav-link"))
		   (list "href" "/home"))
	     (list (list "string" "Home")))))
	  (<li>
	   (list (list "class" "nav-item"))
	   (list
	    (<a>
	     (list (if (equal? s "Eval")
		       (list "class" "nav-link active")
		       (list "class" "nav-link"))
		   (list "href" "/eval"))
	     (list (list "string" "Eval"))))))))))))))
