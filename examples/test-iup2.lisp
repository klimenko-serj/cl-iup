(ql:quickload "cl-iup")

;;=======================================================================
(defpackage #:test-iup-2-t
  (:use :cl :cl-iup :iterate)
  (:export :tmpl-1))
(in-package #:test-iup-2-t)

(iup-defgui tmpl-1 ()
  "vbox" :expandchildren "YES" <<
  (*btn+* = "button" :title "+" :expand :no :rastersize "25x25")
  (*btn-* = "button" :title "-" :expand :no :rastersize "25x25"))
;;=======================================================================
(defpackage #:test-iup-2
  (:use :cl :cl-iup :iterate)
  (:export :main-test))
(in-package #:test-iup-2)
;;-----------------------------------------------------------------------       
(iup-defgui lbl (txt)
  *lbl* = "label" :title (format nil "TAB2 Label:~% ~A" txt) 
  :font "Helvetica, Underline 50" :expand :yes :alignment "ACENTER")
;;-----------------------------------------------------------------------
(iup-defgui btns-hbox (txt1 txt2)
  "hbox" :expandchildren "YES" <<
  (*bt-msg1* = "button" :title txt1 
	     :flat "YES" :expand "HORIZONTAL" :canfocus "NO") 
  (*bt-msg2* = "button" :title txt2 :flat "YES" :canfocus "NO"))
;;-----------------------------------------------------------------------
(iup-defgui main-win (lb)
  *win* = "dialog" :title "\"Test 2\" Dialog" :rastersize "500x350" <<
  ("tabs" :tabtitle0 "Tab0" :tabtitle1 "Tab1" <<
	  ("hbox" <<
		  (tab1 -* test-iup-2-t:tmpl-1)
		  ("vbox" :alignment "ACENTER" <<
			  ("label" :title "Test 2 LaBeL!" :expand "YES" 
				   :font "Courier , Italic 40" :alignment "ACENTER")
			  (m-list = "list" 
				  1 "Gold" 2 "Silver" 3 "Bronze" 4 "Tecgraf" 5 "None" 
				  :XXX_SPACING 4 :VALUE 4 :EXPAND :YES)
		  (btn-list-item = "button" 
				 :expand :vertical :flat :yes :title "Show selected item") 
		  (funcall btns-hbox "DateMSG" "VERSION MSG" << ("label" :title "child lbTest"))
		  (but = "button" :title "Test 2 CLOSE" :expand "YES" :font "Times, Bold 15")))
	  ("hbox" <<  lb (tab2 -* test-iup-2-t:tmpl-1))))
;;-----------------------------------------------------------------------
(iup-defevent (but) IUP_CLOSE)
(iup-defevent-default (*bt-msg1*)
  (iupMessage "msg1" (iupVersionDate)))
(iup-defevent-default (*bt-msg2*)
  (iupMessage "msg2" (iupVersion)))
(iup-defevent-default (btn-list-item)
  (IupMessage "Item:" (iup-attribute m-list (iup-attribute m-list))))
;;-----------------------------------------------------------------------
(iup-defevent-default (*tab1-btn+*)
  (iupMessage "Template test:" "Tab1, +"))
(iup-defevent-default (*tab1-btn-*)
  (iupMessage "Template test:" "Tab1, -"))
(iup-defevent-default (*tab2-btn+*)
  (iupMessage "Template test:" "Tab2, +"))
(iup-defevent-default (*tab2-btn-*)
  (iupMessage "Template test:" "Tab2, -"))
;;-----------------------------------------------------------------------
(defun main-test ()
  (with-iup
    (main-win (lbl "+test \"TEXT\""))
    (iup-set-all-events)
    (iupShow *win*)
    (iupMainLoop)
    (iupDestroy *win*)))
;;-----------------------------------------------------------------------    
(main-test)
;;-----------------------------------------------------------------------
(print "")
(sb-ext:quit)
;;(sb-ext:save-lisp-and-die "tst2.core" :toplevel #'test-iup-2:main-test)
