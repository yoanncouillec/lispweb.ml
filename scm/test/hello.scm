(import "standard.scm")

(debug "loading library")
(load-string (wget "https" "192.168.1.77" 8383 "https://raw.githubusercontent.com/yoanncouillec/lispweb.ml/master/scm/lib/hello.scm"))
(info "library loaded")
(warning "Loading Library")
(success "Loading Library")
(error "Loading Library")
(critical "Loading Library")
(hello "to Lispw")

