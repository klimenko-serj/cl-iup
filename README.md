cl-iup
======

<h3>Common Lisp bindings for IUP</h3>

<i>"IUP is a multi-platform toolkit for building <b>graphical user interfaces</b>. 
It offers a simple API in three basic languages: C, Lua and LED. IUP's purpose is to allow a program source code to be compiled in different systems without any modification."</i>
<a href='http://www.tecgraf.puc-rio.br/iup/'> http://www.tecgraf.puc-rio.br/iup/ </a>

<b>CL-IUP</b> provides Common Lisp bindings(cffi) to IUP.

<h3> Installing IUP </h3>

Download installation archive from <a href='http://www.tecgraf.puc-rio.br/iup/'> Tecgraf site</a>.
Unpack it and run './install' script(in Linux) or copy '.dll' to  'system32' folder(in windows) .


<h3> Example </h3>
<pre>
(defpackage #:test-iup
  (:use :cl :cl-iup))

(in-package #:test-iup)

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

(defun main-test ()
  (with-iup
      (setf *quit-btn* (iupbutton "Close" ""))
      (IupSetCallback *quit-btn* "ACTION"
                      (iup-lambda-callback () IUP_CLOSE))
      
      (setf *msg-btn* (iupbutton "IUP Version" ""))
      (IupSetCallback *msg-btn* "ACTION" (msg-cb))

      (setf *vbox*
            (iup-vbox
            (IupSetAttributes (IupLabel "Test IUP")
                              "EXPAND=HORIZONTAL, ALIGNMENT=ACENTER")
            (iup-hbox *msg-btn* *quit-btn*)))
      (IupSetAttributes *vbox* "ALIGNMENT=ACENTER, MARGIN=1x1, GAP=5")
      
      (setf *dialog* (IupDialog *vbox*))
      (IupSetAttributeHandle *dialog* "DEFAULTESC" *quit-btn*)
      (setf (iup-attribute *dialog* "TITLE") "Test IupDialog!!!")
      (IupSetAttributes *dialog* "RESIZE=YES")
      
      (IupShow *dialog*)
      (IupMainloop)
      (IupDestroy *dialog*)))

(main-test)
</pre>
