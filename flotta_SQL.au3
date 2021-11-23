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
#include <SQLite.au3>

Global $vavoaddForm = 999, $jarmuaddForm = 999, $jarmuadatForm = 999, $array, $auto_L, $save_B, $a, $combo, $b, $marka_I, $modell_I, $tipus_I, $Date1, $Date2, $form_graph
Global $Icon1, $vevokod_I, $vevoadatForm, $vevo_history_L, $evjarat_Combo, $sebvalto_Combo, $forghely_D, $kovszervkm_I, $kovszerv_D, $form_settings, $seged,$vevo_history_array
Global $updatescript = "updatescript.cmd", $fel_B, $le_B, $sorrend_L, $kivett_L, $bal_B, $jobb_B,$vevo_Combo, $auto_history_L,$vevonev_I,$rendszam_I,$vevo_array,$auto_array
Global $kontaktsz_I,$telefon_I,$email_I,$szerz_array,$auto_history_array,$szamla_array,$szerzaddForm,$vevonev,$vevokod,$autorendszam,$autokod,$aRow2
local $hQuery,$aRow,$sMsg,$aResult,$iRows,$iColumns

$oszlopok_vevo = IniReadSection("teszt.ini","vevok")
$oszlopok_auto = IniReadSection("teszt.ini","autok")
$oszlopok_szerzodes = IniReadSection("teszt.ini","szerzodesek")
$oszlopok_szamla = IniReadSection("teszt.ini","szamlak")
global $checkbox_vevo_array[UBound($oszlopok_vevo)],$checkbox_auto_array[UBound($oszlopok_auto)],$checkbox_szerzodes_array[UBound($oszlopok_szerzodes)],$checkbox_szamla_array[UBound($oszlopok_szamla)],$input_autoadd_A[UBound($oszlopok_auto)]
Global $input_szerzadd_A[UBound($oszlopok_szerzodes)]
_SQLite_Startup()

_SQLite_Open(@DesktopDir&"\teszt.db")
SQLparancsok("autok_osszes")
SQLparancsok("vevok_osszes")
SQLparancsok("szerz_osszes")

#Region foForm
$foForm = GUICreate("Flottakezelő", 1100, 970, 147, 65,BitOR($WS_MAXIMIZEBOX,$WS_SIZEBOX,$WS_SYSMENU))

$vevo_L = GUICtrlCreateListView("", 20, 20, 480, 290,-1,BitOR($LVS_EX_HEADERDRAGDROP,$LVS_EX_FULLROWSELECT) )
	for $i=1 to $oszlopok_vevo[0][0]
		_GUICtrlListView_AddColumn(-1,$oszlopok_vevo[$i][0])
	Next
	_GUICtrlListView_AddArray($vevo_L,$vevo_array)
	for $i=0 to $oszlopok_vevo[0][0]
		if $oszlopok_vevo[$i][1] = 0 then
			_GUICtrlListView_HideColumn(-1,$i-1)
		Else
			_GUICtrlListView_SetColumnWidth($vevo_L,$i-1,$LVSCW_AUTOSIZE)
		EndIf
	Next

GUICtrlCreateGroup("",520,20,200,270)
	GUICtrlCreateLabel("Szerződések száma:",540,40,100,20)
	SQLparancsok("szerz_szamolo_all")
	$szerzszam = GUICtrlCreateLabel($aRow[0]&" db",640,40,80,20)

	GUICtrlCreateLabel("Havidíjak összege:",540,70,100,20)
	SQLparancsok("szamla_osszeg_all")
	$szamla_osszeg =  GUICtrlCreateLabel(FormatNum($aRow[0]),640,70,80,20)

	GUICtrlCreateLabel("Kiállított szlak.:",540,100,100,20)
	SQLparancsok("szamlak_havi_kisz_all")
	$szamla_kisz = GUICtrlCreateLabel($aRow[0]&" / "&GUICtrlRead($szerzszam),640,100,80,20)


GUICtrlCreateGroup("", -99, -99, 1, 1)
$auto_L = GUICtrlCreateListView("",20,330,680,290,-1,BitOR($LVS_EX_HEADERDRAGDROP,$LVS_EX_FULLROWSELECT))
	for $i=1 to $oszlopok_auto[0][0]
		_GUICtrlListView_AddColumn(-1,$oszlopok_auto[$i][0])

	Next
	_GUICtrlListView_SetColumnOrder($auto_L,IniRead("teszt.ini","a","a",""))
	GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP)
	_GUICtrlListView_AddArray($auto_L,$auto_array)
	for $i=1 to $oszlopok_auto[0][0]
		if $oszlopok_auto[$i][1] = 0 then
			_GUICtrlListView_HideColumn(-1,$i-1)
		Else
			_GUICtrlListView_SetColumnWidth($auto_L,$i-1,$LVSCW_AUTOSIZE)
		EndIf
	Next

GUICtrlCreateGroup("",720,330,350,290)
	GUICtrlCreateLabel("Szerződés kezdete:",740,350,100,20)
;~ 	SQLparancsok("szerz_egyauto_kiv")
	$szerz_kezd_L = GUICtrlCreateLabel("",840,350,100,20)

GUICtrlCreateGroup("", -99, -99, 1, 1)


