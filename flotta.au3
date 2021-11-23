#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#include <Array.au3>
#include <GUIConstantsEx.au3>
#include <GUIListview.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <GuiComboBox.au3>
#include <ButtonConstants.au3>
#include <ListViewConstants.au3>
#include <ComboConstants.au3>
#include <StaticConstants.au3>
#include <AutoItConstants.au3>
#include <StructureConstants.au3>
#include <String.au3>
#include <File.au3>
#include <Excel.au3>
#include <ColorConstants.au3>
#include <DateTimeConstants.au3>
#include <GuiEdit.au3>
#include <EditConstants.au3>
#include <WinAPI.au3>
#include <graphgdiplus.au3>
#include <WinAPISysWin.au3>
#include <Date.au3>

Global $vavoaddForm = 999, $jarmuaddForm = 999, $jarmuadatForm = 999, $array, $auto_L, $save_B, $a, $combo, $b, $marka_I, $modell_I, $tipus_I, $Date1, $Date2, $form_graph
Global $Icon1, $vevokod_I, $vevoadatForm, $vevo_history_L, $evjarat_Combo, $sebvalto_Combo, $forghely_D, $kovszervkm_I, $kovszerv_D, $form_settings, $seged
Global $updatescript = "updatescript.cmd", $fel_B, $le_B, $sorrend_L, $kivett_L, $bal_B, $jobb_B,$vevo_Combo, $auto_history_L
Const $headers = " # | Cégnév | Vevõkód | Rendszám | Márka | Modell | Típus | Évjárat | Sebváltó | KM állás | KM dátum | Szerz kezd | Szerz vég | Éves futtelj | Forghely dátum | Köv. szerviz (km) | Köv. szerviz (idõ) | Számla kiáll dátuma | Számla fiz dátuma | Havidíj | Extrák  | Adat dátum"
_FileReadToArray("C:\Users\kormoczi.botond\Desktop\teszt.csv",$array,0,",")
;~ if $array[UBound($array)-1][0] = "" then _ArrayDelete($array,UBound($array)-1)
if @error = 3 Then
	MsgBox(0,"","A CSV file nem jó, valamelyik sora nem annyi dimenzió mint a többi, javítsd!")
	Exit
EndIf
;~ _ArrayDisplay($array)
if IniRead("flotta.ini","mon","mon","hiba") <> @MON Then
	For $i = 0 to UBound($array)-1
		$array[$i][18] = ""
	Next
	IniWrite("flotta.ini","mon","mon",@MON)
EndIf
$array_nezet = IniReadSection("flotta.ini","sorrend")
;~ _ArrayDisplay($array_nezet)

#Region foForm
$foForm = GUICreate("Flottakezelő", 1100, 400, 147, 65,BitOR($WS_MAXIMIZEBOX,$WS_SIZEBOX,$WS_SYSMENU))
$vevo_L = GUICtrlCreateListView("Cégnév | Vevőkód", 20, 20, 240, 290 )
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKWIDTH)
_GUICtrlListView_SetColumnWidth(-1,0,190)
for $i = 0 to UBound($array,1)-1
	If ControlListView($foForm, "", $vevo_L, "FindItem", $array[$i][1]) > -1 or $array[$i][1] = "" Then ContinueLoop
	GUICtrlCreateListViewItem($array[$i][1]&"|"&$array[$i][2],$vevo_L)
Next
$ossz_B = GUICtrlCreateButton("All",310,0,30,18)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKSIZE)
$auto_L = GUICtrlCreateListView($headers,280,20,800,290,-1)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP)
Call("frissit",$auto_L)
$vevoadd_B = GUICtrlCreateButton("+", 20, 0, 25, 18)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKSIZE)
$autoadd_B = GUICtrlCreateButton("+", 280, 0, 25, 18)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKSIZE)
$settings_B = GUICtrlCreateButton("Settings",1010,0,70,18)
GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKSIZE + $GUI_DOCKLEFT)
$km_L = GUICtrlCreateLabel("KM:",600,320,30,25)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKSIZE)
$km_I = GUICtrlCreateInput("",640,320,50,25)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKSIZE)
$km_datum_L = GUICtrlCreateLabel("Adat dátum:",700,320,60,25)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKSIZE)
$km_datum_D = GUICtrlCreateDate("",770,320,120,25,$DTS_SHORTDATEFORMAT)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKSIZE)
$kmfrissit_B = GUICtrlCreateButton("Frissít",910,320,80,25)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKSIZE)
;~ $fajlagosfutas = GUICtrlCreateLabel("Fajlagos futás:",100,320,70,25)
;~ $fajlagosfutas_L =GUICtrlCreateLabel("",180,320,30,25)
$nezet_C = GUICtrlCreateCheckbox("Bővebb nézet",800,0,100,18)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKSIZE)
GUICtrlSetState($nezet_C,$GUI_CHECKED)
for $i = 1 to UBound($array_nezet)-1
	$seged &= StringSplit($array_nezet[$i][0],"_")[1] & "|"
