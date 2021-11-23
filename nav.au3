#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

$iniarray = IniReadSection("nav.ini","1")

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 1221, 439, 317, 319)
$List1 = GUICtrlCreateList("", 8, 48, 89, 240)
$List2 = GUICtrlCreateList("", 184, 48, 89, 240)
$List3 = GUICtrlCreateList("", 360, 48, 89, 240)
$List4 = GUICtrlCreateList("", 536, 48, 89, 240)
$List5 = GUICtrlCreateList("", 712, 48, 89, 240)
$List6 = GUICtrlCreateList("", 888, 48, 89, 240)
for $i = 0 to UBound($iniarray,1)-1
	If $iniarray[$i][1] = 1 Then GUICtrlSetData($list1, $iniarray[$i][0])
	If $iniarray[$i][1] = 2 Then GUICtrlSetData($list2, $iniarray[$i][0])
	If $iniarray[$i][1] = 3 Then GUICtrlSetData($list3, $iniarray[$i][0])
	If $iniarray[$i][1] = 4 Then GUICtrlSetData($list4, $iniarray[$i][0])
	If $iniarray[$i][1] = 5 Then GUICtrlSetData($list5, $iniarray[$i][0])
	If $iniarray[$i][1] = 6 Then GUICtrlSetData($list6, $iniarray[$i][0])