;~ $kontrakt_L = GUICtrlCreateListView("",320,640,800,290,-1,BitOR($LVS_EX_HEADERDRAGDROP,$LVS_EX_FULLROWSELECT))
;~ 	for $i=1 to $oszlopok_szerzodes[0][0]
;~ 		_GUICtrlListView_AddColumn(-1,$oszlopok_szerzodes[$i][0])
;~ 		if $oszlopok_szerzodes[$i][1] = 0 then _GUICtrlListView_HideColumn(-1,$i-1)
;~ 	Next
;~ 	_GUICtrlListView_SetColumnOrder($kontrakt_L,IniRead("teszt.ini","b","b",""))
;~ 	_GUICtrlListView_AddArray($kontrakt_L,$szerz_array)

$szamla_L = GUICtrlCreateListView("",20,640,680,290,-1,BitOR($LVS_EX_HEADERDRAGDROP,$LVS_EX_FULLROWSELECT))
	for $i=1 to $oszlopok_szamla[0][0]
		_GUICtrlListView_AddColumn(-1,$oszlopok_szamla[$i][0])
		if $oszlopok_szamla[$i][1] = 0 then _GUICtrlListView_HideColumn(-1,$i-1)
	Next
	_GUICtrlListView_SetColumnOrder($szamla_L,IniRead("teszt.ini","c","c",""))

$ossz_B = GUICtrlCreateButton("All",840,60,60,25)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKSIZE)
$vevoadd_B = GUICtrlCreateButton("Új vevő", 840, 100, 60, 25)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKSIZE)
$autoadd_B = GUICtrlCreateButton("Új autó", 840, 140, 60, 25)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKSIZE)
$szerzadd_B = GUICtrlCreateButton("Új szerződés", 840, 180, 100, 25)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKSIZE)
$settings_B = GUICtrlCreateButton("Settings",1010,20,70,25)
GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKSIZE + $GUI_DOCKLEFT)




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
SQLparancsok("szamla_lejart")
	if UBound($szamla_array) > 0 Then
		$lejart_B = GUICtrlCreateButton("Lejárt számlák",840,20,100,25)
		GUICtrlSetbkColor(-1,$COLOR_RED)
		$lejart = GUICreate("Figyelem, az alábbi számlák fizetési határideje lejárt!",500,250,-1,-1)
		$szamla_lej_L = GUICtrlCreateListView("InvID|Vevő|Rendszám|Határidő|Összeg",20,20,460,200)
		_GUICtrlListView_AddArray($szamla_lej_L,$szamla_array)
		_GUICtrlListView_SetColumnWidth($szamla_lej_L,0,60)
		_GUICtrlListView_SetColumnWidth($szamla_lej_L,1,140)
		_GUICtrlListView_SetColumnWidth($szamla_lej_L,2,70)
		_GUICtrlListView_SetColumnWidth($szamla_lej_L,3,80)
		_GUICtrlListView_SetColumnWidth($szamla_lej_L,4,100)
		GUISetState(@SW_SHOW,$lejart)
	EndIf

GUIRegisterMsg($WM_NOTIFY, "_WM_NOTIFY")


_GUICtrlListView_RegisterSortCallBack($vevo_L)
_GUICtrlListView_RegisterSortCallBack($auto_L)
_GUICtrlListView_SortItems($vevo_L,1)
_GUICtrlListView_SortItems($auto_L,1)
While 1
	$nMsg = GUIGetMsg(1)
	Switch $nMsg[1]
		Case $foForm
			if _GUICtrlListView_GetSelectionMark($auto_L) = -1 and GUICtrlRead($szerz_kezd_L) <> "" Then
				GUICtrlSetData($szerz_kezd_L,"")

			EndIf
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					IniWrite("teszt.ini","a","a",_GUICtrlListView_GetColumnOrder($auto_L))
;~ 					IniWrite("teszt.ini","b","b",_GUICtrlListView_GetColumnOrder($kontrakt_L))
					IniWrite("teszt.ini","c","c",_GUICtrlListView_GetColumnOrder($szamla_L))
					ExitLoop
				Case $vevoadd_B
					vavoaddForm()
				Case $autoadd_B
					jarmuaddForm()
				Case $szerzadd_B
					szerzaddForm()
				Case $vevo_L
					_GUICtrlListView_SortItems($vevo_L, GUICtrlGetState($vevo_L))
				Case $auto_L
					_GUICtrlListView_SortItems($auto_L, GUICtrlGetState($auto_L))
				Case $ossz_B
					_GUICtrlListView_DeleteAllItems($auto_L)
					SQLparancsok("autok_osszes")
					_GUICtrlListView_AddArray($auto_L,$auto_array)