Next
$seged = StringtrimRight($seged,1)
lista_oszlop_nezet($auto_L,"egyéni")
#EndRegion ### END Koda GUI section ###

#Region vavoaddForm
$vavoaddForm = GUICreate("Új vevő", 240, 120, -1, -1)
$vevonev_I = GUICtrlCreateInput("", 90, 24, 130, 21)
$Label1 = GUICtrlCreateLabel("Vevőnév:", 20, 24, 50, 21)
$save_B = GUICtrlCreateButton("Mentés", 20, 69, 60, 21)
#EndRegion ### END Koda GUI section ###

#Region jarmuaddForm
$jarmuaddForm = GUICreate("Új jármű", 657, 430, 485, 229)
$rendszam_I = GUICtrlCreateInput("", 208, 24, 121, 21)
$save_B = GUICtrlCreateButton("Save", 224, 256, 75, 25)
#EndRegion ### END Koda GUI section ###

GUISetState(@SW_SHOW,$foForm)
GUIRegisterMsg($WM_NOTIFY, "_WM_NOTIFY")


_GUICtrlListView_RegisterSortCallBack($vevo_L)
_GUICtrlListView_RegisterSortCallBack($auto_L)
_GUICtrlListView_SortItems($vevo_L,0)
While 1
	$nMsg = GUIGetMsg(1)
	Switch $nMsg[1]
		Case $foForm
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
;~ 					_ArrayDisplay($array)
					ExitLoop
				Case $vevoadd_B
					vavoaddForm()
				Case $autoadd_B
					jarmuaddForm()
				Case $vevo_L
					_GUICtrlListView_SortItems($vevo_L, GUICtrlGetState($vevo_L))
				Case $auto_L
					_GUICtrlListView_SortItems($auto_L, GUICtrlGetState($auto_L))
				Case $ossz_B
					_GUICtrlListView_DeleteAllItems($auto_L)
					frissit($auto_L)
				Case $kmfrissit_B
					if _GUICtrlListView_GetSelectedIndices($auto_L,True)[0] <> 0 Then
						$i =_GUICtrlListView_GetItemText($auto_L,_GUICtrlListView_GetSelectedIndices($auto_L,True)[1])-1
						ConsoleWrite($array[$i][6] & @CRLF)
						if Int(GUICtrlRead($km_I))>Int($array[$i][6]) Then
							$b = _ArrayAdd($array,_ArrayExtract($array,$i,$i))
							$array[$b][0] = UBound($array)
							$array[$b][6] = GUICtrlRead($km_I)
							$array[$b][7] = GUICtrlRead($km_datum_D)
							frissit($auto_L)
						EndIf
					EndIf
				Case $nezet_C
					frissit()
				Case $settings_B
					settingsForm()
			EndSwitch
		Case $vavoaddForm
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					GUIDelete($vavoaddForm)
				Case $save_B
					if GUICtrlRead($vevokod_I) = "" Then
						MsgBox(0,"","Vevőkód megadás kötelező!")
						_ShakeWindow()
					ElseIf _ArraySearch($array,GUICtrlRead($vevokod_I),0,0,0,0,1,2) <> -1 Then
						MsgBox(0,"","A vevőkód már használatban van!")
						GUICtrlSetData($vevokod_I,"")
						_ShakeWindow()
					ElseIf GUICtrlRead($vevonev_I) = "" Then
						MsgBox(0,"","Vevőnév megadása kötelező!")
						_ShakeWindow()
					Else
						_ArrayAdd($array,UBound($array)+1&"|"&GUICtrlRead($vevonev_I)&"|"&GUICtrlRead($vevokod_I))
						GUICtrlCreateListViewItem(GUICtrlRead($vevonev_I)&"|"&GUICtrlRead($vevokod_I),$vevo_L)
						_GUICtrlListView_SortItems($vevo_L,0)
						_GUICtrlListView_SortItems($vevo_L,0)
						GUIDelete($vavoaddForm)
					EndIf
			EndSwitch
		Case $vevoadatForm
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					GUIDelete($vevoadatForm)
				Case $save_B
					if _GUICtrlListView_GetItemText($vevo_L,_GUICtrlListView_GetSelectedIndices($vevo_L,True)[1]) <> GUICtrlRead($vevonev_I) Then
						ConsoleWrite(_GUICtrlListView_GetItemCount($vevo_history_L) & @CRLF)
						for $i = 1 to _GUICtrlListView_GetItemCount($vevo_history_L)
							$array[_GUICtrlListView_GetItemText($vevo_history_L,$i)][1] = GUICtrlRead($vevonev_I)
						Next
					EndIf
					If _GUICtrlListView_GetItemText($vevo_L,_GUICtrlListView_GetSelectedIndices($vevo_L,True)[1],1) <> GUICtrlRead($vevokod_I) Then
						for $i = 0 to _GUICtrlListView_GetItemCount($vevo_history_L)
							$array[_GUICtrlListView_GetItemText($vevo_history_L,$i)][2] = GUICtrlRead($vevokod_I)
						Next
					EndIf
					GUIDelete($vevoadatForm)
			EndSwitch
		Case $jarmuaddForm
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					GUIDelete($jarmuaddForm)
				Case $save_B
					if GUICtrlRead($rendszam_I) = "" or StringLen(GUICtrlRead($rendszam_I)) <> 6 Then
						MsgBox(0,"","Rendszám hiányzik, vagy helytelen formátumu!")
						_ShakeWindow()
						GUICtrlSetData($rendszam_I,"")
					Else
