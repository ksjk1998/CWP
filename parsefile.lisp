(load "split-sequence.lisp")
(load "writefile.lisp")
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
      (setq string-list (cons x string-list)))
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
  (let ((colon-list (list :before-colon (string-trim *whitespace* (before-last-colon string))
			 :after-colon (string-trim *whitespace* (after-last-colon string)))))
    (when (string-equal (getf colon-list :after-colon) "NIL")
      (setf (getf colon-list :after-colon) nil))
    (when (string-equal (getf colon-list :before-colon) "NIL")
      (setf (getf colon-list :before-colon) nil))
    colon-list))

(defun strip-empty-strings (string-list)
  (remove-if #'(lambda (string) (string= string "")) string-list))

(defun do-semicolon (file)
  (let ((rule-list nil))
    (dolist (lines file)
      (push (strip-empty-strings (split-semicolon lines)) rule-list))
    (reverse rule-list)))

(defun do-colon (file)
  (let ((colon-list nil))
    (dolist (rules (do-semicolon file))
      (push (let ((clist nil))
       (dolist (colon-delimiter rules)
         (push (split-last-colon colon-delimiter) clist))
       (reverse clist))
	    colon-list))
    (reverse colon-list)))

(dolist (x (do-semicolon (read-file "default.cwp")))
  (print x))
(dolist (x (do-colon (read-file "default.cwp")))
  (print x))


;(quit)

