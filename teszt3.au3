#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#include <Excel.au3>
#include <Array.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <Misc.au3>
#include <GuiComboBox.au3>
#include <ButtonConstants.au3>
#include <ListViewConstants.au3>
#include <ComboConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <AutoItConstants.au3>
#include <StructureConstants.au3>

local $excel = _Excel_Open(False)
Local $workbook = _Excel_BookOpen($excel,"N:\Botond\co2tervezoriport\Járműértékesítési tervezés.xlsx",True,False)
Local $array=_Excel_RangeRead($workbook)
ReDim $array[UBound($array)][UBound($array,2)+1]
_Excel_BookClose($workbook,False)
_Excel_Close($excel,False)

$iniarray = IniReadSection("data.ini","job")


;~ _ArrayDisplay($array)

#Region Típus ellenőrzés
$Temp = ""
$Temp1 = ""
For $i=1 to UBound($array)-1
	  if $array[$i][9] = "Astra-K" or $array[$i][9] = "COMBO-E" OR $array[$i][9] = "CORSA-F" OR $array[$i][9] = "CROSSLAND X" OR $array[$i][9] = "Grandland X" or $array[$i][9] = "Insignia-B" or $array[$i][9] = "MOVANO-B" or $array[$i][9] = "VIVARO-C/ZAFIRA LIFE" Then
	  Else
		 $Temp &= $array[$i][2] & " " & $array[$i][9] & @LF
		 $Temp1 &= $array[$i][2] & @LF
	  EndIf
Next

if $Temp <> "" then
	ClipPut($Temp1)
	MsgBox(0,"Probléma az alábbi járművekkel",$Temp & @LF&@LF&@LF & "A Típus megnevezés helytelen"&@LF&"Javítani kell az Automaster-ben"&@LF&"A JOB számok a vágólapra lettek másolva")
EndIf
#EndRegion



#Region GUI megjelenítés
$Form1 = GUICreate("Havi tervező", 1281, 901, 225, 51)
$List1 = GUICtrlCreateListView("JOB   | Eseménykód | Típus | Vevő neve | Értékesítő | Kategória | Állapot | T - dátum | Megjegyzés",10,30,1000,400)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 80)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 40)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 50)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 3, 50)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 4, 50)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 5, 50)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 6, 50)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 7, 50)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 8, 200)
$List2 = GUICtrlCreateListView("JOB   | Rendszám | Típus | Vevő neve | Értékesítő | Kategória | Állapot | El. forg. hely. ",10,450,1000,400)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 80)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 40)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 50)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 3, 50)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 4, 50)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 5, 50)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 6, 50)
   GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 7, 50)
$tipus = GUICtrlCreateCombo("",1136, 40, 120, 25)
   _GUICtrlComboBox_AddString($tipus,"S=Személygépkocsi")
   _GUICtrlComboBox_AddString($tipus,"H=Haszongépjármű")
$modell = GUICtrlCreateCombo("",1136, 70, 120, 25)
   _GUICtrlComboBox_AddString($modell,"Astra")
   _GUICtrlComboBox_AddString($modell,"Combo")
   _GUICtrlComboBox_AddString($modell,"Corsa")
   _GUICtrlComboBox_AddString($modell,"Crossland")
   _GUICtrlComboBox_AddString($modell,"Grandland")
   _GUICtrlComboBox_AddString($modell,"Insignia")
   _GUICtrlComboBox_AddString($modell,"Movano")
   _GUICtrlComboBox_AddString($modell,"Vivaro/Zafira")
$ertek = GUICtrlCreateCombo("",1136, 100, 120, 25)
   _GUICtrlComboBox_AddString($ertek,"Fruttus Árpád Zoltán")
   _GUICtrlComboBox_AddString($ertek,"Kaczkó Norbert")
   _GUICtrlComboBox_AddString($ertek,"Lőrincz László")
   _GUICtrlComboBox_AddString($ertek,"Mészáros István")
   _GUICtrlComboBox_AddString($ertek,"Egyéb")
