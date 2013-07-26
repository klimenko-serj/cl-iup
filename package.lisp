;;;; package.lisp

(defpackage #:cl-iup
  (:use #:cl #:cffi)
  (:export

;/************************************************************************/
;/*                        Main API                                      */
;/************************************************************************/

:IupOpen
:IupClose
:IupImageLibOpen

:IupMainLoop
:IupLoopStep
:IupLoopStepWait
:IupMainLoopLevel
:IupFlush
:IupExitLoop

:IupRecordInput
:IupPlayInput

:IupUpdate
:IupUpdateChildren
:IupRedraw
:IupRefresh
:IupRefreshChildren

:IupMapFont
:IupUnMapFont
:IupHelp
:IupLoad
:IupLoadBuffer

:IupVersion
:IupVersionDate
:IupVersionNumber
:IupSetLanguage
:IupGetLanguage

:IupDestroy
:IupDetach
:IupAppend
:IupInsert
:IupGetChild
:IupGetChildPos
:IupGetChildCount
:IupGetNextChild
:IupGetBrother
:IupGetParent
:IupGetDialog
:IupGetDialogChild
:IupReparent

:IupPopup
:IupShow
:IupShowXY
:IupHide
:IupMap
:IupUnmap

:IupSetAttribute
:IupStoreAttribute
:IupSetAttributes
:IupGetAttribute
:IupGetAttributes
:IupGetInt
:IupGetInt2
:IupGetIntInt
:IupGetFloat
:IupSetfAttribute
:IupResetAttribute
:IupGetAllAttributes
:IupSetAtt

:IupSetAttributeId
:IupStoreAttributeId
:IupGetAttributeId
:IupGetFloatId
:IupGetIntId
:IupSetfAttributeId

:IupSetAttributeId2
:IupStoreAttributeId2
:IupGetAttributeId2
:IupGetIntId2
:IupGetFloatId2
:IupSetfAttributeId2

:IupSetGlobal
:IupStoreGlobal
:IupGetGlobal

:IupSetFocus
:IupGetFocus
:IupPreviousField
:IupNextField

:IupGetCallback
:IupSetCallback
:IupSetCallbacks

:IupGetFunction
:IupSetFunction
:IupGetActionName

:IupGetHandle
:IupSetHandle
:IupGetAllNames
:IupGetAllDialogs
:IupGetName

:IupSetAttributeHandle
:IupGetAttributeHandle

:IupGetClassName
:IupGetClassType
:IupGetAllClasses
:IupGetClassAttributes
:IupGetClassCallbacks
:IupSaveClassAttributes
:IupCopyClassAttributes
:IupSetClassDefaultAttribute
:IupClassMatch

:IupCreate
:IupCreatev
:IupCreatep


