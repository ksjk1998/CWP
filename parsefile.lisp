(load "split-sequence.lisp")
(load "writefile.lisp")
(print (read-file "default.cwp"))
(defvar *whitespace* '(#\space #\newline #\backspace
		       #\tab #\rubout #\linefeed
		       #\page #\return))
(defun split-semicolon (string)
  "splits the string where it finds a semicolon"
  (let ((string-list ()))
    (dolist (x (split-sequence:split-sequence #\; string))
      (setq string-list (cons (string-trim *whitespace* x) string-list)))
    (reverse string-list)))

(defun split-colon (string)
  "copied someone elses homework and changed one value, needs improvment"
  (let ((string-list ()))
    (dolist (x (split-sequence:split-sequence #\: string))
      (setq string-list (cons (string-trim *whitespace* x) string-list)))
    (reverse string-list)))

(defun strip-empty-strings (string-list)
  (remove-if #'(lambda (string) (string= string "")) string-list))

(print (let ((colon-list nil))
     (dolist (y (let ((rule-list nil))
                  (dolist (x (read-file "default.cwp"))
                    (push (strip-empty-strings (split-semicolon x)) rule-list))
                  (reverse rule-list)))
            (dolist (z y)
	      (push (strip-empty-strings (split-colon z)) colon-list)))
          (reverse colon-list)))

(quit)
