#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>

HotKeySet("^0", "Test1")
While 1 ;loop forever to wait for the keypress
  Sleep(1000) ;no need to kill the CPU
WEnd

Func Test1()
	Dim	$c = 0
	Dim $d = 0
	Do
	  Local $sText = WinGetTitle("[ACTIVE]")
	  WinMove($sText,"",0,0)
	  MouseClick($MOUSE_CLICK_RIGHT,316,247,1,1)
	  MouseClick($MOUSE_CLICK_LEFT,398,379,1,5)
	  sleep(500)
	  WinWaitActive("Ért. ügy elveszettként jelölése","",10)
	  sleep(2000)
	  If WinGetTitle("[ACTIVE]") = "Ért. ügy elveszettként jelölése" Then
		 sleep(500)
		 Send("!o")
		 $d = $d + 1
		 sleep(4000)
	  ElseIf WinGetTitle("[ACTIVE]") = "Értékesítési asztal" Then
		MsgBox(65536,"","Segítség, elakadtam")
		MsgBox(65536,"",$d & " db törlés sikerült")
		Return False
	  Else
		  $c = $c + 1
	  EndIf
	Until $c = 5
	MsgBox(65536,"",$d & " db törlés sikerült")
EndFunc


