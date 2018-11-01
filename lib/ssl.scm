(define ssl-init
  (lambda ()
    (hostcall Ssl.init)))

(define ssl-protocol-v23
  (lambda ()
    (hostcall Ssl.protocol_v23)))

(define ssl-context-type-server
  (lambda ()
    (hostcall Ssl.context_type_server)))

(define ssl-open-connection
  (lambda (v s)
    (hostcall Ssl.open_connection v s)))

(define ssl-get-certificate
  (lambda (ssl)
    (hostcall Ssl.get_certificate ssl)))

(define ssl-get-cipher
  (lambda (ssl)
    (hostcall Ssl.get_cipher ssl)))

(define ssl-get-issuer
  (lambda (cert)
    (hostcall Ssl.get_issuer cert)))

(define ssl-get-subject
  (lambda (cert)
    (hostcall Ssl.get_subject cert)))

(define ssl-get-cipher-name
  (lambda (cipher)
    (hostcall Ssl.get_cipher_name cipher)))

(define ssl-get-cipher-version
  (lambda (cipher)
    (hostcall Ssl.get_cipher_version cipher)))

(define ssl-get-cipher-description
  (lambda (cipher)
    (hostcall Ssl.get_cipher_description cipher)))

(define ssl-write
  (lambda (ssl buff offset length)
    (hostcall Ssl.write ssl buff offset length)))

(define ssl-read
  (lambda (ssl buff offset length)
    (hostcall Ssl.read ssl buff offset length)))

(define ssl-shutdown
  (lambda (ssl)
    (hostcall Ssl.shutdown ssl)))

(define ssl-create-context
  (lambda (protocol context-type)
    (hostcall Ssl.create_context protocol context-type)))

(define ssl-use-certificate
  (lambda (context cert privkey)
    (hostcall Ssl.use_certificate context cert privkey)))

(define ssl-set-password
  (lambda (context pwd)
    (hostcall Ssl.set_password context pwd)))

(define ssl-embed-socket
  (lambda (context s ctx)
    (hostcall Ssl.embed_socket s ctx)))

(define ssl-accept
  (lambda (sock)
    (hostcall Ssl.accept sock)))

(define ssl-make-client
  (lambda (host port)
    (ssl-init)
    (let* ((he (gethostbyname host))
	   (sockaddr (addr_inet (inet_addr_of_host_entry he) port))
	   (ssl (ssl-open-connection (ssl-protocol-v23) sockaddr))
	   (cert (ssl-get-certificate ssl))
	   (cipher (ssl-get-cipher ssl))
	   (issuer(ssl-get-issuer cert))
	   (subject (ssl-get-subject cert))
	   (cipher_name (ssl-get-cipher-name cipher))
	   (cipher_version (ssl-get-cipher-version cipher))
	   (cipher_description (ssl-get-cipher-description cipher)))
      ssl)))

(define ssl-make-server
  (lambda (port password certfile privkeyfile nbconn)
    (ssl-init)
    (print "111")
    (let* ((sockaddr (addr_inet (inet_addr_any) port))
	   (domain (domain_of_sockaddr sockaddr))
	   (sock (socket (string-of-domain domain) "SOCK_STREAM" 0))
	   (ctx (ssl-create-context (ssl-protocol-v23) (ssl-context-type-server))))
      (print "222")
      (ssl-set-password ctx password)
      (print "333")
      (ssl-use-certificate ctx certfile privkeyfile)
      (print "444")
      (setsockopt sock "SO_REUSEADDR" #t)
      (print "444")
      (bind sock sockaddr)
      (print "555")
      (listen sock nbconn)
      (print "666")
      (let* ((p (accept sock))
	     (s (car p))
	     (caller (car (cdr p)))
	     (sslss (ssl-embed-socket s ctx)))
	(ssl-accept ssl-s)
	ssl-s))))