$allapot = GUICtrlCreateCombo("",1136, 130, 120, 25)
   _GUICtrlComboBox_AddString($allapot,"B=Bérautó")
   _GUICtrlComboBox_AddString($allapot,"D=Demo")
   _GUICtrlComboBox_AddString($allapot,"F=Új-Flotta")
   _GUICtrlComboBox_AddString($allapot,"G=Új-Spec. flotta")
   _GUICtrlComboBox_AddString($allapot,"N=Új-Retail")
   _GUICtrlComboBox_AddString($allapot,"S=Saját")
   _GUICtrlComboBox_AddString($allapot,"T=Taktikai forg.hely")
$kovho = GUICtrlCreateCheckbox("Aktuális hónap",862, 5, 120, 20,$BS_PUSHLIKE)
$Label1 = GUICtrlCreateLabel("Jármű típus", 1026, 40, 91, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Label2 = GUICtrlCreateLabel("Modell", 1026, 72, 53, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Label3 = GUICtrlCreateLabel("Értékesítő", 1026, 104, 79, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Label4 = GUICtrlCreateLabel("Állapot", 1026, 136, 103, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Label5 = GUICtrlCreateLabel("S", 1119, 216, 19, 17, $SS_CENTER)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Label6 = GUICtrlCreateLabel("H", 1175, 216, 20, 17, $SS_CENTER)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Label7 = GUICtrlCreateLabel("Tervezett:", 1020, 248, 80, 20)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Label8 = GUICtrlCreateLabel("Forg. hely:", 1020, 280, 80, 20)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Label9 = GUICtrlCreateLabel("___________________________________", 1016, 304, 198, 2, $SS_ETCHEDHORZ)
$Label10 = GUICtrlCreateLabel("|            |             |             |", 1216, 240, 2, 61, $SS_ETCHEDVERT)
$kilepes = GUICtrlCreateButton("Kilépés", 1032, 808, 105, 41)
$mentes = GUICtrlCreateButton("SAVE", 1032, 738, 105, 41)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$am = GUICtrlCreateButton("Automaster", 1024, 400, 105, 41)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$emaillista = GUICtrlCreateCombo("", 1032, 546, 152, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
   _GUICtrlComboBox_AddString($emaillista,"fruttus.arpad@tormasi.hu")
   _GUICtrlComboBox_AddString($emaillista,"hribik.krisztina@tormasi.hu")
   _GUICtrlComboBox_AddString($emaillista,"tormasi.atilla@tormasi.hu")
$email = GUICtrlCreateButton("E-mail küldés", 1032, 504, 105, 41)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$reset = GUICtrlCreateButton("Reset", 1024, 168, 73, 25)
$excel = GUICtrlCreateButton("Excel export", 1152, 400, 105, 41)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
#EndRegion

Func lista($n=0, $mi=True)
   $countts = 0
   $countth = 0
   $countfs = 0
   $countfh = 0
   If GUICtrlRead($kovho)=4 Then
	  $honap=@MON
   Else
	  If @MON < 10 Then
		 $honap = "0"&@MON+1
	  Else
		 $honap = @MON+1
	  EndIf
   EndIf
   For $i=1 to UBound($array)-1
	     for $j=1 to UBound($iniarray)-1
			 if $array[$i][2] = $iniarray[$j][0] Then
				 $array[$i][34]=$iniarray[$j][1]
			EndIf
		Next
			 If StringLeft($array[$i][4],1) = "2" And StringLeft($array[$i][24],8) >= "2020"&$honap&"01" and StringLeft($array[$i][24],8) <= "2020"&$honap&"31" and $array[$i][$n] = $mi Then
			If StringLeft($array[$i][13],1) = "N" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & StringLeft($array[$i][1],2) & "|" & $array[$i][9] & "|" & $array[$i][6] & "|" & $array[$i][7] & "|" & StringLeft($array[$i][12],1) & "|" & "" & "|" & (StringLeft($array[$i][24],4) & "/" & StringMid($array[$i][24], 5, 2) & "/" & StringMid($array[$i][24], 7, 2))&"|"& $array[$i][34],$List1)
			Else
				GUICtrlCreateListViewItem($array[$i][2] & "|" & StringLeft($array[$i][1],2) & "|" & $array[$i][9] & "|" & $array[$i][6] & "|" & $array[$i][7] & "|" & StringLeft($array[$i][12],1) & "|" & StringLeft($array[$i][13],1) & "|" & (StringLeft($array[$i][24],4) & "/" & StringMid($array[$i][24], 5, 2) & "/" & StringMid($array[$i][24], 7, 2)&"|"& $array[$i][34]),$List1)
			EndIf
			if StringLeft($array[$i][12],1) = "S" Then $countts += 1
			if StringLeft($array[$i][12],1) = "H" Then $countth += 1
		 ElseIf StringLeft($array[$i][4],1) = "1" And StringLeft($array[$i][16],8) >= "2020"&$honap&"01" and StringLeft($array[$i][16],8) <= "2020"&$honap&"31" and $array[$i][$n] = $mi Then
			If StringLeft($array[$i][13],1) = "N" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][3] & "|" & $array[$i][9] & "|" & $array[$i][6] & "|" & $array[$i][7] & "|" & StringLeft($array[$i][12],1) & "|" & "" & "|" & (StringLeft($array[$i][16],4) & "/" & StringMid($array[$i][16], 5, 2) & "/" & StringMid($array[$i][16], 7, 2)),$List2)
			Else
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][3] & "|" & $array[$i][9] & "|" & $array[$i][6] & "|" & $array[$i][7] & "|" & StringLeft($array[$i][12],1) & "|" & StringLeft($array[$i][13],1) & "|" & (StringLeft($array[$i][16],4) & "/" & StringMid($array[$i][16], 5, 2) & "/" & StringMid($array[$i][16], 7, 2)),$List2)
			EndIf
			if StringLeft($array[$i][12],1) = "S" Then $countfs += 1
			if StringLeft($array[$i][12],1) = "H" Then $countfh += 1
		 EndIf
   Next
   $fa=False
   $tr =True
   _GUICtrlListView_SimpleSort($List1,$fa,7,$tr)
   _GUICtrlListView_SimpleSort($List2,$fa,7,$tr)
   _GUICtrlListView_RegisterSortCallBack($List1)
   _GUICtrlListView_RegisterSortCallBack($List2)

   $tervezettdb = _GUICtrlListView_GetItemCount($List1)
   $forghelydb = _GUICtrlListView_GetItemCount($List2)
   GUICtrlCreateLabel($tervezettdb,1226, 248, 40, 20)
   GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
   GUICtrlCreateLabel($forghelydb,1226, 280, 40, 20)
   GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
   GUICtrlCreateLabel($countts+$countfs,1116, 314, 40, 20, $SS_CENTER)
   GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
   GUICtrlCreateLabel($countth+$countfh,1172, 314, 40, 20, $SS_CENTER)
   GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
   GUICtrlCreateLabel($countts,1116, 248, 40, 20, $SS_CENTER)
   GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
   GUICtrlCreateLabel($countth, 1172, 248, 40, 20, $SS_CENTER)
   GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
   GUICtrlCreateLabel($countfs,1116, 280, 40, 20, $SS_CENTER)
   GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
   GUICtrlCreateLabel($countfh, 1172, 280, 40, 20, $SS_CENTER)
   GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
   GUICtrlCreateLabel($tervezettdb+$forghelydb,1226, 314, 40, 20)
   GUICtrlSetFont(-1, 12, 800, 4, "MS Sans Serif")

