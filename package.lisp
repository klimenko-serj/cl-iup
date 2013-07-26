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


;/************************************************************************/
;/*                        Elements                                      */
;/************************************************************************/

:IupFill
:IupRadio
:IupVbox
:IupVboxv
:IupZbox
:IupZboxv
:IupHbox
:IupHboxv

:IupNormalizer
:IupNormalizerv

:IupCbox
:IupCboxv
:IupSbox
:IupSplit
:IupScrollBox
:IupGridBox
:IupGridBoxv
:IupExpander

:IupFrame

:IupImage
:IupImageRGB
:IupImageRGBA

:IupItem
:IupSubmenu
:IupSeparator
:IupMenu
:IupMenuv

:IupButton
:IupCanvas
:IupDialog
:IupUser
:IupLabel
:IupList
:IupText
:IupMultiLine
:IupToggle
:IupTimer
:IupClipboard
:IupProgressBar
:IupVal
:IupTabs
:IupTabsv
:IupTree
:IupLink


;/* Deprecated controls, use SPIN attribute of IupText */
:IupSpin
:IupSpinbox


;/* IupImage utility */
:IupSaveImageAsText

;/* IupText and IupScintilla utilities */
:IupTextConvertLinColToPos
:IupTextConvertPosToLinCol

;/* IupText, IupList, IupTree, IupMatrix and IupScintilla utility */
:IupConvertXYToPos

;/* IupTree utilities */
:IupTreeSetUserId
:IupTreeGetUserId
:IupTreeGetId

;/* Deprecated IupTree utilities, use Iup*AttributeId functions */
:IupTreeSetAttribute
:IupTreeStoreAttribute
:IupTreeGetAttribute
:IupTreeGetInt
:IupTreeGetFloat
:IupTreeSetfAttribute
:IupTreeSetAttributeHandle


;/************************************************************************/
;/*                      Pre-definided dialogs                           */
;/************************************************************************/

:IupFileDlg
:IupMessageDlg
:IupColorDlg
:IupFontDlg

:IupGetFile
:IupMessage
:IupMessagef
:IupAlarm
:IupScanf
:IupListDialog
:IupGetText
:IupGetColor

:IupGetParam
:IupGetParamv

:IupLayoutDialog
:IupElementPropertiesDialog






))
