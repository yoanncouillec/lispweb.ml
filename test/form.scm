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
  (<button> (list (list "type" "submit") (list "class" "btn btn-primary")) (list (list "string" "Eval")))))
