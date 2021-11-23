#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IE_Example("form")
Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
Local $oText = _IEFormElementGetObjByName($oForm, "textExample")
Local $aIEAu3Version = _IE_VersionInfo()
_IEFormElementSetValue($oText, $aIEAu3Version[5])
MsgBox($MB_SYSTEMMODAL, "Form Element Value", _IEFormElementGetValue($oText))

