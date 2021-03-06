#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\Icons\if-weather-46-2682805_90772.ico
#AutoIt3Wrapper_Outfile=N:\Botond\autoit scriptek\CO2tervezo.exe
#AutoIt3Wrapper_Res_Fileversion=1.0.0.17
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_Tidy_Stop_OnError=n
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
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
#include <String.au3>
#include <File.au3>
#include <Excel.au3>
#include <ColorConstants.au3>
#include <IE.au3>



if FileExists("co2.ini") = 0 Then
	MsgBox(0,"Hiba","A co2.ini file hiányzik!")
	Exit
EndIf
Call("adatload")
Global $honap = @MON
Global $tipus,$tipusn, $Input1,$Input2, $text,$elso_label,$masodik_label,$harmadik_label,$elso_lista,$masodik_lista,$harmadik_lista,$keszletn_lista,$Combo2n
Global $save_button, $astra100, $astra85, $astra115, $combo85,$combo100,$combo115,$corsa85,$corsa100,$corsa115,$crossland85,$crossland100,$crossland115,$grandland85,$grandland100,$grandland115,$insignia85,$insignia100,$insignia115,$movano85,$movano100,$movano115,$vivaro85,$vivaro100,$vivaro115,$corsae85,$corsae100,$corsae115,$grandlandh85,$grandlandh100,$grandlandh115
Global $elsodb_label,$masodikdb_label,$harmadikdb_label,$elso_input,$masodik_input,$harmadik_input,$elsovbp_label,$bal1_gomb,$bal2_gomb,$bal3_gomb,$jobb1_gomb,$jobb2_gomb,$jobb3_gomb
Global $Form1 = 999, $Form2 = 999, $Form3 = 999,$masodikvbp_label,$harmadikvbp_label,$honapn,$havisumvbp_label,$negyedevesvbp_label, $updatescript
Global $updatescript = "updatescript.cmd"
;~ _ArrayDisplay($array)

UpdateCheck("CO2tervezo.exe")

Func adatload()
	if FileExists("N:\Botond\co2tervezoriport\Jármuértékesítési tervezés.xlsx") = 1 Then
		Local $file = "N:\Botond\co2tervezoriport\Jármuértékesítési tervezés.xlsx"
		Local $excel = _Excel_Open(False)
		Local $workbook = _Excel_BookOpen($excel, $file, True, False)
		global $adatdatum = FileGetTime($file)
		Global $array = _Excel_RangeRead($workbook)
		;~ ReDim $array[UBound($array)][UBound($array,2)]
		_ArraySort($array, 0, 0, 0, 2)
		_Excel_BookClose($workbook, False)
		_Excel_Close($excel, False)
	Else
		MsgBox(0,"Hiba","A N:\Botond\co2tervezoriport\Jármuértékesítési tervezés.xlsx file nem elérhető.")
		Exit
	EndIf