;~ 					_GUICtrlListView_DeleteAllItems($kontrakt_L)
;~ 					SQLparancsok("szerz_osszes")
;~ 					_GUICtrlListView_AddArray($kontrakt_L,$szerz_array)
					SQLparancsok("szerz_szamolo_all")
					GUICtrlSetData($szerzszam,$aRow[0]& " db")
					SQLparancsok("szamla_osszeg_all")
					GUICtrlSetData($szamla_osszeg,FormatNum($aRow[0]))
					SQLparancsok("szamlak_havi_kisz_all")
					GUICtrlSetData($szamla_kisz,$aRow[0]&" / "&GUICtrlRead($szerzszam))
				Case $settings_B
					settingsForm()
				case $lejart_B
					GUISetState(@SW_SHOW,$lejart)
			EndSwitch
		Case $vavoaddForm
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					GUIDelete($vavoaddForm)
				Case $save_B
					if GUICtrlRead($vevokod_I) = "" Then
						MsgBox(0,"","Vevőkód megadás kötelező!")
						_ShakeWindow()
					ElseIf _ArraySearch($vevo_array,GUICtrlRead($vevokod_I),0,0,0,0,1,0) <> -1 Then
						MsgBox(0,"","A vevőkód már használatban van!")
						GUICtrlSetData($vevokod_I,"")
						_ShakeWindow()
					ElseIf GUICtrlRead($vevonev_I) = "" Then
						MsgBox(0,"","Vevőnév megadása kötelező!")
						_ShakeWindow()
					Else
						$adatok ="1,"&GUICtrlRead($vevokod_I)&",'"&GUICtrlRead($vevonev_I)&"','"&GUICtrlRead($kontaktsz_I)&"','"&GUICtrlRead($telefon_I)&"','"&GUICtrlRead($email_I)&"'"
						_GUICtrlListView_DeleteAllItems($vevo_L)
						SQLparancsok("vevo_add")
						_GUICtrlListView_AddArray($vevo_L,$vevo_array)
						_GUICtrlListView_SortItems($vevo_L,1)
						_GUICtrlListView_SortItems($vevo_L,1)
						GUIDelete($vavoaddForm)
					EndIf
			EndSwitch
		Case $vevoadatForm
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					GUIDelete($vevoadatForm)
				Case $save_B
					if GUICtrlRead($vevokod_I) <> $vevo_history_array[UBound($vevo_history_array)-1][0] Or _
					GUICtrlRead($vevonev_I) <> $vevo_history_array[UBound($vevo_history_array)-1][1] or _
					GUICtrlRead($kontaktsz_I) <> $vevo_history_array[UBound($vevo_history_array)-1][2] or _
					GUICtrlRead($telefon_I) <> $vevo_history_array[UBound($vevo_history_array)-1][3] or _
					GUICtrlRead($email_I) <> $vevo_history_array[UBound($vevo_history_array)-1][4] Then
						$adatok ="1,"&GUICtrlRead($vevokod_I)&",'"&GUICtrlRead($vevonev_I)&"','"&GUICtrlRead($kontaktsz_I)&"','"&GUICtrlRead($telefon_I)&"','"&GUICtrlRead($email_I)&"'"
						_GUICtrlListView_DeleteAllItems($vevo_L)
						SQLparancsok("vevo_update")
						_GUICtrlListView_AddArray($vevo_L,$vevo_array)
						_GUICtrlListView_SortItems($vevo_L,1)
						_GUICtrlListView_SortItems($vevo_L,1)
					EndIf
					GUIDelete($vevoadatForm)
			EndSwitch
		Case $jarmuaddForm
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					GUIDelete($jarmuaddForm)
				Case $save_B
					if GUICtrlRead($input_autoadd_A[2]) = "" or StringLen(GUICtrlRead($input_autoadd_A[2])) <> 6 Then
						MsgBox(0,"","Rendszám hiányzik, vagy helytelen formátumú!")
						_ShakeWindow()
						GUICtrlSetData($input_autoadd_A[2],"")
					Else
						GUICtrlSetData($input_autoadd_A[2],StringUpper(GUICtrlRead($input_autoadd_A[2])))
						$adatok = "1,"
						for $i =1 to $oszlopok_auto[0][0]
							if GUICtrlRead($input_autoadd_A[$i])= "" Then
								$adatok &= "null,"
							ElseIf $oszlopok_auto[$i][0] = "Köv. szerv. (dátum)" or $oszlopok_auto[$i][0] = "Első forg. hely." Then
								$adatok &= "'"&StringTrimRight(StringReplace(GUICtrlRead($input_autoadd_A[$i]),". ","/"),1)&"'"&","
							Else
								$adatok &= "'"&GUICtrlRead($input_autoadd_A[$i])&"'"&","
							EndIf
						Next
						$adatok = StringTrimRight($adatok,1)
						_GUICtrlListView_DeleteAllItems($auto_L)
						SQLparancsok("auto_add")
						_GUICtrlListView_AddArray($auto_L,$auto_array)
						_GUICtrlListView_SortItems($auto_L,1)
						_GUICtrlListView_SortItems($auto_L,1)
						GUIDelete($jarmuaddForm)
					EndIf
			EndSwitch
		Case $jarmuadatForm
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					GUIDelete($jarmuadatForm)
				Case $save_B
					$v=0
					For $i = 2 To $oszlopok_auto[0][0]
						if $oszlopok_auto[$i][0] = "Köv. szerv. (dátum)" or $oszlopok_auto[$i][0] = "Első forg. hely." Then
							if StringTrimRight(StringReplace(GUICtrlRead($input_autoadd_A[$i]),". ","/"),1) <> $auto_history_array[UBound($auto_history_array)-1][$i-1] Then $v=1
						Else
							if GUICtrlRead($input_autoadd_A[$i]) <> $auto_history_array[UBound($auto_history_array)-1][$i-1] Then $v=1
						EndIf
					Next
					if $v = 1 Then
						$adatok = "1,"&$input_autoadd_A[1]&","
						for $i =2 to $oszlopok_auto[0][0]
							if GUICtrlRead($input_autoadd_A[$i])= "" Then
								$adatok &= "null,"
							ElseIf $oszlopok_auto[$i][0] = "Köv. szerv. (dátum)" or $oszlopok_auto[$i][0] = "Első forg. hely." Then
								$adatok &= "'"&StringTrimRight(StringReplace(GUICtrlRead($input_autoadd_A[$i]),". ","/"),1)&"'"&","
							Else
								$adatok &= "'"&GUICtrlRead($input_autoadd_A[$i])&"'"&","
							EndIf
						Next
						$adatok = StringTrimRight($adatok,1)
						SQLparancsok("auto_update")
						_GUICtrlListView_AddArray($auto_L,$auto_array)
						_GUICtrlListView_SortItems($auto_L,1)
						_GUICtrlListView_SortItems($auto_L,1)
					EndIf
					GUIDelete($jarmuadatForm)
			EndSwitch
		case $szerzaddForm
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					GUIDelete($szerzaddForm)
			EndSwitch
		Case $form_graph
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					GUIDelete($form_graph)
			EndSwitch
		Case $form_settings
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					for $i = 1 to $oszlopok_auto[0][0]
						if GUICtrlRead($checkbox_auto_array[$i])=$GUI_CHECKED then
							IniWrite("teszt.ini","autok",$oszlopok_auto[$i][0],1)
							_GUICtrlListView_SetColumnWidth($auto_L,$i-1,$LVSCW_AUTOSIZE)
						Else
							IniWrite("teszt.ini","autok",$oszlopok_auto[$i][0],0)
							_GUICtrlListView_HideColumn($auto_L,$i-1)
						EndIf
					Next
					for $i = 1 to $oszlopok_vevo[0][0]
						if GUICtrlRead($checkbox_vevo_array[$i])=$GUI_CHECKED then
							IniWrite("teszt.ini","vevok",$oszlopok_vevo[$i][0],1)
							_GUICtrlListView_SetColumnWidth($vevo_L,$i-1,$LVSCW_AUTOSIZE)
						Else
							IniWrite("teszt.ini","vevok",$oszlopok_vevo[$i][0],0)
							_GUICtrlListView_HideColumn($vevo_L,$i-1)
						EndIf
					Next
					for $i = 1 to $oszlopok_szamla[0][0]
						if GUICtrlRead($checkbox_szamla_array[$i])=$GUI_CHECKED then
							IniWrite("teszt.ini","szamlak",$oszlopok_szamla[$i][0],1)
							_GUICtrlListView_SetColumnWidth($szamla_L,$i-1,$LVSCW_AUTOSIZE)
						Else
							IniWrite("teszt.ini","szamlak",$oszlopok_szamla[$i][0],0)
							_GUICtrlListView_HideColumn($szamla_L,$i-1)
						EndIf
					Next
					GUIDelete($form_settings)

			EndSwitch
		Case $lejart
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					GUISetState(@SW_HIDE,$lejart)
			EndSwitch
	EndSwitch
