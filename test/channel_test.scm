(import "lib/assert.scm")
(import "lib/channel.scm")

(test-all
 "lib/channel.scm"
 (list
  (lambda ()
    (assert "open-in - no such file"
	    (catch sys-error
		   (open-in "asdf1234.txt"))
	    :expects #f))
  (lambda ()
    (assert "open-in"
	    (catch sys-error
		   (input-line (open-in "test/file.txt")))
	    :expects "file"))
  (lambda ()
    (assert "input-lines"
	    (catch sys-error
		   (input-lines (open-in "test/lines.txt")))
	    :expects (list "line0" "line1" "line2")))
  ))