EndFunc

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=C:\Users\kormoczi.botond\Desktop\autoit-v3\koda_1.7.3.0\Forms\co2_tervezo.kxf
$Form1 = GUICreate("CO2Bot-új verzió", 1267, 949, 0, 0, BitOR($GUI_SS_DEFAULT_GUI, $WS_SIZEBOX, $WS_THICKFRAME))
$forghely_lista = GUICtrlCreateListView("JOB | Modell | CO2 | Áll. | Forg. dátum | E.kód | Vevő", 8, 568, 540, 366)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 85)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 100)
$terv_lista = GUICtrlCreateListView("JOB | Modell | CO2 | Áll. | Terv dátum | E.kód | Vevő", 8, 112, 540, 366, $LBS_MULTIPLESEL)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 85)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 100)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
$keszlet_lista = GUICtrlCreateListView("JOB | Modell | CO2 | Áll. | Terv dátum | E.kód | Vevő", 720, 80, 540, 426, $LBS_MULTIPLESEL)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 85)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 100)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
$bal_gomb = GUICtrlCreateButton("<<<<", 600, 176, 65, 41)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$jobb_gomb = GUICtrlCreateButton(">>>>", 600, 240, 65, 41)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$reset_gomb = GUICtrlCreateButton("RESET", 624, 408, 81, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$excelexport_gomb = GUICtrlCreateButton("EXCEL EXPORT", 560, 360, 145, 41)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$Combo1 = GUICtrlCreateCombo("Személy", 8, 8, 137, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
_GUICtrlComboBox_AddString($Combo1, "Haszon")
$Combo2 = GUICtrlCreateCombo("", 160, 8, 129, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
_GUICtrlComboBox_AddString($Combo2, "Január")
_GUICtrlComboBox_AddString($Combo2, "Február")
_GUICtrlComboBox_AddString($Combo2, "Március")
_GUICtrlComboBox_AddString($Combo2, "Április")
_GUICtrlComboBox_AddString($Combo2, "Május")
_GUICtrlComboBox_AddString($Combo2, "Június")
_GUICtrlComboBox_AddString($Combo2, "Július")
_GUICtrlComboBox_AddString($Combo2, "Augusztus")
_GUICtrlComboBox_AddString($Combo2, "Szeptember")
_GUICtrlComboBox_AddString($Combo2, "Október")
_GUICtrlComboBox_AddString($Combo2, "November")
_GUICtrlComboBox_AddString($Combo2, "December")
_GUICtrlComboBox_SetCurSel($Combo2, @MON - 1)
$celszam_input = GUICtrlCreateInput("", 408, 8, 57, 28)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$co2cel_input = GUICtrlCreateInput("", 408, 40, 57, 28)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$Label1 = GUICtrlCreateLabel("Célszám:", 312, 8, 87, 24, $SS_RIGHT)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$Label2 = GUICtrlCreateLabel("CO2-cél:", 312, 40, 87, 24, $SS_RIGHT)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$tervdb_label = GUICtrlCreateLabel("tervdb_label", 496, 80, 94, 24)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$forghelydb_label = GUICtrlCreateLabel("forghelydb_label", 496, 536, 125, 24)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$Label5 = GUICtrlCreateLabel("CO2 cél:", 752, 584, 69, 24, $SS_RIGHT)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$Label6 = GUICtrlCreateLabel("Sum átlag CO2:", 700, 616, 121, 24, $SS_RIGHT)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$Label7 = GUICtrlCreateLabel("Havi célszám:", 711, 664, 110, 24, $SS_RIGHT)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$adatdatum_label = GUICtrlCreateLabel("", 1148, 56, 90, 20)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlSetData(-1, $adatdatum[0] & "." & $adatdatum[1] & "." & $adatdatum[2] & " " & $adatdatum[3] & ":" & $adatdatum[4])
$Label3 = GUICtrlCreateLabel("Sum db:", 756, 688, 65, 24, $SS_RIGHT)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$Label4 = GUICtrlCreateLabel("VBP:", 778, 720, 43, 24, $SS_RIGHT)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$Label8 = GUICtrlCreateLabel("Minőségi bónusz:", 687, 776, 134, 24, $SS_RIGHT)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$Label9 = GUICtrlCreateLabel("Flottahálózati Extra VB:", 642, 808, 179, 24, $SS_RIGHT)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$Label10 = GUICtrlCreateLabel("Összes bónusz:", 658, 864, 168, 28, $SS_RIGHT)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
$co2cel_label = GUICtrlCreateLabel("co2cel_label", 832, 584, 97, 24)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$sumatlagco2_label = GUICtrlCreateLabel("sumatlagco2_label", 832, 616, 143, 24)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$celszam_label = GUICtrlCreateLabel("celszam_label", 832, 664, 111, 24)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$sumdb_label = GUICtrlCreateLabel("sumdb_label", 832, 688, 98, 24)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$vbp_label = GUICtrlCreateLabel("vbp_label", 832, 720, 160, 24)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetColor(-1, 0x808080)
$minbonusz_label = GUICtrlCreateLabel("minbonusz_label", 832, 776, 150, 24)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetColor(-1, 0x808080)
$rejtettvbp_label = GUICtrlCreateLabel("rejtettvbp_label", 832, 744, 108, 17)
GUICtrlSetColor(-1, 0xC8C8C8)
$flottaextravb_label = GUICtrlCreateLabel("flottaextravb_label", 832, 808, 150, 24)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetColor(-1, 0x808080)
$osszesbonusz_label = GUICtrlCreateLabel("osszesbonusz_label", 832, 864, 224, 28)
GUICtrlSetFont(-1, 15, 800, 4, "Arial")
$co2visszajelzo_label = GUICtrlCreateLabel("co2visszajelzo_label", 910, 600, 158, 26)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$dbvisszajelzo_label = GUICtrlCreateLabel("dbvisszajelzo_label", 910, 672, 149, 26)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$celszamx07 = GUICtrlCreateLabel("celszamx07", 1152, 594, 59, 17)
$celszamx085 = GUICtrlCreateLabel("celszamx085", 1152, 618, 65, 17)
$celszamx1 = GUICtrlCreateLabel("celszamx1", 1152, 642, 53, 17)
$celszamx115 = GUICtrlCreateLabel("celszamx115", 1152, 666, 65, 17)
$Label26 = GUICtrlCreateLabel("70%", 1112, 594, 24, 17, $SS_RIGHT)
$Label27 = GUICtrlCreateLabel("85%", 1112, 618, 24, 17, $SS_RIGHT)
$Label28 = GUICtrlCreateLabel("100%", 1106, 642, 30, 17, $SS_RIGHT)
$Label29 = GUICtrlCreateLabel("115%", 1106, 666, 30, 17, $SS_RIGHT)
$co2korrig_label = GUICtrlCreateLabel("co2korrig_label", 1035, 520, 41, 20)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
$Input1 = GUICtrlCreateInput("1", 920, 520, 25, 20)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
$Label11 = GUICtrlCreateLabel("db, maximum", 950, 520, 83, 20)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
$Label12 = GUICtrlCreateLabel("g-os jármuvel jó a CO2", 1078, 520, 139, 20)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
$Label31 = GUICtrlCreateLabel("Forgalombahelyezés tervezve", 8, 80, 225, 24)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$Label32 = GUICtrlCreateLabel("Már forgalomba van helyezve", 8, 536, 219, 24)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$Label33 = GUICtrlCreateLabel("Készlet", 728, 56, 60, 24)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
$Checkbox1 = GUICtrlCreateCheckbox("Select all", 16, 480, 97, 17)
$Checkbox2 = GUICtrlCreateCheckbox("Select all", 728, 512, 97, 17)
$riportfriss_gomb = GUICtrlCreateButton("Friss riport letőltés", 1136, 8, 121, 41)
$settings_button = GUICtrlCreateButton("Settings", 1136, 856, 97, 33)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
$negyedev_button = GUICtrlCreateButton("Negyedév", 1136, 900, 97, 33)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
$kovszint_label = GUICtrlCreateLabel("kovszint_label", 975, 720, 221, 34)
GUICtrlSetFont(-1, 10, 150, 0, "Arial")
GUICtrlSetColor(-1, 0x808080)

$terv_lista_jobbmenu = GUICtrlCreateContextMenu($terv_lista)
$keszlet_lista_jobbmenu = GUICtrlCreateContextMenu($keszlet_lista)
$forghely_lista_jobbmenu = GUICtrlCreateContextMenu($forghely_lista)
$terv_lista_am = GUICtrlCreateMenuItem("AM - Jármű adat", $terv_lista_jobbmenu)
$keszlet_lista_am = GUICtrlCreateMenuItem("AM - Jármű adat", $keszlet_lista_jobbmenu)
$forghely_lista_am = GUICtrlCreateMenuItem("AM - Jármű adat", $forghely_lista_jobbmenu)
$terv_lista_info = GUICtrlCreateMenuItem("Info", $terv_lista_jobbmenu)
$keszlet_lista_info = GUICtrlCreateMenuItem("Info", $keszlet_lista_jobbmenu)
$forghely_lista_info = GUICtrlCreateMenuItem("Info", $forghely_lista_jobbmenu)
$terv_lista_globalfelv = GUICtrlCreateMenuItem("Global - Felvilágosítás", $terv_lista_jobbmenu)
$keszlet_lista_globalfelv = GUICtrlCreateMenuItem("Global - Felvilágosítás", $keszlet_lista_jobbmenu)
$forghely_lista_globalfelv = GUICtrlCreateMenuItem("Global - Felvilágosítás", $forghely_lista_jobbmenu)


GUISetState(@SW_SHOW)


#EndRegion ### END Koda GUI section ###

Func FormatNum($iNum)
	$iNum = StringFormat("%#." & "f", $iNum)
	SetExtended(1)
	While @extended
		$iNum = StringRegExpReplace($iNum, '(.*\d)(\d{' & "3" & '}[.,\s]\d*)', "\1\ \2", 1)
	WEnd
	Return StringReplace($iNum & " Ft", ".", "")
EndFunc   ;==>FormatNum

Func VBP($honap,$n,$melylista)

	$VBP_osszeg = 0

	For $i = 0 To _GUICtrlListView_GetItemCount($melylista) - 1
		If _GUICtrlListView_GetItemText($melylista, $i, 3) = "D" Or _GUICtrlListView_GetItemText($melylista, $i, 3) = "G" Then
			ContinueLoop
		EndIf
		If StringLeft(_GUICtrlListView_GetItemText($melylista, $i, 1), StringInStr(_GUICtrlListView_GetItemText($melylista, $i, 1), " ") - 1) = "Astra-K" Then
			$VBP_osszeg = $VBP_osszeg + Number(StringSplit(IniRead("co2.ini", $honap, "astra", "1"), ",")[$n])
		ElseIf StringLeft(_GUICtrlListView_GetItemText($melylista, $i, 1), StringInStr(_GUICtrlListView_GetItemText($melylista, $i, 1), " ") - 1) = "CORSA-F" Then
			if StringInStr($array[$i][10],"Elektromos") <> 0 Then
				$VBP_osszeg = $VBP_osszeg + Number(StringSplit(IniRead("co2.ini", $honap, "corsae", "1"), ",")[$n])
			Else
				$VBP_osszeg = $VBP_osszeg + Number(StringSplit(IniRead("co2.ini", $honap, "corsa", "1"), ",")[$n])
			EndIf
		ElseIf StringLeft(_GUICtrlListView_GetItemText($melylista, $i, 1), StringInStr(_GUICtrlListView_GetItemText($melylista, $i, 1), " ") - 1) = "COMBO-E" Then
			$VBP_osszeg = $VBP_osszeg + Number(StringSplit(IniRead("co2.ini", $honap, "combo", "1"), ",")[$n])
		ElseIf StringLeft(_GUICtrlListView_GetItemText($melylista, $i, 1), StringInStr(_GUICtrlListView_GetItemText($melylista, $i, 1), " ") - 1) = "CROSSLAND" Then
			$VBP_osszeg = $VBP_osszeg + Number(StringSplit(IniRead("co2.ini", $honap, "crossland", "1"), ",")[$n])
		ElseIf StringLeft(_GUICtrlListView_GetItemText($melylista, $i, 1), StringInStr(_GUICtrlListView_GetItemText($melylista, $i, 1), " ") - 1) = "Grandland" Then
			if StringInStr($array[$i][10],"Elektromos") <> 0 Then
				$VBP_osszeg = $VBP_osszeg + Number(StringSplit(IniRead("co2.ini", $honap, "grandlandh", "1"), ",")[$n])
			Else
				$VBP_osszeg = $VBP_osszeg + Number(StringSplit(IniRead("co2.ini", $honap, "grandland", "1"), ",")[$n])
			EndIf
		ElseIf StringLeft(_GUICtrlListView_GetItemText($melylista, $i, 1), StringInStr(_GUICtrlListView_GetItemText($melylista, $i, 1), " ") - 1) = "Insignia-B" Then
			$VBP_osszeg = $VBP_osszeg + Number(StringSplit(IniRead("co2.ini", $honap, "insignia", "1"), ",")[$n])
		ElseIf StringLeft(_GUICtrlListView_GetItemText($melylista, $i, 1), StringInStr(_GUICtrlListView_GetItemText($melylista, $i, 1), " ") - 1) = "VIVARO-C/ZAFIRA" Then
			$VBP_osszeg = $VBP_osszeg + Number(StringSplit(IniRead("co2.ini", $honap, "vivaro", "1"), ",")[$n])
		ElseIf StringLeft(_GUICtrlListView_GetItemText($melylista, $i, 1), StringInStr(_GUICtrlListView_GetItemText($melylista, $i, 1), " ") - 1) = "MOVANO-B" Then
			$VBP_osszeg = $VBP_osszeg + Number(StringSplit(IniRead("co2.ini", $honap, "movano", "1"), ",")[$n])
		EndIf
	Next

	Return $VBP_osszeg

EndFunc   ;==>VBP

Func feliratok($honap)
	$forghelydb = _GUICtrlListView_GetItemCount($forghely_lista)
	GUICtrlSetData($forghelydb_label, $forghelydb & " db")
	$tervdb = _GUICtrlListView_GetItemCount($terv_lista)
	GUICtrlSetData($tervdb_label, $tervdb & " db")
	$sumdb = $forghelydb + $tervdb
	GUICtrlSetData($celszam_label, GUICtrlRead($celszam_input))
	GUICtrlSetData($sumdb_label, $sumdb)
	GUICtrlSetData($co2cel_label, GUICtrlRead($co2cel_input))
	GUICtrlSetData($minbonusz_label, FormatNum($sumdb * 80000))

	GUICtrlSetData($celszamx07, Round(GUICtrlRead($celszam_label) * 0.7))
	GUICtrlSetData($celszamx085, Round(GUICtrlRead($celszam_label) * 0.85))
	GUICtrlSetData($celszamx1, Round(GUICtrlRead($celszam_label)))
	GUICtrlSetData($celszamx115, Round(GUICtrlRead($celszam_label) * 1.15))
	If $sumdb < GUICtrlRead($celszamx07) Then
		GUICtrlSetData($dbvisszajelzo_label, "<70%!!!!")
		GUICtrlSetColor($dbvisszajelzo_label, 0x660000)
		GUICtrlSetFont($dbvisszajelzo_label, 20, 700)
		GUICtrlSetData($vbp_label, "0 Ft")
		$vbpnum = 0
		GUICtrlSetData($kovszint_label, "")
	ElseIf GUICtrlRead($celszamx085) > $sumdb And $sumdb >= GUICtrlRead($celszamx07) Then
		GUICtrlSetData($dbvisszajelzo_label, "70%")
		GUICtrlSetColor($dbvisszajelzo_label, 0xFF0000)
		GUICtrlSetFont($dbvisszajelzo_label, 20, 700)
		GUICtrlSetData($vbp_label, "0 Ft")
		$vbpnum = 0
		GUICtrlSetData($kovszint_label, "Ha a mostani db-szám lenne a 85%, akkor a VBP: " & FormatNum(Call("VBP",$honap, 1,$terv_lista) + Call("VBP",$honap, 1,$forghely_lista)))
	ElseIf GUICtrlRead($celszamx1) > $sumdb And $sumdb >= GUICtrlRead($celszamx085) Then
		GUICtrlSetData($dbvisszajelzo_label, "85%")
		GUICtrlSetColor($dbvisszajelzo_label, 0xFF8000)
		GUICtrlSetFont($dbvisszajelzo_label, 20, 700)
		$vbpnum = Call("VBP",$honap, 1,$terv_lista) + Call("VBP",$honap, 1,$forghely_lista)
		GUICtrlSetData($vbp_label, FormatNum($vbpnum))
		GUICtrlSetData($kovszint_label, "Ha a mostani db-szám lenne a 100%, akkor a VBP: " & FormatNum(Call("VBP",$honap, 2,$terv_lista) + Call("VBP",$honap, 2,$forghely_lista)))
	ElseIf GUICtrlRead($celszamx115) > $sumdb And $sumdb >= GUICtrlRead($celszamx1) Then
		GUICtrlSetData($dbvisszajelzo_label, "100%")
		GUICtrlSetColor($dbvisszajelzo_label, 0x4C9900)
		GUICtrlSetFont($dbvisszajelzo_label, 20, 700)
		$vbpnum = Call("VBP", $honap, 2,$terv_lista)+ Call("VBP",$honap, 2,$forghely_lista)
		GUICtrlSetData($vbp_label, FormatNum($vbpnum))
		GUICtrlSetData($kovszint_label, "Ha a mostani db-szám lenne a 115%, akkor a VBP: " & FormatNum(Call("VBP",$honap, 3,$terv_lista) + Call("VBP",$honap, 3,$forghely_lista)))
	ElseIf $sumdb >= GUICtrlRead($celszamx115) Then
		GUICtrlSetData($dbvisszajelzo_label, "115%")
		GUICtrlSetColor($dbvisszajelzo_label, 0x00FF00)
		GUICtrlSetFont($dbvisszajelzo_label, 20, 700)
		$vbpnum = Call("VBP", $honap, 3,$terv_lista)+ Call("VBP",$honap, 3,$forghely_lista)
		GUICtrlSetData($vbp_label, FormatNum($vbpnum))
		GUICtrlSetData($kovszint_label, "")
	EndIf
	If GUICtrlRead($Combo1) = "Személy" Then
		$co2_1 = 0
		$co2_2 = 0
		$sumdb_cohoz = 0
		For $i = 0 To $tervdb - 1
			If _GUICtrlListView_GetItemText($terv_lista, $i, 2) = "E" Or _GUICtrlListView_GetItemText($terv_lista, $i, 2) = "N/D" Then ContinueLoop
			$co2_1 = _GUICtrlListView_GetItemText($terv_lista, $i, 2) + $co2_1
			$sumdb_cohoz = $sumdb_cohoz + 1
		Next
		For $i = 0 To $forghelydb - 1
			If _GUICtrlListView_GetItemText($forghely_lista, $i, 2) = "E" Or _GUICtrlListView_GetItemText($forghely_lista, $i, 2) = "N/D" Then ContinueLoop
			$co2_2 = _GUICtrlListView_GetItemText($forghely_lista, $i, 2) + $co2_2
			$sumdb_cohoz = $sumdb_cohoz + 1
		Next
		$sumco2 = $co2_1 + $co2_2
		GUICtrlSetData($sumatlagco2_label, Round($sumco2 / $sumdb_cohoz, 2))
		If Number(GUICtrlRead($co2cel_label),3) < Number(GUICtrlRead($sumatlagco2_label),3) Then
			GUICtrlSetData($co2visszajelzo_label, "!!!!!")
			GUICtrlSetColor($co2visszajelzo_label, 0xFF0000)
			GUICtrlSetFont($co2visszajelzo_label, 20, 700)
			GUICtrlSetData($co2korrig_label, Round(((GUICtrlRead($Input1) + $sumdb_cohoz) * GUICtrlRead($co2cel_label) - $sumco2) / GUICtrlRead($Input1), 2))
			GUICtrlSetData($vbp_label, "0 Ft  - CO2 miatt")
			$vbpnum = 0
			If GUICtrlRead($celszamx1) > $sumdb And $sumdb >= GUICtrlRead($celszamx085) Then
				GUICtrlSetData($rejtettvbp_label, FormatNum(Call("VBP",$honap, 1,$terv_lista) + Call("VBP",$honap, 1,$forghely_lista)))
			ElseIf GUICtrlRead($celszamx115) > $sumdb And $sumdb >= GUICtrlRead($celszamx1) Then
				GUICtrlSetData($rejtettvbp_label, FormatNum(Call("VBP",$honap, 2,$terv_lista) + Call("VBP",$honap, 2,$forghely_lista)))
			ElseIf $sumdb >= GUICtrlRead($celszamx115) Then
				GUICtrlSetData($rejtettvbp_label, FormatNum(Call("VBP",$honap, 3,$terv_lista) + Call("VBP",$honap, 3,$forghely_lista)))
			Else
				GUICtrlSetData($rejtettvbp_label, "")
			EndIf
		ElseIf Number(GUICtrlRead($co2cel_input),3) >= Number(GUICtrlRead($sumatlagco2_label),3) Then
			GUICtrlSetData($co2visszajelzo_label, "OK")
			GUICtrlSetColor($co2visszajelzo_label, 0x00FF00)
			GUICtrlSetFont($co2visszajelzo_label, 20, 700)
			GUICtrlSetData($co2korrig_label, "###")
			GUICtrlSetData($rejtettvbp_label, "")
		EndIf
	ElseIf GUICtrlRead($Combo1) = "Haszon" Then
		GUICtrlSetData($sumatlagco2_label, "")
		GUICtrlSetData($co2visszajelzo_label, "")
		GUICtrlSetData($co2korrig_label, "###")
		GUICtrlSetData($co2cel_label, "")
		GUICtrlSetData($rejtettvbp_label, "")
	EndIf
	$countF = 0
	For $i = 0 To $forghelydb - 1
		If _GUICtrlListView_GetItemText($forghely_lista, $i, 3) = "F" Then $countF = $countF + 1
	Next
	For $i = 0 To $tervdb - 1
		If _GUICtrlListView_GetItemText($terv_lista, $i, 3) = "F" Then $countF = $countF + 1
	Next
	If $sumdb < GUICtrlRead($celszamx1) And $countF > 0 Then
		GUICtrlSetData($flottaextravb_label, "<100% miatt 0 Ft")
		GUICtrlSetColor($flottaextravb_label, 0xFF0000)
		GUICtrlSetData($osszesbonusz_label, FormatNum($vbpnum + $sumdb * 80000))
	Else
		GUICtrlSetData($flottaextravb_label, FormatNum($countF * 40000))
		GUICtrlSetColor($flottaextravb_label, 0x808080)
		GUICtrlSetData($osszesbonusz_label, FormatNum($vbpnum + $countF * 40000 + $sumdb * 80000))
	EndIf

EndFunc   ;==>feliratok

Call(lista)

Func lista($tipus = "S", $honap = @MON)

	For $i = 1 To UBound($array) - 1
		If ControlListView($Form1, "", $forghely_lista, "FindItem", $array[$i][2]) > -1 or ControlListView($Form1, "", $terv_lista, "FindItem", $array[$i][2]) > -1 or ControlListView($Form1, "", $keszlet_lista, "FindItem", $array[$i][2]) > -1 Then ContinueLoop
		If StringLeft($array[$i][12], 1) = "S" And $array[$i][29] = "Not CO2 Relevant" Then $array[$i][11] = "E"
		If $array[$i][11] = "" Then $array[$i][11] = "N/D"
		If StringLeft($array[$i][1], 2) = " 1" Then $array[$i][1] = "60"
;~ forghely lista
		If StringLeft($array[$i][4], 1) = "1" And StringLeft($array[$i][12], 1) = $tipus And StringLeft($array[$i][16], 8) >= "2021" & $honap & "01" And StringLeft($array[$i][16], 8) <= "2021" & $honap & "31" Then
			GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][16], 4) & "." & StringMid($array[$i][16], 5, 2) & "." & StringMid($array[$i][16], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $forghely_lista)
;~ 	tervezett
		ElseIf StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][12], 1) = $tipus And StringLeft($array[$i][24], 8) >= "2021" & $honap & "01" And StringLeft($array[$i][24], 8) <= "2021" & $honap & "31" Then
			GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $terv_lista)
