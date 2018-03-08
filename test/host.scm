(let (fd (hostcall Unix.openfile (list "tmp.tmp" (list "O_CREAT" "O_RDWR") "0o640")))
  (let (buff "1234567890")
    (let (len (hostcall String.length (list buff)))
      (begin
	(hostcall Unix.write (list fd buff 0 len))
	(hostcall Unix.write (list (hostcall Unix.stdout (list)) buff 0 len))
	(hostcall Unix.close (list fd))))))
