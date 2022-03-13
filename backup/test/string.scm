(import "lib/string.scm")
(import "lib/http.scm")
(import "lib/url.scm")

(let (s "%28%2B+1+2%29")
  (url-decode-light s))
