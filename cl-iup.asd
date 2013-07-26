;;;; cl-iup.asd

(asdf:defsystem #:cl-iup
  :serial t
  :description "Describe cl-iup here"
  :author "Klimenko Serj"
  :license "MIT"
  :depends-on (#:cffi)
  :components ((:file "package")
               (:file "cl-iup")))