;~ 	keszlet
		ElseIf StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][24], 8) > "2021" & $honap & "31" And StringLeft($array[$i][12], 1) = $tipus Then
			GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $keszlet_lista)
		ElseIf StringLeft($array[$i][4], 1) = "3" And StringLeft($array[$i][12], 1) = $tipus Then
			GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $keszlet_lista)
		EndIf
	Next

	If $tipus = "S" Then
		GUICtrlSetState($co2cel_input, $gui_show)
		GUICtrlSetData($celszam_input, IniRead("co2.ini", "sdb", $honap, "??"))
		GUICtrlSetData($co2cel_input, IniRead("co2.ini", "co2", $honap, "??"))
	ElseIf $tipus = "H" Then
		GUICtrlSetData($celszam_input, IniRead("co2.ini", "hdb", $honap, "??"))
		GUICtrlSetState($co2cel_input, $gui_hide)
	EndIf


	Call("feliratok",$honap)


EndFunc   ;==>lista

Func listanegyedev($negyedev, $tipusn = "H")
	For $i = 1 To UBound($array) - 1
		If ControlListView($Form3, "", $elso_lista, "FindItem", $array[$i][2]) > -1 or ControlListView($Form3, "", $masodik_lista, "FindItem", $array[$i][2]) > -1 or ControlListView($Form3, "", $harmadik_lista, "FindItem", $array[$i][2]) > -1 or ControlListView($Form3, "", $keszletn_lista, "FindItem", $array[$i][2]) > -1 Then ContinueLoop
		If StringLeft($array[$i][12], 1) = "S" And $array[$i][29] = "Not CO2 Relevant" Then $array[$i][11] = "E"
		If $array[$i][11] = "" Then $array[$i][11] = "N/D"
		If StringLeft($array[$i][1], 2) = " 1" Then $array[$i][1] = "60"
		if $negyedev = 1 Then
		;~ első lista
			If StringLeft($array[$i][4], 1) = "1" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][16], 8) >= "20210101" And StringLeft($array[$i][16], 8) <= "20210131" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][16], 4) & "." & StringMid($array[$i][16], 5, 2) & "." & StringMid($array[$i][16], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $elso_lista)
			ElseIf StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][24], 8) >= "20210101" And StringLeft($array[$i][24], 8) <= "20210131" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $elso_lista)
			EndIf
		;~ második lista
			If StringLeft($array[$i][4], 1) = "1" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][16], 8) >= "20210201" And StringLeft($array[$i][16], 8) <= "20210231" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][16], 4) & "." & StringMid($array[$i][16], 5, 2) & "." & StringMid($array[$i][16], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $masodik_lista)
			ElseIf StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][24], 8) >= "20210201" And StringLeft($array[$i][24], 8) <= "20210231" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $masodik_lista)
			EndIf
		;~ harmadik lista
			If StringLeft($array[$i][4], 1) = "1" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][16], 8) >= "20210301" And StringLeft($array[$i][16], 8) <= "20210331" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][16], 4) & "." & StringMid($array[$i][16], 5, 2) & "." & StringMid($array[$i][16], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $harmadik_lista)
			ElseIf StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][24], 8) >= "20210301" And StringLeft($array[$i][24], 8) <= "20210331" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $harmadik_lista)
			EndIf
		;~ készlet
			If StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][24], 8) > "2021" & $honap & "31" And StringLeft($array[$i][12], 1) = $tipusn Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $keszletn_lista)
			ElseIf StringLeft($array[$i][4], 1) = "3" And StringLeft($array[$i][12], 1) = $tipusn Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $keszletn_lista)
			EndIf
		ElseIf $negyedev = 2 Then
			;~ első lista
			If StringLeft($array[$i][4], 1) = "1" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][16], 8) >= "20210401" And StringLeft($array[$i][16], 8) <= "20210431" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][16], 4) & "." & StringMid($array[$i][16], 5, 2) & "." & StringMid($array[$i][16], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $elso_lista)
			ElseIf StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][24], 8) >= "20210401" And StringLeft($array[$i][24], 8) <= "20210431" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $elso_lista)
			EndIf
		;~ második lista
			If StringLeft($array[$i][4], 1) = "1" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][16], 8) >= "20210501" And StringLeft($array[$i][16], 8) <= "20210531" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][16], 4) & "." & StringMid($array[$i][16], 5, 2) & "." & StringMid($array[$i][16], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $masodik_lista)
			ElseIf StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][24], 8) >= "20210501" And StringLeft($array[$i][24], 8) <= "20210531" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $masodik_lista)
			EndIf
		;~ harmadik lista
			If StringLeft($array[$i][4], 1) = "1" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][16], 8) >= "20210601" And StringLeft($array[$i][16], 8) <= "20210631" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][16], 4) & "." & StringMid($array[$i][16], 5, 2) & "." & StringMid($array[$i][16], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $harmadik_lista)
			ElseIf StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][24], 8) >= "20210601" And StringLeft($array[$i][24], 8) <= "20210631" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $harmadik_lista)
			EndIf
		;~ készlet
			If StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][24], 8) > "2021" & $honap & "31" And StringLeft($array[$i][12], 1) = $tipusn Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $keszletn_lista)
			ElseIf StringLeft($array[$i][4], 1) = "3" And StringLeft($array[$i][12], 1) = $tipusn Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $keszletn_lista)
			EndIf
		ElseIf $negyedev = 3 Then
			;~ első lista
			If StringLeft($array[$i][4], 1) = "1" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][16], 8) >= "20210701" And StringLeft($array[$i][16], 8) <= "20210731" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][16], 4) & "." & StringMid($array[$i][16], 5, 2) & "." & StringMid($array[$i][16], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $elso_lista)
			ElseIf StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][24], 8) >= "20210701" And StringLeft($array[$i][24], 8) <= "20210731" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $elso_lista)
			EndIf
		;~ második lista
			If StringLeft($array[$i][4], 1) = "1" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][16], 8) >= "20210801" And StringLeft($array[$i][16], 8) <= "20210831" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][16], 4) & "." & StringMid($array[$i][16], 5, 2) & "." & StringMid($array[$i][16], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $masodik_lista)
			ElseIf StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][24], 8) >= "20210801" And StringLeft($array[$i][24], 8) <= "20210831" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $masodik_lista)
			EndIf
		;~ harmadik lista
			If StringLeft($array[$i][4], 1) = "1" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][16], 8) >= "20210901" And StringLeft($array[$i][16], 8) <= "20210931" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][16], 4) & "." & StringMid($array[$i][16], 5, 2) & "." & StringMid($array[$i][16], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $harmadik_lista)
			ElseIf StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][24], 8) >= "20210901" And StringLeft($array[$i][24], 8) <= "20210931" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $harmadik_lista)
			EndIf
		;~ készlet
			If StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][24], 8) > "2021" & $honap & "31" And StringLeft($array[$i][12], 1) = $tipusn Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $keszletn_lista)
			ElseIf StringLeft($array[$i][4], 1) = "3" And StringLeft($array[$i][12], 1) = $tipusn Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $keszletn_lista)
			EndIf
		ElseIf $negyedev = 4 Then
			;~ első lista
			If StringLeft($array[$i][4], 1) = "1" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][16], 8) >= "20211001" And StringLeft($array[$i][16], 8) <= "20211031" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][16], 4) & "." & StringMid($array[$i][16], 5, 2) & "." & StringMid($array[$i][16], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $elso_lista)
			ElseIf StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][24], 8) >= "20211001" And StringLeft($array[$i][24], 8) <= "20211031" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $elso_lista)
			EndIf
		;~ második lista
			If StringLeft($array[$i][4], 1) = "1" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][16], 8) >= "20211101" And StringLeft($array[$i][16], 8) <= "20211131" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][16], 4) & "." & StringMid($array[$i][16], 5, 2) & "." & StringMid($array[$i][16], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $masodik_lista)
			ElseIf StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][24], 8) >= "20211101" And StringLeft($array[$i][24], 8) <= "20211131" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $masodik_lista)
			EndIf
		;~ harmadik lista
			If StringLeft($array[$i][4], 1) = "1" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][16], 8) >= "20211201" And StringLeft($array[$i][16], 8) <= "20211231" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][16], 4) & "." & StringMid($array[$i][16], 5, 2) & "." & StringMid($array[$i][16], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $harmadik_lista)
			ElseIf StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][12], 1) = $tipusn And StringLeft($array[$i][24], 8) >= "20211201" And StringLeft($array[$i][24], 8) <= "20211231" Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $harmadik_lista)
			EndIf
		;~ készlet
			If StringLeft($array[$i][4], 1) = "2" And StringLeft($array[$i][24], 8) > "2021" & $honap & "31" And StringLeft($array[$i][12], 1) = $tipusn Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $keszletn_lista)
			ElseIf StringLeft($array[$i][4], 1) = "3" And StringLeft($array[$i][12], 1) = $tipusn Then
				GUICtrlCreateListViewItem($array[$i][2] & "|" & $array[$i][9] & " " & $array[$i][10] & "|" & $array[$i][11] & "|" & StringLeft($array[$i][13], 1) & "|" & StringLeft($array[$i][24], 4) & "." & StringMid($array[$i][24], 5, 2) & "." & StringMid($array[$i][24], 7, 2) & "|" & StringLeft($array[$i][1], 2) & "|" & $array[$i][6] , $keszletn_lista)
			EndIf
		EndIf

	Next

