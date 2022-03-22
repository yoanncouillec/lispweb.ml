(import "standard.scm")

(print "Getting library...")

(load-string (wget "https" "raw.githubusercontent.com" 443 "/yoanncouillec/lispweb.ml/master/scm/lib/hello.scm"))

(print (welcome :name "to Lispw"))
