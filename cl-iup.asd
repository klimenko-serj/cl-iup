;;;; cl-iup.asd

(asdf:defsystem #:cl-iup
  :serial t
  :description "Common Lisp bindings for IUP."
  :author "Klimenko Serj"
  :license "MIT"
  :version "0.1"
  :depends-on (#:cffi #:iterate)
  :components ((:file "package")
	       (:file "cl-iup-cffi")
               (:file "cl-iup")))

