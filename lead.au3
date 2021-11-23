#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile_type=a3x
#AutoIt3Wrapper_Icon=N:\Botond\autoit scriptek\icons\lead.ico
#AutoIt3Wrapper_Outfile=N:\Botond\autoit scriptek\lead.a3x
#AutoIt3Wrapper_Res_Fileversion=0.0.0.19
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Outlook.au3>
#include <Date.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiComboBox.au3>
#include <Misc.au3>
Opt("TrayAutoPause", 0)
TraySetIcon("N:\Botond\autoit scriptek\icons\lead.ico")
Global $updatescript = "updatescript.cmd"

UpdateCheck("lead.a3x")
HotKeySet("^l","Main")
While 1
	Sleep(10000)

WEnd

Func Main()
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Lead küldő", 615, 460, 192, 124)
GUISetIcon("N:\Botond\autoit scriptek\icons\tormasi.ico")
GUISetFont(10, 400, 0, "@Arial Unicode MS")
$Radio1 = GUICtrlCreateRadio("Kaczkó Norbert", 40, 72, 113, 17)
$Radio2 = GUICtrlCreateRadio("Lőrincz László", 40, 112, 113, 17)
$Radio3 = GUICtrlCreateRadio("Mészáros István", 40, 152, 113, 17)
$Radio4 = GUICtrlCreateRadio("Fakanné Zsuzsanna", 232, 72, 113, 17)
$Radio5 = GUICtrlCreateRadio("Sáfár Attila", 232, 112, 113, 17)
$Radio6 = GUICtrlCreateRadio("Tokay János", 232, 152, 113, 17)
$Radio7 = GUICtrlCreateRadio("Fekete László", 408, 72, 113, 17)
$Combo1 = GUICtrlCreateCombo("", 32, 208, 95, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
_GUICtrlComboBox_AddString($Combo1,"Opel")
_GUICtrlComboBox_AddString($Combo1,"Suzuki")
_GUICtrlComboBox_AddString($Combo1,"Használt")
$Combo2 = GUICtrlCreateCombo("", 152, 208, 95, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
$Input1 = GUICtrlCreateInput("", 152, 208, 89, 26)
GUICtrlSetState(-1, $GUI_DISABLE & $gui_HIDE)
$Label1 = GUICtrlCreateLabel("Név:", 80, 288, 31, 22)
$Label2 = GUICtrlCreateLabel("Telefonszám:", 28, 336, 83, 22)
$Label3 = GUICtrlCreateLabel("Email cím:", 45, 384, 66, 22)
$Input2 = GUICtrlCreateInput("", 128, 288, 150, 26)
$Input3 = GUICtrlCreateInput("", 128, 336, 150, 26)
$Input4 = GUICtrlCreateInput("", 128, 384, 150, 26)
GUICtrlCreatePic("N:\Botond\autoit scriptek\icons\opel.jpg",72,20,65,40)
GUICtrlCreatePic("N:\Botond\autoit scriptek\icons\suzuki.jpg",264,20,65,40)
GUICtrlCreatePic("N:\Botond\autoit scriptek\icons\tormasi.jpg",475,400,140,60)
$Edit1 = GUICtrlCreateEdit("", 344, 208, 233, 113, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_WANTRETURN,$ES_MULTILINE))
GUICtrlSetData(-1, "")
$Button1 = GUICtrlCreateButton("Küldés", 380, 340, 113, 41)
;~ $Label4 = GUICtrlCreateLabel("OPEL", 72, 24, 39, 22)
;~ $Label5 = GUICtrlCreateLabel("SUZUKI", 264, 24, 51, 22)
$Label6 = GUICtrlCreateLabel("Használt", 432, 24, 55, 22)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			GUISetState(@SW_HIDE)
		Case $Combo1
			if GUICtrlRead($Combo1) = "Opel" Then
				GUICtrlSetState($Input1,$GUI_DISABLE & $gui_HIDE)
				GUICtrlSetState($Combo2,$gui_enable & $gui_show)
				_GUICtrlComboBox_ResetContent($Combo2)
				_GUICtrlComboBox_AddString($Combo2,"Astra")
				_GUICtrlComboBox_AddString($Combo2,"Combo")
				_GUICtrlComboBox_AddString($Combo2,"Corsa")
				_GUICtrlComboBox_AddString($Combo2,"Crossland")
				_GUICtrlComboBox_AddString($Combo2,"Grandland")
				_GUICtrlComboBox_AddString($Combo2,"Insignia")
				_GUICtrlComboBox_AddString($Combo2,"Mokka")
				_GUICtrlComboBox_AddString($Combo2,"Movano")
				_GUICtrlComboBox_AddString($Combo2,"Vivaro")
				_GUICtrlComboBox_AddString($Combo2,"Egyéb")
			ElseIf  GUICtrlRead($Combo1) = "Suzuki" Then
				GUICtrlSetState($Input1,$GUI_DISABLE & $gui_HIDE)
				GUICtrlSetState($Combo2,$gui_enable & $gui_show)
				_GUICtrlComboBox_ResetContent($Combo2)
				_GUICtrlComboBox_AddString($Combo2,"SX4 S-Cross")
				_GUICtrlComboBox_AddString($Combo2,"Vitara")
				_GUICtrlComboBox_AddString($Combo2,"Ignis")
				_GUICtrlComboBox_AddString($Combo2,"Swift")
				_GUICtrlComboBox_AddString($Combo2,"Egyéb")
			ElseIf  GUICtrlRead($Combo1) = "Használt" Then
				GUICtrlSetState($Combo2,$GUI_DISABLE & $gui_HIDE)
				GUICtrlSetState($Input1,$gui_enable & $gui_show)
			EndIf
		Case $Button1
			if $Radio1 = True Then $kinek = "kaczko.norbert@tormasi.hu"
			if $Radio2 = True Then $kinek = "lorincz.laszlo@tormasi.hu"
			if $Radio3 = True Then $kinek = "m.istvan@tormasi.hu"
			if $Radio4 = True Then $kinek = "fakan.dezsone@tormasi.hu"
			if $Radio5 = True Then $kinek = "safar.attila@tormasi.hu"
			if $Radio6 = True Then $kinek = "tokay.janos@tormasi.hu"
			if $Radio7 = True Then $kinek = "fekete.laszlo@tormasi.hu"
			$marka = GUICtrlRead($Combo1)
			if GUICtrlRead($Input1) <> "" and GUICtrlGetState($Input1) = 80 Then
				$modell = GUICtrlRead($Input1)
			Else
				$modell = GUICtrlRead($Combo2)
			EndIf
			$nev = GUICtrlRead($Input2)
			$tel = GUICtrlRead($Input3)
			$email = GUICtrlRead($Input4)
			$textbox = GUICtrlRead($Edit1)
			$body = "Az alábbi lead érkezett be:" & @CRLF & @CRLF & "Márka: " & $marka & @CRLF & "Modell: " & $modell & @CRLF & "Név: " & $nev & @CRLF & "Telefonszám: " & $tel & @CRLF & "Email cím: " & $email _
			& @CRLF & @CRLF & $textbox
			$subject = "Telefonos lead - " & _Now()
			$oO = _OutlookOpen()
			_OutlookSendMail($oO,$kinek &";fruttus.arpad@tormasi.hu","","",$subject,$body)
			GUISetState(@SW_HIDE)
	EndSwitch
WEnd

EndFunc

Func UpdateCheck($script)
	if StringRight($script,3) = "exe" Then
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
	ElseIf StringRight($script,3) = "a3x" Then
		$CurrentVersion = FileGetTime(@ScriptFullPath,0,1)
		$LastVersion = FileGetTime("N:\Botond\autoit scriptek\" & $script,0,1)
		if $LastVersion > $CurrentVersion Then
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
			Run( $updatescript, @ScriptDir,@SW_HIDE) ;launch batch file in hidden mode
			Exit ;exit so batch file can continue
		EndIf
	EndIf
EndFunc   ;==>UpdateCheck
