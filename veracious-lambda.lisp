(defpackage :veracious-lambda
  (:use :cl)
  (:export
   :enable
   :disable
   :vl-readtable))

(in-package :veracious-lambda)

(defun whitespacep (char)
  (some (lambda (whitespace) (char= char whitespace))
        '(#\Newline #\Space #\Tab #\Page #\Return)))

(defun lambda-reader (stream char)
  (declare (ignore char))
  (let ((next (peek-char nil stream nil nil t)))
    (if (or (null next)
            (whitespacep next)
            (and (get-macro-character next)
                 (not (char= next #\λ))))
      'lambda
      (with-standard-io-syntax
        (read-from-string (format nil "λ~S" (read stream t nil t)))))))

(named-readtables:defreadtable vl-readtable
  (:merge :standard)
  (:case :upcase)
  (:macro-char #\λ #'lambda-reader t))

(defun enable ()
  (named-readtables:in-readtable vl-readtable))

(defun disable ()
  (named-readtables:in-readtable :standard))
