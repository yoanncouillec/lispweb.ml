(load "lib/string.scm")
(load "lib/http.scm")
(load "lib/url.scm")

(let (s "%28%2B+1+2%29")
  (url-decode-light s))