EndFunc

Func _Form2($honap)
	$Form2 = GUICreate("Settings",  698, 675, -1, -1)
	$Label1 = GUICtrlCreateLabel("Astra", 96, 88, 44, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$astra85 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "astra", "0"), ",")[1], 160, 88, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$astra100 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "astra", "0"), ",")[2], 320, 88, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$astra115 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "astra", "0"), ",")[3], 480, 88, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$Label2 = GUICtrlCreateLabel("85%", 208, 56, 37, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$Label3 = GUICtrlCreateLabel("100%", 360, 56, 46, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$Label4 = GUICtrlCreateLabel("115%", 520, 56, 46, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$Label5 = GUICtrlCreateLabel("Combo", 83, 128, 57, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$combo85 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "combo", "0"), ",")[1], 160, 128, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$combo100 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "combo", "0"), ",")[2], 320, 128, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$combo115 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "combo", "0"), ",")[3], 480, 128, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$Label6 = GUICtrlCreateLabel("Corsa", 91, 168, 49, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$corsa85 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "corsa", "0"), ",")[1], 160, 168, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$corsa100 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "corsa", "0"), ",")[2], 320, 168, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$corsa115 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "corsa", "0"), ",")[3], 480, 168, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$Label7 = GUICtrlCreateLabel("Crossland", 60, 208, 80, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$crossland85 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "crossland", "0"), ",")[1], 160, 208, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$crossland100 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "crossland", "0"), ",")[2], 320, 208, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$crossland115 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "crossland", "0"), ",")[3], 480, 208, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$Label8 = GUICtrlCreateLabel("Grandland", 59, 248, 81, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$grandland85 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "grandland", "0"), ",")[1], 160, 248, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$grandland100 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "grandland", "0"), ",")[2], 320, 248, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$grandland115 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "grandland", "0"), ",")[3], 480, 248, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$Label9 = GUICtrlCreateLabel("Insignia", 79, 288, 61, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$insignia85 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "insignia", "0"), ",")[1], 160, 288, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$insignia100 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "insignia", "0"), ",")[2], 320, 288, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$insignia115 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "insignia", "0"), ",")[3], 480, 288, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$Label10 = GUICtrlCreateLabel("Movano", 78, 328, 62, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$movano85 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "movano", "0"), ",")[1], 160, 328, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$movano100 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "movano", "0"), ",")[2], 320, 328, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$movano115 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "movano", "0"), ",")[3], 480, 328, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$Label11 = GUICtrlCreateLabel("Vivaro/Zafira", 42, 368, 98, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$vivaro85 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "vivaro", "0"), ",")[1], 160, 368, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$vivaro100 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "vivaro", "0"), ",")[2], 320, 368, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$vivaro115 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "vivaro", "0"), ",")[3], 480, 368, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$save_button = GUICtrlCreateButton("Save", 552, 512, 113, 49)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$honap_label = GUICtrlCreateLabel(GUICtrlRead($Combo2), 16, 16, 165, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$Label12 = GUICtrlCreateLabel("Corsa-e", 76, 408, 64, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$corsae85 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "corsae", "0"), ",")[1], 160, 408, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$corsae100 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "corsae", "0"), ",")[2], 320, 408, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$corsae115 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "corsae", "0"), ",")[3], 480, 408, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$Label13 = GUICtrlCreateLabel("Grandland Hibrid", 10, 448, 130, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$grandlandh85 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "grandlandh", "0"), ",")[1], 160, 448, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$grandlandh100 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "grandlandh", "0"), ",")[2], 320, 448, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$grandlandh115 = GUICtrlCreateInput(StringSplit(IniRead("co2.ini", $honap, "grandlandh", "0"), ",")[3], 480, 448, 121, 28)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$Group1 = GUICtrlCreateGroup("Global", 56, 536, 345, 105)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$Label14 = GUICtrlCreateLabel("Username", 96, 568, 81, 28)
	$Label15 = GUICtrlCreateLabel("Password", 96, 600, 78, 28)
	$Input1 = GUICtrlCreateInput(IniRead("co2.ini","global","user",""), 184, 568, 193, 28)
	$Input2 = GUICtrlCreateInput(IniRead("co2.ini","global","pass",""), 184, 600, 193, 28)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###
EndFunc   ;==>_Form2

