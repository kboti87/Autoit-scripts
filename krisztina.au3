#include <IE.au3>
#include <Array.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#Include <GuiListBox.au3>
#include <GUIConstantsEx.au3>
#include <Excel.au3>
#include <String.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <TrayConstants.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#NoTrayIcon
Global $x, $text
Opt("TrayMenuMode", 3)


#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("", 363, 139, 397, 162)
$Button1 = GUICtrlCreateButton("Keres", 224, 16, 91, 25)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Radio1 = GUICtrlCreateRadio("AM - Jármű adat", 16, 8, 153, 25)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Radio2 = GUICtrlCreateRadio("AM - Szerződés", 16, 40, 153, 25)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Radio3 = GUICtrlCreateRadio("Global - Felvilágosítás", 16, 72, 193, 25)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$input = GUICtrlCreateInput("", 224, 56, 121, 28)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Radio4 = GUICtrlCreateRadio("Global - Credit/Debit", 16, 104, 193, 25)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")


GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
Local $amjarmu = TrayCreateItem("AM - Jármű adat") ; Create a tray menu sub menu with two sub items.
Local $amszerzodes = TrayCreateItem("AM - Szerződés")
Local $global = TrayCreateItem("Global - Felvilágosítás")
Local $globalcd = TrayCreateItem("Global - Credit/Debit")
TrayCreateItem("") ; Create a separator line.
Local $idExit = TrayCreateItem("Exit")
$x = 3
TraySetState($TRAY_ICONSTATE_SHOW) ; Show the tray menu.

While 1

	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		case $Button1
				if GUICtrlRead($input) = "" Then
					$text = StringStripCR(StringStripWS(ClipGet(),8))
					if StringLen($text) = 8 Then
						$x = 0
					ElseIf StringLen($text) = 6 Then
						$x = 1
					Else
						$x = 3
					EndIf
					if GUICtrlRead($Radio1) = 1 Then
						Call("AMjarmu")
					ElseIf GUICtrlRead($Radio2) = 1 Then
						Call("AMszerz")
					ElseIf GUICtrlRead($Radio3) = 1 Then
						Call("IEGlobal")
					ElseIf GUICtrlRead($Radio4) = 1 Then
						Call("IEGlobalcd")
					EndIf
				Else
					$text = GUICtrlRead($input)
					if StringLen(GUICtrlRead($input)) = 8 Then
						$x = 0
					ElseIf StringLen(GUICtrlRead($input)) = 6 Then
						$x = 1
					Else
						$x = 3
					EndIf
					if GUICtrlRead($Radio1) = 1 Then
						Call("AMjarmu")
					ElseIf GUICtrlRead($Radio2) = 1 Then
						Call("AMszerz")
					ElseIf GUICtrlRead($Radio3) = 1 Then
						Call("IEGlobal")
					ElseIf GUICtrlRead($Radio4) = 1 Then
						Call("IEGlobalcd")
					EndIf
					GUICtrlSetData($input,"")
				EndIf
				$text = ""
	EndSwitch
	Switch TrayGetMsg()
            Case $amjarmu ; Display a message box about the AutoIt version and installation path of the AutoIt executable.
                $text = StringStripCR(StringStripWS(ClipGet(),8))
				if StringLen($text) = 8 Then
					$x = 0
				ElseIf StringLen($text) = 6 Then
					$x = 1
				Else
					$x = 3
				EndIf
				Call("AMjarmu")

		Case $amszerzodes
				$text = StringStripCR(StringStripWS(ClipGet(),8))
				if StringLen($text) = 8 Then
					$x = 0
				ElseIf StringLen($text) = 6 Then
					$x = 1
				Else
					$x = 3
				EndIf
                Call("AMszerz")
		case $global
				$text = StringStripCR(StringStripWS(ClipGet(),8))
				if StringLen($text) = 8 Then
					$x = 0
				ElseIf StringLen($text) = 6 Then
					$x = 1
				Else
					$x = 3
				EndIf
				Call("IEGlobal")
		case $globalcd
				$text = StringStripCR(StringStripWS(ClipGet(),8))
				if StringLen($text) = 8 Then
					$x = 0
				ElseIf StringLen($text) = 6 Then
					$x = 1
				Else
					$x = 3
				EndIf
				Call("IEGlobalcd")
            Case $idExit ; Exit the loop.
                ExitLoop
        EndSwitch
