(load "lib/string.scm")
(load "lib/socket.scm")
(load "lib/channel.scm")
(load "lib/stdout.scm")

(define http-parse-queryparams
  (lambda (queryparams)
    (print "http-parse-queryparams")
    (let (xxx (split '&' queryparams))
      (let (yyy (map (lambda (p)
		       (let (res (split '=' p))
			 (list
			  (list->string (car res))
			  (list->string (car (cdr res)))))
		       )
		     xxx))
	yyy))))
    

(define http-parse-method
  (lambda (read fd)
    (print "http-parse-method")
    (let* ((fst-line (map list->string (split ' ' (string->list (read-line read fd)))))
	   (method (car fst-line))
	   (path (car (cdr fst-line)))
	   (pathqueryparams (split-into-2 '?' (string->list path)))
	   (path (list->string (car pathqueryparams)))
	   (queryparams (http-parse-queryparams (car (cdr pathqueryparams))))
	   (protocol (car (cdr (cdr fst-line)))))
      (print (concat "=" (list "  method" method)))
      (print (concat "=" (list "  path" path)))
      (print (concat "=" (list "  queryparams" (val->string queryparams))))
      (print (concat "=" (list "  protocol" (val->string protocol))))
      (if (equal? "GET" method)
	  (list method path queryparams protocol)
	  (throw error 'wrong-http-first-line)))))

(define http-parse-response-status
  (lambda (l)
    (let* ((fst-line (map list->string (split ' ' (string->list l))))
	   (version (car fst-line))
	   (code (car (cdr fst-line)))
	   (phrase (car (cdr (cdr fst-line)))))
      (list version code phrase))))

(define http-parse-header
  (lambda (in)
    (map list->string (split ':' (string->list (input-line in))))))

(define http-parse-headers
  (lambda (read fd)
    (let* ((l (read-line read fd)))
      (if (equal? "" l)
	    l
	    (let* ((header (split-into-2 ':' (string->list l)))
		   (len (length header)))
	      (cons (map list->string 
			 header)
		    (http-parse-headers read fd)))))))

(define http-parse-headers-light
  (lambda (read fd)
    (print "http-parse-headers-light")
    (let* ((l (read-line read fd)))
      (if (equal? "" l)
	    l
	      (cons l (http-parse-headers-light fd))))))

(define http-send-response
  (lambda (fd code type content)
    (write-lines
     fd
     (list
      (concat " " (list "HTTP/1.1" code "OK"))
      (concat " " (list "Content-Length:" (int->string (string-length content))))
      (concat " " (list "Content-Type:" type))))
    (write-char fd '\n')
    (write-string fd content)
    (shutdown fd "SHUTDOWN_ALL")))

(define read-all
  (lambda (fd)
    (let* ((s (make-empty-string 1)))
      (if (equal? (read fd s 0 1) 0)
	    (list)
	      (cons s (read-all fd))))))

(define serve
  (lambda (client service)
    (print "serve")
    (let* ((first-line (http-parse-method read client))
	   (method (car first-line))
	   (path (car (cdr first-line)))
	   (queryparams (car (cdr (cdr first-line))))
	   (protocol (car (cdr (cdr (cdr first-line)))))
	   (headers (http-parse-headers-light read client)))
      (service client method path queryparams protocol headers))))
    
(define accept-client
  (lambda (server service)
    (print "accept-client")
    (let* ((client (car (accept server))))
      (serve client service)
      (accept-client server service))))

(define http-server
  (lambda (port service)
    (print "http-server")
    (let* ((server (socket "PF_INET" "SOCK_STREAM" 0))
	   (sockaddr (addr_inet (inet_addr_loopback) port)))
      (bind server sockaddr)
      (listen server 10)
      (accept-client server service))))

(define url-decode-light
  (lambda (s)
    (global-replace-list
     (list
      (list (make-regexp "+") " ")
      (list (make-regexp "%20") " ")
      (list (make-regexp "%21") "!")
      (list (make-regexp "%22") "\"")
      (list (make-regexp "%23") "#")
      (list (make-regexp "%24") "$")
      (list (make-regexp "%25") "%")
      (list (make-regexp "%26") "&")
      (list (make-regexp "%27") "'")
      (list (make-regexp "%28") "(")
      (list (make-regexp "%29") ")")
      (list (make-regexp "%2A") "*")
      (list (make-regexp "%2B") "+")
      (list (make-regexp "%2C") ",")
      (list (make-regexp "%2D") "-")
      (list (make-regexp "%2E") ".")
      (list (make-regexp "%2F") "/")
      (list (make-regexp "%30") "0")
      (list (make-regexp "%31") "1")
      (list (make-regexp "%32") "2")
      (list (make-regexp "%33") "3")
      (list (make-regexp "%34") "4")
      (list (make-regexp "%35") "5")
      (list (make-regexp "%36") "6")
      (list (make-regexp "%37") "7")
      (list (make-regexp "%38") "8")
      (list (make-regexp "%39") "9")
      (list (make-regexp "%3A") ":")
      (list (make-regexp "%3B") ";")
      (list (make-regexp "%3C") "<")
      (list (make-regexp "%3D") "=")
      (list (make-regexp "%3E") ">")
      (list (make-regexp "%3F") "?")
      (list (make-regexp "%40") "@")
      (list (make-regexp "%41") "A")
      (list (make-regexp "%42") "B")
      (list (make-regexp "%43") "C")
      (list (make-regexp "%44") "D")
      (list (make-regexp "%45") "E")
      (list (make-regexp "%46") "F")
      (list (make-regexp "%47") "G")
      (list (make-regexp "%48") "H")
      (list (make-regexp "%49") "I")
      (list (make-regexp "%4A") "J")
      (list (make-regexp "%4B") "K")
      (list (make-regexp "%4C") "L")
      (list (make-regexp "%4D") "M")
      (list (make-regexp "%4E") "N")
      (list (make-regexp "%4F") "O")
      (list (make-regexp "%50") "P")
      (list (make-regexp "%51") "Q")
      (list (make-regexp "%52") "R")
      (list (make-regexp "%53") "S")
      (list (make-regexp "%54") "T")
      (list (make-regexp "%55") "U")
      (list (make-regexp "%56") "V")
      (list (make-regexp "%57") "W")
      (list (make-regexp "%58") "X")
      (list (make-regexp "%59") "Y")
      (list (make-regexp "%5A") "Z")
      (list (make-regexp "%5B") "[")
      (list (make-regexp "%5D") "]")
      (list (make-regexp "%5E") "^")
      (list (make-regexp "%5F") "_")
      (list (make-regexp "%60") "`")
      (list (make-regexp "%61") "a")
      (list (make-regexp "%62") "b")
      (list (make-regexp "%63") "c")
      (list (make-regexp "%64") "d")
      (list (make-regexp "%65") "e")
      (list (make-regexp "%66") "f")
      (list (make-regexp "%67") "g")
      (list (make-regexp "%68") "h")
      (list (make-regexp "%69") "i")
      (list (make-regexp "%6A") "j")
      (list (make-regexp "%6B") "k")
      (list (make-regexp "%6C") "l")
      (list (make-regexp "%6D") "m")
      (list (make-regexp "%6E") "n")
      (list (make-regexp "%6F") "o")
      (list (make-regexp "%70") "p")
      (list (make-regexp "%71") "q")
      (list (make-regexp "%72") "r")
      (list (make-regexp "%73") "s")
      (list (make-regexp "%74") "t")
      (list (make-regexp "%75") "u")
      (list (make-regexp "%76") "v")
      (list (make-regexp "%77") "w")
      (list (make-regexp "%78") "x")
      (list (make-regexp "%79") "y")
      (list (make-regexp "%7A") "z")
      (list (make-regexp "%7B") "{")
      (list (make-regexp "%7C") "|")
      (list (make-regexp "%7D") "}")
      (list (make-regexp "%7E") "~")
      )
     s)))

(define url-decode
  (lambda (s)
    (global-replace-list
     (list
      (list (make-regexp "+") " ")
      (list (make-regexp "%20") " ")
      (list (make-regexp "%21") "!")
      (list (make-regexp "%22") "\"")
      (list (make-regexp "%23") "#")
      (list (make-regexp "%24") "$")
      (list (make-regexp "%25") "%")
      (list (make-regexp "%26") "&")
      (list (make-regexp "%27") "'")
      (list (make-regexp "%28") "(")
      (list (make-regexp "%29") ")")
      (list (make-regexp "%2A") "*")
      (list (make-regexp "%2B") "+")
      (list (make-regexp "%2C") ",")
      (list (make-regexp "%2D") "-")
      (list (make-regexp "%2E") ".")
      (list (make-regexp "%2F") "/")
      (list (make-regexp "%30") "0")
      (list (make-regexp "%31") "1")
      (list (make-regexp "%32") "2")
      (list (make-regexp "%33") "3")
      (list (make-regexp "%34") "4")
      (list (make-regexp "%35") "5")
      (list (make-regexp "%36") "6")
      (list (make-regexp "%37") "7")
      (list (make-regexp "%38") "8")
      (list (make-regexp "%39") "9")
      (list (make-regexp "%3A") ":")
      (list (make-regexp "%3B") ";")
      (list (make-regexp "%3C") "<")
      (list (make-regexp "%3D") "=")
      (list (make-regexp "%3E") ">")
      (list (make-regexp "%3F") "?")
      (list (make-regexp "%40") "@")
      (list (make-regexp "%41") "A")
      (list (make-regexp "%42") "B")
      (list (make-regexp "%43") "C")
      (list (make-regexp "%44") "D")
      (list (make-regexp "%45") "E")
      (list (make-regexp "%46") "F")
      (list (make-regexp "%47") "G")
      (list (make-regexp "%48") "H")
      (list (make-regexp "%49") "I")
      (list (make-regexp "%4A") "J")
      (list (make-regexp "%4B") "K")
      (list (make-regexp "%4C") "L")
      (list (make-regexp "%4D") "M")
      (list (make-regexp "%4E") "N")
      (list (make-regexp "%4F") "O")
      (list (make-regexp "%50") "P")
      (list (make-regexp "%51") "Q")
      (list (make-regexp "%52") "R")
      (list (make-regexp "%53") "S")
      (list (make-regexp "%54") "T")
      (list (make-regexp "%55") "U")
      (list (make-regexp "%56") "V")
      (list (make-regexp "%57") "W")
      (list (make-regexp "%58") "X")
      (list (make-regexp "%59") "Y")
      (list (make-regexp "%5A") "Z")
      (list (make-regexp "%5B") "[")
      (list (make-regexp "%5D") "]")
      (list (make-regexp "%5E") "^")
      (list (make-regexp "%5F") "_")
      (list (make-regexp "%60") "`")
      (list (make-regexp "%61") "a")
      (list (make-regexp "%62") "b")
      (list (make-regexp "%63") "c")
      (list (make-regexp "%64") "d")
      (list (make-regexp "%65") "e")
      (list (make-regexp "%66") "f")
      (list (make-regexp "%67") "g")
      (list (make-regexp "%68") "h")
      (list (make-regexp "%69") "i")
      (list (make-regexp "%6A") "j")
      (list (make-regexp "%6B") "k")
      (list (make-regexp "%6C") "l")
      (list (make-regexp "%6D") "m")
      (list (make-regexp "%6E") "n")
      (list (make-regexp "%6F") "o")
      (list (make-regexp "%70") "p")
      (list (make-regexp "%71") "q")
      (list (make-regexp "%72") "r")
      (list (make-regexp "%73") "s")
      (list (make-regexp "%74") "t")
      (list (make-regexp "%75") "u")
      (list (make-regexp "%76") "v")
      (list (make-regexp "%77") "w")
      (list (make-regexp "%78") "x")
      (list (make-regexp "%79") "y")
      (list (make-regexp "%7A") "z")
      (list (make-regexp "%7B") "{")
      (list (make-regexp "%7C") "|")
      (list (make-regexp "%7D") "}")
      (list (make-regexp "%7E") "~")
      (list (make-regexp "%7F") " ")
      (list (make-regexp "%E2%82%AC") "`")
      (list (make-regexp "%E2%80%9A") "‚")
      (list (make-regexp "%E2%80%9E") "„")
      (list (make-regexp "%E2%80%A6") "…")
      (list (make-regexp "%E2%80%A0") "†")
      (list (make-regexp "%E2%80%A1") "‡")
      (list (make-regexp "%CB%86"   ) "ˆ")
      (list (make-regexp "%C5%BD"   ) "Ž")
      (list (make-regexp "%E2%80%B0") "‰")
      (list (make-regexp "%E2%80%B9") "‹")
      (list (make-regexp "%E2%80%98") "‘")
      (list (make-regexp "%E2%80%99") "’")
      (list (make-regexp "%E2%80%9C") "“")
      (list (make-regexp "%E2%80%9D") "”")
      (list (make-regexp "%E2%80%A2") "•")
      (list (make-regexp "%E2%80%93") "–")
      (list (make-regexp "%E2%80%94") "—")
      (list (make-regexp "%C5%92"   ) "Œ")
      (list (make-regexp "%C5%A0"   ) "Š")
      (list (make-regexp "%C6%92"   ) "ƒ")
      (list (make-regexp "%CB%9C"   ) "˜")
      (list (make-regexp "%E2%84"   ) "™")
      (list (make-regexp "%C5%A1"   ) "š")
      (list (make-regexp "%E2%80"   ) "›")
      (list (make-regexp "%C5%93"   ) "œ")
      (list (make-regexp "%8F") "")
      (list (make-regexp "%81") "")
      (list (make-regexp "%C5%8D") "")
      (list (make-regexp "%C2%90") "")
      (list (make-regexp "%9D") "")
      (list (make-regexp "%C5%BE") "ž")
      (list (make-regexp "%C5%B8") "Ÿ")
      (list (make-regexp "%C2%A0") " ")
      (list (make-regexp "%C2%A1") "¡")
      (list (make-regexp "%C2%A2") "¢")
      (list (make-regexp "%C2%A3") "£")
      (list (make-regexp "%C2%A4") "¤")
      (list (make-regexp "%C2%A5") "¥")
      (list (make-regexp "%C2%A6") "¦")
      (list (make-regexp "%C2%A7") "§")
      (list (make-regexp "%C2%A8") "¨")
      (list (make-regexp "%C2%A9") "©")
      (list (make-regexp "%C2%AA") "ª")
      (list (make-regexp "%C2%AB") "«")
      (list (make-regexp "%C2%AC") "¬")
      (list (make-regexp "%C2%AD") "­")
      (list (make-regexp "%C2%AE") "®")
      (list (make-regexp "%C2%AF") "¯")
      (list (make-regexp "%C2%B0") "°")
      (list (make-regexp "%C2%B1") "±")
      (list (make-regexp "%C2%B2") "²")
      (list (make-regexp "%C2%B3") "³")
      (list (make-regexp "%C2%B4") "´")
      (list (make-regexp "%C2%B5") "µ")
      (list (make-regexp "%C2%B6") "¶")
      (list (make-regexp "%C2%B7") "·")
      (list (make-regexp "%C2%B8") "¸")
      (list (make-regexp "%C2%B9") "¹")
      (list (make-regexp "%C2%BA") "º")
      (list (make-regexp "%C2%BB") "»")
      (list (make-regexp "%C2%BC") "¼")
      (list (make-regexp "%C2%BD") "½")
      (list (make-regexp "%C2%BE") "¾")
      (list (make-regexp "%C2%BF") "¿")
      (list (make-regexp "%C3%80") "À")
      (list (make-regexp "%C3%81") "Á")
      (list (make-regexp "%C3%82") "Â")
      (list (make-regexp "%C3%83") "Ã")
      (list (make-regexp "%C3%84") "Ä")
      (list (make-regexp "%C3%85") "Å")
      (list (make-regexp "%C3%86") "Æ")
      (list (make-regexp "%C3%87") "Ç")
      (list (make-regexp "%C3%88") "È")
      (list (make-regexp "%C3%89") "É")
      (list (make-regexp "%C3%8A") "Ê")
      (list (make-regexp "%C3%8B") "Ë")
      (list (make-regexp "%C3%8C") "Ì")
      (list (make-regexp "%C3%8D") "Í")
      (list (make-regexp "%C3%8E") "Î")
      (list (make-regexp "%C3%8F") "Ï")
      (list (make-regexp "%C3%90") "Ð")
      (list (make-regexp "%C3%91") "Ñ")
      (list (make-regexp "%C3%92") "Ò")
      (list (make-regexp "%C3%93") "Ó")
      (list (make-regexp "%C3%94") "Ô")
      (list (make-regexp "%C3%95") "Õ")
      (list (make-regexp "%C3%96") "Ö")
      (list (make-regexp "%C3%97") "×")
      (list (make-regexp "%C3%98") "Ø")
      (list (make-regexp "%C3%99") "Ù")
      (list (make-regexp "%C3%9A") "Ú")
      (list (make-regexp "%C3%9B") "Û")
      (list (make-regexp "%C3%9C") "Ü")
      (list (make-regexp "%C3%9D") "Ý")
      (list (make-regexp "%C3%9E") "Þ")
      (list (make-regexp "%C3%9F") "ß")
      (list (make-regexp "%C3%A0") "à")
      (list (make-regexp "%C3%A1") "á")
      (list (make-regexp "%C3%A2") "â")
      (list (make-regexp "%C3%A3") "ã")
      (list (make-regexp "%C3%A4") "ä")
      (list (make-regexp "%C3%A5") "å")
      (list (make-regexp "%C3%A6") "æ")
      (list (make-regexp "%C3%A7") "ç")
      (list (make-regexp "%C3%A8") "è")
      (list (make-regexp "%C3%A9") "é")
      (list (make-regexp "%C3%AA") "ê")
      (list (make-regexp "%C3%AB") "ë")
      (list (make-regexp "%C3%AC") "ì")
      (list (make-regexp "%C3%AD") "í")
      (list (make-regexp "%C3%AE") "î")
      (list (make-regexp "%C3%AF") "ï")
      (list (make-regexp "%C3%B0") "ð")
      (list (make-regexp "%C3%B1") "ñ")
      (list (make-regexp "%C3%B2") "ò")
      (list (make-regexp "%C3%B3") "ó")
      (list (make-regexp "%C3%B4") "ô")
      (list (make-regexp "%C3%B5") "õ")
      (list (make-regexp "%C3%B6") "ö")
      (list (make-regexp "%C3%B7") "÷")
      (list (make-regexp "%C3%B8") "ø")
      (list (make-regexp "%C3%B9") "ù")
      (list (make-regexp "%C3%BA") "ú")
      (list (make-regexp "%C3%BB") "û")
      (list (make-regexp "%C3%BC") "ü")
      (list (make-regexp "%C3%BD") "ý")
      (list (make-regexp "%C3%BE") "þ")
      (list (make-regexp "%C3%BF") "ÿ")
      )
     s)))
