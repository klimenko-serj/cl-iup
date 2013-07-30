(ql:quickload "cl-iup")

(defpackage #:test-iup
  (:use :cl :cl-iup)
  (:export :main-test))

(in-package #:test-iup)

;;(cffi:defcallback quit-cb :int ()
;;  cl-iup:IUP_CLOSE)

(iup-defcallback msg-cb ()
  (progn
    (cl-iup:iupmessage "TestMSG" 
		       (format nil "Hello, IUP!~%Version: ~A~%~t(~A)" 
			       (IupVersion)
			       (IupVersionDate)))
    cl-iup:IUP_DEFAULT))

(defparameter *dialog* nil)
(defparameter *quit-btn* nil)
(defparameter *vbox* nil)
(defparameter *msg-btn* nil)
(defparameter *list* nil)
(defparameter *but3* nil)

(defun main-test ()
  (with-iup
    (setf *quit-btn*  (iupbutton "Close" ""))
    (IupSetCallback *quit-btn* "ACTION" 
		    (iup-lambda-callback () IUP_CLOSE))
    
    (setf *msg-btn*  (iupbutton "IUP Version" ""))
    (IupSetCallback *msg-btn* "ACTION" msg-cb)

    (setf *list* (IupList "list_act"))
    (IupSetAttributes 
     *list* 
     "1=Gold, 2=Silver, 3=Bronze, 4=Tecgraf, 5=None, XXX_SPACING=4, VALUE=4, EXPAND=YES")

    (setf *but3*  (iup-set-attributes 
		   (iupButton "Show selected item" "")
		   :expand "VERTICAL"
		   :flat "YES"))
    (IupSetCallback 
     *but3* "ACTION" 
     (iup-lambda-callback 
      () (progn
	   (IupMessage "Item:" 
		       (IupGetAttribute
			*list*
			(IupGetAttribute
			 *list* "VALUE")))
	   IUP_DEFAULT)))
    

    (setf *vbox*
	  (iup-vbox
	   (iup-set-attributes (IupLabel "Test IUP")
			       :EXPAND "HORIZONTAL"
			       :ALIGNMENT :ACENTER)
	   *list*
	   (iup-hbox *but3*)
	   (iup-hbox *msg-btn* *quit-btn*)))
    
    (iup-set-attributes *vbox* :ALIGNMENT "ACENTER" :MARGIN="1x1" :GAP 5)
    
    (setf *dialog* (IupDialog *vbox*))
    (IupSetAttributeHandle *dialog* "DEFAULTESC" *quit-btn*)
    (setf (iup-attribute *dialog* "TITLE") "Test IupDialog!!!")
    (IupSetAttributes *dialog* "RESIZE=YES")
    
    (IupShow *dialog*)
    (msg-cb)
    (IupMainloop)
    (IupDestroy *dialog*)))

(main-test)
(sb-ext:quit)
;;(sb-ext:save-lisp-and-die "test-iup" :toplevel #'main-test :executable t)
