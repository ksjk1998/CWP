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
(defun strip-empty-strings (string-list)
  (remove-if #'(lambda (string) (string= string "")) string-list))
(print (strip-empty-strings
 (split-semicolon
	"one-more; \nand-another; and-another-rule; yet-another-rule; another-rule; rule;")))
(quit)
