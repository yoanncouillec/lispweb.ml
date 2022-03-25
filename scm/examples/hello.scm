(import "standard.scm")
(import "process.scm")

(print (getenv "LISPW_LIB_DIR"))

(define mylogger (logger (getenv "LEVEL")))

(print (gethostname))
(mylogger "DEBUG" "loading library")
(mylogger "INFO" "loading library")
(load-string (wget "https" "raw.githubusercontent.com" 443 "/yoanncouillec/lispweb.ml/master/scm/lib/hello.scm"))
(print (hello :name "to Lispw"))
(mylogger "ERROR" "this is to test error log")
(mylogger "FATAL" "this is to test fatal log")
(mylogger "WARNING" "this is to test warning log")

