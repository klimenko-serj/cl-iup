(ql:quickload "cl-iup")

(defpackage #:test-iup
  (:use :cl :cl-iup))

(in-package #:test-iup)

;;(cffi:defcallback quit-cb :int ()
;;  cl-iup:IUP_CLOSE)
;(iup-defcallback quit-cb ()
;    cl-iup:IUP_CLOSE)

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

(defun main-test ()
  (with-iup
      (setf *quit-btn*  (iupbutton "Close" ""))
      (IupSetCallback *quit-btn* "ACTION" 
		      (iup-lambda-callback () IUP_CLOSE))
      
      (setf *msg-btn*  (iupbutton "Test-Message" ""))
      (IupSetCallback *msg-btn* "ACTION" (msg-cb))
      
      (setf *list* (IupList "list_act"))
      (IupSetAttributes 
       *list* 
       "1=Gold, 2=Silver, 3=Bronze, 4=Tecgraf, 5=None, XXX_SPACING=4, VALUE=4, EXPAND=YES")
      
      (setf *vbox*
	    (IupVbox 
	     (IupSetAttributes (IupLabel "Test IUP")
			       "EXPAND=YES, ALIGNMENT=ACENTER") 
	     :pointer *list*
	     :pointer (IupHbox *msg-btn* :pointer *quit-btn* :int 0) :int 0))
      (IupSetAttributes *vbox* "ALIGNMENT=ACENTER, MARGIN=1x1, GAP=5")
      
      (setf *dialog* (IupDialog *vbox*))
      (IupSetAttributeHandle *dialog* "DEFAULTESC" *quit-btn*)
      (IupSetAttributes *dialog* "TITLE =\"TEst IupDialog \", RESIZE=YES")
      
      (IupShow *dialog*)
      (IupMainloop)
      (IupDestroy *dialog*)))

(main-test)
(sb-ext:quit)
