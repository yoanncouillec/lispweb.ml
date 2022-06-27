(import "lib/html.scm")
(import "lib/string.scm")

(let* ((page
	(<html> (list)
	 (<body> (list)
	  (<h1> (list)
	   (list "string" "Hello world!"))))))
  (html->string page))
