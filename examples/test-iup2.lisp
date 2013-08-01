(ql:quickload "cl-iup")

(defpackage #:test-iup-2
  (:use :cl :cl-iup :iterate)
  (:export :main-test))

(in-package #:test-iup-2)
       
(iup-defgui mk-gui (rs)
  *win* = "dialog" :title "\"Test 2\" Dialog" :rastersize rs <<
  ("vbox" :alignment "ACENTER" 
   <<
   ("label" :title "Test 2 LaBeL!" :expand "YES" 
	    :font "Courier , Italic 40" :alignment "ACENTER")
   (*list* = "list" 
	   1 "Gold" 2 "Silver" 3 "Bronze" 4 "Tecgraf" 5 "None" 
	   :XXX_SPACING 4 :VALUE 4 :EXPAND :YES)
   (*btn-list-item* = "button" :expand :vertical :flat :yes :title "Show selected item") 
   ("hbox" :expandchildren "YES" <<
	   (*bt-msg1* = "button" :title "Test 2 msg1" 
		      :flat "YES" :expand "HORIZONTAL" :canfocus "NO") 
	   (*bt-msg2* = "button" :title "Test 2 msg2" :flat "YES" :canfocus "NO"))
   (*but* = "button" :title "Test 2 CLOSE" :expand "YES" :font "Times, Bold 15")))

(iup-defevent (*but*) IUP_CLOSE)
(iup-defevent-default (*bt-msg1*)
  (iupMessage "msg1" (iupVersionDate)))
(iup-defevent-default (*bt-msg2*)
  (iupMessage "msg2" (iupVersion)))
(iup-defevent-default (*btn-list-item*)
  (IupMessage "Item:" (iup-attribute *list* (iup-attribute *list*))))

(defun main-test ()
  (with-iup
    (mk-gui "600x300")
    (iup-set-all-events)
    (iupShow *win*)
    (iupMainLoop)
    (iupDestroy *win*)))
    
(main-test)
(sb-ext:quit)
;;(sb-ext:save-lisp-and-die "tst2.core" :toplevel #'test-iup-2:main-test)
