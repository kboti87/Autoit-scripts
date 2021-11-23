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
#include <INet.au3>
#include <Outlook.au3>


Local $array_data, $array_hasznalt_AM[0], $array_hasznalt_net[0], $temp


$file = FileOpen("N:\Botond\co2tervezoriport\hasznaltauto_lista.xml")
$hasznalt_AM = FileRead($file)
$hasznalt_net = _INetGetSource("http://hex.hasznaltauto.hu/1.0/xml/tormasikft2_hex")

 $i = 1
While 1
	if StringInStr($hasznalt_AM,'Textbox225="',0,$i) <> 0 Then
		_ArrayAdd($array_hasznalt_AM,StringMid($hasznalt_AM,StringInStr($hasznalt_AM,'Textbox225="',0,$i)+12,8))
	ElseIf StringInStr($hasznalt_AM,'Textbox225="',0,$i) = 0 Then
		ExitLoop
	EndIf
	$i = $i + 1
WEnd
for $i = 0 to UBound($array_hasznalt_AM)-1
	if StringRight($array_hasznalt_AM[$i],2) = '" ' Then $array_hasznalt_AM[$i] = StringLeft($array_hasznalt_AM[$i],6)
Next
;~ _ArrayDisplay($array_hasznalt_AM)


$i = 1
While 1
	if StringInStr($hasznalt_net,'belsoazonosito="',0,$i) <> 0 Then
		_ArrayAdd($array_hasznalt_net,StringMid($hasznalt_net,StringInStr($hasznalt_net,'belsoazonosito="',0,$i)+16,8))
	ElseIf StringInStr($hasznalt_net,'belsoazonosito="',0,$i) = 0 Then
		ExitLoop
	EndIf
	$i = $i + 1
WEnd
for $i = 0 to UBound($array_hasznalt_net)-1
	if StringRight($array_hasznalt_net[$i],2) = '">' Then $array_hasznalt_net[$i] = StringLeft($array_hasznalt_net[$i],6)
Next
;~ _ArrayDisplay($array_hasznalt_net)

For $i = 0 To UBound($array_hasznalt_net)-1

    $found = _ArraySearch($array_hasznalt_AM, $array_hasznalt_net[$i])

    If $found <> -1 Then
        _ArrayDelete($array_hasznalt_AM, $found)
    Else
		$temp &= $array_hasznalt_net[$i] & @CRLF
;~         ConsoleWrite($array_hasznalt_net[$i] & " AM-ben nincs" & @CRLF)
    EndIf

Next
;~ ConsoleWrite($temp & @CRLF)
;~ _ArrayDisplay($array_hasznalt_AM)
$subject = "Napi használtautó jelentés - " & _NowDate()
$body = "Az alábbi autók nincsenek fent a hasznaltauto.hu-n: "& @CRLF & _ArrayToString($array_hasznalt_AM,@CRLF) & @CRLF & @CRLF & "Az alábbi autók még fent vannak: " & @CRLF & $temp
$oO = _OutlookOpen()
_OutlookSendMail($oO,"kormoczi.botond@tormasi.hu","","",$subject,$body)
_OutlookSendMail($oO,"kormoczi.botond@tormasi.hu","","","ez másik","Ennyi autó nincs fent: " & UBound($array_hasznalt_AM))