;~ 						itt rendbe kell rakni!
						_ArrayAdd($array,UBound($array)+1&"|"&"---"&"|"&""&"|"&StringUpper(GUICtrlRead($rendszam_I))&"|"&GUICtrlRead($marka_I)&"|"&GUICtrlRead($modell_I)&"|"&GUICtrlRead($tipus_I)&"|"&GUICtrlRead($evjarat_Combo)&"|"&GUICtrlRead($sebvalto_Combo)&"|"&GUICtrlRead($km_I)&"|"&GUICtrlRead($km_datum_D)&"|"&""&"|"&""&"|"&""&"|"&""&"|"&GUICtrlRead($kovszervkm_I)&"|"&GUICtrlRead($kovszerv_D)&"|"&""&"|"&""&"|"&""&"|"&""&_Now())
						GUIDelete($jarmuaddForm)
					EndIf
			EndSwitch
		Case $jarmuadatForm
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					GUIDelete($jarmuadatForm)
				Case $save_B
					$b = _ArrayAdd($array,_ArrayExtract($array,$a,$a))
					$array[$b][0] = UBound($array)
					$array[$b][1] = GUICtrlRead($vevo_Combo)
					$array[$b][3] = GUICtrlRead($rendszam_I)
					$array[$b][4] = GUICtrlRead($marka_I)
					$array[$b][5] = GUICtrlRead($modell_I)
					$array[$b][6] = GUICtrlRead($tipus_I)
					$array[$b][7] = GUICtrlRead($evjarat_Combo)
					$array[$b][8] = GUICtrlRead($sebvalto_Combo)
					$array[$b][15] = GUICtrlRead($kovszervkm_I)
					$array[$b][16] = GUICtrlRead($kovszerv_D)
					$array[$b][14] = GUICtrlRead($forghely_D)
					$array[$b][21] = _Now()
;~ 					$array[$b][9] = GUICtrlRead($Date2)
					GUIDelete($jarmuadatForm)
					Call("frissit",$auto_history_L)
				Case $Icon1
					graph_form()
			EndSwitch
		Case $form_graph
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					GUIDelete($form_graph)
			EndSwitch
		Case $form_settings
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					$array_nezet_uj = _GUICtrlListView_CreateArray($sorrend_L,"|")
					ReDim $array_nezet_uj[UBound($array_nezet_uj)][UBound($array_nezet_uj,2)+1]
					for $i = 1 to UBound($array_nezet_uj)-1
						$array_nezet_uj[$i][1] = 1
					Next
					$array_nezet_uj_K = _GUICtrlListView_CreateArray($kivett_L,"|")
					ReDim $array_nezet_uj_K[UBound($array_nezet_uj_K)][UBound($array_nezet_uj_K,2)+1]
					for $i = 1 to UBound($array_nezet_uj_K)-1
						$array_nezet_uj_K[$i][1] = 0
					Next
					_ArrayDelete($array_nezet_uj_K,0)
					_ArrayAdd($array_nezet_uj,$array_nezet_uj_K)