WEnd



Func AMjarmu()
	if $text <> "" Then
		if $x = 0 Then
			Run("R:\Exe\Am0aauy.exe")
			WinWaitActive("Login to AutoMaster DMS")
			Send("{ENTER}")
			WinWaitActive("Jármű")
			Send("^f")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Sleep(1000)
			Send($text)
			Send("{ENTER}")
		ElseIf $x = 1 Then
			Run("R:\Exe\Am0aauy.exe")
			WinWaitActive("Login to AutoMaster DMS")
			Send("{ENTER}")
			WinWaitActive("Jármű")
			Send("^f")
			Sleep(1000)
			Send($text)
			Send("{ENTER}")
		ElseIf $x = 3 Then
		EndIf
	EndIf
EndFunc

Func AMszerz()
	if $text <> "" Then
		if $x = 0 Then
			Run("R:\Exe\Am0atsk.exe")
			WinWaitActive("Login to AutoMaster DMS")
			Send("{ENTER}")
			WinWaitActive("Jármű")
			Send("^f")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Sleep(1000)
			Send($text)
			Send("{ENTER}")
		ElseIf $x = 1 Then
			Run("R:\Exe\Am0atsk.exe")
			WinWaitActive("Login to AutoMaster DMS")
			Send("{ENTER}")
			WinWaitActive("Jármű")
			Send("^f")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Sleep(1000)
			Send($text)
			Send("{ENTER}")
			Send("{ENTER}")
		ElseIf $x = 3 Then
		EndIf
	EndIf
EndFunc

Func IEGlobal()
	if $text <> "" Then
		if $x = 0 Then
			$User_Name = "khribik@hu0190"
			$User_Password = "Tormkri75*"
			$oIE = _IECreate("https://dealerportal.opel-group.com/usmentosso/UI/Login?goto=https%3A%2F%2Fdealerportal.opel-group.com%3A443%2F" , Default , 1)
			_IELoadWait($oIE)
			$User_Login = _IEGetObjById($oIE , "IDToken1")
			_IEFormElementSetValue($User_Login , $User_Name)
			$User_Pass =_IEGetObjById($oIE , "IDToken2")
			_IEFormElementSetValue($User_Pass , $User_Password)
			$o_Button = _IEGetObjByName ( $oIE, "Login.Submit" )
			_IEAction ( $o_Button, "click" )
			_IELoadWait($oIE)
			$rendasztal = _IEGetObjById($oIE,"Order_OWB_1def")
			_IEAction($rendasztal,"click")
			Sleep(2000)
			$oIE = _IEAttach(WinActive("Rendelés Munkaasztal"),"hwnd")
			_IEImgClick($oIE,"Image102","id")
			$job = _IEGetObjById($oIE,"vehicleNumber")
			_IEFormElementSetValue($job,$text)
			Send("{ENTER}")
		EndIf
	EndIf
EndFunc

Func IEGlobalcd()
	if $text <> "" Then
		if $x = 0 Then
			$User_Name = "khribik@hu0190"
			$User_Password = "Tormkri75*"
			$oIE = _IECreate("https://dealerportal.opel-group.com/usmentosso/UI/Login?goto=https%3A%2F%2Fdealerportal.opel-group.com%3A443%2F" , Default , 1)
			_IELoadWait($oIE)
			$User_Login = _IEGetObjById($oIE , "IDToken1")
			_IEFormElementSetValue($User_Login , $User_Name)
			$User_Pass =_IEGetObjById($oIE , "IDToken2")
			_IEFormElementSetValue($User_Pass , $User_Password)
			$o_Button = _IEGetObjByName ( $oIE, "Login.Submit" )
			_IEAction ( $o_Button, "click" )
			_IELoadWait($oIE)
			$rendasztal = _IEGetObjById($oIE,"Order_OWB_1def")
			_IEAction($rendasztal,"click")
			Sleep(2000)
			$oIE = _IEAttach(WinActive("Rendelés Munkaasztal"),"hwnd")
			_IEImgClick($oIE,"Image62","id")
			$job = _IEGetObjByName($oIE,"vehicleNum")
			_IEFormElementSetValue($job,$text)
			Send("{ENTER}")
		EndIf
	EndIf
EndFunc