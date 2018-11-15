(defun read-file (filename) 
 (setq lines '(filename))
  (with-open-file (stream filename)
    (do ((line (read-line stream nil)(read-line stream nil)))
     ((null line))
     (push line (cdr (last lines)))))
  lines)

; will be implemented in a way that runs for the first time you execute the server
;(with-open-file (str "/etc/default.cwp"
;                     :direction :output
;                     :if-exists :supersede
;                     :if-does-not-exist :create)
;  (loop for line in (cdr (read-file "default.cwp"))
;       do (format str "~a~%" line)))

;(print (read-file "default.cwp"))
