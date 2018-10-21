(load "lib/file.scm")
(load "lib/http.scm")
(load "lib/string.scm")
(load "lib/html.scm")

(define service
  (lambda (out method path protocol headers)
    (if (equal? path "/")
	(http-send-response out "200" "text/html" 
			    (html->string 
			     (<div> (list) 
				    (list 
				     (<h1> (list) (list (list "string" "Welcome to LispWeb Server 1.0")))
				     (<form>
				      (list (list "action" "/eval"))
				      (list
				       (<input> (list (list "type" "text") (list "name" "expr")) (list))))))))
	(if (equal? path "/eval")
	    (let* ((expr "\"hello\"")
		   (xxx (eval expr)))
	      (http-send-response out "200" "text/html" (html->string (<h1> (list) (list (list "string" expr))))))
	    (http-send-response out "404" "text/html" (html->string (<h1> (list) (list (list "string" path)))))))
    (flush out)))

(http-server 8081
 service)

http://hostname:port/api/run?player=xxx&x=yyy...

[Root("api")]
public class{

[HTTPGET("/run")
public void Run(string player, int x, int y){

}
|
