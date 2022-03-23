(import "standard.scm")
(import "process.scm")

(print (gethostname))
(debug "loading library")
(info "loading library")
(load-string (wget "https" "raw.githubusercontent.com" 443 "/yoanncouillec/lispweb.ml/master/scm/lib/hello.scm"))
(success "library loaded")
(print (hello :name "to Lispw"))
(error "this is to test error log")
(fatal "this is to test fatal log")
(warning "this is to test warning log")

