(with-open-file (str "/etc/default.cwp"
                     :direction :output
                     :if-exists :supersede
                     :if-does-not-exist :create)
  (with-open-file (stream "default.cwp")
    (loop for line = (read-line stream nil)
          while line
          do (format str "~a~%" line))))
(quit)