WEnd
_GUICtrlListView_UnRegisterSortCallBack($vevo_L)
_GUICtrlListView_UnRegisterSortCallBack($auto_L)

_SQLite_Close()
_SQLite_Shutdown()


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
					If _GUICtrlListView_GetItemText($vevo_L,_GUICtrlListView_GetSelectedIndices($vevo_L,True)[1],0) <> 0 Then
						$vevonev = "'"&_GUICtrlListView_GetItemText($vevo_L,_GUICtrlListView_GetSelectedIndices($vevo_L,True)[1],1)&"'"

						_GUICtrlListView_DeleteAllItems($auto_L)
						SQLparancsok("auto_egyvevo_kiv")
						_GUICtrlListView_AddArray($auto_L,$auto_array)

;~ 						_GUICtrlListView_DeleteAllItems($kontrakt_L)
;~ 						SQLparancsok("szerz_egyvevo_kiv")
;~ 						_GUICtrlListView_AddArray($kontrakt_L,$szerz_array)

;~ 						_GUICtrlListView_DeleteAllItems($szamla_L)
;~ 						SQLparancsok("szamla_egyvevo_kiv")
;~ 						_GUICtrlListView_AddArray($szamla_L,$szamla_array)

						SQLparancsok("szerz_szamolo_egy")
						GUICtrlSetData($szerzszam,$aRow[0]& " db")

						SQLparancsok("szamla_osszeg_egy")
						GUICtrlSetData($szamla_osszeg,FormatNum($aRow[0]))

						SQLparancsok("szamlak_havi_kisz_egy")
						GUICtrlSetData($szamla_kisz,$aRow[0]&" / "& GUICtrlRead($szerzszam))
					Else
						_GUICtrlListView_DeleteAllItems($auto_L)
						SQLparancsok("auto_szabadok")
						_GUICtrlListView_AddArray($auto_L,$auto_array)
;~ 						_GUICtrlListView_DeleteAllItems($kontrakt_L)
						GUICtrlSetData($szerzszam,"---")
						GUICtrlSetData($szamla_osszeg,"---")
						GUICtrlSetData($szamla_kisz,"---")
					EndIf
				EndIf
			Case $NM_DBLCLK
				$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
				if DllStructGetData($tInfo, "Index") <> -1 Then
					$vevokod = _GUICtrlListView_GetItemText($vevo_L,_GUICtrlListView_GetSelectedIndices($vevo_L,True)[1],0)
					SQLparancsok("vevo_history")
					vevoadatForm()
					_GUICtrlListView_DeleteAllItems($vevo_history_L)
					_GUICtrlListView_AddArray($vevo_history_L,$vevo_history_array)
				EndIf
        EndSwitch
	ElseIf $cCID = $auto_L Then
		Switch $iCode
			Case $NM_CLICK
				$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
				if DllStructGetData($tInfo, "Index") <> -1 Then
					$autorendszam = "'"&_GUICtrlListView_GetItemText($auto_L,_GUICtrlListView_GetSelectedIndices($auto_L,True)[1],1)&"'"
					_GUICtrlListView_DeleteAllItems($szamla_L)
					SQLparancsok("szerz_egyauto_kiv")
