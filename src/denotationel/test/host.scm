(let (fd (hostcall Unix.openfile (list "tmp.tmp" (list "O_CREAT" "O_RDWR") "0o640")))
  (let (buff "1234567890")
    (begin
      (hostcall Unix.write (list fd buff 0 10))
      (hostcall Unix.close (list fd)))))
