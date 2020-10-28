(load "lib/stdout.scm")
(load "lib/thread.scm")

(let (t
      (call-with-new-thread
       (lambda ()
	 (print "123"))))
  (thread-join t))
