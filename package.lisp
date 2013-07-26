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

   ;; CONSTANTS
;/************************************************************************/
;/*                   Common Return Values                               */
;/************************************************************************/
   :IUP_ERROR
   :IUP_NOERROR
   :IUP_OPENED
   :IUP_INVALID

;/************************************************************************/
;/*                   Callback Return Values                             */
;/************************************************************************/
   :IUP_IGNORE
   :IUP_DEFAULT
   :IUP_CLOSE
   :IUP_CONTINUE
;/************************************************************************/
;/*           IupPopup and IupShowXY Parameter Values                    */
;/************************************************************************/
   :IUP_CENTER
   :IUP_LEFT
   :IUP_RIGHT
   :IUP_MOUSEPOS
   :IUP_CURRENT
   :IUP_CENTERPARENT
   :IUP_TOP
   :IUP_BOTTOM
;/************************************************************************/
;/*               Mouse Button Values and Macros                         */
;/************************************************************************/
   :IUP_BUTTON1
   :IUP_BUTTON2
   :IUP_BUTTON3
   :IUP_BUTTON4
   :IUP_BUTTON5
;/************************************************************************/
;/*                      Pre-Defined Masks                               */
;/************************************************************************/
   :IUP_MASK_FLOAT
   :IUP_MASK_UFLOAT
   :IUP_MASK_EFLOAT
   :IUP_MASK_INT
   :IUP_MASK_UINT
;/************************************************************************/
;/*                   IupGetParam Callback situations                    */
;/************************************************************************/
   :IUP_GETPARAM_OK
   :IUP_GETPARAM_INIT
   :IUP_GETPARAM_CANCEL
   :IUP_GETPARAM_HELP

   ;; Enums
;/************************************************************************/
;/*               SHOW_CB Callback Values                                */
;/************************************************************************/
   :IUP_SHOW :IUP_RESTORE :IUP_MINIMIZE :IUP_MAXIMIZE :IUP_HIDE
;/************************************************************************/
;/*               SCROLL_CB Callback Values                              */
;/************************************************************************/
   :IUP_SBUP :IUP_SBDN :IUP_SBPGUP :IUP_SBPGDN :IUP_SBPOSV :IUP_SBDRAGV
   :IUP_SBLEFT :IUP_SBRIGHT :IUP_SBPGLEFT :IUP_SBPGRIGHT :IUP_SBPOSH :IUP_SBDRAGH
;/************************************************************************/
;/*                   Record Input Modes                                 */
;/************************************************************************/
   :IUP_RECBINARY :IUP_RECTEXT
   ))
