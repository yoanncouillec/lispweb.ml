(define ssl-init
  (lambda ()
    (hostcall Ssl.init)))

(define ssl-protocol-v23
  (lambda ()
    (hostcall Ssl.protocol_v23)))

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

(define ssl-make
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

