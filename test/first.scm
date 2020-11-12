(let (first (lambda (x) (lambda (y) x)))
  (let (second (lambda (x) (lambda (y) y)))
    (list
     ((first 1) 2)
     ((second 1) 2))))
