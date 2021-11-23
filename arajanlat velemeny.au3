#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile_type=a3x
#AutoIt3Wrapper_Res_Fileversion=0.0.0.2
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; *** Start added by AutoIt3Wrapper ***
#include <MsgBoxConstants.au3>
#include <StructureConstants.au3>
#include <Excel.au3>
#include <GDIPlus.au3>
#include <WinAPI.au3>
#include <GUISlider.au3>
#include <GUIConstants.au3>
#include <WindowsConstants.au3>
#include <Date.au3>
#include <Misc.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <GuiButton.au3>


global $Form1, $hwnd_almenu, $hwnd_fo,$hwnd_eger,$1,$2,$3,$R1I,$R1N,$R2I,$R2N,$R2I1,$R2I2,$R2I3,$C2N1,$C2N2,$C2N3
Global Const $PIE_DIAMETER = 270
Global Const $PIE_MARGIN = $PIE_DIAMETER * 0.025
Global Const $PIE_DEPTH = $PIE_DIAMETER * 0.2
Global Const $PIE_AREA = $PIE_DIAMETER + 2 * $PIE_MARGIN
global $ghGDIPDll
Global Const $NUM_VALUES = 2
Global $aChartValue[$NUM_VALUES]
Global $aChartColour[$NUM_VALUES]
Global Const $PI = ATan(1) * 4
Local $hUser32_Dll = DllOpen("user32.dll")

;~ $ablaknev = "TESZT"
;~ HotKeySet("^0", "Form1")
;~ While 1 ;loop forever to wait for the keypress
;~   Sleep(30000) ;no need to kill the CPU
;~ WEnd

while 1
	if WinExists("[CLASS:Gupta:AccFrame]","Számla adatok") Then
		$hwnd = WinGetHandle("[CLASS:Gupta:AccFrame]","Számla adatok")
		$szoveg = WinGetText($hwnd)
		$ablaknev = StringMid($szoveg,StringInStr($szoveg,"Rendsz.")+8,6)
;~ 		ConsoleWrite($ablaknev & @CRLF)
		Form1()
		WinWaitClose("[CLASS:Gupta:AccFrame]","Számla adatok")
	EndIf
	sleep(1000)
WEnd
;~ While 1
;~  		if _IsPressed("11", $hUser32_Dll) and _IsPressed("10", $hUser32_Dll) and _IsPressed("49", $hUser32_Dll) Then
;~  			local $ablaknev = WinGetTitle("[ACTIVE]")

;~  			if StringInStr($ablaknev,"Munkalap") <> 0 and StringLeft($ablaknev,10)<>"Munkalapok" Then
;~  				While _IsPressed("11", $hUser32_Dll)
;~  					Sleep(250)
;~  				WEnd
 				ConsoleWrite($ablaknev & @CRLF)
;~  				Form1()
;~  			EndIf
;~  		EndIf
;~ ; ;~ 		ConsoleWrite("egy ciklus" & @CRLF)
;~ WEnd




Func Form1()

	local $nem = IniRead("N:\Botond\ajanlatvelemeny.ini","1","0","0")
	local $igen = IniRead("N:\Botond\ajanlatvelemeny.ini","1","1","0")
	local $belso = IniRead("N:\Botond\ajanlatvelemeny.ini","1","BELSO","0")

	$aChartValue[0] = $nem
	$aChartValue[1] = $igen
	$aChartColour[0] = 0xFD5656
	$aChartColour[1] = 0x4EFA70

