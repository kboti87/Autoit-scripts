#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile_type=a3x
#AutoIt3Wrapper_Outfile=N:\Botond\autoit scriptek\munkalap_adatmasolo_V5.a3x
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
AutoItSetOption("WinTitleMatchMode", 2)

HotKeySet("^1", "Test1")
;~ HotKeySet("^1", "Test2")
While 1 ;loop forever to wait for the keypress
  Sleep(30000) ;no need to kill the CPU
WEnd

Func Test1()
   if StringMid(WinGetTitle("[ACTIVE]"),StringInStr(WinGetTitle("[ACTIVE]"),"-"),10)="- Munkalap" Then
	  Local $sText = WinGetTitle("[ACTIVE]")
	  WinMove($sText,"",0,0)
	  MouseClick($MOUSE_CLICK_RIGHT,166,201,1,1)
	  MouseClick($MOUSE_CLICK_LEFT,346,312,1,5)
	  MouseClick($MOUSE_CLICK_LEFT,500,310,1,5);vágólap
	  sleep(500)
	  Global $adat = ClipGet()
	  MouseClick($MOUSE_CLICK_LEFT,556,32,1,1)
	  MouseClick($MOUSE_CLICK_LEFT,600,157,1,10)
	  sleep(2000)
	  WinWait("Új feladat")
	  If WinActive("Új feladat") = 0 Then
		 MsgBox($MB_SYSTEMMODAL,"","HIBA történt, próbáld újra")
	  Else
		 MouseClick($MOUSE_CLICK_LEFT,126,87,1,1)
		 sleep(500)
		 Send(StringTrimRight($sText, StringLen($sText)-StringInStr($sText, '-')+2 ))
		 Send("{TAB 4}")
		 Send("0000000000")
		 Send("{TAB 9}")
		 Send("Sziasztok. Kérem az alábbi anyagok megrendelését. Köszönöm." & @LF&@LF)
		 Global $adat2 = StringSplit(StringReplace($adat,@TAB," "),@LF)
		 For $sor in $adat2
			   Send(StringMid($sor,StringInStr($sor,",",0,3)+2,StringInStr($sor,",",0,4)-StringInStr($sor,",",0,3)-2)&@LF)
		 Next
	  EndIf
   Else
	  MsgBox($MB_SYSTEMMODAL,"","Itt nem használható a program!" &@LF& "Munkalap ablakban indítsd a programot!")
   EndIf
EndFunc

Func Test2()
   if StringMid(WinGetTitle("[ACTIVE]"),StringInStr(WinGetTitle("[ACTIVE]"),"-"),10)="- Munkalap" Then
	  Local $sText = WinGetTitle("[ACTIVE]")
	  WinMove($sText,"",0,0)
	  Sleep(500)
	  MouseClick($MOUSE_CLICK_LEFT,556,32,1,1)
	  MouseClick($MOUSE_CLICK_LEFT,600,157,1,10)
	  sleep(2000)
	  WinWait("Új feladat")
	  If WinActive("Új feladat") = 0 Then
		 MsgBox($MB_SYSTEMMODAL,"","HIBA történt, próbáld újra")
	  Else
		 MouseClick($MOUSE_CLICK_LEFT,126,87,1,1)
		 sleep(500)
		 Send(StringTrimRight($sText, StringLen($sText)-StringInStr($sText, '-')+2 ))
		 Send("{TAB 4}")
		 Send("00000")
		 MouseClick($MOUSE_CLICK_LEFT,323,205,1,1)
		 Send("{TAB 3}")
	  EndIf
   Else
	  MsgBox($MB_SYSTEMMODAL,"","Itt nem használható a program!" &@LF& "Munkalap ablakban indítsd a programot!")
   EndIf
EndFunc

