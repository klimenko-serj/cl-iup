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
(defun get-fn-args (cb-args)
  (mapcar #'first cb-args))
   
(defmacro iup-defcallback (name args &body body)
  (let ((cb-name (gensym "iup-cb"))
	(fn-args (get-fn-args args)))
    `(progn
       (defun ,name ,fn-args ,@body)
       (cffi:defcallback ,cb-name :int ,args ,@body)
       (setf (get ',name 'cb) (lambda () (cffi:callback ,cb-name))))))
;;--------------------------------------------------------------------------------------
(defmacro iup-defcallback-default (name args &body body)
  `(iup-defcallback ,name ,args 
     (progn
       ,@body
       IUP_DEFAULT)))     
;;--------------------------------------------------------------------------------------
(defmacro iup-callback (name)
  `(funcall (get ',name 'cb)))
;;--------------------------------------------------------------------------------------
(defmacro iup-set-callback (ih name callbck)
  `(iupSetCallback ,ih ,name (iup-callback ,callbck)))
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
(%def-iup-container-macro iupgridbox iup-grid-box)
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
