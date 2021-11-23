#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>
DllCall('uxtheme.dll', 'none', 'SetThemeAppProperties', 'int', 0)
$hTaskbar_Wnd = WinGetHandle("[CLASS:Shell_TrayWnd]")
$hTaskbarCtrl_Wnd = ControlGetHandle("[CLASS:Shell_TrayWnd]", "", "ToolbarWindow321")
$Pos = ControlGetPos("[CLASS:Shell_TrayWnd]","","[TEXT:Running applications]")

$hGUI = GUICreate("", 300, 22, $Pos[2]-120, 10, $WS_POPUP, $WS_EX_TOPMOST, $hTaskbar_Wnd)
GUISetBkColor(0x000000)
$Input = GUICtrlCreateInput("Search...", 0, 0, 70, 22)
GUICtrlSetColor(-1, 0xC0C0C0)
$radio1 = GUICtrlCreateRadio("AM",80,0,40,22)
GUICtrlSetColor(-1, 0xFFFFFF)
$radio2 = GUICtrlCreateRadio("Forgalmi",120,0,60,22)
GUICtrlSetColor(-1, 0xFFFFFF)
$radio3 = GUICtrlCreateRadio("Global",180,0,60,22)
GUICtrlSetColor(-1, 0xFFFFFF)
$button = GUICtrlCreateButton("Keres",240,0,50,22)


GUISetState(@SW_SHOW, $hGUI)
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

_WinAPI_SetParent($hGUI, $hTaskbar_Wnd)

$nDummyEnterID = GUICtrlCreateDummy()

Dim $aAccelKeys[1][2] = [["{ENTER}", $nDummyEnterID]]
GUISetAccelerators($aAccelKeys)

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $nDummyEnterID
            $sInput_Read = GUICtrlRead($Input)

            If $sInput_Read <> "" Then ShellExecute("http://www.google.ru/search?hl=en&q=" & $sInput_Read)
    EndSwitch
WEnd

Func WM_COMMAND($hWnd, $nMsg, $wParam, $lParam)
    Local $nNotifyCode = BitShift($wParam, 16)
    Local $nID = BitAND($wParam, 0xFFFF)
    Local $hCtrl = $lParam

    Switch $nID
        Case $Input
            Switch $nNotifyCode
                Case $EN_CHANGE, $EN_UPDATE

                Case $EN_SETFOCUS
                    If GUICtrlRead($Input) = "Search..." Then GUICtrlSetData($Input, "")

                    GUICtrlSetColor($Input, 0x0)
                Case $EN_KILLFOCUS
                    If GUICtrlRead($Input) = "" Then GUICtrlSetData($Input, "Search...")

                    GUICtrlSetColor($Input, 0xC0C0C0)
            EndSwitch
    EndSwitch

    Return $GUI_RUNDEFMSG
EndFunc