;~ 					_ArrayDisplay($array_nezet_uj)
					IniWriteSection("flotta.ini","sorrend",$array_nezet_uj)
					$array_nezet = IniReadSection("flotta.ini","sorrend")
					$seged = ""
					for $i = 1 to UBound($array_nezet)-1
						$seged &= StringSplit($array_nezet[$i][0],"_")[1] & "|"
					Next
					$seged = StringtrimRight($seged,1)
					lista_oszlop_nezet($auto_L,"egyéni")
					GUIDelete($form_settings)
				Case $fel_B
					If UD($sorrend_L, 0) = -1 Then MsgBox(0, "", "Ez már a legfelső elem!")
				Case $le_B
					If UD($sorrend_L, 1) = -1 Then MsgBox(0, "", "Ez már a legalsó elem!")
				Case $jobb_B
					_GUICtrlListView_CopyItems ($sorrend_L,$kivett_L,True)
				Case $bal_B
					_GUICtrlListView_CopyItems ($kivett_L,$sorrend_L,True)
			EndSwitch
	EndSwitch

	if GUICtrlRead($nezet_C) = $GUI_unCHECKED Then
		_GUICtrlListView_HideColumn($auto_L,3)
		_GUICtrlListView_HideColumn($auto_L,6)
		_GUICtrlListView_HideColumn($auto_L,7)
		_GUICtrlListView_HideColumn($auto_L,8)
	EndIf
WEnd
_GUICtrlListView_UnRegisterSortCallBack($vevo_L)
_GUICtrlListView_UnRegisterSortCallBack($auto_L)


if _FileWriteFromArray("C:\Users\kormoczi.botond\Desktop\teszt.csv",$array,0,Default,",") = 0 Then MsgBox(0,"","Valami nem jó")

Func _WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)

    #forceref $hWnd, $iMsg, $wParam
    ; Create structure
    Local $tStruct = DllStructCreate("hwnd hWndFrom;uint_ptr IDFrom;int Code", $lParam)
    Local $cCID = DllStructGetData($tStruct, "IDFrom")
    Local $iCode = DllStructGetData($tStruct, "Code")

    If $cCID = $vevo_L Then
        ; Check action
        Switch $iCode
            Case $NM_CLICK
				$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
				if DllStructGetData($tInfo, "Index") <> -1 Then
					_GUICtrlListView_DeleteAllItems($auto_L)
					for $i = 0 to UBound($array,1)-1
						If $array[$i][3] = "" then ContinueLoop
						if $array[$i][1] = _GUICtrlListView_GetItemText($vevo_L,_GUICtrlListView_GetSelectedIndices($vevo_L,True)[1]) and _ArraySearch($array,$array[$i][3],0,0,0,0,0) = $i Then
							If ControlListView($foForm, "", $auto_L, "FindItem", $array[$i][3],1) > -1 Then _GUICtrlListView_DeleteItem($auto_L,ControlListView($foForm, "", $auto_L, "FindItem", $array[$i][3],1))
								GUICtrlCreateListViewItem($array[$i][0]&"|"&$array[$i][1]&"|"&$array[$i][2]&"|"&$array[$i][3]&"|"&$array[$i][4]&"|"&$array[$i][5]&"|"&$array[$i][6]&"|"&$array[$i][7]&"|"&$array[$i][8]&"|"&$array[$i][9]&"|"&$array[$i][10]&"|"&$array[$i][11]&"|"&$array[$i][12]&"|"&$array[$i][13]&"|"&$array[$i][14]&"|"&$array[$i][15]&"|"&$array[$i][16]&"|"&$array[$i][17]&"|"&$array[$i][18]&"|"&$array[$i][19]&"|"&$array[$i][20]&"|"&$array[$i][21],$auto_L)
						EndIf
					Next
				EndIf
			Case $NM_DBLCLK
				$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
				if DllStructGetData($tInfo, "Index") <> -1 Then
					vevoadatForm()
				EndIf
        EndSwitch
	ElseIf $cCID = $auto_L Then
		Switch $iCode
			Case $NM_DBLCLK
				$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
				if DllStructGetData($tInfo, "Index") <> -1 Then
					jarmuadatForm()
				EndIf
			Case $NM_CLICK
				$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
				if DllStructGetData($tInfo, "Index") <> -1 Then
					GUICtrlSetData($km_I,_GUICtrlListView_GetItemText($auto_L,_GUICtrlListView_GetSelectedIndices($auto_L,True)[1],5))
				EndIf
		EndSwitch
    EndIf


EndFunc

