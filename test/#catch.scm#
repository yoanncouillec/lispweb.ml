(begin
  (catch e
	 (throw e 12))
  (let (f (lambda (x) (throw exn 13)))
    (catch exn (f 11))))
