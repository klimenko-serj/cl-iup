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
  (let ((cb-name (intern (concatenate 'string "%" (string name) (string '#:-callback))))
	(fn-args (get-fn-args args)))
    `(progn
       (defun ,name ,fn-args ,@body)
       (cffi:defcallback ,cb-name :int ,args (,name ,@fn-args))
       (define-symbol-macro ,name (cffi:get-callback ',cb-name)))))
;;--------------------------------------------------------------------------------------
(defmacro iup-defcallback-default (name args &body body)
  `(iup-defcallback ,name ,args 
     (progn
       ,@body
       IUP_DEFAULT)))     
;;--------------------------------------------------------------------------------------
(defmacro iup-lambda-callback (args body)
  (let ((cb-name (gensym "iup-cb")))
    `(cffi:get-callback (cffi:defcallback ,cb-name :int ,args ,body))))
;;--------------------------------------------------------------------------------------
;=======================================================================================
(defparameter *event-connections* nil)
;;--------------------------------------------------------------------------------------
(defun iup-register-event (object-name action cb-name)
  (pushnew (list object-name action cb-name) *event-connections* :test #'equal))
;;--------------------------------------------------------------------------------------
(defmacro iup-defevent ((object &key (action "ACTION") 
				(name (intern (concatenate 
					       'string 
					       (string-trim "*" (string object)) 
					       "-" action)))
				(args nil)) &body body)
  (let ((cb-name (intern (concatenate 'string "%" (string name) (string '#:-callback))))
	(fn-args (get-fn-args args)))
    `(progn
       (iup-register-event ',object ,action ',cb-name)
       (defun ,name ,fn-args ,@body)
       (cffi:defcallback ,cb-name :int ,args (,name ,@fn-args))
       (define-symbol-macro ,name (cffi:get-callback ',cb-name)))))

(defmacro iup-defevent-default ((object &key 
					(action "ACTION") 
					(name (intern (concatenate 
						       'string 
						       (string-trim "*" (string object)) 
						       "-" action)))
					(args nil)) &body body)
  `(iup-defevent (,object :action ,action :name ,name :args ,args)
		 (progn
		   ,@body
		   IUP_DEFAULT)))
;;--------------------------------------------------------------------------------------
(defun iup-set-all-events ()
  (mapcar #'(lambda (x)
	      (iupSetCallback (symbol-value (first x))
	       		      (second x)
	       		      (cffi:get-callback (print (third x)))))
	  *event-connections*))
;=======================================================================================
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
(defun iup-attribute (ih &optional (attr-name "VALUE"))
  (iupGetAttribute ih attr-name))

(defun (setf iup-attribute) (val ih &optional (attr-name "VALUE"))
  (iupStoreAttribute ih (format nil "~A" attr-name) (format nil "~A" val)))
;;--------------------------------------------------------------------------------------
(defun iup-set-attributes (ih &rest attributes)
  (iter (for (a v) on attributes by #'cddr)
	(setf (iup-attribute ih a) v)
	(finally (return ih))))
  ;; (iupsetattributes 
  ;;  ih 
  ;;  (format nil
  ;; 	   "~{~A=\"~A\"~^, ~}"
  ;; 	   attributes)))
;;--------------------------------------------------------------------------------------
;=======================================================================================
;; IUP-DEFGUI
;=======================================================================================
;;--------------------------------------------------------------------------------------

(defun %get-name/class/attr (lst)
  (if (eq '= (second lst))
      (values (first lst)
	      (third lst)
	      (cdddr lst))
      (values nil
	      (first lst)
	      (rest lst))))
;;--------------------------------------------------------------------------------------
(defun %childs (args &optional (curr nil))
  (cond ((null args) (values nil curr))
	((and (symbolp (first args))
	      (string= (string (first args)) "<<")) 
;;	((eq '<< (first args))
	 (values (rest args) curr))
	(T (%childs (rest args) (append curr (list (first args)))))))
;;--------------------------------------------------------------------------------------
(defun %iup-defgui-defparams (args)
  (append 
   (when (eq '= (second args)) (list (first args)))
   (mapcan #'%iup-defgui-defparams
	   (%childs args))))
;;--------------------------------------------------------------------------------------
(defun %iup-defgui-defun-lets/sets (args &optional parent)
  (multiple-value-bind (chlds curr) (%childs args)
    (multiple-value-bind (name clss attr) (%get-name/class/attr curr)
      (let ((lets nil) (sets nil))
	(when (null name)
	  (setf name (gensym "%iup-gui-component-"))
	  (push name lets))
	(setf sets
	      (append 
	       sets
	       (list `(setf ,name (iupCreate ,clss)))
	       (when attr (list `(iup-set-attributes ,name ,@attr)))
	       (when parent (list `(iupAppend ,parent ,name)))))
	(iter (for ch in chlds)
	      (multiple-value-bind (l s) (%iup-defgui-defun-lets/sets ch name)
		(when l (setf lets (append lets l)))
		(when s (setf sets (append sets s)))))
	(values lets sets name)))))
;;--------------------------------------------------------------------------------------
(defmacro iup-defgui (fname args &body iup-dsl)
  `(progn 
     ,@(mapcar #'(lambda (x) `(defparameter ,x nil)) (%iup-defgui-defparams iup-dsl))
     (defun ,fname ,args
       ,(multiple-value-bind 
	 (lts sts fin) (%iup-defgui-defun-lets/sets iup-dsl)
	 `(let (,@(mapcar #'(lambda (x) `(,x nil)) lts))
	    ,@sts
	    ,fin)))))
;;--------------------------------------------------------------------------------------
;=======================================================================================
;;--------------------------------------------------------------------------------------
