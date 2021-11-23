#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>

HotKeySet("^0", "Test") ;wait for ALT-a keystroke, then go to Main()
While 1 ;loop forever to wait for the keypress
  Sleep(1000) ;no need to kill the CPU
  if @HOUR=18 then Exit
WEnd

Func Test()
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
	  WinWaitActive("Új feladat - ","",10)
	  sleep(1000)
	  If WinGetTitle("[ACTIVE]") <> "Új feladat - " Then
		 MsgBox(65536,"","HIBA történt, próbáld újra")
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
			if StringLeft($sor,1)="p" Then
			   Send(StringMid($sor,StringInStr($sor,",",0,3)+2,StringInStr($sor,",",0,4)-StringInStr($sor,",",0,3)-2)&@LF)
			EndIf
		 Next
	  EndIf
   Else
	  MsgBox(65536,"","Itt nem használható a program!" &@LF& "Munkalap ablakban indítsd a programot!")
   EndIf
EndFunc