Func _Form3()
	$Form3 = GUICreate("Negyedév", 1257, 943, -1, -1)
	GUISetFont(12, 400, 0, "Arial")
	$Combo1n = GUICtrlCreateCombo("Haszon", 24, 24, 153, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
		_GUICtrlComboBox_AddString($Combo1n, "Személy")
	$Combo2n = GUICtrlCreateCombo("", 208, 24, 65, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	    _GUICtrlComboBox_AddString($Combo2n, "Q1")
		_GUICtrlComboBox_AddString($Combo2n, "Q2")
		_GUICtrlComboBox_AddString($Combo2n, "Q3")
		_GUICtrlComboBox_AddString($Combo2n, "Q4")
		If @MON = 1 Or @MON = 2 or @MON = 3 Then _GUICtrlComboBox_SetCurSel($Combo2n,0)
		If @MON = 4 Or @MON = 5 or @MON = 6 Then _GUICtrlComboBox_SetCurSel($Combo2n,1)
		If @MON = 7 Or @MON = 8 or @MON = 9 Then _GUICtrlComboBox_SetCurSel($Combo2n,2)
		If @MON = 10 Or @MON = 11 or @MON = 12 Then _GUICtrlComboBox_SetCurSel($Combo2n,3)
	$elso_input = GUICtrlCreateLabel("", 336, 72, 57, 22)
	$Label1 = GUICtrlCreateLabel("Célszám:", 264, 72, 69, 22, $SS_RIGHT)
	$elso_lista = GUICtrlCreateListView("JOB | Modell | CO2 | Áll. | Forg./T dátum | E.kód | Vevő", 24, 96, 540, 222,$LBS_MULTIPLESEL)
		GUICtrlSetFont(-1, 10, 400, 0, "Arial")
		GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 85)
		GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 100)
	$elsodb_label = GUICtrlCreateLabel("elsodb_label", 472, 72, 93, 22,$SS_RIGHT)
	$bal1_gomb = GUICtrlCreateButton("<<<<", 592, 152, 65, 41)
	$jobb1_gomb = GUICtrlCreateButton(">>>>", 592, 216, 65, 41)
	$bal2_gomb = GUICtrlCreateButton("<<<<", 592, 448, 65, 41)
	$jobb2_gomb = GUICtrlCreateButton(">>>>", 592, 512, 65, 41)
	$bal3_gomb = GUICtrlCreateButton("<<<<", 592, 752, 65, 41)
	$jobb3_gomb = GUICtrlCreateButton(">>>>", 592, 816, 65, 41)
	$masodik_lista = GUICtrlCreateListView("JOB | Modell | CO2 | Áll. | Forg./T dátum | E.kód | Vevő", 24, 392, 540, 222,$LBS_MULTIPLESEL)
		GUICtrlSetFont(-1, 10, 400, 0, "Arial")
		GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 85)
		GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 100)
	$harmadik_lista = GUICtrlCreateListView("JOB | Modell | CO2 | Áll. | Forg./T dátum | E.kód | Vevő", 24, 688, 540, 222,$LBS_MULTIPLESEL)
		GUICtrlSetFont(-1, 10, 400, 0, "Arial")
		GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 85)
		GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 100)
	$keszletn_lista = GUICtrlCreateListView("JOB | Modell | CO2 | Áll. | Forg./T dátum | E.kód | Vevő", 688, 96, 540, 510,$LBS_MULTIPLESEL)
		GUICtrlSetFont(-1, 10, 400, 0, "Arial")
		GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 85)
		GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 100)
	$elso_label = GUICtrlCreateLabel("elsőhónap", 24, 72, 164, 22)
		if GUICtrlRead($Combo2n) = "Q1" Then GUICtrlSetData(-1,"Január")
		if GUICtrlRead($Combo2n) = "Q2" Then GUICtrlSetData(-1,"Április")
		if GUICtrlRead($Combo2n) = "Q3" Then GUICtrlSetData(-1,"Július")
		if GUICtrlRead($Combo2n) = "Q4" Then GUICtrlSetData(-1,"Október")
	$masodik_input = GUICtrlCreateLabel("", 336, 368, 57, 22)
	$Label2 = GUICtrlCreateLabel("Célszám:", 264, 368, 69, 22, $SS_RIGHT)
	$masodikdb_label = GUICtrlCreateLabel("masodikdb_label", 440, 368, 124, 22,$SS_RIGHT)
	$masodik_label = GUICtrlCreateLabel("másodikhónap", 24, 368, 163, 22)
		if GUICtrlRead($Combo2n) = "Q1" Then GUICtrlSetData(-1,"Február")
		if GUICtrlRead($Combo2n) = "Q2" Then GUICtrlSetData(-1,"Május")
		if GUICtrlRead($Combo2n) = "Q3" Then GUICtrlSetData(-1,"Augusztus")
		if GUICtrlRead($Combo2n) = "Q4" Then GUICtrlSetData(-1,"November")
	$harmadik_input = GUICtrlCreateLabel("", 336, 664, 57, 22)
	$Label3 = GUICtrlCreateLabel("Célszám:", 264, 664, 69, 22, $SS_RIGHT)
	$harmadikdb_label = GUICtrlCreateLabel("harmadikdb_label", 432, 664, 129, 22,$SS_RIGHT)
	$harmadik_label = GUICtrlCreateLabel("harmadikhónap", 24, 664, 160, 22)
		if GUICtrlRead($Combo2n) = "Q1" Then GUICtrlSetData(-1,"Március")
		if GUICtrlRead($Combo2n) = "Q2" Then GUICtrlSetData(-1,"Június")
		if GUICtrlRead($Combo2n) = "Q3" Then GUICtrlSetData(-1,"Szeptember")
		if GUICtrlRead($Combo2n) = "Q4" Then GUICtrlSetData(-1,"December")
	$Label4 = GUICtrlCreateLabel("Havi", 856, 792, 44, 26)
	GUICtrlSetFont(-1, 14, 800, 4, "Arial")
	GUICtrlSetColor(-1, 0x000000)
	$Label5 = GUICtrlCreateLabel("Negyedéves", 1056, 792, 118, 26)
	GUICtrlSetFont(-1, 14, 800, 4, "Arial")
	GUICtrlSetColor(-1, 0x000000)
	$Label6 = GUICtrlCreateLabel("Első:", 784, 656, 39, 22)
	$Label7 = GUICtrlCreateLabel("Második:", 755, 688, 68, 22)
	$Label8 = GUICtrlCreateLabel("Harmadik:", 747, 720, 76, 22)
	$elsovbp_label = GUICtrlCreateLabel("elsovbp_label", 840, 656, 100, 22)
	$masodikvbp_label = GUICtrlCreateLabel("masodikvbp_label", 840, 688, 131, 22)
	$harmadikvbp_label = GUICtrlCreateLabel("harmadikvbp_label", 840, 720, 136, 22)
	$havisumvbp_label = GUICtrlCreateLabel("havisumvbp_label", 816, 832, 128, 22)
	$negyedevesvbp_label = GUICtrlCreateLabel("negyedevesvbp_label", 1048, 832, 155, 22)

	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###
	Call("negyed_darabok")

EndFunc

