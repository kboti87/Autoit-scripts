#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 519, 184, 2155, 173)
$Combo1 = GUICtrlCreateCombo("", 16, 104, 185, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
$Button1 = GUICtrlCreateButton("Szerelo", 64, 24, 65, 33)
$Button2 = GUICtrlCreateButton("Mosós", 160, 24, 65, 33)
$Button3 = GUICtrlCreateButton("Admin", 264, 24, 65, 33)
$Combo2 = GUICtrlCreateCombo("", 256, 104, 161, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
$Button4 = GUICtrlCreateButton("OK", 448, 104, 33, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button1
			guictrlsetdata($Combo1,"")
			GUICtrlSetData($Combo1,"Szerelo1")
			GUICtrlSetData($Combo1,"Szerelo2")
			guictrlsetdata($Combo2,"")
			GUICtrlSetData($Combo2,"Szerelo_napkezdet")
			GUICtrlSetData($Combo2,"Szerelo_navvege")
			GUICtrlSetData($Combo2,"Szerelo_munkalap")
			GUICtrlSetData($Combo2,"Szerelo_alkatrészre vár")
		Case $Button2
			guictrlsetdata($Combo1,"")
			GUICtrlSetData($Combo1,"Mosós1")
			GUICtrlSetData($Combo1,"Mosós2")
			guictrlsetdata($Combo2,"")
			GUICtrlSetData($Combo2,"Mosós_napkezdet")
			GUICtrlSetData($Combo2,"Mosós_navvege")
			GUICtrlSetData($Combo2,"Mosós_munkalap")
			GUICtrlSetData($Combo2,"Mosós_demó autó")
		Case $Button3
			guictrlsetdata($Combo1,"")
			GUICtrlSetData($Combo1,"Admin1")
			GUICtrlSetData($Combo1,"Admin2")
			guictrlsetdata($Combo2,"")
			GUICtrlSetData($Combo2,"Admin_napkezdet")
			GUICtrlSetData($Combo2,"Admin_navvege")
			GUICtrlSetData($Combo2,"Admin_munkalap")
	EndSwitch
WEnd
