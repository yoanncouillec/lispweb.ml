(begin
  (eval
   (hostcall Parse.parse_scheme (list)))
  (define --from-syntax "lisp")
  (eval
   (hostcall Parse.parse_scheme (list "1"))))
