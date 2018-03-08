(begin
  (block x
	 (return-from x 12))
  (let (f (lambda (x) (return-from exn 13)))
    (block exn (f 0))))
