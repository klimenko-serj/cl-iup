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
(defcfun ("IupFill" IupFill) :pointer)

(defcfun ("IupRadio" IupRadio) :pointer
  (child :pointer))

(defcfun ("IupVbox" IupVbox) :pointer
  (child :pointer)
  &rest)

(defcfun ("IupVboxv" IupVboxv) :pointer
  (children :pointer))

(defcfun ("IupZbox" IupZbox) :pointer
  (child :pointer)
  &rest)

(defcfun ("IupZboxv" IupZboxv) :pointer
  (children :pointer))

(defcfun ("IupHbox" IupHbox) :pointer
  (child :pointer)
  &rest)

(defcfun ("IupHboxv" IupHboxv) :pointer
  (children :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupNormalizer" IupNormalizer) :pointer
  (ih_first :pointer)
  &rest)

(defcfun ("IupNormalizerv" IupNormalizerv) :pointer
  (ih_list :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupCbox" IupCbox) :pointer
  (child :pointer)
  &rest)

(defcfun ("IupCboxv" IupCboxv) :pointer
  (children :pointer))

(defcfun ("IupSbox" IupSbox) :pointer
  (child :pointer))

(defcfun ("IupSplit" IupSplit) :pointer
  (child1 :pointer)
  (child2 :pointer))

(defcfun ("IupScrollBox" IupScrollBox) :pointer
  (child :pointer))

(defcfun ("IupGridBox" IupGridBox) :pointer
  (child :pointer)
  &rest)

(defcfun ("IupGridBoxv" IupGridBoxv) :pointer
  (children :pointer))

(defcfun ("IupExpander" IupExpander) :pointer
  (child :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupFrame" IupFrame) :pointer
  (child :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupImage" IupImage) :pointer
  (width :int)
  (height :int)
  (pixmap :pointer))

(defcfun ("IupImageRGB" IupImageRGB) :pointer
  (width :int)
  (height :int)
  (pixmap :pointer))

(defcfun ("IupImageRGBA" IupImageRGBA) :pointer
  (width :int)
  (height :int)
  (pixmap :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupItem" IupItem) :pointer
  (title :string)
  (action :string))

(defcfun ("IupSubmenu" IupSubmenu) :pointer
  (title :string)
  (child :pointer))

(defcfun ("IupSeparator" IupSeparator) :pointer)

(defcfun ("IupMenu" IupMenu) :pointer
  (child :pointer)
  &rest)

(defcfun ("IupMenuv" IupMenuv) :pointer
  (children :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupButton" IupButton) :pointer
  (title :string)
  (action :string))

(defcfun ("IupCanvas" IupCanvas) :pointer
  (action :string))

(defcfun ("IupDialog" IupDialog) :pointer
  (child :pointer))

(defcfun ("IupUser" IupUser) :pointer)

(defcfun ("IupLabel" IupLabel) :pointer
  (title :string))

(defcfun ("IupList" IupList) :pointer
  (action :string))

(defcfun ("IupText" IupText) :pointer
  (action :string))

(defcfun ("IupMultiLine" IupMultiLine) :pointer
  (action :string))

(defcfun ("IupToggle" IupToggle) :pointer
  (title :string)
  (action :string))

(defcfun ("IupTimer" IupTimer) :pointer)

(defcfun ("IupClipboard" IupClipboard) :pointer)

(defcfun ("IupProgressBar" IupProgressBar) :pointer)

(defcfun ("IupVal" IupVal) :pointer
  (type :string))

(defcfun ("IupTabs" IupTabs) :pointer
  (child :pointer)
  &rest)

(defcfun ("IupTabsv" IupTabsv) :pointer
  (children :pointer))

(defcfun ("IupTree" IupTree) :pointer)

(defcfun ("IupLink" IupLink) :pointer
  (url :string)
  (title :string))
;;--------------------------------------------------------------------------------------
(defcfun ("IupSpin" IupSpin) :pointer)

(defcfun ("IupSpinbox" IupSpinbox) :pointer
  (child :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupSaveImageAsText" IupSaveImageAsText) :int
  (ih :pointer)
  (file_name :string)
  (format :string)
  (name :string))
;;--------------------------------------------------------------------------------------
(defcfun ("IupTextConvertLinColToPos" IupTextConvertLinColToPos) :void
  (ih :pointer)
  (lin :int)
  (col :int)
  (pos :pointer))

(defcfun ("IupTextConvertPosToLinCol" IupTextConvertPosToLinCol) :void
  (ih :pointer)
  (pos :int)
  (lin :pointer)
  (col :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupConvertXYToPos" IupConvertXYToPos) :int
  (ih :pointer)
  (x :int)
  (y :int))
;;--------------------------------------------------------------------------------------
(defcfun ("IupTreeSetUserId" IupTreeSetUserId) :int
  (ih :pointer)
  (id :int)
  (userid :pointer))

(defcfun ("IupTreeGetUserId" IupTreeGetUserId) :pointer
  (ih :pointer)
  (id :int))

(defcfun ("IupTreeGetId" IupTreeGetId) :int
  (ih :pointer)
  (userid :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupTreeSetAttribute" IupTreeSetAttribute) :void
  (ih :pointer)
  (name :string)
  (id :int)
  (value :string))

(defcfun ("IupTreeStoreAttribute" IupTreeStoreAttribute) :void
  (ih :pointer)
  (name :string)
  (id :int)
  (value :string))

(defcfun ("IupTreeGetAttribute" IupTreeGetAttribute) :string
  (ih :pointer)
  (name :string)
  (id :int))

(defcfun ("IupTreeGetInt" IupTreeGetInt) :int
  (ih :pointer)
  (name :string)
  (id :int))

(defcfun ("IupTreeGetFloat" IupTreeGetFloat) :float
  (ih :pointer)
  (name :string)
  (id :int))

(defcfun ("IupTreeSetfAttribute" IupTreeSetfAttribute) :void
  (ih :pointer)
  (name :string)
  (id :int)
  (format :string)
  &rest)

(defcfun ("IupTreeSetAttributeHandle" IupTreeSetAttributeHandle) :void
  (ih :pointer)
  (a :string)
  (id :int)
  (ih_named :pointer))
;;--------------------------------------------------------------------------------------
;;======================================================================================
;; Pre-defined dialogs
;;======================================================================================
;;--------------------------------------------------------------------------------------
(defcfun ("IupFileDlg" IupFileDlg) :pointer)

(defcfun ("IupMessageDlg" IupMessageDlg) :pointer)

(defcfun ("IupColorDlg" IupColorDlg) :pointer)

(defcfun ("IupFontDlg" IupFontDlg) :pointer)
;;--------------------------------------------------------------------------------------
(defcfun ("IupGetFile" IupGetFile) :int
  (arq :string))

(defcfun ("IupMessage" IupMessage) :void
  (title :string)
  (msg :string))

(defcfun ("IupMessagef" IupMessagef) :void
  (title :string)
  (format :string)
  &rest)

(defcfun ("IupAlarm" IupAlarm) :int
  (title :string)
  (msg :string)
  (b1 :string)
  (b2 :string)
  (b3 :string))

(defcfun ("IupScanf" IupScanf) :int
  (format :string)
  &rest)

(defcfun ("IupListDialog" IupListDialog) :int
  (type :int)
  (title :string)
  (size :int)
  (list :pointer)
  (op :int)
  (max_col :int)
  (max_lin :int)
  (marks :pointer))

(defcfun ("IupGetText" IupGetText) :int
  (title :string)
  (text :string))

(defcfun ("IupGetColor" IupGetColor) :int
  (x :int)
  (y :int)
  (r :pointer)
  (g :pointer)
  (b :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupGetParam" IupGetParam) :int
  (title :string)
  (action :pointer)
  (user_data :pointer)
  (format :string)
  &rest)

(defcfun ("IupGetParamv" IupGetParamv) :int
  (title :string)
  (action :pointer)
  (user_data :pointer)
  (format :string)
  (param_count :int)
  (param_extra :int)
  (param_data :pointer))
;;--------------------------------------------------------------------------------------
(defcfun ("IupLayoutDialog" IupLayoutDialog) :pointer
  (dialog :pointer))

(defcfun ("IupElementPropertiesDialog" IupElementPropertiesDialog) :pointer
  (elem :pointer))
;;--------------------------------------------------------------------------------------

;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------

