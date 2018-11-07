(defun merge-plist (p1 p2)
  (loop with notfound = '#:notfound
        for (indicator value) on p1 by #'cddr
        when (eq (getf p2 indicator notfound) notfound) 
        do (progn
             (push value p2)
             (push indicator p2)))
  p2)
(defclass CWP-object ()
  ((type :accessor CWP-type
	 :initarg :type)
   (rules :accessor rules
	       :initarg :rules)
   (name :accessor name
	 :initarg :name)))
(defclass element (CWP-object)
  ((content :accessor content
	    :initarg :content))
  (:default-initargs
   :type :element
    :content nil))
(defgeneric get-rules (object)
  (:documentation "gets the rules for a given CWP object"))
(defmethod get-rules ((object CWP-object))
  (rules object))
(defgeneric merge-rules (object new-rules)
  (:documentation "returns a combination of the given CWP object's rules and the new ones"))
(defmethod merge-rules ((object CWP-object) new-rules)
  (merge-plist (rules object) new-rules))
(defgeneric add-rules (object new-rules)
  (:documentation "adds new rules to a CWP object"))
(defmethod add-rules ((object CWP-object) new-rules)
  (setf (rules object) (merge-plist (rules object) new-rules)))
(defun print-rules (object)
  (format t "~{~a~t~a~%~}" (get-rules object)))
(defclass text-element (element)
  ((text :accessor text
	 :initarg :text))
  (:default-initargs
   :type :text-element
    :rules '(:font (:comic-sans)
	     :font-size (12 :px)
	     :font-bold nil
	     :font-italic nil
	     :font-underlined nil
	     :font-strikethrough nil)
    :text nil))
(defclass header-1 (text-element)
  ()
  (:default-initargs
   :rules (merge-plist (slot-value (make-instance 'text-element) 'rules)
			'(:font (:liberation-serif
				 :times-new-roman
				 :times-serif
				 :serif
				 :times)
			  :font-size (5 :em)
			  :font-bold t))))
(defclass header-2 (header-1)
  ()
  (:default-initargs
   :rules (merge-rules (make-instance 'header-1) '(:font-size (4 :em)))))

