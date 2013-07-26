;;;; cl-iup.asd

(asdf:defsystem #:cl-iup
  :serial t
  :description "Common Lisp bindings for IUP."
  :author "Klimenko Serj"
  :license "MIT"
  :depends-on (#:cffi)
  :components ((:file "package")
               (:file "cl-iup")))