EndFunc

Func inimentes()
	for $i = 0 to _GUICtrlListView_GetItemCount($List1)
		if _GUICtrlListView_GetItemText($List1,$i,8) <> "" Then
		   IniWrite("data.ini","job",_GUICtrlListView_GetItemText($List1,$i),_GUICtrlListView_GetItemText($List1,$i,8))
		EndIf
	Next
EndFunc

func initorles()

EndFunc

Call(lista)
GUISetState(@SW_SHOW)
GUIRegisterMsg($WM_NOTIFY, "_WM_NOTIFY")

#Region billentyűparancsok
$info =  GUICtrlCreateDummy()
$copy =  GUICtrlCreateDummy()
local $acckeys[2][2] = [["i",$info],["c",$copy]]
GUISetAccelerators($acckeys)
#EndRegion



While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
	    Case $GUI_EVENT_CLOSE
		 ExitLoop
	    Case $List1
		 _GUICtrlListView_SortItems($List1, GUICtrlGetState($List1))
	    Case $List2
		 _GUICtrlListView_SortItems($List2, GUICtrlGetState($List2))
	    Case $tipus
		 _GUICtrlListView_DeleteAllItems($List1)
		 _GUICtrlListView_DeleteAllItems($List2)
		 lista(12,GUICtrlRead($tipus))
		 _GUICtrlComboBox_SetEditText($modell,"")
		 _GUICtrlComboBox_SetEditText($ertek,"")
		 _GUICtrlComboBox_SetEditText($allapot,"")
	    Case $modell
		 If GUICtrlRead($modell) = "Astra" Then
			_GUICtrlListView_DeleteAllItems($List1)
			_GUICtrlListView_DeleteAllItems($List2)
			lista(9,"Astra-K")
		 ElseIf GUICtrlRead($modell) = "Combo" Then
			_GUICtrlListView_DeleteAllItems($List1)
			_GUICtrlListView_DeleteAllItems($List2)
			lista(9,"COMBO-E")
		 ElseIf GUICtrlRead($modell) = "Corsa" Then
			_GUICtrlListView_DeleteAllItems($List1)
			_GUICtrlListView_DeleteAllItems($List2)
			lista(9,"CORSA-F")
		 ElseIf GUICtrlRead($modell) = "Crossland" Then
			_GUICtrlListView_DeleteAllItems($List1)
			_GUICtrlListView_DeleteAllItems($List2)
			lista(9,"CROSSLAND X")
		 ElseIf GUICtrlRead($modell) = "Grandland" Then
			_GUICtrlListView_DeleteAllItems($List1)
			_GUICtrlListView_DeleteAllItems($List2)
			lista(9,"Grandland X")
		 ElseIf GUICtrlRead($modell) = "Insignia" Then
			_GUICtrlListView_DeleteAllItems($List1)
			_GUICtrlListView_DeleteAllItems($List2)
			lista(9,"Insignia-B")
		 ElseIf GUICtrlRead($modell) = "Movano" Then
			_GUICtrlListView_DeleteAllItems($List1)
			_GUICtrlListView_DeleteAllItems($List2)
			lista(9,"MOVANO-B")
		 ElseIf GUICtrlRead($modell) = "Vivaro/Zafira" Then
			_GUICtrlListView_DeleteAllItems($List1)
			_GUICtrlListView_DeleteAllItems($List2)
			lista(9,"VIVARO-C/ZAFIRA LIFE")
		 EndIf
		 _GUICtrlComboBox_SetEditText($tipus,"")
		 _GUICtrlComboBox_SetEditText($ertek,"")
		 _GUICtrlComboBox_SetEditText($allapot,"")
	    Case $ertek
		 _GUICtrlListView_DeleteAllItems($List1)
		 _GUICtrlListView_DeleteAllItems($List2)
		 if GUICtrlRead($ertek) = "Egyéb" Then
			lista(7,"")
		 Else
			lista(7,GUICtrlRead($ertek))
		 EndIf
		 _GUICtrlComboBox_SetEditText($tipus,"")
		 _GUICtrlComboBox_SetEditText($modell,"")
		 _GUICtrlComboBox_SetEditText($allapot,"")
	    Case $allapot
		 _GUICtrlListView_DeleteAllItems($List1)
		 _GUICtrlListView_DeleteAllItems($List2)
		 lista(13,GUICtrlRead($allapot))
		 _GUICtrlComboBox_SetEditText($tipus,"")
		 _GUICtrlComboBox_SetEditText($ertek,"")
		 _GUICtrlComboBox_SetEditText($modell,"")
	    Case $kovho
		 Switch GUICtrlRead($kovho)
			Case $GUI_CHECKED
			   GUICtrlSetData($kovho,"Következő hónap")
			   _GUICtrlListView_DeleteAllItems($List1)
			   _GUICtrlListView_DeleteAllItems($List2)
			   lista()
			Case Else
			   GUICtrlSetData($kovho,"Aktuális hónap")
			   _GUICtrlListView_DeleteAllItems($List1)
			   _GUICtrlListView_DeleteAllItems($List2)
			   lista()
		 EndSwitch
		 _GUICtrlComboBox_SetEditText($modell,"")
		 _GUICtrlComboBox_SetEditText($ertek,"")
		 _GUICtrlComboBox_SetEditText($allapot,"")
		 _GUICtrlComboBox_SetEditText($tipus,"")
	    Case $reset
		 _GUICtrlListView_DeleteAllItems($List1)
		 _GUICtrlListView_DeleteAllItems($List2)
		 lista()
		 _GUICtrlComboBox_SetEditText($modell,"")
		 _GUICtrlComboBox_SetEditText($ertek,"")
		 _GUICtrlComboBox_SetEditText($allapot,"")
		 _GUICtrlComboBox_SetEditText($tipus,"")
	    Case $excel
		 local $ujexcel = _Excel_Open()
		 $munkafuzet = _Excel_BookNew($ujexcel)
		 $a = _GUICtrlListView_GetItemCount($List1)
		 _Excel_RangeWrite($munkafuzet,1,"Tervezett","A1")
		 _Excel_RangeWrite($munkafuzet,1,"Forg. hely.","A"&$a+1)


		 $i = 0
		 Do
			 if $a=0 Then ExitLoop
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List1,$i,0),"B"&$i+1)
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List1,$i,1),"C"&$i+1)
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List1,$i,2),"D"&$i+1)
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List1,$i,3),"E"&$i+1)
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List1,$i,4),"F"&$i+1)
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List1,$i,5),"G"&$i+1)
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List1,$i,6),"H"&$i+1)
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List1,$i,7),"I"&$i+1)
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List1,$i,8),"J"&$i+1)
			$i=$i+1
		 Until $i =  $a
		 $a += 1
		 $i = 0
		 Do
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List2,$i,0),"B"&$i+$a)
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List2,$i,1),"C"&$i+$a)
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List2,$i,2),"D"&$i+$a)
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List2,$i,3),"E"&$i+$a)
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List2,$i,4),"F"&$i+$a)
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List2,$i,5),"G"&$i+$a)
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List2,$i,6),"H"&$i+$a)
			_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($List2,$i,7),"I"&$i+$a)
			$i=$i+1
		 Until $i =  _GUICtrlListView_GetItemCount($List2)
		 $munkafuzet.ActiveSheet.Columns("A:J").Autofit
	    Case $info
		   MsgBox(0,"",_GUICtrlListView_GetSelectedIndices($List1))
	    Case $copy
			For $i = 0 to _GUICtrlListView_GetItemCount($List1)
				Local $aItemAttrib = _GUICtrlListView_GetItem($List1, $i)
				If (IsArray($aItemAttrib) and BitAND($aItemAttrib[0], 12)) Then
						ClipPut(_GUICtrlListView_GetItemText($List1,$i))
					ExitLoop
				EndIf
			Next
	    Case $kilepes
			IniDelete("data.ini","job")
			inimentes()
			ExitLoop
		Case $mentes
			inimentes()
    EndSwitch
 WEnd
 _GUICtrlListView_UnRegisterSortCallBack($List1)
 _GUICtrlListView_UnRegisterSortCallBack($List2)

 Func _WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)

	If Not IsHWnd($List1) Then $hWndList1 = GUICtrlGetHandle($List1)
	If Not IsHWnd($List2) Then $hWndList2 = GUICtrlGetHandle($List2)

    Local $tStruct = DllStructCreate($tagNMHDR, $lParam)
	if @error then ConsoleWrite(@error)
    Switch DllStructGetData($tStruct, "Code")
        Case $NM_DBLCLK
            Switch DllStructGetData($tStruct, "hWndFrom")
				Case $hWndList1
					For $i = 0 to _GUICtrlListView_GetItemCount($List1)
						Local $aItemAttrib = _GUICtrlListView_GetItem($List1, $i)
						If (IsArray($aItemAttrib) and BitAND($aItemAttrib[0], 12)) Then
								$megj = InputBox("Megjegyzés","Ide írd a megjegyzést, majd ENTER")
								_GUICtrlListView_AddSubItem($List1,$i,$megj,8)
							ExitLoop
						EndIf
					Next
			EndSwitch
    EndSwitch

EndFunc   ;==>_WM_NOTIFY
