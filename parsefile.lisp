(print (read-file "default.cwp"))
(print (split-sequence:SPLIT-SEQUENCE #\; (remove #\Space "one-more; and-another; and-another-rule; yet-another-rule; another-rule; rule;")))
(quit)
