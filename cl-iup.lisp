;;;; cl-iup.lisp

(in-package #:cl-iup)

;;; "cl-iup" goes here. Hacks and glory await!

(defun iup-open ()
  #+sbcl (sb-ext::set-floating-point-modes :traps nil)
  (IupOpen 
   (cffi:foreign-alloc :int :initial-element 0)
   (cffi:foreign-alloc 
    :pointer
    :initial-element
    (cffi:foreign-alloc :string
			:initial-element
			"Program"))))
;;--------------------------------------------------------------------------------------
(defmacro with-iup (&body body)
  `(unwind-protect
	(progn
	  (iup-open)
	  ,@body)
     (IupClose)))
;;--------------------------------------------------------------------------------------
(defmacro iup-defcallback (name args body)
  (let ((cb-name (gensym)))
    `(progn
       (defmacro ,name () (cffi:callback ,cb-name))
       (cffi:defcallback ,cb-name :int ,args ,body))))
;;--------------------------------------------------------------------------------------
(defmacro iup-lambda-callback (args body)
  (let ((cb-name (gensym "iup-cb")))
    `(cffi:get-callback (cffi:defcallback ,cb-name :int ,args ,body))))
;;--------------------------------------------------------------------------------------
(defmacro iup-vbox (child &rest childs)
  `(IupVbox ,child ,@(mapcan #'(lambda (x) (list :pointer x)) childs)
	    :int 0))
;;--------------------------------------------------------------------------------------
(defmacro iup-hbox (child &rest childs)
  `(IupHbox ,child ,@(mapcan #'(lambda (x) (list :pointer x)) childs)
	    :int 0))
;;--------------------------------------------------------------------------------------