#Region ### START Koda GUI section ### Form=
	$Form1 = GUICreate("Ügyfél vélemény árajánlatról", 1080, 350, -1, -1, -1, BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
		GUISetIcon("N:\Botond\tormasi.ico", -1)
	$Label1 = GUICtrlCreateLabel("Az ügyfél fix kedvezményt kap vagy szerzödéses partnerünk?", 24, 24, 437, 24)
		GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	$Label2 = GUICtrlCreateLabel("Az eredeti ajánlatot fogadta el?", 24, 72, 231, 24)
		GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
		GUICtrlSetState(-1, $GUI_HIDE)
	$Button1 = GUICtrlCreateButton("OK", 24, 232, 57, 33)
		GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
		GUICtrlSetBkColor(-1, 0x00FF00)
	$Button2 = GUICtrlCreateButton("Belso árajánlat", 208, 232, 145, 33)
		GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
		GUICtrlSetColor(-1, 0xFFFFFF)
		GUICtrlSetBkColor(-1, 0xFF0000)
	$Label3 = GUICtrlCreateLabel("Igen - "&Round($igen/($igen+$nem)*100)&"%",960,80,80,20, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10, 700, 0, "MS Sans Serif")
	GUICtrlSetBkColor($Label3,$aChartColour[1])
	$Label4 = GUICtrlCreateLabel("Nem - "&100-Round($igen/($igen+$nem)*100)&"%",960,110,80,20, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10, 700, 0, "MS Sans Serif")
	GUICtrlSetBkColor($Label4,$aChartColour[0])
	$Label5 = GUICtrlCreateLabel("Az eredeti ajánlatot fogadta el?", 750, 24, 231, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	GUICtrlSetColor($Label5,0x808080)
	$label6 = GUICtrlCreateLabel("Igen - "&$igen&" db",960,210,100,20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$label7 = GUICtrlCreateLabel("Nem - "&$nem&" db",960,240,100,20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	$label8 = GUICtrlCreateLabel("BELSO - "&$belso&" db",960,270,100,20)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	GUIStartGroup()
		$R2I1 = GUICtrlCreateRadio("Gond nélkül elfogadta", 32, 112, 193, 25)
			GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
			GUICtrlSetState(-1, $GUI_HIDE)
		$R2I2 = GUICtrlCreateRadio("Szóvá tette, hogy sok, de elfogadta", 32, 152, 289, 25)
			GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
			GUICtrlSetState(-1, $GUI_HIDE)
		$R2I3 = GUICtrlCreateRadio("Nehezen, de végül elfogadta", 32, 192, 241, 25)
			GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
			GUICtrlSetState(-1, $GUI_HIDE)
	GUIStartGroup()
		$C2N1 = GUICtrlCreateCheckbox("Kedvezményt kapott", 344, 112, 233, 25)
			GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
			GUICtrlSetState(-1, $GUI_HIDE)
		$C2N2 = GUICtrlCreateCheckbox("Kivettünk az ajánlatból tételeket", 344, 152, 273, 25)
			GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
			GUICtrlSetState(-1, $GUI_HIDE)
		$C2N3 = GUICtrlCreateCheckbox("Plusz dolgot kapott (mosás)", 344, 192, 249, 25)
			GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
			GUICtrlSetState(-1, $GUI_HIDE)
	GUIStartGroup()
		$R2I = GUICtrlCreateRadio("Igen", 264, 72, 57, 25)
			GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
			GUICtrlSetState(-1, $GUI_HIDE)
		$R2N = GUICtrlCreateRadio("Nem", 328, 72, 65, 25)
			GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
			GUICtrlSetState(-1, $GUI_HIDE)
	GUIStartGroup()
		$R1I = GUICtrlCreateRadio("Igen", 480, 24, 57, 25)
			GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
		$R1N = GUICtrlCreateRadio("Nem", 544, 24, 65, 25)
			GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")

	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()

; Create the brushes and pens
Global $ahBrush[$NUM_VALUES][2], $ahPen[$NUM_VALUES]
For $i = 0 To $NUM_VALUES - 1
    $ahBrush[$i][0] = _GDIPlus_BrushCreateSolid(BitOR(0xff000000, $aChartColour[$i]))
    $ahBrush[$i][1] = _GDIPlus_BrushCreateSolid(BitOR(0xff000000, _GetDarkerColour($aChartColour[$i])))
    $ahPen[$i] = _GDIPlus_PenCreate(BitOR(0xff000000, _GetDarkerColour(_GetDarkerColour($aChartColour[$i]))))
Next


; Set up GDI+
Global $hDC = _WinAPI_GetDC($Form1)
Global $hGraphics = _GDIPlus_GraphicsCreateFromHDC($hDC)
Global $hBitmap = _GDIPlus_BitmapCreateFromGraphics($PIE_AREA, $PIE_AREA, $hGraphics)
Global $hBuffer = _GDIPlus_ImageGetGraphicsContext($hBitmap)
_GDIPlus_GraphicsSetSmoothingMode($hBuffer, 2)

; Draw the initial pie chart
_DrawPie($aChartValue, -90)

; Wait until the user quits
;~ While GUIGetMsg() <> $GUI_EVENT_CLOSE
;~     Sleep(10)
;~ WEnd

; Release the resources
For $i = 0 To UBound($aChartColour) - 1
    _GDIPlus_PenDispose($ahPen[$i])
    _GDIPlus_BrushDispose($ahBrush[$i][0])
    _GDIPlus_BrushDispose($ahBrush[$i][1])
Next
_GDIPlus_GraphicsDispose($hBuffer)
_GDIPlus_BitmapDispose($hBitmap)
_GDIPlus_GraphicsDispose($hGraphics)
_WinAPI_ReleaseDC($Form1, $hDC)

; Shut down GDI+
_GDIPlus_Shutdown()



#EndRegion ### END Koda GUI section ###

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($Form1)
				Exitloop
			Case $Button1
				if GUICtrlRead($R2I)=1 And (GUICtrlRead($R2I1)=4 And GUICtrlRead($R2I2)=4 and GUICtrlRead($R2I3)=4) Then
					MsgBox($MB_TOPMOST,"Hiba","Valamelyik opciót muszály kiválasztani!")
				ElseIf GUICtrlRead($R2N)=1 and (GUICtrlRead($C2N3)=4 And GUICtrlRead($C2N2)=4 and GUICtrlRead($C2N1)=4) Then
					MsgBox($MB_TOPMOST,"Hiba","Valamelyik opciót muszály kiválasztani!")
				ElseIf (GUICtrlRead($R2I)=4 and GUICtrlRead($R2N)=4) or (GUICtrlRead($R1I)=4 and GUICtrlRead($R1N)=4) Then
					MsgBox($MB_TOPMOST,"Hiba","Valamelyik opciót muszály kiválasztani!")
				Else
					local $file = FileOpen("N:\Botond\ajanlatvelemeny.csv",1)
					kiert()
					FileWriteLine($file, _NowDate() &","& @UserName &","& $1 &","& $2 &","& $3 &","& $ablaknev)
					FileClose($file)
					GUIDelete($Form1)
					ExitLoop
				EndIf
			Case $R1I
				GUICtrlSetState($Label2, $gui_show)
				GUICtrlSetState($R2I, $gui_show)
				GUICtrlSetState($R2N, $gui_show)
			Case $R1N
				GUICtrlSetState($Label2, $gui_show)
				GUICtrlSetState($R2I, $gui_show)
				GUICtrlSetState($R2N, $gui_show)
			Case $R2I
				GUICtrlSetState($R2I1, $gui_show)
				GUICtrlSetState($R2I2, $gui_show)
				GUICtrlSetState($R2I3, $gui_show)
				GUICtrlSetState($C2N1, 36)
				GUICtrlSetState($C2N2, 36)
				GUICtrlSetState($C2N3, 36)

			case $R2N
				GUICtrlSetState($C2N1, $gui_show)
				GUICtrlSetState($C2N2, $gui_show)
				GUICtrlSetState($C2N3, $gui_show)
				GUICtrlSetState($R2I1, 36)
				GUICtrlSetState($R2I2, 36)
				GUICtrlSetState($R2I3, 36)
			Case $Button2
;~ 				!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!EZ TESZT MOST, ÁTÍRNI!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				local $file = FileOpen("N:\Botond\ajanlatvelemeny.csv",1)
				FileWriteLine($file, _NowDate() &","& @UserName &",BELSO,BELSO,BELSO,"& $ablaknev)
				FileClose($file)
				GUIDelete($Form1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func kiert()
	if GUICtrlRead($R1I)=1 Then
		$1=1
	Else
		$1=0
	EndIf
	if GUICtrlRead($R2I)=1 Then
		$2=1
		if GUICtrlRead($R2I1)=1 Then
			$3=1
		ElseIf GUICtrlRead($R2I2)=1 Then
			$3=2
		Else
			$3=3
		EndIf
	Else
		$2=0
		if GUICtrlRead($C2N1)=1 And GUICtrlRead($C2N2)=4 and GUICtrlRead($C2N3)=4 Then
			$3=1
		ElseIf GUICtrlRead($C2N1)=4 And GUICtrlRead($C2N2)=1 and GUICtrlRead($C2N3)=4 Then
			$3=2
		ElseIf GUICtrlRead($C2N1)=4 And GUICtrlRead($C2N2)=4 and GUICtrlRead($C2N3)=1 Then
			$3=4
		ElseIf GUICtrlRead($C2N1)=1 And GUICtrlRead($C2N2)=1 and GUICtrlRead($C2N3)=4 Then
			$3=3
		ElseIf GUICtrlRead($C2N1)=1 And GUICtrlRead($C2N2)=4 and GUICtrlRead($C2N3)=1 Then
			$3=5
		ElseIf GUICtrlRead($C2N1)=4 And GUICtrlRead($C2N2)=1 and GUICtrlRead($C2N3)=1 Then
			$3=6
		ElseIf GUICtrlRead($C2N1)=1 And GUICtrlRead($C2N2)=1 and GUICtrlRead($C2N3)=1 Then
			$3=7
		EndIf
	EndIf
EndFunc











; Get a darker version of a colour by extracting the RGB components
Func _GetDarkerColour($Colour)
    Local $Red, $Green, $Blue
    $Red = (BitAND($Colour, 0xff0000) / 0x10000) - 40
    $Green = (BitAND($Colour, 0x00ff00) / 0x100) - 40
    $Blue = (BitAND($Colour, 0x0000ff)) - 40
    If $Red < 0 Then $Red = 0
    If $Green < 0 Then $Green = 0
    If $Blue < 0 Then $Blue = 0
    Return ($Red * 0x10000) + ($Green * 0x100) + $Blue
EndFunc ;==>_GetDarkerColour

; Draw the pie chart
Func _DrawPie($Percentage, $rotation)
    Local $nCount, $nTotal = 0, $angleStart, $angleSweep, $X, $Y
    Local $pieLeft = $PIE_MARGIN, $pieTop = $PIE_MARGIN
    Local $pieWidth = $PIE_DIAMETER, $pieHeight = $PIE_DIAMETER, $hPath

; Total up the values
    For $nCount = 0 To UBound($Percentage) - 1
        $nTotal += $Percentage[$nCount]
    Next

; Set the fractional values
    For $nCount = 0 To UBound($Percentage) - 1
        $Percentage[$nCount] /= $nTotal
    Next

; Make sure we don't over-rotate
    $rotation = Mod($rotation, 360)

; Clear the graphics buffer
    _GDIPlus_GraphicsClear($hBuffer, 0xffc0c0c0)

; Set the initial angles based on the fractional values
    Local $Angles[UBound($Percentage) + 1]
    For $nCount = 0 To UBound($Percentage)
        If $nCount = 0 Then
            $Angles[$nCount] = $rotation
        Else
            $Angles[$nCount] = $Angles[$nCount - 1] + ($Percentage[$nCount - 1] * 360)
        EndIf
    Next
; Adjust the angles based on the aspect
		For $nCount = 0 To UBound($Percentage)
			$X = $PIE_DIAMETER * Cos($Angles[$nCount] * $PI / 180)
			$Y = $PIE_DIAMETER * Sin($Angles[$nCount] * $PI / 180)
			$Y -= ($PIE_DIAMETER - $pieHeight) * Sin($Angles[$nCount] * $PI / 180)
			If $X = 0 Then
				$Angles[$nCount] = 90 + ($Y < 0) * 180
			Else
				$Angles[$nCount] = ATan($Y / $X) * 180 / $PI
			EndIf
			If $X < 0 Then $Angles[$nCount] += 180
			If $X >= 0 And $Y < 0 Then $Angles[$nCount] += 360
			$X = $PIE_DIAMETER * Cos($Angles[$nCount] * $PI / 180)
			$Y = $pieHeight * Sin($Angles[$nCount] * $PI / 180)
		Next

; Decide which pieces to draw first and last
		Local $nStart = -1, $nEnd = -1
		For $nCount = 0 To UBound($Percentage) - 1
			$angleStart = Mod($Angles[$nCount], 360)
			$angleSweep = Mod($Angles[$nCount + 1] - $Angles[$nCount] + 360, 360)
			If $angleStart <= 270 And ($angleStart + $angleSweep) >= 270 Then
				$nStart = $nCount
			EndIf
			If ($angleStart <= 90 And ($angleStart + $angleSweep) >= 90) _
					Or ($angleStart <= 450 And ($angleStart + $angleSweep) >= 450) Then
				$nEnd = $nCount
			EndIf
			If $nEnd >= 0 And $nStart >= 0 Then ExitLoop
		Next

; Draw the first piece
		_DrawPiePiece($hBuffer, $pieLeft, $pieTop, $pieWidth, $pieHeight, $PIE_DEPTH , $nStart, $Angles)

; Draw pieces "to the right"
		$nCount = Mod($nStart + 1, UBound($Percentage))
		While $nCount <> $nEnd
			_DrawPiePiece($hBuffer, $pieLeft, $pieTop, $pieWidth, $pieHeight, $PIE_DEPTH, $nCount, $Angles)
			$nCount = Mod($nCount + 1, UBound($Percentage))
		WEnd

; Draw pieces "to the left"
		$nCount = Mod($nStart + UBound($Percentage) - 1, UBound($Percentage))
		While $nCount <> $nEnd
			_DrawPiePiece($hBuffer, $pieLeft, $pieTop, $pieWidth, $pieHeight, $PIE_DEPTH , $nCount, $Angles)
			$nCount = Mod($nCount + UBound($Percentage) - 1, UBound($Percentage))
		WEnd

; Draw the last piece
		_DrawPiePiece($hBuffer, $pieLeft, $pieTop, $pieWidth, $pieHeight, $PIE_DEPTH , $nEnd, $Angles)

; Now draw the bitmap on to the device context of the window
    _GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 650, 65)
EndFunc ;==>_DrawPie

Func _DrawPiePiece($hGraphics, $iX, $iY, $iWidth, $iHeight, $iDepth, $nCount, $Angles)
    Local $hPath, $cX = $iX + ($iWidth / 2), $cY = $iY + ($iHeight / 2), $fDrawn = False
    Local $iStart = Mod($Angles[$nCount], 360), $iSweep = Mod($Angles[$nCount + 1] - $Angles[$nCount] + 360, 360)

; Draw side
    $hPath = _GDIPlus_GraphicsPathCreate()
    If $iStart < 180 And ($iStart + $iSweep > 180) Then
        _GDIPlus_GraphicsPathAddArc($hPath, $iX, $iY, $iWidth, $iHeight, $iStart, 180 - $iStart)
        _GDIPlus_GraphicsPathAddArc($hPath, $iX, $iY + $iDepth, $iWidth, $iHeight, 180, $iStart - 180)
        _GDIPlus_GraphicsPathCloseFigure($hPath)
        _GDIPlus_GraphicsFillPath($hGraphics, $ahBrush[$nCount][1], $hPath)
        _GDIPlus_GraphicsDrawPath($hGraphics, $ahPen[$nCount], $hPath)
        $fDrawn = True
    EndIf
    If $iStart + $iSweep > 360 Then
        _GDIPlus_GraphicsPathAddArc($hPath, $iX, $iY, $iWidth, $iHeight, 0, $iStart + $iSweep - 360)
        _GDIPlus_GraphicsPathAddArc($hPath, $iX, $iY + $iDepth, $iWidth, $iHeight, $iStart + $iSweep - 360, 360 - $iStart - $iSweep)
        _GDIPlus_GraphicsPathCloseFigure($hPath)
        _GDIPlus_GraphicsFillPath($hGraphics, $ahBrush[$nCount][1], $hPath)
        _GDIPlus_GraphicsDrawPath($hGraphics, $ahPen[$nCount], $hPath)
        $fDrawn = True
    EndIf
    If $iStart < 180 And (Not $fDrawn) Then
        _GDIPlus_GraphicsPathAddArc($hPath, $iX, $iY, $iWidth, $iHeight, $iStart, $iSweep)
        _GDIPlus_GraphicsPathAddArc($hPath, $iX, $iY + $iDepth, $iWidth, $iHeight, $iStart + $iSweep, -$iSweep)
        _GDIPlus_GraphicsPathCloseFigure($hPath)
        _GDIPlus_GraphicsFillPath($hGraphics, $ahBrush[$nCount][1], $hPath)
        _GDIPlus_GraphicsDrawPath($hGraphics, $ahPen[$nCount], $hPath)
    EndIf
    _GDIPlus_GraphicsPathDispose($hPath)

; Draw top
    _GDIPlus_GraphicsFillPie($hGraphics, $iX, $iY, $iWidth, $iHeight, $iStart, $iSweep, $ahBrush[$nCount][0])
    _GDIPlus_GraphicsDrawPie($hGraphics, $iX, $iY, $iWidth, $iHeight, $iStart, $iSweep, $ahPen[$nCount])

EndFunc ;==>_DrawPiePiece

Func _GDIPlus_GraphicsPathCreate($iFillMode = 0)
    Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreatePath", "int", $iFillMode, "int*", 0);
    If @error Then Return SetError(@error, @extended, 0)
    Return SetError($aResult[0], 0, $aResult[2])
EndFunc ;==>_GDIPlus_GraphicsPathCreate

Func _GDIPlus_GraphicsPathAddLine($hGraphicsPath, $iX1, $iY1, $iX2, $iY2)
    Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathLine", "hwnd", $hGraphicsPath, "float", $iX1, "float", $iY1, _
            "float", $iX2, "float", $iY2)
    If @error Then Return SetError(@error, @extended, 0)
    Return SetError($aResult[0], 0, 0)
EndFunc ;==>_GDIPlus_GraphicsPathAddLine

Func _GDIPlus_GraphicsPathAddArc($hGraphicsPath, $iX, $iY, $iWidth, $iHeight, $iStartAngle, $iSweepAngle)
    Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathArc", "hwnd", $hGraphicsPath, "float", $iX, "float", $iY, _
            "float", $iWidth, "float", $iHeight, "float", $iStartAngle, "float", $iSweepAngle)
    If @error Then Return SetError(@error, @extended, 0)
    Return SetError($aResult[0], 0, 0)
EndFunc ;==>_GDIPlus_GraphicsPathAddArc

Func _GDIPlus_GraphicsPathAddPie($hGraphicsPath, $iX, $iY, $iWidth, $iHeight, $iStartAngle, $iSweepAngle)
    Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathPie", "hwnd", $hGraphicsPath, "float", $iX, "float", $iY, _
            "float", $iWidth, "float", $iHeight, "float", $iStartAngle, "float", $iSweepAngle)
    If @error Then Return SetError(@error, @extended, 0)
    Return SetError($aResult[0], 0, 0)
EndFunc ;==>_GDIPlus_GraphicsPathAddPie

Func _GDIPlus_GraphicsPathCloseFigure($hGraphicsPath)
    Local $aResult = DllCall($ghGDIPDll, "int", "GdipClosePathFigure", "hwnd", $hGraphicsPath)
    If @error Then Return SetError(@error, @extended, 0)
    Return SetError($aResult[0], 0, 0)
EndFunc ;==>_GDIPlus_GraphicsPathCloseFigure

Func _GDIPlus_GraphicsPathDispose($hGraphicsPath)
    Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeletePath", "hwnd", $hGraphicsPath)
    If @error Then Return SetError(@error, @extended, 0)
    Return SetError($aResult[0], 0, 0)
EndFunc ;==>_GDIPlus_GraphicsPathDispose


