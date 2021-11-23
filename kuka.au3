#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile_type=a3x
#AutoIt3Wrapper_Outfile=N:\Botond\autoit scriptek\kuka\kuka.a3x
#AutoIt3Wrapper_Res_Fileversion=1.0.0.6
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <File.au3>
#include <Misc.au3>

ConsoleWrite(@ScriptName & @CRLF)

;~ UpdateCheck("kuka.a3x")

;~ HotKeySet("^k","valami")
;~ ConsoleWrite(FileGetVersion(@ScriptFullPath) & @CRLF)
;~ While 1
;~ 	Sleep(1000)
;~ WEnd

;~ Func valami()
;~ 	MsgBox(0,"","ez már updatelt!!")
;~ EndFunc

;~ Func UpdateCheck($script)

;~ $CurrentVersion = StringRight(@ScriptName,
;~ $LastVersion = FileGetVersion("N:\Botond\autoit scriptek\" & $script)
;~ If _VersionCompare($CurrentVersion,$LastVersion) = -1 Then
;~   FileDelete(@ScriptFullPath)
;~   TrayTip("Updater", "Updating. . .", "", 2)
;~   FileCopy("N:\Botond\autoit scriptek\" & $script, @ScriptDir)
;~   Run(@ScriptName)
;~   Exit
;~ EndIf
;~ EndFunc   ;==>UpdateCheck