Func negyed_darabok()
	if GUICtrlRead($Combo2n) = "Q1" then
		$honapn = "01"
		Call("listanegyedev",1)
		GUICtrlSetData($elsodb_label,_GUICtrlListView_GetItemCount($elso_lista)& " db")
		GUICtrlSetData($elso_input,IniRead("co2.ini","hdb","01","-"))
		GUICtrlSetData($masodikdb_label,_GUICtrlListView_GetItemCount($masodik_lista)& " db")
		GUICtrlSetData($masodik_input,IniRead("co2.ini","hdb","02","-"))
		GUICtrlSetData($harmadikdb_label,_GUICtrlListView_GetItemCount($harmadik_lista)& " db")
		GUICtrlSetData($harmadik_input,IniRead("co2.ini","hdb","03","-"))
	ElseIf GUICtrlRead($Combo2n) = "Q2" then
		$honapn = "04"
		Call("listanegyedev",2)
		GUICtrlSetData($elsodb_label,_GUICtrlListView_GetItemCount($elso_lista)& " db")
		GUICtrlSetData($elso_input,IniRead("co2.ini","hdb","04","-"))
		GUICtrlSetData($masodikdb_label,_GUICtrlListView_GetItemCount($masodik_lista)& " db")
		GUICtrlSetData($masodik_input,IniRead("co2.ini","hdb","05","-"))
		GUICtrlSetData($harmadikdb_label,_GUICtrlListView_GetItemCount($harmadik_lista)& " db")
		GUICtrlSetData($harmadik_input,IniRead("co2.ini","hdb","06","-"))
	ElseIf GUICtrlRead($Combo2n) = "Q3" then
		$honapn = "07"
		Call("listanegyedev",3)
		GUICtrlSetData($elsodb_label,_GUICtrlListView_GetItemCount($elso_lista)& " db")
		GUICtrlSetData($elso_input,IniRead("co2.ini","hdb","07","-"))
		GUICtrlSetData($masodikdb_label,_GUICtrlListView_GetItemCount($masodik_lista)& " db")
		GUICtrlSetData($masodik_input,IniRead("co2.ini","hdb","08","-"))
		GUICtrlSetData($harmadikdb_label,_GUICtrlListView_GetItemCount($harmadik_lista)& " db")
		GUICtrlSetData($harmadik_input,IniRead("co2.ini","hdb","09","-"))
	ElseIf GUICtrlRead($Combo2n) = "Q4" then
		$honapn = "10"
		Call("listanegyedev",4)
		GUICtrlSetData($elsodb_label,_GUICtrlListView_GetItemCount($elso_lista)& " db")
		GUICtrlSetData($elso_input,IniRead("co2.ini","hdb","10","-"))
		GUICtrlSetData($masodikdb_label,_GUICtrlListView_GetItemCount($masodik_lista)& " db")
		GUICtrlSetData($masodik_input,IniRead("co2.ini","hdb","11","-"))
		GUICtrlSetData($harmadikdb_label,_GUICtrlListView_GetItemCount($harmadik_lista)& " db")
		GUICtrlSetData($harmadik_input,IniRead("co2.ini","hdb","12","-"))
	EndIf
	if Call("percent",GUICtrlRead($elso_input),_GUICtrlListView_GetItemCount($elso_lista)) = 0 Then
		$vbp1 = 0
		GUICtrlSetData($elsovbp_label,FormatNum("0"))
	ElseIf Call("percent",GUICtrlRead($elso_input),_GUICtrlListView_GetItemCount($elso_lista)) = 1 Then
		$vbp1 = call("VBP",$honapn,1,$elso_lista)
		GUICtrlSetData($elsovbp_label,FormatNum($vbp1))
	ElseIf Call("percent",GUICtrlRead($elso_input),_GUICtrlListView_GetItemCount($elso_lista)) = 2 Then
		$vbp1 = call("VBP",$honapn,2,$elso_lista)
		GUICtrlSetData($elsovbp_label,FormatNum($vbp1))
	ElseIf Call("percent",GUICtrlRead($elso_input),_GUICtrlListView_GetItemCount($elso_lista)) = 3 Then
		$vbp1 = call("VBP",$honapn,3,$elso_lista)
		GUICtrlSetData($elsovbp_label,FormatNum($vbp1))
	EndIf
	if Call("percent",GUICtrlRead($masodik_input),_GUICtrlListView_GetItemCount($masodik_lista)) = 0 Then
		$vbp2 = 0
		GUICtrlSetData($masodikvbp_label,FormatNum("0"))
	ElseIf Call("percent",GUICtrlRead($masodik_input),_GUICtrlListView_GetItemCount($masodik_lista)) = 1 Then
		$vbp2 = call("VBP",StringFormat("%02d", $honapn + 1),1,$masodik_lista)
		GUICtrlSetData($masodikvbp_label,FormatNum($vbp2))
	ElseIf Call("percent",GUICtrlRead($masodik_input),_GUICtrlListView_GetItemCount($masodik_lista)) = 2 Then
		$vbp2 = call("VBP",StringFormat("%02d", $honapn + 1),2,$masodik_lista)
		GUICtrlSetData($masodikvbp_label,FormatNum($vbp2))
	ElseIf Call("percent",GUICtrlRead($masodik_input),_GUICtrlListView_GetItemCount($masodik_lista)) = 3 Then
		$vbp2 = call("VBP",StringFormat("%02d", $honapn + 1),3,$masodik_lista)
		GUICtrlSetData($masodikvbp_label,FormatNum($vbp2))
	EndIf
	if Call("percent",GUICtrlRead($harmadik_input),_GUICtrlListView_GetItemCount($harmadik_lista)) = 0 Then
		$vbp3 = 0
		GUICtrlSetData($harmadikvbp_label,FormatNum("0"))
	ElseIf Call("percent",GUICtrlRead($harmadik_input),_GUICtrlListView_GetItemCount($harmadik_lista)) = 1 Then
		$vbp3 = call("VBP",StringFormat("%02d", $honapn + 2),1,$harmadik_lista)
		GUICtrlSetData($harmadikvbp_label,FormatNum($vbp3))
	ElseIf Call("percent",GUICtrlRead($harmadik_input),_GUICtrlListView_GetItemCount($harmadik_lista)) = 2 Then
		$vbp3 = call("VBP",StringFormat("%02d", $honapn + 2),2,$harmadik_lista)
		GUICtrlSetData($harmadikvbp_label,FormatNum($vbp3))
	ElseIf Call("percent",GUICtrlRead($harmadik_input),_GUICtrlListView_GetItemCount($harmadik_lista)) = 3 Then
		$vbp3 = call("VBP",StringFormat("%02d", $honapn + 2),3,$harmadik_lista)
		GUICtrlSetData($harmadikvbp_label,FormatNum($vbp3))
	EndIf
	GUICtrlSetData($havisumvbp_label,FormatNum($vbp1+$vbp2+$vbp3))
	if Call("percent",GUICtrlRead($elso_input)+GUICtrlRead($masodik_input)+GUICtrlRead($harmadik_input),_GUICtrlListView_GetItemCount($harmadik_lista)+_GUICtrlListView_GetItemCount($elso_lista)+_GUICtrlListView_GetItemCount($masodik_lista)) = 0 Then
		GUICtrlSetData($negyedevesvbp_label,FormatNum("0"))
	ElseIf Call("percent",GUICtrlRead($elso_input)+GUICtrlRead($masodik_input)+GUICtrlRead($harmadik_input),_GUICtrlListView_GetItemCount($harmadik_lista)+_GUICtrlListView_GetItemCount($elso_lista)+_GUICtrlListView_GetItemCount($masodik_lista)) = 1 Then
		GUICtrlSetData($negyedevesvbp_label,FormatNum(call("VBP",StringFormat("%02d", $honapn + 1),1,$masodik_lista)+call("VBP",$honapn,1,$elso_lista)+call("VBP",StringFormat("%02d", $honapn + 2),1,$harmadik_lista)))
	ElseIf Call("percent",GUICtrlRead($elso_input)+GUICtrlRead($masodik_input)+GUICtrlRead($harmadik_input),_GUICtrlListView_GetItemCount($harmadik_lista)+_GUICtrlListView_GetItemCount($elso_lista)+_GUICtrlListView_GetItemCount($masodik_lista)) = 2 Then
		GUICtrlSetData($negyedevesvbp_label,FormatNum(call("VBP",StringFormat("%02d", $honapn + 1),2,$masodik_lista)+call("VBP",$honapn,2,$elso_lista)+call("VBP",StringFormat("%02d", $honapn + 2),2,$harmadik_lista)))
	ElseIf Call("percent",GUICtrlRead($elso_input)+GUICtrlRead($masodik_input)+GUICtrlRead($harmadik_input),_GUICtrlListView_GetItemCount($harmadik_lista)+_GUICtrlListView_GetItemCount($elso_lista)+_GUICtrlListView_GetItemCount($masodik_lista)) = 3 Then
		GUICtrlSetData($negyedevesvbp_label,FormatNum(call("VBP",StringFormat("%02d", $honapn + 1),3,$masodik_lista)+call("VBP",$honapn,3,$elso_lista)+call("VBP",StringFormat("%02d", $honapn + 2),3,$harmadik_lista)))
	EndIf
EndFunc

Func percent($x,$y)
	if Round($x * 0.85) > $y then Return 0
	if $x > $y and $y >= Round($x * 0.85) then Return 1
	if Round($x * 1.15) > $y and $y >= $x Then Return 2
	if Round($x * 1.15) <= $y then Return 3
EndFunc

Func AM()
	if FileExists("R:\Exe\Am0aauy.exe") = 0 Then
		MsgBox(0,"Hiba","Az Automaster nem elérhető!")
		Return
	EndIf
	Run("R:\Exe\Am0aauy.exe")
	WinWaitActive("Login to AutoMaster DMS")
	Send("{ENTER}")
	WinWaitActive("Jármű - Tormási")
	Send("^f")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("^v")
	Send("{ENTER}")
EndFunc

Func IEGlobal()
	$User_Name = IniRead("co2.ini","global","user","0")
	$User_Password = IniRead("co2.ini","global","pass","0")
	$oIE = _IECreate("https://dealerportal.opel-group.com/usmentosso/UI/Login?goto=https%3A%2F%2Fdealerportal.opel-group.com%3A443%2F" , Default , 1)
	_IELoadWait($oIE)
;~ 	WinActive("[CLASS:IEFrame]","Access Denied")
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
;~ 	if WinWaitActive("Rendelés Munkaasztal","",6) = 0 then MsgBox(0,"","Hiba, próbáld újra")
	$oIE = _IEAttach(WinWaitActive("Rendelés Munkaasztal","",6),"hwnd")
	_IELoadWait($oIE)
	Sleep(2000)
	_IEImgClick($oIE,"Image102","id")
	$job = _IEGetObjById($oIE,"vehicleNumber")
	_IEFormElementSetValue($job,ClipGet())
	Send("{ENTER}")
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