;~ 					ConsoleWrite($aRow & @CRLF)
;~ 					_ArrayDisplay($aRow)
					if UBound($aRow2) >= 2 Then
						GUICtrlSetData($szerz_kezd_L,$aRow2[4])
					Else
						GUICtrlSetData($szerz_kezd_L,"")
					EndIf
					SQLparancsok("szamla_egyauto_kiv")
					_GUICtrlListView_AddArray($szamla_L,$szamla_array)
					for $i = 1 to $oszlopok_szamla[0][0]
						_GUICtrlListView_SetColumnWidth($szamla_L,$i-1,$LVSCW_AUTOSIZE_USEHEADER )
					Next
				EndIf
			Case $NM_DBLCLK
				$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
				if DllStructGetData($tInfo, "Index") <> -1 Then
					$autorendszam = "'"&_GUICtrlListView_GetItemText($auto_L,_GUICtrlListView_GetSelectedIndices($auto_L,True)[1],1)&"'"
					SQLparancsok("auto_history")
					jarmuadatForm()
					_GUICtrlListView_DeleteAllItems($auto_history_L)
					_GUICtrlListView_AddArray($auto_history_L,$auto_history_array)
				EndIf
		EndSwitch
;~ 	ElseIf $cCID = $kontrakt_L Then
;~ 		Switch $iCode
;~ 			Case $NM_CLICK
;~ 				$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
;~ 				if DllStructGetData($tInfo, "Index") <> -1 Then
;~ 					$vevokod = _GUICtrlListView_GetItemText($vevo_L,_GUICtrlListView_GetSelectedIndices($vevo_L,True)[1],1)

;~ 				EndIf
;~ 			case $NM_DBLCLK
;~ 				$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
;~ 				if DllStructGetData($tInfo, "Index") <> -1 Then
;~ 					szerzodesadatForm()
;~ 				EndIf
;~ 		EndSwitch
    EndIf


EndFunc