Func vevoadatForm()
	$vevoadatForm = GUICreate("Vevő adatok", 863, 438, -1, -1 )
	$vevo_history_L = GUICtrlCreateListView("#|Vevőnév|Vevőkód", 20, 20, 820, 305)
	for $i = 0 to UBound($array)-1
		if $array[$i][1] =  _GUICtrlListView_GetItemText($vevo_L,_GUICtrlListView_GetSelectedIndices($vevo_L,True)[1]) Then
			GUICtrlCreateListViewItem($array[$i][0]&"|"&$array[$i][1]&"|"&$array[$i][2],$vevo_history_L)
		EndIf
	Next
	$label1 = GUICtrlCreateLabel("Vevőnév:", 28, 342, 62, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$label2 = GUICtrlCreateLabel("Vevőkód:", 28, 382, 68, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$vevonev_I = GUICtrlCreateInput(_GUICtrlListView_GetItemText($vevo_L,_GUICtrlListView_GetSelectedIndices($vevo_L,True)[1],0), 101, 342, 148, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$save_B = GUICtrlCreateButton("Mentés", 328, 379, 65, 25)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$vevokod_I = GUICtrlCreateInput(_GUICtrlListView_GetItemText($vevo_L,_GUICtrlListView_GetSelectedIndices($vevo_L,True)[1],1), 101, 382, 148, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	GUISetState(@SW_SHOW)
EndFunc

Func vavoaddForm()
	$vavoaddForm = GUICreate("Új vevő", 240, 160, -1, -1)
	$vevonev_I = GUICtrlCreateInput("", 90, 24, 130, 21)
	$Label1 = GUICtrlCreateLabel("Vevőnév:", 20, 24, 50, 21)
	$vevokod_I = GUICtrlCreateInput("", 90, 65, 130, 21)
	$Label2 = GUICtrlCreateLabel("Vevőkód:", 20, 65, 50, 21)
	$save_B = GUICtrlCreateButton("Mentés", 20, 110, 60, 21)
	GUISetState(@SW_SHOW)
EndFunc

Func jarmuaddForm()
	$jarmuaddForm = GUICreate("Új jármű", 508, 336, -1, -1)
	$Label6 = GUICtrlCreateLabel("Rendszám:", 20, 30, 76, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$rendszam_I = GUICtrlCreateInput("", 101, 30, 100, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$marka_I = GUICtrlCreateInput("", 101, 70, 100, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$Label1 = GUICtrlCreateLabel("Márka:", 20, 70, 76, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$Label2 = GUICtrlCreateLabel("Modell:", 20, 110, 76, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$Label3 = GUICtrlCreateLabel("Típus:", 20, 150, 76, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$modell_I = GUICtrlCreateInput("", 101, 110, 100, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$tipus_I = GUICtrlCreateInput("", 101, 150, 100, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$Label4 = GUICtrlCreateLabel("Évjárat:", 20, 190, 52, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$evjarat_Combo = GUICtrlCreateCombo("", 101, 190, 64, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	_GUICtrlComboBox_AddString($evjarat_Combo,@YEAR)
	_GUICtrlComboBox_AddString($evjarat_Combo,@YEAR-1)
	_GUICtrlComboBox_AddString($evjarat_Combo,@YEAR-2)
	_GUICtrlComboBox_AddString($evjarat_Combo,@YEAR-3)
	_GUICtrlComboBox_AddString($evjarat_Combo,@YEAR-4)
	_GUICtrlComboBox_AddString($evjarat_Combo,@YEAR-5)
	$Label5 = GUICtrlCreateLabel("Sebváltó:", 20, 230, 68, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$sebvalto_Combo = GUICtrlCreateCombo("", 101, 230, 40, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	_GUICtrlComboBox_AddString($sebvalto_Combo,"A")
	_GUICtrlComboBox_AddString($sebvalto_Combo,"M")
	$Label12 = GUICtrlCreateLabel("KM állás:",268,30,108,20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$km_I = GUICtrlCreateInput("",381,30,68,24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$Label32 = GUICtrlCreateLabel("KM dátum:",268,70,108,20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$km_datum_D = GUICtrlCreateDate(_NowDate, 381, 70, 80, 24, 0)
	$Label9 = GUICtrlCreateLabel("Köv. szerviz (km):", 268, 110, 108, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$kovszervkm_I = GUICtrlCreateInput("", 381, 110, 68, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$Label9 = GUICtrlCreateLabel("Köv. szerviz (idő):", 268, 150, 108, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$kovszerv_D = GUICtrlCreateDate(_NowDate, 381, 150, 80, 24, 0)

	$save_B = GUICtrlCreateButton("Mentés", 328, 275, 65, 25)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")

	GUISetState(@SW_SHOW)
EndFunc

Func jarmuadatForm()
	$jarmuadatForm = GUICreate("Jármű adatok",863, 550,-1,-1)
	$auto_history_L = GUICtrlCreateListView($headers,20, 20, 820,305)
	for $i = 0 to UBound($array)-1
		if $array[$i][3] =  _GUICtrlListView_GetItemText($auto_L,_GUICtrlListView_GetSelectedIndices($auto_L,True)[1],3) Then
			GUICtrlCreateListViewItem($array[$i][0]&"|"&$array[$i][1]&"|"&$array[$i][2]&"|"&$array[$i][3]&"|"&$array[$i][4]&"|"&$array[$i][5]&"|"&$array[$i][6]&"|"&$array[$i][7]&"|"&$array[$i][8]&"|"&$array[$i][9]&"|"&$array[$i][10]&"|"&$array[$i][11]&"|"&$array[$i][12]&"|"&$array[$i][13]&"|"&$array[$i][14]&"|"&$array[$i][15]&"|"&$array[$i][16]&"|"&$array[$i][17]&"|"&$array[$i][18]&"|"&$array[$i][19]&"|"&$array[$i][20]&"|"&$array[$i][21],$auto_history_L)
			$a = $i
		EndIf
	Next
;~ 	_GUICtrlListView_HideColumn($auto_history_L,0)
	$Vevo_label = GUICtrlCreateLabel("Vevő:", 28, 342, 46, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$vevo_Combo = GUICtrlCreateCombo($array[$a][1], 87, 342, 160, 25)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	for $i = 0 to _GUICtrlListView_GetItemCount($vevo_L)-1
		if _GUICtrlListView_GetItemText($vevo_L,$i) = $array[$a][1] Then ContinueLoop
		_GUICtrlComboBox_AddString($vevo_Combo,_GUICtrlListView_GetItemText($vevo_L,$i))
	Next
	$rendszam_label = GUICtrlCreateLabel("Rendszám:", 28, 382, 76, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$rendszam_I = GUICtrlCreateInput($array[$a][3], 109, 382, 100, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$Label1 = GUICtrlCreateLabel("Márka:", 28, 422, 76, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$Label2 = GUICtrlCreateLabel("Modell:", 28, 462, 76, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$Label3 = GUICtrlCreateLabel("Típus:", 28, 502, 76, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$marka_I = GUICtrlCreateInput($array[$a][4], 109, 422, 100, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$modell_I = GUICtrlCreateInput($array[$a][5], 109, 462, 100, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$tipus_I = GUICtrlCreateInput($array[$a][6], 109, 502, 100, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$evjarat_Combo = GUICtrlCreateCombo($array[$a][7], 351, 342, 64, 25)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$sebvalto_Combo = GUICtrlCreateCombo($array[$a][8], 351, 382, 40, 25)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$kovszervkm_I = GUICtrlCreateInput($array[$a][15], 389, 422, 68, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$kovszerv_D = GUICtrlCreateDate($array[$a][16], 389, 462, 80, 24, 0)
	$Label7 = GUICtrlCreateLabel("Forg. hely dátum:", 276, 502, 108, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$forghely_D = GUICtrlCreateDate($array[$a][14], 389, 502, 80, 24, 0)
	$Label8 = GUICtrlCreateLabel("Köv. szerviz (km):", 276, 422, 108, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$Label9 = GUICtrlCreateLabel("Köv. szerviz (idő):", 276, 462, 108, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$Label4 = GUICtrlCreateLabel("Évjárat:", 276, 342, 52, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$Label5 = GUICtrlCreateLabel("Sebváltó:", 276, 382, 68, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$Icon1 = GUICtrlCreateIcon("C:\Users\kormoczi.botond\Desktop\Autoit+Scite portable\install\Icons\Icons8-Windows-8-Data-Scatter-Plot.ico", -0, 796, 340, 41, 41)
	$save_B = GUICtrlCreateButton("Mentés", 744, 491, 65, 25)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")

	GUISetState(@SW_SHOW)
EndFunc

Func graph_form()
	$form_graph = GUICreate("Futásteljesítmény grafikon - " & "",500,500,-1,-1)
	$graph = _GraphGDIPlus_Create($form_graph,40,20,400,400)
	_GraphGDIPlus_Set_RangeX($graph,0,12,12)
	_GraphGDIPlus_Set_RangeY($graph,0,12000,12)

	GUISetState(@SW_SHOW)
EndFunc

Func settingsForm()
	$form_settings = GUICreate("Settings", 400,300)
	$sorrend_L = GUICtrlCreateListView("aaaaaaaaaaaaaaa",20,20,150,260,BitOR($LVS_NOCOLUMNHEADER,$LVS_SINGLESEL))
;~ 	_GUICtrlListView_SetColumnWidth($sorrend_L,0,130)
;~ 	_GUICtrlListView_HideColumn($sorrend_L,1)
	$kivett_L = GUICtrlCreateListView("aaaaaaaaaaaaaaa",230,20,150,260,BitOR($LVS_NOCOLUMNHEADER,$LVS_SINGLESEL))
;~ 	_GUICtrlListView_SetColumnWidth($kivett_L,0,130)
;~ 	_GUICtrlListView_HideColumn($kivett_L,1)
	for $i = 1 to UBound($array_nezet)-1
		If $array_nezet[$i][1] = 1 Then
			_GUICtrlListView_AddItem($sorrend_L,$array_nezet[$i][0])
		ElseIf $array_nezet[$i][1] = 0 Then
			_GUICtrlListView_AddItem($kivett_L,$array_nezet[$i][0])
		EndIf
	Next
	$fel_B = GUICtrlCreateButton("^",180,60,20,20)
	$le_B = GUICtrlCreateButton("ˇ",180,90,20,20)
	$jobb_B = GUICtrlCreateButton(">>",210,60,20,20)
	$bal_B = GUICtrlCreateButton("<<",210,90,20,20)

	GUISetState(@SW_SHOW)
EndFunc

Func _GUICtrlListView_CreateArray($hListView, $sDelimeter = '|')
    Local $iColumnCount = _GUICtrlListView_GetColumnCount($hListView), $iDim = 0, $iItemCount = _GUICtrlListView_GetItemCount($hListView)
    If $iColumnCount < 3 Then
        $iDim = 3 - $iColumnCount
    EndIf
    If $sDelimeter = Default Then
        $sDelimeter = '|'
    EndIf

    Local $aColumns = 0, $aReturn[$iItemCount + 1][$iColumnCount]

    For $i = 0 To $iItemCount - 1
        For $j = 0 To $iColumnCount - 1
            $aReturn[$i + 1][$j] = _GUICtrlListView_GetItemText($hListView, $i, $j)
        Next
    Next
    Return SetError(Number($aReturn[0][0] = 0), 0, $aReturn)
EndFunc   ;==>_GUICtrlListView_CreateArray

Func frissit($valamely_lista)
	_GUICtrlListView_DeleteAllItems($valamely_lista)
	for $i = 0 to UBound($array,1)-1
		If $array[$i][3] = "" then ContinueLoop
		If ControlListView($foForm, "", $auto_L, "FindItem", $array[$i][3],3) > -1 Then _GUICtrlListView_DeleteItem($auto_L,ControlListView($foForm, "", $auto_L, "FindItem", $array[$i][3],3))
		GUICtrlCreateListViewItem($array[$i][0]&"|"&$array[$i][1]&"|"&$array[$i][2]&"|"&$array[$i][3]&"|"&$array[$i][4]&"|"&$array[$i][5]&"|"&$array[$i][6]&"|"&$array[$i][7]&"|"&$array[$i][8]&"|"&$array[$i][9]&"|"&$array[$i][10]&"|"&$array[$i][11]&"|"&$array[$i][12]&"|"&$array[$i][13]&"|"&$array[$i][14]&"|"&$array[$i][15]&"|"&$array[$i][16]&"|"&$array[$i][17]&"|"&$array[$i][18]&"|"&$array[$i][19]&"|"&$array[$i][20]&"|"&$array[$i][21],$valamely_lista)
	Next
EndFunc

Func listpop($adottlista)
	GUICtrlCreateListViewItem($array[$i][0]&"|"&$array[$i][1]&"|"&$array[$i][2]&"|"&$array[$i][3]&"|"&$array[$i][4]&"|"&$array[$i][5]&"|"&$array[$i][6]&"|"&$array[$i][7]&"|"&$array[$i][8]&"|"&$array[$i][9]&"|"&$array[$i][10]&"|"&$array[$i][11]&"|"&$array[$i][12]&"|"&$array[$i][13]&"|"&$array[$i][14]&"|"&$array[$i][15]&"|"&$array[$i][16]&"|"&$array[$i][17]&"|"&$array[$i][18]&"|"&$array[$i][19]&"|"&$array[$i][20]&"|"&$array[$i][21],$adottlista)
EndFunc

Func UD($iCID, $iFlag)
    Local $iCnt, $sCur,$iCur, $sNxt, $iNew = -1
    $iCur = _GUICtrlListView_GetNextItem($iCID)
    $sCur = _GUICtrlListView_GetItemText($iCID, $iCur)
    $iCnt = _GUICtrlListView_GetItemCount($iCID)
    If $iFlag And $iCur < ($iCnt - 1) Then
        $iNew = $iCur + 1
    ElseIf Not $iFlag And $iCur > 0 Then
        $iNew = $iCur - 1
    EndIf
    If $iNew = -1 Then Return $iNew
    $sNxt = _GUICtrlListView_GetItemText($iCID, $iNew)
    _GUICtrlListView_SetItemText($iCID, $iNew, $sCur)
    _GUICtrlListView_SetItemText($iCID, $iCur, $sNxt)
    _GUICtrlListView_SetItemSelected($iCID, $iNew, True)
EndFunc

Func _ShakeWindow()     ;self-explanatory
	Local $Window = WinGetTitle("", ""), $ShakeAmount = 5, $Win_pos = WinGetPos($Window)
	For $i = 0 To 20
		WinMove($Window, "", $Win_pos[0], $Win_pos[1] + $ShakeAmount * Mod($i, 2))
		Sleep(10)
	Next
EndFunc   ;==>_ShakeWindow

Func lista_oszlop_nezet($lista,$nezet)
	if $nezet = "alap" Then

	ElseIf $nezet = "bő" Then

	ElseIf $nezet = "full" Then
		for $i = 0 to 21
			_GUICtrlListView_SetColumnWidth($lista,$i,$LVSCW_AUTOSIZE_USEHEADER)
		Next
	ElseIf $nezet = "egyéni" Then
;~ 		ConsoleWrite($seged & @CRLF)
		_GUICtrlListView_SetColumnOrder($lista,$seged)
;~ 		ConsoleWrite(_GUICtrlListView_GetColumnOrder($lista) & @CRLF)
		for $i = 1 to UBound($array_nezet)-1
			if $array_nezet[$i][1] = 1 Then
				_GUICtrlListView_SetColumnWidth($lista,Number(StringSplit($array_nezet[$i][0],"_")[1]), $LVSCW_AUTOSIZE_USEHEADER  )
			ElseIf $array_nezet[$i][1] = 0 Then
				_GUICtrlListView_HideColumn($lista,Number(StringSplit($array_nezet[$i][0],"_")[1]))
			EndIf
		Next
	EndIf
	frissit($auto_L)
EndFunc

Func UpdateCheck($script)
$CurrentVersion = FileGetVersion(@ScriptName)
$LastVersion = FileGetVersion("N:\Botond\autoit scriptek\" & $script)
If _VersionCompare($CurrentVersion,$LastVersion)= -1 and $CurrentVersion <> "0.0.0.0" Then
	FileCopy("N:\Botond\autoit scriptek\" & $script,@ScriptFullPath&".new")
	$exename = @ScriptName
	$pid = @AutoItPID
	FileWriteLine( $updatescript, "@echo off")
	FileWriteLine( $updatescript, ":loop")
	FileWriteLine( $updatescript, "tasklist /fi " & '"pid eq ' & $pid & '" | find ":" > nul') ;batch file won't continue until old autoit exe process id terminates
	FileWriteLine( $updatescript, "if errorlevel 1 (")
	FileWriteLine( $updatescript, "  ping localhost -n 2 > nul")
	FileWriteLine( $updatescript, "  goto loop")
	FileWriteLine( $updatescript, ") else (")
	FileWriteLine( $updatescript, "  goto continue")
	FileWriteLine( $updatescript, ")")
	FileWriteLine( $updatescript, ":continue")
	FileWriteLine( $updatescript, "del " & '"' & $exename & '"') ;deletes old exe
	FileWriteLine( $updatescript, "ren " & '"' & $exename & ".new " & '"'&" "& '"' & $exename & '"') ;renames new exe to the same name
	FileWriteLine( $updatescript, 'start "" ' & '"' & $exename & '"') ;launches with any parameters the old exe had
	FileWriteLine( $updatescript, "(goto) 2>nul & del ""%~f0""") ;batch file self deletes
	Run( $updatescript, @ScriptDir, @SW_HIDE) ;launch batch file in hidden mode
	Exit ;exit so batch file can continue
EndIf
EndFunc   ;==>UpdateCheck