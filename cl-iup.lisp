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
  (let ((cb-name (gensym "%iup-cb-")))
    `(cffi:get-callback (cffi:defcallback ,cb-name :int ,args ,body))))
;;--------------------------------------------------------------------------------------
;=======================================================================================
;; IUP-DEFEVENT: in-current-package
;;--------------------------------------------------------------------------------------
(defmacro iup-register-event (object-name action cb-name)
  `(progn 
     (defvar *%iup-event-connections* nil)
     (pushnew (list ,object-name ,action ,cb-name) *%iup-event-connections* :test #'equal)))
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
(defmacro iup-set-all-events ()
  '(mapcar #'(lambda (x)
	      (iupSetCallback (symbol-value (first x))
	       		      (second x)
	       		      (cffi:get-callback (print (third x)))))
	  *%iup-event-connections*))
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
  (when (listp args)
    (append 
     (when (eq '= (second args)) (list (first args)))
     (mapcan #'%iup-defgui-defparams
	     (%childs args)))))
;;--------------------------------------------------------------------------------------
(defun %iup-defgui-defun-lets/sets (iup-dsl args &optional parent)
  (multiple-value-bind (chlds curr) (%childs iup-dsl)
    (multiple-value-bind (name clss attr) (%get-name/class/attr curr)
      (let ((lets nil) (sets nil))
	(when (null name)
	  (setf name (gensym "%iup-gui-component-"))
	  (push name lets))
	(setf sets
	      (append 
	       `((setf ,name
		       ,(cond ((and (symbolp clss) (eq 'funcall clss))
			      (prog1 attr (setf attr nil)))
			     ((and (symbolp clss) 
				   (string= "APPLY-TEMPLATE" (string clss)))
			      (error "There is no Templates :("))
			     (T `(iupCreate ,clss)))))
	       (when parent (list `(iupAppend ,parent ,name)))))
	(iter (for ch in chlds)
	      (cond 
		((symbolp ch) 
		 (if (member ch args) 
		     (setf sets (append sets (list `(iupAppend ,name ,ch))))
		     (error "Undefined symbol: ~A" ch)))
		(T (multiple-value-bind (l s) (%iup-defgui-defun-lets/sets ch args name)
		     (when l (setf lets (append lets l)))
		     (when s (setf sets (append sets s)))))))
	(when attr (setf sets (append sets (list `(iup-set-attributes ,name ,@attr)))))
	(values lets sets name)))))
;;--------------------------------------------------------------------------------------
(defmacro iup-defgui-template (name &body iup-dsl)
  `(setf (get (intern ,(string name)) 'iup-template) ',iup-dsl))

(defun %iup-update-template-variables (prefix template)
  (multiple-value-bind (chlds curr) (%childs template)
    (append 
     (if (eq '= (second curr))
	 (append (list (intern (format nil "*~A-~A*" prefix 
				       (string-trim "*" (string (first curr)))))) 
		 (rest curr))
	 curr)
     (when chlds 
       (cons '<< (mapcar #'(lambda (x) (%iup-update-template-variables prefix x)) chlds))))))

(defun %iup-defgui-process-templates (iup-dsl)
  (if (listp iup-dsl)
      (multiple-value-bind (chlds curr) (%childs iup-dsl)
	(if (null chlds) 
	    (if  (string= (string (second curr)) "-*")
		  (%iup-update-template-variables 
		   (first curr) 
		   (%iup-defgui-process-templates (print (get (third curr) 'iup-template))))
		 curr)
	    (append curr '(<<) (mapcar #'%iup-defgui-process-templates chlds))))
      iup-dsl))
;;--------------------------------------------------------------------------------------
(defmacro iup-defgui (fname args &body iup-dsl)
  (setf iup-dsl (%iup-defgui-process-templates iup-dsl))
  `(progn 
     ,@(mapcar #'(lambda (x) `(defparameter ,x nil)) (%iup-defgui-defparams iup-dsl))
     (defun ,fname ,args
       ,(multiple-value-bind 
	 (lts sts fin) (%iup-defgui-defun-lets/sets iup-dsl args)
	 `(let (,@(mapcar #'(lambda (x) `(,x nil)) lts))
	    ,@sts
	    ,fin)))
     (iup-defgui-template ,fname ,@iup-dsl)))
