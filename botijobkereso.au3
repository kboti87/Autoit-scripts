#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\Downloads\find_search_locate_6312.ico
#AutoIt3Wrapper_Outfile=N:\Botond\autoit scriptek\JOBkereso.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
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
#include <File.au3>
Opt("TrayIconHide")
Global $x, $text
Opt("TrayMenuMode", 3)

If FileExists(@WorkingDir & "\botijobkereso.ini") Then
	$User_Name = IniRead("botijobkereso.ini","1","user","0")
	$User_Password = IniRead("botijobkereso.ini","1","pass","0")

Else
	Call("adatgui")

EndIf


#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("", 363, 139, 397, 162,-1,$WS_EX_TOPMOST)
$Button1 = GUICtrlCreateButton("Keres", 224, 16, 91, 25)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Radio1 = GUICtrlCreateRadio("AM - Jármű adat", 16, 8, 153, 25)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Radio2 = GUICtrlCreateRadio("Forgalmi", 16, 40, 153, 25)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Radio3 = GUICtrlCreateRadio("Global - Felvilágosítás", 16, 72, 193, 25)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$input = GUICtrlCreateInput("", 224, 56, 121, 28)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")

GUISetState(@SW_SHOW)


#EndRegion ### END Koda GUI section ###
Local $amjarmu = TrayCreateItem("AM - Jármu adat") ; Create a tray menu sub menu with two sub items.
Local $forgalmi = TrayCreateItem("Forgalmi")
Local $global = TrayCreateItem("Global - Felvilágosítás")
TrayCreateItem("") ; Create a separator line.
Local $settings = TrayCreateItem("Settings")
Local $menu = TrayCreateItem("Menu")
Local $idExit = TrayCreateItem("Exit")
$x = 3
TraySetState($TRAY_ICONSTATE_SHOW) ; Show the tray menu.

HotKeySet("^g","globallogin")


Func globallogin()

$User_Name = IniRead("botijobkereso.ini","1","user","0")
$User_Password = IniRead("botijobkereso.ini","1","pass","0")
$oIE = _IECreate("https://dealerportal.opel-group.com/usmentosso/UI/Login?goto=https%3A%2F%2Fdealerportal.opel-group.com%3A443%2F" , Default , 1)
_IELoadWait($oIE)
$User_Login = _IEGetObjById($oIE , "IDToken1")
_IEFormElementSetValue($User_Login , $User_Name)
$User_Pass =_IEGetObjById($oIE , "IDToken2")
_IEFormElementSetValue($User_Pass , $User_Password)
$o_Button = _IEGetObjByName ( $oIE, "Login.Submit" )
_IEAction ( $o_Button, "click" )
_IELoadWait($oIE)

EndFunc
While 1

	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $GUI_EVENT_MINIMIZE
			GUISetState(@SW_HIDE)

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
						Call("forgalmi")
					ElseIf GUICtrlRead($Radio3) = 1 Then
						Call("IEGlobal")

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
						Call("forgalmi")
					ElseIf GUICtrlRead($Radio3) = 1 Then
						Call("IEGlobal")

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

		Case $forgalmi
				$text = StringStripCR(StringStripWS(ClipGet(),8))
				if StringLen($text) = 8 Then
					$x = 0
				ElseIf StringLen($text) = 6 Then
					$x = 1
				Else
					$x = 3
				EndIf
				Call("forgalmi")
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
		Case $settings
			Call("adatgui")
		Case $menu
			GUISetState(@SW_SHOW)
			GUISetState(@SW_RESTORE)
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
			WinWaitActive("Jármű - Tormási")
			Sleep(500)
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
			WinWaitActive("Jármű - Tormási")
			Sleep(500)
			Send("^f")
			Sleep(1000)
			Send($text)
			Send("{ENTER}")
		ElseIf $x = 3 Then
		EndIf
	EndIf
EndFunc

Func forgalmi()
	if $x = 1 Then
		$filelista = _FileListToArray("N:\Forgalmi másolat\")
		For $i = 1 to $filelista[0]
			if StringLeft(StringReplace(StringStripWS($filelista[$i],8),"-",""),6) = $text Then
				run("RunDLL32.EXE url.dll,FileProtocolHandler "& "N:\Forgalmi másolat\"&$filelista[$i])
			EndIf
		Next
	EndIf
EndFunc

Func IEGlobal()
	if $text <> "" Then
		if $x = 0 Then
			$User_Name = IniRead("botijobkereso.ini","1","user","0")
			$User_Password = IniRead("botijobkereso.ini","1","pass","0")
			$oIE = _IECreate("https://dealerportal.opel-group.com/usmentosso/UI/Login?goto=https%3A%2F%2Fdealerportal.opel-group.com%3A443%2F" , Default , 1)
			_IELoadWait($oIE)
			if StringInStr(_IEPropertyGet($oIE,"innertext"),"Access Denied") <> 0 Then
				MsgBox(0,"","A dealerportal már nyitva van, zárd be és próbáld újra")
				Return
			EndIf
			$User_Login = _IEGetObjById($oIE , "IDToken1")
			_IEFormElementSetValue($User_Login , $User_Name)
			$User_Pass =_IEGetObjById($oIE , "IDToken2")
			_IEFormElementSetValue($User_Pass , $User_Password)
			$o_Button = _IEGetObjByName ( $oIE, "Login.Submit" )
			_IEAction ( $o_Button, "click" )
			_IELoadWait($oIE)
			$rendasztal = _IEGetObjById($oIE,"Order_OWB_1def")
			_IEAction($rendasztal,"click")
			_IEQuit($oIE)
			Sleep(2000)
			if WinActive("[CLASS:IEFrame]","RoleSelector") <> 0 Then
				$oIE = _IEAttach("RoleSelector","url")
				$ok = _IEGetObjByName($oIE,"ok")
				_IEAction($ok,"click")
				Sleep(1000)
			EndIf
			$oIE = _IEAttach(WinWaitActive("Rendelés Munkaasztal","",6),"hwnd")
			_IEImgClick($oIE,"Image102","id")
			$job = _IEGetObjById($oIE,"vehicleNumber")
			_IEFormElementSetValue($job,$text)
			Send("{ENTER}")
		EndIf
	EndIf
EndFunc

func adatgui()
	$form = GUICreate("Bejelentkezési adatok",300,70,-1,-1,-1,-1)
	GUICtrlCreateLabel("Username: ",20,10,80,22)
	$userinput = GUICtrlCreateInput("",100,10,150,22)
	GUICtrlSetData(-1,IniRead("botijobkereso.ini","1","user",""))
	GUICtrlCreateLabel("Password: ",20,40,80,22)
	$passinput = GUICtrlCreateInput("",100,40,150,22)
	GUICtrlSetData(-1,IniRead("botijobkereso.ini","1","pass",""))
	GUISetState(@SW_SHOW)
	While 1
		$msg = GUIGetMsg()
        Switch $msg
			Case $GUI_EVENT_CLOSE
				IniWrite("botijobkereso.ini","1","user",GUICtrlRead($userinput))
				IniWrite("botijobkereso.ini","1","pass",GUICtrlRead($passinput))
				guidelete($form)
                ExitLoop

        EndSwitch
    WEnd

EndFunc