_GUICtrlListView_RegisterSortCallBack($forghely_lista)
_GUICtrlListView_RegisterSortCallBack($terv_lista)
_GUICtrlListView_RegisterSortCallBack($keszlet_lista)
While 1
	$nMsg = GUIGetMsg(1)
	Switch $nMsg[1]
		Case $Form1
			Switch $nMsg[0]

				Case $GUI_EVENT_CLOSE
					Exit
				Case $terv_lista_am
					For $i = 0 To _GUICtrlListView_GetItemCount($terv_lista) - 1
						If _GUICtrlListView_GetItemFocused($terv_lista, $i) = True Then
							ClipPut(_GUICtrlListView_GetItemText($terv_lista, $i))
							Call("AM")
							ExitLoop
						EndIf
					Next
				Case $keszlet_lista_am
					For $i = 0 To _GUICtrlListView_GetItemCount($keszlet_lista) - 1
						If _GUICtrlListView_GetItemFocused($keszlet_lista, $i) = True Then
							ClipPut(_GUICtrlListView_GetItemText($keszlet_lista, $i))
							Call("AM")
							ExitLoop
						EndIf
					Next
				Case $forghely_lista_am
					For $i = 0 To _GUICtrlListView_GetItemCount($forghely_lista) - 1
						If _GUICtrlListView_GetItemFocused($forghely_lista, $i) = True Then
							ClipPut(_GUICtrlListView_GetItemText($forghely_lista, $i))
							Call("AM")
							ExitLoop
						EndIf
					Next
				Case $terv_lista_globalfelv
					For $i = 0 To _GUICtrlListView_GetItemCount($terv_lista) - 1
						If _GUICtrlListView_GetItemFocused($terv_lista, $i) = True Then
							ClipPut(_GUICtrlListView_GetItemText($terv_lista, $i))
							ExitLoop
						EndIf
					Next
					Call("IEGlobal")
				Case $forghely_lista_globalfelv
					For $i = 0 To _GUICtrlListView_GetItemCount($forghely_lista) - 1
						If _GUICtrlListView_GetItemFocused($forghely_lista, $i) = True Then
							ClipPut(_GUICtrlListView_GetItemText($forghely_lista, $i))
							ExitLoop
						EndIf
					Next
					Call("IEGlobal")
				Case $keszlet_lista_globalfelv
					For $i = 0 To _GUICtrlListView_GetItemCount($keszlet_lista) - 1
						If _GUICtrlListView_GetItemFocused($keszlet_lista, $i) = True Then
							ClipPut(_GUICtrlListView_GetItemText($keszlet_lista, $i))
							ExitLoop
						EndIf
					Next
					Call("IEGlobal")
				Case $terv_lista_info
					For $i = 0 To _GUICtrlListView_GetItemCount($terv_lista) - 1
						If _GUICtrlListView_GetItemFocused($terv_lista, $i) = True Then
							$job = _GUICtrlListView_GetItemText($terv_lista,$i)
							ExitLoop
						EndIf
					Next
					$sor =_ArraySearch($array,$job,0,0,0,0,1,2,False)
					For $i = 1 to UBound($array,2)-1
						$text &= $array[UBound($array)-1][$i] &": "&$array[$sor][$i]&@CRLF
					Next
					MsgBox(0,"INFO",$text)
					$text = ""
				Case $forghely_lista_info
					For $i = 0 To _GUICtrlListView_GetItemCount($forghely_lista) - 1
						If _GUICtrlListView_GetItemFocused($forghely_lista, $i) = True Then
							$job = _GUICtrlListView_GetItemText($forghely_lista,$i)
							ExitLoop
						EndIf
					Next
					$sor =_ArraySearch($array,$job,0,0,0,0,1,2,False)
					For $i = 1 to UBound($array,2)-1
						$text &= $array[UBound($array)-1][$i] &": "&$array[$sor][$i]&@CRLF
					Next
					MsgBox(0,"INFO",$text)
					$text = ""
				Case $keszlet_lista_info
					For $i = 0 To _GUICtrlListView_GetItemCount($keszlet_lista) - 1
						If _GUICtrlListView_GetItemFocused($keszlet_lista, $i) = True Then
							$job = _GUICtrlListView_GetItemText($keszlet_lista,$i)
							ExitLoop
						EndIf
					Next
					$sor =_ArraySearch($array,$job,0,0,0,0,1,2,False)
					For $i = 1 to UBound($array,2)-1
						$text &= $array[UBound($array)-1][$i] &": "&$array[$sor][$i]&@CRLF
					Next
					MsgBox(0,"INFO",$text)
					$text = ""
				Case $Combo1
					If GUICtrlRead($Combo1) = "Haszon" Then
						_GUICtrlListView_DeleteAllItems($forghely_lista)
						_GUICtrlListView_DeleteAllItems($terv_lista)
						_GUICtrlListView_DeleteAllItems($keszlet_lista)
						_GUICtrlComboBox_SetCurSel($Combo2, @MON - 1)
						Call(lista("H", @MON))
					ElseIf GUICtrlRead($Combo1) = "Személy" Then
						_GUICtrlListView_DeleteAllItems($forghely_lista)
						_GUICtrlListView_DeleteAllItems($terv_lista)
						_GUICtrlListView_DeleteAllItems($keszlet_lista)
						_GUICtrlComboBox_SetCurSel($Combo2, @MON - 1)
						Call(lista("S", @MON))
					EndIf
				Case $Combo2
					If GUICtrlRead($Combo1) = "Személy" Then
						If GUICtrlRead($Combo2) = "Január" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							$honap = "01"
							Call(lista("S", "01"))
						ElseIf GUICtrlRead($Combo2) = "Február" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							$honap = "02"
							Call(lista("S", "02"))
						ElseIf GUICtrlRead($Combo2) = "Március" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							$honap = "03"
							Call(lista("S", "03"))
						ElseIf GUICtrlRead($Combo2) = "Április" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							$honap = "04"
							Call(lista("S", "04"))
						ElseIf GUICtrlRead($Combo2) = "Május" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							$honap = "05"
							Call(lista("S", "05"))
						ElseIf GUICtrlRead($Combo2) = "Június" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							$honap = "06"
							Call(lista("S", "06"))
						ElseIf GUICtrlRead($Combo2) = "Július" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							$honap = "07"
							Call(lista("S", "07"))
						ElseIf GUICtrlRead($Combo2) = "Augusztus" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							$honap = "08"
							Call(lista("S", "08"))
						ElseIf GUICtrlRead($Combo2) = "Szeptember" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							$honap = "09"
							Call(lista("S", "09"))
						ElseIf GUICtrlRead($Combo2) = "Október" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							$honap = "10"
							Call(lista("S", "10"))
						ElseIf GUICtrlRead($Combo2) = "November" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							$honap = "11"
							Call(lista("S", "11"))
						ElseIf GUICtrlRead($Combo2) = "December" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							$honap = "12"
							Call(lista("S", "12"))
						EndIf
					ElseIf GUICtrlRead($Combo1) = "Haszon" Then
						If GUICtrlRead($Combo2) = "Január" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							Call(lista("H", "01"))
						ElseIf GUICtrlRead($Combo2) = "Február" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							Call(lista("H", "02"))
						ElseIf GUICtrlRead($Combo2) = "Március" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							Call(lista("H", "03"))
						ElseIf GUICtrlRead($Combo2) = "Április" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							Call(lista("H", "04"))
						ElseIf GUICtrlRead($Combo2) = "Május" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							Call(lista("H", "05"))
						ElseIf GUICtrlRead($Combo2) = "Június" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							Call(lista("H", "06"))
						ElseIf GUICtrlRead($Combo2) = "Július" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							Call(lista("H", "07"))
						ElseIf GUICtrlRead($Combo2) = "Augusztus" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							Call(lista("H", "08"))
						ElseIf GUICtrlRead($Combo2) = "Szeptember" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							Call(lista("H", "09"))
						ElseIf GUICtrlRead($Combo2) = "Október" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							Call(lista("H", "10"))
						ElseIf GUICtrlRead($Combo2) = "November" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							Call(lista("H", "11"))
						ElseIf GUICtrlRead($Combo2) = "December" Then
							_GUICtrlListView_DeleteAllItems($forghely_lista)
							_GUICtrlListView_DeleteAllItems($terv_lista)
							_GUICtrlListView_DeleteAllItems($keszlet_lista)
							Call(lista("H", "12"))
						EndIf
					EndIf
				Case $forghely_lista
					_GUICtrlListView_SortItems($forghely_lista, GUICtrlGetState($forghely_lista))
				Case $terv_lista
					_GUICtrlListView_SortItems($terv_lista, GUICtrlGetState($terv_lista))
				Case $keszlet_lista
					_GUICtrlListView_SortItems($keszlet_lista, GUICtrlGetState($keszlet_lista))
				Case $co2cel_input
					If _GUICtrlComboBox_GetCurSel($Combo2) >= "9" Then
						GUICtrlSetData($co2cel_input, StringReplace(GUICtrlRead($co2cel_input), ",", "."))
						IniWrite("co2.ini", "co2", _GUICtrlComboBox_GetCurSel($Combo2) + 1, StringReplace(GUICtrlRead($co2cel_input), ",", "."))
					Else
						GUICtrlSetData($co2cel_input, StringReplace(GUICtrlRead($co2cel_input), ",", "."))
						IniWrite("co2.ini", "co2", "0" & (_GUICtrlComboBox_GetCurSel($Combo2) + 1), StringReplace(GUICtrlRead($co2cel_input), ",", "."))
					EndIf
					Call("feliratok", $honap)
				Case $celszam_input
					If GUICtrlRead($Combo1) = "Személy" Then
						If _GUICtrlComboBox_GetCurSel($Combo2) >= "9" Then
							IniWrite("co2.ini", "sdb", _GUICtrlComboBox_GetCurSel($Combo2) + 1, GUICtrlRead($celszam_input))
						Else
							IniWrite("co2.ini", "sdb", "0" & (_GUICtrlComboBox_GetCurSel($Combo2) + 1), GUICtrlRead($celszam_input))
						EndIf
					ElseIf GUICtrlRead($Combo1) = "Haszon" Then
						If _GUICtrlComboBox_GetCurSel($Combo2) >= "9" Then
							IniWrite("co2.ini", "hdb", _GUICtrlComboBox_GetCurSel($Combo2) + 1, GUICtrlRead($celszam_input))
						Else
							IniWrite("co2.ini", "hdb", "0" & (_GUICtrlComboBox_GetCurSel($Combo2)+1), GUICtrlRead($celszam_input))
						EndIf
					EndIf
					Call("feliratok",$honap)
				Case $bal_gomb
					$index1 = _GUICtrlListView_GetSelectedIndices($keszlet_lista, True)
					For $i = 1 To $index1[0]
						GUICtrlCreateListViewItem(_GUICtrlListView_GetItemTextString($keszlet_lista, $index1[$i]), $terv_lista)
					Next
					_GUICtrlListView_DeleteItemsSelected($keszlet_lista)
					Call("feliratok", $honap)
				Case $jobb_gomb
					$index2 = _GUICtrlListView_GetSelectedIndices($terv_lista, True)
					For $i = 1 To $index2[0]
						GUICtrlCreateListViewItem(_GUICtrlListView_GetItemTextString($terv_lista, $index2[$i]), $keszlet_lista)
					Next
					_GUICtrlListView_DeleteItemsSelected($terv_lista)
					Call("feliratok", $honap)
				Case $Checkbox1
					_GUICtrlListView_SetItemSelected($terv_lista, -1)
				Case $Checkbox2
					_GUICtrlListView_SetItemSelected($keszlet_lista, -1)
				Case $Input1
					Call("feliratok", $honap)
				Case $reset_gomb
					_GUICtrlListView_DeleteAllItems($forghely_lista)
					_GUICtrlListView_DeleteAllItems($terv_lista)
					_GUICtrlListView_DeleteAllItems($keszlet_lista)
					_GUICtrlComboBox_SetCurSel($Combo2, @MON - 1)
					_GUICtrlComboBox_SetCurSel($Combo1, 0)
					Call(lista)
					GUICtrlSetResizing($Form1,$GUI_DOCKAUTO)
				Case $excelexport_gomb
					 local $ujexcel = _Excel_Open()
					 $munkafuzet = _Excel_BookNew($ujexcel)
					 $a = _GUICtrlListView_GetItemCount($forghely_lista)
					 _Excel_RangeWrite($munkafuzet,1,"Forg. hely.","A1")
					 _Excel_RangeWrite($munkafuzet,1,"Tervezett","A"&$a+1)


					 $i = 0
					 Do
						 if $a=0 Then ExitLoop
						_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($forghely_lista,$i,0),"B"&$i+1)
						_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($forghely_lista,$i,1),"C"&$i+1)
						_Excel_RangeWrite($munkafuzet,1,StringReplace(_GUICtrlListView_GetItemText($forghely_lista,$i,2),".",","),"D"&$i+1)
						_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($forghely_lista,$i,3),"E"&$i+1)
						_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($forghely_lista,$i,4),"F"&$i+1)
						_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($forghely_lista,$i,5),"G"&$i+1)
						_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($forghely_lista,$i,6),"H"&$i+1)
						_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($forghely_lista,$i,7),"I"&$i+1)
						_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($forghely_lista,$i,8),"J"&$i+1)
						$i=$i+1
					 Until $i =  $a
					 $a += 1
					 $i = 0
					 Do
						_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($terv_lista,$i,0),"B"&$i+$a)
						_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($terv_lista,$i,1),"C"&$i+$a)
						_Excel_RangeWrite($munkafuzet,1,StringReplace(_GUICtrlListView_GetItemText($terv_lista,$i,2),".",","),"D"&$i+$a)
						_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($terv_lista,$i,3),"E"&$i+$a)
						_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($terv_lista,$i,4),"F"&$i+$a)
						_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($terv_lista,$i,5),"G"&$i+$a)
						_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($terv_lista,$i,6),"H"&$i+$a)
						_Excel_RangeWrite($munkafuzet,1,_GUICtrlListView_GetItemText($terv_lista,$i,7),"I"&$i+$a)
						$i=$i+1
					 Until $i =  _GUICtrlListView_GetItemCount($terv_lista)
					 $munkafuzet.ActiveSheet.Columns("A:J").Autofit
				Case $riportfriss_gomb
					$oIE = _IECreate("http://sqlserver3/Reports/Pages/Report.aspx?ItemPath=%2fTormasi+report%2f%c3%89rt%c3%a9kes%c3%adt%c3%a9s%2fJ%c3%a1rm%c5%b1%c3%a9rt%c3%a9kes%c3%adt%c3%a9si+tervez%c3%a9s")
					_IELoadWait($oIE)
					$kdatum = _IEGetObjById($oIE , "ctl32_ctl04_ctl09_txtValue")
					_IEFormElementSetValue($kdatum , "2021. 01. 01")
					$vdatum =_IEGetObjById($oIE , "ctl32_ctl04_ctl11_txtValue")
					_IEFormElementSetValue($vdatum , "2021. 12. 30")
					Sleep(2000)
					$o_Button = _IEGetObjById ( $oIE, "ctl32_ctl04_ctl00" )
					_IEAction ( $o_Button, "click" )
					_IELoadWait($oIE)
					Sleep(4000)
					$elemek = _IETagNameGetCollection($oIE,"a")
					for $elem In $elemek
						If StringInStr($elem.title,"Excel") > 0 Then
							_IEAction($elem,"focus")
							_IEAction($elem,"click")
							ExitLoop
						EndIf
					Next
					Sleep(3000)
					Send("!s")
					Sleep(2000)
					FileMove("C:\Users\kormoczi.botond\Downloads\Járműértékesítési tervezés.xlsx","N:\Botond\co2tervezoriport\Jármuértékesítési tervezés.xlsx",1)
					_IEQuit($oIE)
					MsgBox(0,"","Frissítés kész!")
					Call("adatload")
					GUICtrlSetData($adatdatum_label, $adatdatum[0] & "." & $adatdatum[1] & "." & $adatdatum[2] & " " & $adatdatum[3] & ":" & $adatdatum[4])
					_GUICtrlListView_DeleteAllItems($forghely_lista)
					_GUICtrlListView_DeleteAllItems($terv_lista)
					_GUICtrlListView_DeleteAllItems($keszlet_lista)
					_GUICtrlComboBox_SetCurSel($Combo2, @MON - 1)
					_GUICtrlComboBox_SetCurSel($Combo1, 0)
					Call(lista)
				Case $settings_button
					GUISetState(@SW_HIDE, $Form1)
					_Form2($honap)
				Case $negyedev_button
					GUISetState(@SW_HIDE, $Form1)
					_Form3()

			EndSwitch
		Case $Form2
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					Call("feliratok",$honap)
					GUIDelete($Form2)
					GUISetState(@SW_SHOW, $Form1)
				Case $save_button
					IniWrite("co2.ini",$honap,"astra",GUICtrlRead($astra85)&","&GUICtrlRead($astra100)&","&GUICtrlRead($astra115))
					IniWrite("co2.ini",$honap,"combo",GUICtrlRead($combo85)&","&GUICtrlRead($combo100)&","&GUICtrlRead($combo115))
					IniWrite("co2.ini",$honap,"corsa",GUICtrlRead($corsa85)&","&GUICtrlRead($corsa100)&","&GUICtrlRead($corsa115))
					IniWrite("co2.ini",$honap,"crossland",GUICtrlRead($crossland85)&","&GUICtrlRead($crossland100)&","&GUICtrlRead($crossland115))
					IniWrite("co2.ini",$honap,"grandland",GUICtrlRead($grandland85)&","&GUICtrlRead($grandland100)&","&GUICtrlRead($grandland115))
					IniWrite("co2.ini",$honap,"movano",GUICtrlRead($movano85)&","&GUICtrlRead($movano100)&","&GUICtrlRead($movano115))
					IniWrite("co2.ini",$honap,"insignia",GUICtrlRead($insignia85)&","&GUICtrlRead($insignia100)&","&GUICtrlRead($insignia115))
					IniWrite("co2.ini",$honap,"vivaro",GUICtrlRead($vivaro85)&","&GUICtrlRead($vivaro100)&","&GUICtrlRead($vivaro115))
					IniWrite("co2.ini",$honap,"corsae",GUICtrlRead($corsae85)&","&GUICtrlRead($corsae100)&","&GUICtrlRead($corsae115))
					IniWrite("co2.ini",$honap,"grandlandh",GUICtrlRead($grandlandh85)&","&GUICtrlRead($grandlandh100)&","&GUICtrlRead($grandlandh115))
					IniWrite("co2.ini","global","user",GUICtrlRead($Input1))
					IniWrite("co2.ini","global","pass",GUICtrlRead($Input2))
			EndSwitch
		Case $Form3
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					_GUICtrlListView_DeleteAllItems($elso_lista)
					_GUICtrlListView_DeleteAllItems($masodik_lista)
					_GUICtrlListView_DeleteAllItems($harmadik_lista)
					_GUICtrlListView_DeleteAllItems($keszletn_lista)
					GUIDelete($Form3)
					GUISetState(@SW_SHOW, $Form1)
				Case $bal1_gomb
					$index11 = _GUICtrlListView_GetSelectedIndices($keszletn_lista, True)
					For $i = 1 To $index11[0]
						GUICtrlCreateListViewItem(_GUICtrlListView_GetItemTextString($keszletn_lista, $index11[$i]), $elso_lista)
					Next
					_GUICtrlListView_DeleteItemsSelected($keszletn_lista)
					Call("negyed_darabok")
				Case $jobb1_gomb
					$index21 = _GUICtrlListView_GetSelectedIndices($elso_lista, True)
					For $i = 1 To $index21[0]
						GUICtrlCreateListViewItem(_GUICtrlListView_GetItemTextString($elso_lista, $index21[$i]), $keszletn_lista)
					Next
					_GUICtrlListView_DeleteItemsSelected($elso_lista)
					Call("negyed_darabok")
				Case $bal2_gomb
					$index12 = _GUICtrlListView_GetSelectedIndices($keszletn_lista, True)
					For $i = 1 To $index12[0]
						GUICtrlCreateListViewItem(_GUICtrlListView_GetItemTextString($keszletn_lista, $index12[$i]), $masodik_lista)
					Next
					_GUICtrlListView_DeleteItemsSelected($keszletn_lista)
					Call("negyed_darabok")
				Case $jobb2_gomb
					$index22 = _GUICtrlListView_GetSelectedIndices($masodik_lista, True)
					For $i = 1 To $index22[0]
						GUICtrlCreateListViewItem(_GUICtrlListView_GetItemTextString($masodik_lista, $index22[$i]), $keszletn_lista)
					Next
					_GUICtrlListView_DeleteItemsSelected($masodik_lista)
					Call("negyed_darabok")
				Case $bal3_gomb
					$index13 = _GUICtrlListView_GetSelectedIndices($keszletn_lista, True)
					For $i = 1 To $index13[0]
						GUICtrlCreateListViewItem(_GUICtrlListView_GetItemTextString($keszletn_lista, $index13[$i]), $harmadik_lista)
					Next
					_GUICtrlListView_DeleteItemsSelected($keszletn_lista)
					Call("negyed_darabok")
				Case $jobb3_gomb
					$index23 = _GUICtrlListView_GetSelectedIndices($harmadik_lista, True)
					For $i = 1 To $index23[0]
						GUICtrlCreateListViewItem(_GUICtrlListView_GetItemTextString($harmadik_lista, $index23[$i]), $keszletn_lista)
					Next
					_GUICtrlListView_DeleteItemsSelected($harmadik_lista)
					Call("negyed_darabok")
				Case $Combo2n
					if GUICtrlRead($Combo2n) = "Q1" Then
						_GUICtrlListView_DeleteAllItems($elso_lista)
						_GUICtrlListView_DeleteAllItems($masodik_lista)
						_GUICtrlListView_DeleteAllItems($harmadik_lista)
						_GUICtrlListView_DeleteAllItems($keszletn_lista)
						GUICtrlSetData($elso_label,"Január")
						GUICtrlSetData($masodik_label,"Február")
						GUICtrlSetData($harmadik_label,"Március")
						Call("listanegyedev","1")
					elseif GUICtrlRead($Combo2n) = "Q2" Then
						_GUICtrlListView_DeleteAllItems($elso_lista)
						_GUICtrlListView_DeleteAllItems($masodik_lista)
						_GUICtrlListView_DeleteAllItems($harmadik_lista)
						_GUICtrlListView_DeleteAllItems($keszletn_lista)
						GUICtrlSetData($elso_label,"Április")
						GUICtrlSetData($masodik_label,"Május")
						GUICtrlSetData($harmadik_label,"Június")
						Call("listanegyedev","2")
					elseif GUICtrlRead($Combo2n) = "Q3" Then
						_GUICtrlListView_DeleteAllItems($elso_lista)
						_GUICtrlListView_DeleteAllItems($masodik_lista)
						_GUICtrlListView_DeleteAllItems($harmadik_lista)
						_GUICtrlListView_DeleteAllItems($keszletn_lista)
						GUICtrlSetData($elso_label,"Július")
						GUICtrlSetData($masodik_label,"Augusztus")
						GUICtrlSetData($harmadik_label,"Szeptember")
						Call("listanegyedev","3")
					elseif GUICtrlRead($Combo2n) = "Q4" Then
						_GUICtrlListView_DeleteAllItems($elso_lista)
						_GUICtrlListView_DeleteAllItems($masodik_lista)
						_GUICtrlListView_DeleteAllItems($harmadik_lista)
						_GUICtrlListView_DeleteAllItems($keszletn_lista)
						GUICtrlSetData($elso_label,"Október")
						GUICtrlSetData($masodik_label,"November")
						GUICtrlSetData($harmadik_label,"December")
						Call("listanegyedev","4")
					EndIf
					Call("negyed_darabok")
			EndSwitch
	EndSwitch
WEnd
_GUICtrlListView_UnRegisterSortCallBack($forghely_lista)
_GUICtrlListView_UnRegisterSortCallBack($terv_lista)
_GUICtrlListView_UnRegisterSortCallBack($keszlet_lista)




