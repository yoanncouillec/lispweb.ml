(import "lib/assert.scm")
(import "lib/file.scm")

(test-all
 "lib/file.scm"
 (list
  (lambda ()
    (assert "openfile - no such file"
	    (catch no-such-file
		   (openfile "asdf1234.txt"))
	    :expects #f))
  (lambda ()
    (assert "openfile"
	    (catch no-such-file
		   (let ((buf (bytes-create 4)))
		     (read (openfile "test/file.txt") buf 0 4)
		     (bytes->string buf)))
	    :expects "file"))
  (lambda ()
    (assert "read-line"
	    (read-line read (openfile "test/file.txt"))
	    :expects "file"))
  ))
