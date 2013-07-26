;;;; cl-iup.lisp

(in-package #:cl-iup)

;;; "cl-iup" goes here. Hacks and glory await!
;;--------------------------------------------------------------------------------------
;;======================================================================================
;; Main API
;;======================================================================================
;;--------------------------------------------------------------------------------------
(defcfun ("IupOpen" IupOpen) :int
  (argc :pointer)
  (argv :pointer))

(defcfun ("IupClose" IupClose) :void)

(defcfun ("IupImageLibOpen" IupImageLibOpen) :void)
;;--------------------------------------------------------------------------------------
(defcfun ("IupMainLoop" IupMainLoop) :int)

(defcfun ("IupLoopStep" IupLoopStep) :int)

(defcfun ("IupLoopStepWait" IupLoopStepWait) :int)

(defcfun ("IupMainLoopLevel" IupMainLoopLevel) :int)

(defcfun ("IupFlush" IupFlush) :void)

(defcfun ("IupExitLoop" IupExitLoop) :void)
;;--------------------------------------------------------------------------------------
(defcfun ("IupRecordInput" IupRecordInput) :int
  (filename :string)
  (mode :int))

(defcfun ("IupPlayInput" IupPlayInput) :int
  (filename :string))
;;--------------------------------------------------------------------------------------
(defcfun ("IupUpdate" IupUpdate) :void
  (ih :pointer))

(defcfun ("IupUpdateChildren" IupUpdateChildren) :void
  (ih :pointer))

(defcfun ("IupRedraw" IupRedraw) :void
  (ih :pointer)
  (children :int))

(defcfun ("IupRefresh" IupRefresh) :void
  (ih :pointer))

(defcfun ("IupRefreshChildren" IupRefreshChildren) :void
  (ih :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupMapFont" IupMapFont) :string
  (iupfont :string))

(defcfun ("IupUnMapFont" IupUnMapFont) :string
  (driverfont :string))

(defcfun ("IupHelp" IupHelp) :int
  (url :string))

(defcfun ("IupLoad" IupLoad) :string
  (filename :string))

(defcfun ("IupLoadBuffer" IupLoadBuffer) :string
  (buffer :string))
;;--------------------------------------------------------------------------------------
(defcfun ("IupVersion" IupVersion) :string)

(defcfun ("IupVersionDate" IupVersionDate) :string)

(defcfun ("IupVersionNumber" IupVersionNumber) :int)

(defcfun ("IupSetLanguage" IupSetLanguage) :void
  (lng :string))

(defcfun ("IupGetLanguage" IupGetLanguage) :string)
;;--------------------------------------------------------------------------------------
(defcfun ("IupDestroy" IupDestroy) :void
  (ih :pointer))

(defcfun ("IupDetach" IupDetach) :void
  (child :pointer))

(defcfun ("IupAppend" IupAppend) :pointer
  (ih :pointer)
  (child :pointer))

(defcfun ("IupInsert" IupInsert) :pointer
  (ih :pointer)
  (ref_child :pointer)
  (child :pointer))

(defcfun ("IupGetChild" IupGetChild) :pointer
  (ih :pointer)
  (pos :int))

(defcfun ("IupGetChildPos" IupGetChildPos) :int
  (ih :pointer)
  (child :pointer))

(defcfun ("IupGetChildCount" IupGetChildCount) :int
  (ih :pointer))

(defcfun ("IupGetNextChild" IupGetNextChild) :pointer
  (ih :pointer)
  (child :pointer))

(defcfun ("IupGetBrother" IupGetBrother) :pointer
  (ih :pointer))

(defcfun ("IupGetParent" IupGetParent) :pointer
  (ih :pointer))

(defcfun ("IupGetDialog" IupGetDialog) :pointer
  (ih :pointer))

(defcfun ("IupGetDialogChild" IupGetDialogChild) :pointer
  (ih :pointer)
  (name :string))

(defcfun ("IupReparent" IupReparent) :int
  (ih :pointer)
  (new_parent :pointer)
  (ref_child :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupPopup" IupPopup) :int
  (ih :pointer)
  (x :int)
  (y :int))

(defcfun ("IupShow" IupShow) :int
  (ih :pointer))

(defcfun ("IupShowXY" IupShowXY) :int
  (ih :pointer)
  (x :int)
  (y :int))

(defcfun ("IupHide" IupHide) :int
  (ih :pointer))

(defcfun ("IupMap" IupMap) :int
  (ih :pointer))

(defcfun ("IupUnmap" IupUnmap) :void
  (ih :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupSetAttribute" IupSetAttribute) :void
  (ih :pointer)
  (name :string)
  (value :string))

(defcfun ("IupStoreAttribute" IupStoreAttribute) :void
  (ih :pointer)
  (name :string)
  (value :string))

(defcfun ("IupSetAttributes" IupSetAttributes) :pointer
  (ih :pointer)
  (str :string))

(defcfun ("IupGetAttribute" IupGetAttribute) :string
  (ih :pointer)
  (name :string))

(defcfun ("IupGetAttributes" IupGetAttributes) :string
  (ih :pointer))

(defcfun ("IupGetInt" IupGetInt) :int
  (ih :pointer)
  (name :string))

(defcfun ("IupGetInt2" IupGetInt2) :int
  (ih :pointer)
  (name :string))

(defcfun ("IupGetIntInt" IupGetIntInt) :int
  (ih :pointer)
  (name :string)
  (i1 :pointer)
  (i2 :pointer))

(defcfun ("IupGetFloat" IupGetFloat) :float
  (ih :pointer)
  (name :string))

(defcfun ("IupSetfAttribute" IupSetfAttribute) :void
  (ih :pointer)
  (name :string)
  (format :string)
  &rest)

(defcfun ("IupResetAttribute" IupResetAttribute) :void
  (ih :pointer)
  (name :string))

(defcfun ("IupGetAllAttributes" IupGetAllAttributes) :int
  (ih :pointer)
  (names :pointer)
  (n :int))

(defcfun ("IupSetAtt" IupSetAtt) :pointer
  (handle_name :string)
  (ih :pointer)
  (name :string)
  &rest)
;;--------------------------------------------------------------------------------------
(defcfun ("IupSetAttributeId" IupSetAttributeId) :void
  (ih :pointer)
  (name :string)
  (id :int)
  (value :string))

(defcfun ("IupStoreAttributeId" IupStoreAttributeId) :void
  (ih :pointer)
  (name :string)
  (id :int)
  (value :string))

(defcfun ("IupGetAttributeId" IupGetAttributeId) :string
  (ih :pointer)
  (name :string)
  (id :int))

(defcfun ("IupGetFloatId" IupGetFloatId) :float
  (ih :pointer)
  (name :string)
  (id :int))

(defcfun ("IupGetIntId" IupGetIntId) :int
  (ih :pointer)
  (name :string)
  (id :int))

(defcfun ("IupSetfAttributeId" IupSetfAttributeId) :void
  (ih :pointer)
  (name :string)
  (id :int)
  (format :string)
  &rest)
;;--------------------------------------------------------------------------------------
(defcfun ("IupSetAttributeId2" IupSetAttributeId2) :void
  (ih :pointer)
  (name :string)
  (lin :int)
  (col :int)
  (value :string))

(defcfun ("IupStoreAttributeId2" IupStoreAttributeId2) :void
  (ih :pointer)
  (name :string)
  (lin :int)
  (col :int)
  (value :string))

(defcfun ("IupGetAttributeId2" IupGetAttributeId2) :string
  (ih :pointer)
  (name :string)
  (lin :int)
  (col :int))

(defcfun ("IupGetIntId2" IupGetIntId2) :int
  (ih :pointer)
  (name :string)
  (lin :int)
  (col :int))

(defcfun ("IupGetFloatId2" IupGetFloatId2) :float
  (ih :pointer)
  (name :string)
  (lin :int)
  (col :int))

(defcfun ("IupSetfAttributeId2" IupSetfAttributeId2) :void
  (ih :pointer)
  (name :string)
  (lin :int)
  (col :int)
  (format :string)
  &rest)
;;--------------------------------------------------------------------------------------
(defcfun ("IupSetGlobal" IupSetGlobal) :void
  (name :string)
  (value :string))

(defcfun ("IupStoreGlobal" IupStoreGlobal) :void
  (name :string)
  (value :string))

(defcfun ("IupGetGlobal" IupGetGlobal) :string
  (name :string))
;;--------------------------------------------------------------------------------------
(defcfun ("IupSetFocus" IupSetFocus) :pointer
  (ih :pointer))

(defcfun ("IupGetFocus" IupGetFocus) :pointer)

(defcfun ("IupPreviousField" IupPreviousField) :pointer
  (ih :pointer))

(defcfun ("IupNextField" IupNextField) :pointer
  (ih :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupGetCallback" IupGetCallback) :pointer
  (ih :pointer)
  (name :string))

(defcfun ("IupSetCallback" IupSetCallback) :pointer
  (ih :pointer)
  (name :string)
  (func :pointer))

(defcfun ("IupSetCallbacks" IupSetCallbacks) :pointer
  (ih :pointer)
  (name :string)
  (func :pointer)
  &rest)
;;--------------------------------------------------------------------------------------
(defcfun ("IupGetFunction" IupGetFunction) :pointer
  (name :string))

(defcfun ("IupSetFunction" IupSetFunction) :pointer
  (name :string)
  (func :pointer))

(defcfun ("IupGetActionName" IupGetActionName) :string)
;;--------------------------------------------------------------------------------------
(defcfun ("IupGetHandle" IupGetHandle) :pointer
  (name :string))

(defcfun ("IupSetHandle" IupSetHandle) :pointer
  (name :string)
  (ih :pointer))

(defcfun ("IupGetAllNames" IupGetAllNames) :int
  (names :pointer)
  (n :int))

(defcfun ("IupGetAllDialogs" IupGetAllDialogs) :int
  (names :pointer)
  (n :int))

(defcfun ("IupGetName" IupGetName) :string
  (ih :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupSetAttributeHandle" IupSetAttributeHandle) :void
  (ih :pointer)
  (name :string)
  (ih_named :pointer))

(defcfun ("IupGetAttributeHandle" IupGetAttributeHandle) :pointer
  (ih :pointer)
  (name :string))
;;--------------------------------------------------------------------------------------
(defcfun ("IupGetClassName" IupGetClassName) :string
  (ih :pointer))

(defcfun ("IupGetClassType" IupGetClassType) :string
  (ih :pointer))

(defcfun ("IupGetAllClasses" IupGetAllClasses) :int
  (names :pointer)
  (n :int))

(defcfun ("IupGetClassAttributes" IupGetClassAttributes) :int
  (classname :string)
  (names :pointer)
  (n :int))

(defcfun ("IupGetClassCallbacks" IupGetClassCallbacks) :int
  (classname :string)
  (names :pointer)
  (n :int))

(defcfun ("IupSaveClassAttributes" IupSaveClassAttributes) :void
  (ih :pointer))

(defcfun ("IupCopyClassAttributes" IupCopyClassAttributes) :void
  (src_ih :pointer)
  (dst_ih :pointer))

(defcfun ("IupSetClassDefaultAttribute" IupSetClassDefaultAttribute) :void
  (classname :string)
  (name :string)
  (value :string))

(defcfun ("IupClassMatch" IupClassMatch) :int
  (ih :pointer)
  (classname :string))
;;--------------------------------------------------------------------------------------
(defcfun ("IupCreate" IupCreate) :pointer
  (classname :string))

(defcfun ("IupCreatev" IupCreatev) :pointer
  (classname :string)
  (params :pointer))

(defcfun ("IupCreatep" IupCreatep) :pointer
  (classname :string)
  (first :pointer)
  &rest)
;;--------------------------------------------------------------------------------------
;;======================================================================================
;; Elements
;;======================================================================================
;;--------------------------------------------------------------------------------------
(cffi:defcfun ("IupFill" IupFill) :pointer)

(cffi:defcfun ("IupRadio" IupRadio) :pointer
  (child :pointer))

(cffi:defcfun ("IupVbox" IupVbox) :pointer
  (child :pointer)
  &rest)

(cffi:defcfun ("IupVboxv" IupVboxv) :pointer
  (children :pointer))

(cffi:defcfun ("IupZbox" IupZbox) :pointer
  (child :pointer)
  &rest)

(cffi:defcfun ("IupZboxv" IupZboxv) :pointer
  (children :pointer))

(cffi:defcfun ("IupHbox" IupHbox) :pointer
  (child :pointer)
  &rest)

(cffi:defcfun ("IupHboxv" IupHboxv) :pointer
  (children :pointer))
;;--------------------------------------------------------------------------------------
(cffi:defcfun ("IupNormalizer" IupNormalizer) :pointer
  (ih_first :pointer)
  &rest)

(cffi:defcfun ("IupNormalizerv" IupNormalizerv) :pointer
  (ih_list :pointer))
;;--------------------------------------------------------------------------------------
(cffi:defcfun ("IupCbox" IupCbox) :pointer
  (child :pointer)
  &rest)

(cffi:defcfun ("IupCboxv" IupCboxv) :pointer
  (children :pointer))

(cffi:defcfun ("IupSbox" IupSbox) :pointer
  (child :pointer))

(cffi:defcfun ("IupSplit" IupSplit) :pointer
  (child1 :pointer)
  (child2 :pointer))

(cffi:defcfun ("IupScrollBox" IupScrollBox) :pointer
  (child :pointer))

(cffi:defcfun ("IupGridBox" IupGridBox) :pointer
  (child :pointer)
  &rest)

(cffi:defcfun ("IupGridBoxv" IupGridBoxv) :pointer
  (children :pointer))

(cffi:defcfun ("IupExpander" IupExpander) :pointer
  (child :pointer))
;;--------------------------------------------------------------------------------------
(cffi:defcfun ("IupFrame" IupFrame) :pointer
  (child :pointer))
;;--------------------------------------------------------------------------------------
(cffi:defcfun ("IupImage" IupImage) :pointer
  (width :int)
  (height :int)
  (pixmap :pointer))

(cffi:defcfun ("IupImageRGB" IupImageRGB) :pointer
  (width :int)
  (height :int)
  (pixmap :pointer))

(cffi:defcfun ("IupImageRGBA" IupImageRGBA) :pointer
  (width :int)
  (height :int)
  (pixmap :pointer))
;;--------------------------------------------------------------------------------------
(cffi:defcfun ("IupItem" IupItem) :pointer
  (title :string)
  (action :string))

(cffi:defcfun ("IupSubmenu" IupSubmenu) :pointer
  (title :string)
  (child :pointer))

(cffi:defcfun ("IupSeparator" IupSeparator) :pointer)

(cffi:defcfun ("IupMenu" IupMenu) :pointer
  (child :pointer)
  &rest)

(cffi:defcfun ("IupMenuv" IupMenuv) :pointer
  (children :pointer))
;;--------------------------------------------------------------------------------------
(cffi:defcfun ("IupButton" IupButton) :pointer
  (title :string)
  (action :string))

(cffi:defcfun ("IupCanvas" IupCanvas) :pointer
  (action :string))

(cffi:defcfun ("IupDialog" IupDialog) :pointer
  (child :pointer))

(cffi:defcfun ("IupUser" IupUser) :pointer)

(cffi:defcfun ("IupLabel" IupLabel) :pointer
  (title :string))

(cffi:defcfun ("IupList" IupList) :pointer
  (action :string))

(cffi:defcfun ("IupText" IupText) :pointer
  (action :string))

(cffi:defcfun ("IupMultiLine" IupMultiLine) :pointer
  (action :string))

(cffi:defcfun ("IupToggle" IupToggle) :pointer
  (title :string)
  (action :string))

(cffi:defcfun ("IupTimer" IupTimer) :pointer)

(cffi:defcfun ("IupClipboard" IupClipboard) :pointer)

(cffi:defcfun ("IupProgressBar" IupProgressBar) :pointer)

(cffi:defcfun ("IupVal" IupVal) :pointer
  (type :string))

(cffi:defcfun ("IupTabs" IupTabs) :pointer
  (child :pointer)
  &rest)

(cffi:defcfun ("IupTabsv" IupTabsv) :pointer
  (children :pointer))

(cffi:defcfun ("IupTree" IupTree) :pointer)

(cffi:defcfun ("IupLink" IupLink) :pointer
  (url :string)
  (title :string))
;;--------------------------------------------------------------------------------------
(cffi:defcfun ("IupSpin" IupSpin) :pointer)

(cffi:defcfun ("IupSpinbox" IupSpinbox) :pointer
  (child :pointer))
;;--------------------------------------------------------------------------------------
(cffi:defcfun ("IupSaveImageAsText" IupSaveImageAsText) :int
  (ih :pointer)
  (file_name :string)
  (format :string)
  (name :string))
;;--------------------------------------------------------------------------------------
(cffi:defcfun ("IupTextConvertLinColToPos" IupTextConvertLinColToPos) :void
  (ih :pointer)
  (lin :int)
  (col :int)
  (pos :pointer))

(cffi:defcfun ("IupTextConvertPosToLinCol" IupTextConvertPosToLinCol) :void
  (ih :pointer)
  (pos :int)
  (lin :pointer)
  (col :pointer))
;;--------------------------------------------------------------------------------------
(cffi:defcfun ("IupConvertXYToPos" IupConvertXYToPos) :int
  (ih :pointer)
  (x :int)
  (y :int))
;;--------------------------------------------------------------------------------------
(cffi:defcfun ("IupTreeSetUserId" IupTreeSetUserId) :int
  (ih :pointer)
  (id :int)
  (userid :pointer))

(cffi:defcfun ("IupTreeGetUserId" IupTreeGetUserId) :pointer
  (ih :pointer)
  (id :int))

(cffi:defcfun ("IupTreeGetId" IupTreeGetId) :int
  (ih :pointer)
  (userid :pointer))
;;--------------------------------------------------------------------------------------
(cffi:defcfun ("IupTreeSetAttribute" IupTreeSetAttribute) :void
  (ih :pointer)
  (name :string)
  (id :int)
  (value :string))

(cffi:defcfun ("IupTreeStoreAttribute" IupTreeStoreAttribute) :void
  (ih :pointer)
  (name :string)
  (id :int)
  (value :string))

(cffi:defcfun ("IupTreeGetAttribute" IupTreeGetAttribute) :string
  (ih :pointer)
  (name :string)
  (id :int))

(cffi:defcfun ("IupTreeGetInt" IupTreeGetInt) :int
  (ih :pointer)
  (name :string)
  (id :int))

(cffi:defcfun ("IupTreeGetFloat" IupTreeGetFloat) :float
  (ih :pointer)
  (name :string)
  (id :int))

(cffi:defcfun ("IupTreeSetfAttribute" IupTreeSetfAttribute) :void
  (ih :pointer)
  (name :string)
  (id :int)
  (format :string)
  &rest)

(cffi:defcfun ("IupTreeSetAttributeHandle" IupTreeSetAttributeHandle) :void
  (ih :pointer)
  (a :string)
  (id :int)
  (ih_named :pointer))
;;--------------------------------------------------------------------------------------
;;======================================================================================
;; 
;;======================================================================================
;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------

