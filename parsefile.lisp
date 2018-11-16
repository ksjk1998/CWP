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
  (if (< 1 (length (split-colon-and-reverse string)))
      (car (split-colon-and-reverse string))
      nil))

(defun before-last-colon (string)
  "returns the text before the last colon in a string"
  (subseq string 0 (search (concatenate 'string ":" (after-last-colon string)) string)))

(defun split-last-colon (string)
  "returns a plist cointaining the portions of the string before and after the last colon"
  (list :before-colon (before-last-colon string)
	:after-colon (after-last-colon string)))

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
        (push (split-last-colon z) colon-list)))
    (reverse colon-list)))

(print (do-colon (read-file "default.cwp")))

(quit)