;;--------------------------------------------------------------------------------------
;=======================================================================================
;; IUP-DEFEVENT :class
;;--------------------------------------------------------------------------------------
;; (defmacro iup-register-event (object-name action fn-name fn-args)
;;   `(pushnew 
;;     (list ',(rest object-name) ,action ',fn-name ',fn-args) 
;;     (get ',(first object-name) 'events)
;;     :test #'equal))
;; ;;--------------------------------------------------------------------------------------
;; (defun %make-event-name-by-object&action (object action)
;;   (intern (format nil "~{~A-~}~A" (reverse object) action)))
   
;; (defmacro iup-defevent ((object &key (action "ACTION") 
;; 				(name (%make-event-name-by-object&action object action))
;; 				(args nil)) &body body)
;;   (let (;(cb-name (intern (concatenate 'string "%" (string name) (string '#:-callback))))
;; 	(fn-args (get-fn-args args)))
;;     `(progn
;;        (iup-register-event ,object ,action ,name ,args)
;;        (defun ,name ,fn-args ,@body))))
;; ;;       (cffi:defcallback ,cb-name :int ,args (,name ,@fn-args))
;; ;;       (define-symbol-macro ,name (cffi:get-callback ',cb-name)))))

;; (defmacro iup-defevent-default ((object &key 
;; 					(action "ACTION") 
;; 					(name (%make-event-name-by-object&action object action))
;; 					(args nil)) &body body)
;;   `(iup-defevent (,object :action ,action :name ,name :args ,args)
;; 		 (progn
;; 		   ,@body
;; 		   IUP_DEFAULT)))
;; ;;--------------------------------------------------------------------------------------
;; (defun %recur-accessor (accessors obj)
;;   (if (null accessors) 
;;       obj
;;       (%recur-accessor (cdr accessors) (funcall (car accessors) obj))))      
      
;; (defparameter *it* nil)

;; (defun iup-set-all-events (obj)
;;   (mapcar #'(lambda (x)
;; 	      (iupSetCallback (%recur-accessor (reverse (first x)) obj)
;; 	       		      (second x)
;; 	       		      (cffi:get-callback 
;; 			       (eval `(cffi:defcallback 
;; 					  ,(gensym "%iup-cb-") :int 
;; 					  ,(fourth x)
;; 					(let ((cl-iup:*it* ,obj))
;; 					  (,(third x) ,@(fourth x))))))))
;; 	  (get (class-name (class-of obj)) 'events)))

;; (defclass %iup-gui-superclass ()
;;   ((%iup-ih :accessor iup-ih :initform nil :initarg :ih)))

;; (defgeneric iup-build-gui (iup-gui))
;; ;;--------------------------------------------------------------------------------------

;; (defun %iup-defgui-defun-lets/sets (c-name iup-dsl &optional parent)
;;   (multiple-value-bind (chlds curr) (%childs iup-dsl)
;;     (multiple-value-bind (name clss attr) (%get-name/class/attr curr)
;;       (let ((lets nil) (sets nil))
;; 	(if (null name)
;; 	    (progn
;; 	      (setf name (gensym "%IUP-GUI-COMPONENT-"))
;; 	      (push name lets))
;; 	    (setf name `(,name ,c-name)))
;; 	(setf sets
;; 	      (append 
;; 	       `((setf ,name
;; 		       ,(cond ((and (symbolp clss) (eq 'funcall clss))
;; 			      (prog1 attr (setf attr nil)))
;; 			     ((and (symbolp clss) 
;; 				   (string= "APPLY-TEMPLATE" (string clss)))
;; 			      (error "There is no Templates :("))
;; 			     (T `(iupCreate ,clss)))))
;; 	       (when parent (list `(iupAppend ,parent ,name)))))
;; 	(iter (for ch in chlds)
;; 	      (multiple-value-bind (l s) (%iup-defgui-defun-lets/sets c-name ch name)
;; 		(when l (setf lets (append lets l)))
;; 		(when s (setf sets (append sets s)))))
;; 	(when attr (setf sets (append sets (list `(iup-set-attributes ,name ,@attr)))))
;; 	(values lets sets name)))))

;;--------------------------------------------------------------------------------------
;; (defmacro iup-defgui (name &body iup-dsl)
;;   (let ((meth-var-name (gensym "%IUP-GUI-VAR-")))
;;     `(progn
;;        (defclass ,name (%iup-gui-superclass)
;; 	 ,(mapcar #'(lambda (x) `(,x :accessor ,x)) (%iup-defgui-defparams iup-dsl)))
;;        (defmethod iup-build-gui ((,meth-var-name ,name))
;; 	 ,(multiple-value-bind 
;; 	   (lts sts fin) (%iup-defgui-defun-lets/sets meth-var-name iup-dsl)
;; 	   `(let (,@(mapcar #'(lambda (x) `(,x nil)) lts))
;; 	      ,@sts
;; 	      (setf (iup-ih ,meth-var-name) ,fin)))))))

;; (defun iup-show (dlg)
;;   (iupShow (iup-ih dlg)))
