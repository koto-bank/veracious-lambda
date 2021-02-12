(in-package :cl-user)

(defpackage :veracious-lambda-system
  (:use :cl :asdf))

(in-package :veracious-lambda-system)

(defsystem :veracious-lambda
  :license "BSD-3-Clause"
  :depends-on (:named-readtables)
  :components
  ((:file "veracious-lambda")))