Func vevoadatForm()
	$vevoadatForm = GUICreate("Vevő adatok", 863, 438, -1, -1 )
	$vevo_history_L = GUICtrlCreateListView("Vevőkód|Vevőnév|Kontaktszemély|Telefon|Email", 20, 20, 820, 305)
	$label1 = GUICtrlCreateLabel("Vevőnév:", 28, 342, 62, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$label3 = GUICtrlCreateLabel("Kontaktszemély:", 270, 342, 100, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$label2 = GUICtrlCreateLabel("Vevőkód:", 28, 382, 68, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$label4 = GUICtrlCreateLabel("Telefon:", 270, 382, 100, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$label5 = GUICtrlCreateLabel("Email:", 540, 342, 60, 20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$vevonev_I = GUICtrlCreateInput($vevo_history_array[UBound($vevo_history_array)-1][1], 101, 342, 148, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$kontaktsz_I = GUICtrlCreateInput($vevo_history_array[UBound($vevo_history_array)-1][2], 370, 342, 148, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$email_I = GUICtrlCreateInput($vevo_history_array[UBound($vevo_history_array)-1][4], 640, 342, 148, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$telefon_I = GUICtrlCreateInput($vevo_history_array[UBound($vevo_history_array)-1][3], 370, 382, 148, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$save_B = GUICtrlCreateButton("Mentés", 700, 379, 65, 25)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$vevokod_I = GUICtrlCreateInput($vevo_history_array[UBound($vevo_history_array)-1][0], 101, 382, 148, 24)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	GUISetState(@SW_SHOW)
EndFunc

Func vavoaddForm()
	$vavoaddForm = GUICreate("Új vevő", 240, 250, -1, -1)
	$vevonev_I = GUICtrlCreateInput("", 90, 25, 130, 20)
	$Label1 = GUICtrlCreateLabel("Vevőnév:", 20, 25, 50, 20)
	$vevokod_I = GUICtrlCreateInput("", 90, 65, 130, 20)
	$Label2 = GUICtrlCreateLabel("Vevőkód:", 20, 65, 50, 20)
	$kontaktsz_I = GUICtrlCreateInput("", 90, 105, 130, 20)
	$Label3 = GUICtrlCreateLabel("Kontakszemély:", 20, 105, 50, 20)
	$telefon_I = GUICtrlCreateInput("", 90, 145, 130, 20)
	$Label4 = GUICtrlCreateLabel("Telefon:", 20, 145, 50, 20)
	$email_I = GUICtrlCreateInput("", 90, 185, 130, 20)
	$Label3 = GUICtrlCreateLabel("Email:", 20, 185, 50, 20)

	$save_B = GUICtrlCreateButton("Mentés", 20, 225, 60, 20)

	GUISetState(@SW_SHOW)
EndFunc

Func jarmuaddForm()
	$jarmuaddForm = GUICreate("Új jármű", 400, 700, -1, -1)
	GUICtrlCreateLabel("Autókód",20,20,120,20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	_SQLite_QuerySingleRow(-1,"select max(vehiid) from vehicles",$iRows)
	$input_autoadd_A[1] = GUICtrlCreateInput($iRows[0]+1,140,20,120,20,$ES_READONLY)
	for $i= 2 to $oszlopok_auto[0][0]
		GUICtrlCreateLabel($oszlopok_auto[$i][0]&":",20,$i*40-20,120,20)
		GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
		if $oszlopok_auto[$i][0] = "Sebváltó" Then
			$input_autoadd_A[$i] = GUICtrlCreateCombo("",140,$i*40-20,120,20)
			GUICtrlSetData(-1,"A|M","A")
		ElseIf $oszlopok_auto[$i][0] = "Kategória" Then
			$input_autoadd_A[$i] = GUICtrlCreateCombo("",140,$i*40-20,120,20)
			GUICtrlSetData(-1,"Sz|H","Sz")
		ElseIf $oszlopok_auto[$i][0] = "Köv. szerv. (dátum)" or $oszlopok_auto[$i][0] ="Első forg. hely." Then
			$input_autoadd_A[$i] = GUICtrlCreateDate(_NowDate(),140,$i*40-20,120,20,$DTS_SHORTDATEFORMAT)
		ElseIf $oszlopok_auto[$i][0] = "KGFB forduló" Then
			$input_autoadd_A[$i] = GUICtrlCreateInput("",140,$i*40-20,120,20)
			_GUICtrlEdit_SetCueBanner(-1, "Formátum: MM/DD")
		Else
			$input_autoadd_A[$i] = GUICtrlCreateInput("",140,$i*40-20,120,20)
		EndIf
	Next
	$save_B = GUICtrlCreateButton("Mentés", 328, 600, 65, 25)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")

	GUISetState(@SW_SHOW)
EndFunc

Func jarmuadatForm()
	$jarmuadatForm = GUICreate("Jármű adatok",1000, 700,-1,-1)
	$auto_history_L = GUICtrlCreateListView("",280, 20, 820,305)
	$oszlopok_auto = IniReadSection("teszt.ini","autok")
	for $i=1 to $oszlopok_auto[0][0]
		_GUICtrlListView_AddColumn(-1,$oszlopok_auto[$i][0])
		if $oszlopok_auto[$i][1] = 0 then _GUICtrlListView_HideColumn(-1,$i-1)
	Next
	_GUICtrlListView_SetColumnOrder($auto_L,IniRead("teszt.ini","a","a",""))
	GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP)
	$input_autoadd_A[1] = $auto_history_array[UBound($auto_history_array)-1][0]
	for $i= 2 to $oszlopok_auto[0][0]
		GUICtrlCreateLabel($oszlopok_auto[$i][0]&":",20,$i*40-40,120,20)
		GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
		if $oszlopok_auto[$i][0] = "Sebváltó" Then
			$input_autoadd_A[$i] = GUICtrlCreateCombo($auto_history_array[UBound($auto_history_array)-1][$i-1],140,$i*40-40,120,20)
			GUICtrlSetData(-1,"A|M")
		ElseIf $oszlopok_auto[$i][0] = "Kategória" Then
			$input_autoadd_A[$i] = GUICtrlCreateCombo($auto_history_array[UBound($auto_history_array)-1][$i-1],140,$i*40-40,120,20)
			GUICtrlSetData(-1,"Sz|H")

		ElseIf $oszlopok_auto[$i][0] = "Köv. szerv. (dátum)" or $oszlopok_auto[$i][0] ="Első forg. hely."  Then
			$input_autoadd_A[$i] = GUICtrlCreateDate($auto_history_array[UBound($auto_history_array)-1][$i-1],140,$i*40-40,120,20,$DTS_SHORTDATEFORMAT)
		Else
			$input_autoadd_A[$i] = GUICtrlCreateInput($auto_history_array[UBound($auto_history_array)-1][$i-1],140,$i*40-40,120,20)
		EndIf
	Next
	$save_B = GUICtrlCreateButton("Mentés", 744, 491, 65, 25)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")

	GUISetState(@SW_SHOW)
EndFunc

func szerzodesadatForm()

EndFunc

func szerzaddForm()
	$szerzaddForm = GUICreate("Új szerződés", 400, 700, -1, -1)
	for $i= 2 to $oszlopok_szerzodes[0][0]
		GUICtrlCreateLabel($oszlopok_szerzodes[$i][0]&":",20,$i*40-20,120,20)
		GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
		if $oszlopok_szerzodes[$i][0] = "Rendszám" Then
			$input_szerzadd_A[$i] = GUICtrlCreateCombo("",140,$i*40-20,120,20)
			_SQLite_GetTable2d(-1,"select v.licno from vehicles v left JOIN (select * from contracts c where c.STATUS = 1) c on v.vehiID = c.vehiID WHERE c.vehiID is NULL;",$auto_array,$iRows,$iColumns)
			_ArrayDelete($auto_array,0)
			for $j = 0 to UBound($auto_array)-1
			_GUICtrlComboBox_AddString(-1,$auto_array[$j][0])
			Next
		ElseIf $oszlopok_szerzodes[$i][0] = "Vevőnév" Then
			$input_szerzadd_A[$i] = GUICtrlCreateCombo("",140,$i*40-20,120,20)
			_SQLite_GetTable2d(-1,"select custNAME from customers where status=1 ORDER by custNAME;",$auto_array,$iRows,$iColumns)
			_ArrayDelete($auto_array,0)
			for $j = 0 to UBound($auto_array)-1
			_GUICtrlComboBox_AddString(-1,$auto_array[$j][0])
			Next
		ElseIf $oszlopok_szerzodes[$i][0] = "Szerz. kezd." or $oszlopok_szerzodes[$i][0] = "Szerz. vége" Then
			$input_szerzadd_A[$i] = GUICtrlCreateDate(_NowDate(),140,$i*40-20,120,20,$DTS_SHORTDATEFORMAT)
		Else
			$input_szerzadd_A[$i] = GUICtrlCreateInput("",140,$i*40-20,120,20)
		EndIf
	Next
	$save_B = GUICtrlCreateButton("Mentés", 328, 600, 65, 25)
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
	$oszlopok_auto = IniReadSection("teszt.ini","autok")
	$oszlopok_vevo = IniReadSection("teszt.ini","vevok")
	$oszlopok_szamla = IniReadSection("teszt.ini","szamlak")
	$form_settings = GUICreate("Settings", 710, 840, -1, -1)
	$Group1 = GUICtrlCreateGroup("Vevők", 20, 20, 210, 800)
	for $i=1 to $oszlopok_vevo[0][0]
		$checkbox_vevo_array[$i] =  GUICtrlCreateCheckbox($oszlopok_vevo[$i][0], 40, 18+($i*38), 130, 17)
		GUICtrlSetFont(-1, 12, 400, 0, "Calibri")
		if $oszlopok_vevo[$i][1] = 1 then GUICtrlSetState(-1,1)
	Next
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$Group2 = GUICtrlCreateGroup("Autók", 250, 20, 210, 800)
	for $i=1 to $oszlopok_auto[0][0]
		$checkbox_auto_array[$i] =  GUICtrlCreateCheckbox($oszlopok_auto[$i][0], 270, 18+($i*38), 130, 17)
		GUICtrlSetFont(-1, 12, 400, 0, "Calibri")
		if $oszlopok_auto[$i][1] = 1 then GUICtrlSetState(-1,1)
	Next
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$Group3 = GUICtrlCreateGroup("Számlák", 480, 20, 210, 800)
	for $i=1 to $oszlopok_szamla[0][0]
		$checkbox_szamla_array[$i] =  GUICtrlCreateCheckbox($oszlopok_szamla[$i][0], 500, 18+($i*38), 130, 17)
		GUICtrlSetFont(-1, 12, 400, 0, "Calibri")
		if $oszlopok_szamla[$i][1] = 1 then GUICtrlSetState(-1,1)
	Next
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUISetState(@SW_SHOW)
EndFunc

Func _ShakeWindow()     ;self-explanatory
	Local $Window = WinGetTitle("", ""), $ShakeAmount = 5, $Win_pos = WinGetPos($Window)
	For $i = 0 To 20
		WinMove($Window, "", $Win_pos[0], $Win_pos[1] + $ShakeAmount * Mod($i, 2))
		Sleep(10)
	Next
EndFunc   ;==>_ShakeWindow

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

Func FormatNum($iNum)
	$iNum = StringFormat("%#." & "f", $iNum)
	SetExtended(1)
	While @extended
		$iNum = StringRegExpReplace($iNum, '(.*\d)(\d{' & "3" & '}[.,\s]\d*)', "\1\ \2", 1)
	WEnd
	Return StringReplace($iNum & " Ft", ".", "")
EndFunc   ;==>FormatNum

Func SQLparancsok($mely)
	if $mely = "autok_osszes" Then
		_SQLite_GetTable2d(-1,"select * from vehicles where status=1;",$auto_array,$iRows,$iColumns)
		_ArrayDelete($auto_array,0)
		_ArrayColDelete($auto_array,0)
	ElseIf $mely = "vevok_osszes" Then
		_SQLite_GetTable2d(-1,"select * from customers where status=1;",$vevo_array,$iRows,$iColumns)
		_ArrayDelete($vevo_array,0)
		_ArrayColDelete($vevo_array,0)
	ElseIf $mely = "szerz_osszes" Then
		_SQLite_GetTable2d(-1,"select * from contracts where status=1;",$szerz_array,$iRows,$iColumns)
		_ArrayDelete($szerz_array,0)
		_ArrayColDelete($szerz_array,0)
	ElseIf $mely = "vevo_add" Then
		_SQLite_Exec(-1,"insert into customers values("&$adatok&");")
		_SQLite_GetTable2d(-1,"select * from customers where status=1;",$vevo_array,$iRows,$iColumns)
		_ArrayDelete($vevo_array,0)
		_ArrayColDelete($vevo_array,0)
	ElseIf $mely = "vevo_update" Then
		_SQLite_Exec(-1,"update customers set STATUS = 0 where custID = "&guictrlread($vevokod_I)&"; " & _
						"insert into customers " & _
						"select " & $adatok & _
						" from customers " & _
						"where custID = "&guictrlread($vevokod_I) & _
						" ORDER by ROWID DESC limit 1")
		_GUICtrlListView_DeleteAllItems($vevo_L)
		_SQLite_GetTable2d(-1,"select custID,custname,contactname,contacttel,contactemail from customers where status=1;",$vevo_array,$iRows,$iColumns)
		_ArrayDelete($vevo_array,0)
	ElseIf $mely = "auto_egyvevo_kiv" Then
		_SQLite_GetTable2d(-1,"select v.* from contracts c inner join  vehicles v on v.licno = c.LICNO inner join customers d on d.custNAME = c.custNAME where v.status = 1 and c.status = 1 and d.status = 1 and d.custNAME ="& $vevonev &";",$auto_array,$iRows,$iColumns)
		_ArrayDelete($auto_array,0)
		_ArrayColDelete($auto_array,0)
	ElseIf $mely = "szerz_egyvevo_kiv" Then
		_SQLite_GetTable2d(-1,"select * from contracts where status = 1 and custNAME ="& $vevonev &";",$szerz_array,$iRows,$iColumns)
		_ArrayDelete($szerz_array,0)
		_ArrayColDelete($szerz_array,0)
	ElseIf $mely = "szamla_egyauto_kiv" Then
		_SQLite_GetTable2d(-1,"select invid,month,invdate,invdeadline,amount,invsent,invpaid from invoices a inner join contracts b on a.contid=b.contid where a.status=1 and b.status=1 and licno="& $autorendszam &";",$szamla_array,$iRows,$iColumns)
		_ArrayDelete($szamla_array,0)
	ElseIf $mely = "auto_szabadok" Then
		_SQLite_GetTable2d(-1,"select v.* from vehicles v left join (select c.licNO from contracts c where c.status=1)  c on v.licNO = c.licNO where c.licno is null;",$auto_array,$iRows,$iColumns)
		_ArrayDelete($auto_array,0)
		_ArrayColDelete($auto_array,0)
	ElseIf $mely = "vevo_history" Then
		_SQLite_GetTable2d(-1,"select * from customers where custID ="& $vevokod &";",$vevo_history_array,$iRows,$iColumns)
		_ArrayDelete($vevo_history_array,0)
		_ArrayColDelete($vevo_history_array,0)
	ElseIf $mely = "szerz_egyauto_kiv" Then
		_SQLite_QuerySingleRow(-1,"select a.* from contracts a inner JOIN customers b on a.custNAME = b.custNAME inner JOIN vehicles c on a.licNO = c.licNO where a.status = 1 and b.status = 1 and c.status =1 and a.licNO ="& $autorendszam &";",$aRow2)
	ElseIf $mely = "auto_history" Then
		_SQLite_GetTable2d(-1,"select * from vehicles where licno ="& $autorendszam &";",$auto_history_array,$iRows,$iColumns)
		_ArrayDelete($auto_history_array,0)
		_ArrayColDelete($auto_history_array,0)
	ElseIf $mely = "auto_add" Then
		_SQLite_Exec(-1,"insert into vehicles values("&$adatok&");")
		_SQLite_GetTable2d(-1,"select * from vehicles where status=1;",$auto_array,$iRows,$iColumns)
		_ArrayDelete($auto_array,0)
		_ArrayColDelete($auto_array,0)
	ElseIf $mely = "auto_update" Then
		_SQLite_Exec(-1,"update vehicles set STATUS = 0 where vehiID = "&$input_autoadd_A[1]&"; " & _
						"insert into vehicles " & _
						"select " & $adatok & _
						" from vehicles " & _
						"where vehiID = "&$input_autoadd_A[1] & _
						" ORDER by ROWID DESC limit 1")
		_GUICtrlListView_DeleteAllItems($auto_L)
		_SQLite_GetTable2d(-1,"select * from vehicles where status=1;",$auto_array,$iRows,$iColumns)
		_ArrayDelete($auto_array,0)
		_ArrayColDelete($auto_array,0)
	ElseIf $mely = "szerz_szamolo_all" Then
		_SQLite_QuerySingleRow(-1,"select count(contid) from contracts where STATUS=1;",$aRow)
	ElseIf $mely = "szerz_szamolo_egy" Then
		_SQLite_QuerySingleRow(-1,"select count(contid) from contracts where STATUS=1 and custname="& $vevonev &";",$aRow)
	ElseIf $mely = "szamla_osszeg_all" Then
		_SQLite_QuerySingleRow(-1,"select sum(fee) from contracts where STATUS = 1",$aRow)
	ElseIf $mely = "szamla_osszeg_egy" Then
		_SQLite_QuerySingleRow(-1,"select sum(fee) from contracts where STATUS = 1 and custname="& $vevonev &";",$aRow)
	ElseIf $mely = "szamlak_havi_kisz_all" Then
		_SQLite_QuerySingleRow(-1,"select count(invid) from invoices where status=1 and invsent=1 and invDATE <'"&@YEAR&"/"&@MON&"/30' and invDATE >'"&@YEAR&"/"&@MON&"/01';",$aRow)
	ElseIf $mely = "szamlak_havi_kisz_egy" Then
		_SQLite_QuerySingleRow(-1,"select count(a.invid) from invoices a inner JOIN contracts b on a.contID=b.contID where a.status=1 and b.status=1 and invDATE <'"&@YEAR&"/"&@MON&"/30' and invDATE >'"&@YEAR&"/"&@MON&"/01' and b.custNAME="& $vevonev &";",$aRow)
	ElseIf $mely = "szamla_lejart" Then
		_SQLite_GetTable2d(-1,"select INVID,custNAME,licno,invDEADLINE,amount from invoices a inner JOIN contracts b on a.contID=b.contID where a.status=1 and b.status=1 and invPAID=0 and invDEADLINE <= '"&@YEAR&"/"&@MON&"/"&@MDAY&"';",$szamla_array,$iRows,$iColumns)
		_ArrayDelete($szamla_array,0)
	EndIf
EndFunc