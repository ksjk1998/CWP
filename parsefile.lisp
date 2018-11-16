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

(defun split-colon-and-reverse (string)
  "splits a string at every colon and returns a reversed list of results"
  (let ((string-list ()))
    (dolist (x (split-sequence:split-sequence #\: string))
      (setq string-list (cons (string-trim *whitespace* x) string-list)))
    string-list))

(defun after-last-colon (string)
  "returns the text after the last colon in a string"
  (car (split-colon string)))

(defun strip-empty-strings (string-list)
  (remove-if #'(lambda (string) (string= string "")) string-list))

(defun do-semicolon (l)
  (let ((rule-list nil))
    (dolist (x l)
      (push (strip-empty-strings (split-semicolon x)) rule-list))
    (reverse rule-list)))

(defun do-colon (l)
  (let ((colon-list nil))
    (dolist (y (do-semicolon l))
      (dolist (z y)
        (push (strip-empty-strings (reverse(split-colon-and-reverse z))) colon-list)))
    (reverse colon-list)))

(print (do-colon (read-file "default.cwp")))

(quit)