Next
$Group1 = GUICtrlCreateGroup("", 1008, 24, 185, 313)
$Checkbox1 = GUICtrlCreateCheckbox("Munkalap", 1048, 112, 121, 33)
$Checkbox2 = GUICtrlCreateCheckbox("Fényképek", 1048, 152, 121, 33)
$Checkbox3 = GUICtrlCreateCheckbox("Számla", 1048, 192, 121, 33)
$Checkbox4 = GUICtrlCreateCheckbox("Checkbox1", 1048, 232, 121, 33)
$Label1 = GUICtrlCreateLabel("", 1032, 48, 36, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton(">>>>", 120, 112, 41, 33)
$Label2 = GUICtrlCreateLabel("NAV ajánlatkérés megérkezett", 16, 16, 91, 28)
$Label3 = GUICtrlCreateLabel("Ajánlatkérés továbbítva alv.-nak", 184, 16, 91, 28)
$Label4 = GUICtrlCreateLabel("Ajánlat alv.-tól megjött", 360, 16, 91, 28)
$Label5 = GUICtrlCreateLabel("Ajánlat elküldve NAV-nak", 536, 16, 91, 28)
$Label6 = GUICtrlCreateLabel("Ajánlat elfogadva", 712, 16, 91, 28)
$Label7 = GUICtrlCreateLabel("Munka kész", 888, 16, 91, 28)
$Group2 = GUICtrlCreateGroup("", 16, 336, 201, 97)
$Input1 = GUICtrlCreateInput("", 32, 352, 81, 21)
$Radio1 = GUICtrlCreateRadio("Saját", 136, 360, 113, 17)
$Radio2 = GUICtrlCreateRadio("Egyéb", 136, 400, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Button7 = GUICtrlCreateButton("Hozzáad", 32, 384, 65, 33)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button2 = GUICtrlCreateButton(">>>>", 296, 112, 41, 33)
$Button3 = GUICtrlCreateButton(">>>>", 472, 112, 41, 33)
$Button4 = GUICtrlCreateButton(">>>>", 648, 112, 41, 33)
$Button5 = GUICtrlCreateButton(">>>>", 824, 112, 41, 33)
$Button6 = GUICtrlCreateButton("R", 568, 296, 33, 25)
$Button8 = GUICtrlCreateButton("X", 920, 296, 33, 25)

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			if _GUICtrlListBox_GetCount($list1) > 0 Then
				for $i = 0 to _GUICtrlListBox_GetCount($list1)-1
					IniWrite("nav.ini","1",_GUICtrlListBox_GetText($list1,$i),"1")
				Next
			EndIf
			if _GUICtrlListBox_GetCount($list2) > 0 Then
				for $i = 0 to _GUICtrlListBox_GetCount($list2)-1
					IniWrite("nav.ini","1",_GUICtrlListBox_GetText($list2,$i),"2")
				Next
			EndIf
			if _GUICtrlListBox_GetCount($list3) > 0 Then
				for $i = 0 to _GUICtrlListBox_GetCount($list3)-1
					IniWrite("nav.ini","1",_GUICtrlListBox_GetText($list3,$i),"3")
				Next
			EndIf
			if _GUICtrlListBox_GetCount($list4) > 0 Then
				for $i = 0 to _GUICtrlListBox_GetCount($list4)-1
					IniWrite("nav.ini","1",_GUICtrlListBox_GetText($list4,$i),"4")
				Next
			EndIf
			if _GUICtrlListBox_GetCount($list5) > 0 Then
				for $i = 0 to _GUICtrlListBox_GetCount($list5)-1
					IniWrite("nav.ini","1",_GUICtrlListBox_GetText($list5,$i),"5")
				Next
			EndIf
			if _GUICtrlListBox_GetCount($list6) > 0 Then
				for $i = 0 to _GUICtrlListBox_GetCount($list6)-1
					IniWrite("nav.ini","1",_GUICtrlListBox_GetText($list6,$i),"6")
				Next
			EndIf
			Exit
		Case $Button7
			if GUICtrlRead($Radio1) = 1 then
				if GUICtrlRead($Input1) <> "" then GUICtrlSetData($List1,GUICtrlRead($Input1)& "  ")
			Else
				if GUICtrlRead($Input1) <> "" then GUICtrlSetData($List1,GUICtrlRead($Input1))
			EndIf
			GUICtrlSetData($Input1,"")
		case $Button1
			if StringRight(GUICtrlRead($list1),2) = "  " Then
				if GUICtrlRead($List1) <> "" Then
					GUICtrlSetData($list4,GUICtrlRead($list1))
					_GUICtrlListBox_DeleteString($List1, _GUICtrlListBox_GetCaretIndex($List1))
				EndIf
			Else
				if GUICtrlRead($List1) <> "" Then
					GUICtrlSetData($list2,GUICtrlRead($list1))
					_GUICtrlListBox_DeleteString($List1, _GUICtrlListBox_GetCaretIndex($List1))
				EndIf
			EndIf
		case $Button2
			if GUICtrlRead($list2) <> "" Then
				GUICtrlSetData($List3, GUICtrlRead($list2))
				_GUICtrlListBox_DeleteString($List2, _GUICtrlListBox_GetCaretIndex($List2))
			EndIf
		case $Button3
			if GUICtrlRead($list3) <> "" Then
				GUICtrlSetData($List4, GUICtrlRead($list3))
				_GUICtrlListBox_DeleteString($List3, _GUICtrlListBox_GetCaretIndex($List3))
			EndIf
		case $Button4
			if GUICtrlRead($list4) <> "" Then
				GUICtrlSetData($List5, GUICtrlRead($list4))
				_GUICtrlListBox_DeleteString($List4, _GUICtrlListBox_GetCaretIndex($List4))
			EndIf
		case $Button5
			if GUICtrlRead($list5) <> "" Then
				GUICtrlSetData($List6, GUICtrlRead($list5))
				_GUICtrlListBox_DeleteString($List5, _GUICtrlListBox_GetCaretIndex($List5))
			EndIf
		Case $Button8
			if GUICtrlRead($list6) <> "" Then _GUICtrlListBox_DeleteString($List6, _GUICtrlListBox_GetCaretIndex($List6))
		case $Button6
			if GUICtrlRead($list4) <> "" Then
				GUICtrlSetData($List1, GUICtrlRead($list4))
				_GUICtrlListBox_DeleteString($List4, _GUICtrlListBox_GetCaretIndex($List4))
			EndIf
	EndSwitch

WEnd

