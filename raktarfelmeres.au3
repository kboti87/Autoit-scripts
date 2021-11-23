#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile_type=a3x
#AutoIt3Wrapper_Outfile=N:\Botond\autoit scriptek\raktarfelmeres.a3x
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <Date.au3>

local $1, $2, $Radio1,$Radio2,$Radio4,$Radio5,$Radio6

HotKeySet("^0", "proc")

While 1 ;loop forever to wait for the keypress
  Sleep(30000) ;no need to kill the CPU
WEnd

Func proc()
	local $ablaknev = WinGetTitle("[ACTIVE]")
	if StringInStr($ablaknev,"Munkalap - Munkalap") <> 0 or StringInStr($ablaknev,"Munkalap - Árajánlat") <> 0 or StringInStr($ablaknev,"Munkalap - Munkaid") <> 0 Then
		#Region ### START Koda GUI section ### Form=
		$ablaknev = StringLeft($ablaknev,StringInStr($ablaknev,"- Tormási")-2)
		$Form1 = GUICreate("Alkatrész utórendelés felmérés", 392, 406, -1, -1, $GUI_SS_DEFAULT_GUI, BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
		GUISetIcon("N:\Botond\tormasi.ico", -1)
		$Label1 = GUICtrlCreateLabel(StringLeft($ablaknev,StringInStr($ablaknev,",")-1), 16, 16, 94, 29)
		GUICtrlSetFont(-1, 16, 400, 0, "MS Sans Serif")
		$Group1 = GUICtrlCreateGroup("Az alkatrész igény:", 32, 80, 305, 137)
		GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
		$Radio4 = GUICtrlCreateRadio("Raktárról kiszolgálható", 48, 112, 281, 25)
		$Radio5 = GUICtrlCreateRadio("Városból beszerezheto", 48, 144, 281, 25)
		$Radio6 = GUICtrlCreateRadio("Városon kívülrol lehet beszerezni", 48, 176, 273, 25)
		GUICtrlCreateGroup("", -99, -99, 1, 1)
		$Group2 = GUICtrlCreateGroup("A szerelo az alkatrészt:", 32, 248, 201, 105)
		GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
		$Radio1 = GUICtrlCreateRadio("Álláson megvárja", 48, 280, 161, 25)
		$Radio2 = GUICtrlCreateRadio("Leáll az állásról", 48, 312, 161, 25)
		GUICtrlCreateGroup("", -99, -99, 1, 1)
		$Button1 = GUICtrlCreateButton("OK", 280, 320, 81, 33)
		GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
		GUICtrlSetBkColor(-1, 0x00FF00)
		GUISetState(@SW_SHOW)
		#EndRegion ### END Koda GUI section ###

		While 1
			$nMsg = GUIGetMsg()
			Switch $nMsg
				Case $GUI_EVENT_CLOSE
					GUIDelete($Form1)
					Exitloop
				Case $Button1
					Save()
					local $file = FileOpen("N:\Botond\raktarfelmeres.csv",1)
					FileWriteLine($file, _NowDate() &","& @UserName &","& $1 &","& $2 &","& $ablaknev)
					FileClose($file)
					GUIDelete($Form1)
					Exitloop
			EndSwitch
		WEnd
	Else
		MsgBox(262144,"Figyelem","Itt nem indítható a program")
	EndIf
EndFunc


Func Save()
	if GUICtrlRead($Radio4)=1 Then $1 = 1
	if GUICtrlRead($Radio5)=1 Then $1 = 2
	if GUICtrlRead($Radio6)=1 Then $1 = 3
	if GUICtrlRead($Radio1)=1 Then $2 = 1
	if GUICtrlRead($Radio2)=1 Then $2 = 2
EndFunc
