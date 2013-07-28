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
(defmacro %def-iup-container-macro (iupname iup-name)
  `(defmacro ,iup-name (child &rest childs)
     (append (list ',iupname child) 
	     (mapcan #'(lambda (x) 
			 (list :pointer x)) childs) '(:int 0))))

(%def-iup-container-macro iupvbox iup-vbox)
(%def-iup-container-macro iuphbox iup-hbox)
(%def-iup-container-macro iuptabs iup-tabs)
;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------
(defun iup-attribute (ih attr-name)
  (iupGetAttribute ih attr-name))

(defun (setf iup-attribute) (val ih attr-name)
  (iupSetAttribute ih attr-name (foreign-string-alloc val)))
;;--------------------------------------------------------------------------------------
(defun iup-set-attributes (ih &rest attributes)
  (iupsetattributes 
   ih 
   (format nil
	   "~{~A=\"~A\"~^, ~}"
	   attributes)))
;;--------------------------------------------------------------------------------------
