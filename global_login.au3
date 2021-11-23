#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile_type=a3x
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <IE.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <TrayConstants.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
Opt("TrayMenuMode", 3)


Local $settings = TrayCreateItem("Settings")
TrayCreateItem("") ; Create a separator line.
Local $idExit = TrayCreateItem("Exit")
TraySetState($TRAY_ICONSTATE_SHOW) ; Show the tray menu.

If FileExists(@WorkingDir & "\global_login.ini") Then
	$User_Name = IniRead("global_login.ini","1","user","0")
	$User_Password = IniRead("global_login.ini","1","pass","0")

Else
	Call("adatgui")

EndIf

HotKeySet("^g","globallogin")

While 1
    Switch TrayGetMsg()
		Case $settings
			Call("adatgui")
		Case $idExit ; Exit the loop.
                ExitLoop
	EndSwitch
WEnd

Func globallogin()

$User_Name = IniRead("global_login.ini","1","user","0")
$User_Password = IniRead("global_login.ini","1","pass","0")
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

EndFunc

func adatgui()
	$form = GUICreate("Bejelentkezési adatok",300,70,-1,-1,-1,-1)
	GUICtrlCreateLabel("Username: ",20,10,80,22)
	$userinput = GUICtrlCreateInput("",100,10,150,22)
	GUICtrlSetData(-1,IniRead("global_login.ini","1","user",""))
	GUICtrlCreateLabel("Password: ",20,40,80,22)
	$passinput = GUICtrlCreateInput("",100,40,150,22)
	GUICtrlSetData(-1,IniRead("global_login.ini","1","pass",""))
	GUISetState(@SW_SHOW)
	While 1
		$msg = GUIGetMsg()
        Switch $msg
			Case $GUI_EVENT_CLOSE
				IniWrite("global_login.ini","1","user",GUICtrlRead($userinput))
				IniWrite("global_login.ini","1","pass",GUICtrlRead($passinput))
				guidelete($form)
                ExitLoop

        EndSwitch
    WEnd

EndFunc
