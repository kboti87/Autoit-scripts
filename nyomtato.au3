#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile_type=a3x
#AutoIt3Wrapper_Outfile=N:\Botond\autoit scriptek\munkalap_survey_nyomtato.a3x
#AutoIt3Wrapper_Res_Fileversion=0.0.0.4
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Word.au3>
#include <MsgBoxConstants.au3>
#include <Date.au3>


HotKeySet("^2", "progi")
While 1 ;loop forever to wait for the keypress
  Sleep(30000) ;no need to kill the CPU
WEnd


Func progi()

	local $ablaknev = WinGetTitle("[ACTIVE]")

	if StringInStr($ablaknev,"Munkalap - Munkalap") <> 0 Then
		Local $ertek = StringLeft($ablaknev,StringInStr($ablaknev,",")-1)
		Local $oWord = _Word_Create(False,True)
		local $oDoc = _Word_DocOpen($oWord, "N:\Botond\Munkalapszám_survey.docx",False,Default,True)
		if @error Then MsgBox(0,"Hiba","A file valamiért nem érheto el, szólj a Botinak")
		_Word_DocFindReplace($oDoc,"mlapsz",$ertek)
		_Word_DocFindReplace($oDoc,"date",_NowDate())
;~ 	 	_Word_DocPrint($oDoc)
		_Word_DocClose($oDoc)
	 	_Word_Quit($oWord)
	Else
		MsgBox(0,"Figyelem","Ez a program csak akkor futtatható, ha egy munkalap az aktív ablak!")
	EndIf
EndFunc



