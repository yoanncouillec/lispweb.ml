(import "standard.scm")
(import "string.scm")
(import "assert.scm")

(begin-test "string.scm")

(assert "make-string 1" (make-string 3 'x') "xxx")

(assert "make-empty-string 1" (make-empty-string 3) "xxx")

(assert-todo "make-regexp")
(assert-todo "global-replace")
(assert-todo "global-replace-list")

(assert "string->list 1" (string->list "xyz") (list 'x' 'y' 'z'))

(assert "list->string" (list->string (list 'x' 'y' 'z')) "xyz")
(assert-todo "string-length")
(assert-todo "get-char")
(assert-todo "sub-string")
(assert-todo "char->string")
(assert-todo "char->bytes")
(assert-todo "concat")
(assert-todo "string-concat")
(assert-todo "string-concat-sep")

(end-test)