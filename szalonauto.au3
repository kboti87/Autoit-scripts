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

Local $array_data_sz, $array_szalon_AM[0], $array_szalon_net[0], $ambennincs
Local $array_data_h, $array_hasznalt_AM[0], $array_hasznalt_net[0]

hasznalt()
szalon()
if @error = "1" then $hibauzi = "hasznaltauto_lista.xml beolvasás"
if @error = "2" then $hibauzi = "hasznaltauto.hu-n nem elérhető az xml file"
if @error = "3" then $hibauzi = "$array_hasznalt_AM készítése"
if @error = "4" then $hibauzi = "nem talált rendszámot az xml-ben (AM file, használt)"
if @error = "5" then $hibauzi = "UBound($array_hasznalt_AM)-el történt valami"
if @error = "6" then $hibauzi = "$array_hasznalt_net készítése"
if @error = "7" then $hibauzi = "nem talált rendszámot az xml-ben (net file, használt)"
if @error = "8" then $hibauzi = "UBound($array_hasznalt_net)-el történt valami"
if @error = "9" then $hibauzi = "a 2 array összehasonlítása közben történt valami (használt)"
if @error = "10" then $hibauzi = "email küldés (használt)"
if @error = "11" then $hibauzi = "mikor mi.csv beolvasás"
if @error = "12" then $hibauzi = "$array_szalon_AM készítése"
if @error = "13" then $hibauzi = "szalonauto.hu-n nem elérhető az xml file"
if @error = "14" then $hibauzi = "$array_szalon_net készítése"
if @error = "15" then $hibauzi = "nem talált rendszámot/job számot az xml-ben (net file, szalon)"
if @error = "16" then $hibauzi = "UBound($array_szalon_net)-el történt valami"
if @error = "17" then $hibauzi = "a 2 array összehasonlítása közben történt valami (szalon)"
if @error = "18" then $hibauzi = "email küldés (szalon)"

if @error Then
	$oO = _OutlookOpen()
	_OutlookSendMail($oO,"kormoczi.botond@tormasi.hu","","","HIBA a használt/szalon autó programmban",$hibauzi)
	$a = FileOpen("hasz_szalon_log.txt")
	FileWriteLine($a,$hibauzi & " " & _NowDate)
EndIf

Func hasznalt()

	$file = FileOpen("N:\Botond\co2tervezoriport\hasznaltauto_lista.xml")
	if @error then SetError("1")
	$hasznalt_AM = FileRead($file)
	$hasznalt_net = _INetGetSource("http://hex.hasznaltauto.hu/1.0/xml/tormasikft2_hex")
	if @error then SetError("2")

	$i = 1
	While 1
		if StringInStr($hasznalt_AM,'Textbox225="',0,$i) <> 0 Then
			_ArrayAdd($array_hasznalt_AM,StringMid($hasznalt_AM,StringInStr($hasznalt_AM,'Textbox225="',0,$i)+12,8))
			if @error then SetError("3")
		ElseIf StringInStr($hasznalt_AM,'Textbox225="',0,$i) = 0 Then
			ExitLoop
		EndIf
		$i = $i + 1
	WEnd
	if $i = 1 then SetError("4")

	for $i = 0 to UBound($array_hasznalt_AM)-1
		if StringRight($array_hasznalt_AM[$i],2) = '" ' Then $array_hasznalt_AM[$i] = StringLeft($array_hasznalt_AM[$i],6)
	Next
	if @error then SetError("5")
;~ 	_ArrayDisplay($array_hasznalt_AM)

	$i = 1
	While 1
		if StringInStr($hasznalt_net,'belsoazonosito="',0,$i) <> 0 Then
			_ArrayAdd($array_hasznalt_net,StringMid($hasznalt_net,StringInStr($hasznalt_net,'belsoazonosito="',0,$i)+16,8))
			if @error then SetError("6")
		ElseIf StringInStr($hasznalt_net,'belsoazonosito="',0,$i) = 0 Then
			ExitLoop
		EndIf
		$i = $i + 1
	WEnd
	if $i=1 then SetError("7")

	for $i = 0 to UBound($array_hasznalt_net)-1
		if StringRight($array_hasznalt_net[$i],2) = '">' Then $array_hasznalt_net[$i] = StringLeft($array_hasznalt_net[$i],6)
	Next
	if @error then SetError("8")
;~ 	_ArrayDisplay($array_hasznalt_net)

	For $i = 0 To UBound($array_hasznalt_net)-1
		$found = _ArraySearch($array_hasznalt_AM, $array_hasznalt_net[$i])
		If $found <> -1 Then _ArrayDelete($array_hasznalt_AM, $found)
	Next
	if @error then SetError("9")

	if UBound($array_hasznalt_AM) >= 1 Then
		$subject = "FIGYELEM! Eltérés a hasznaltauto.hu-n lévő autók és a nyílvántartásunk között"
		$body_arpad = "Az alábbi autók nincsenek fent a hasznaltauto.hu-n: "& @CRLF & _ArrayToString($array_hasznalt_AM,@CRLF)
		$body_ertek = "Figyelem, " & UBound($array_hasznalt_AM) & "db autó nincs fent a hasznaltauto.hu-n!"
		$oO = _OutlookOpen()
	;~ 	Árpádnak
		_OutlookSendMail($oO,"kormoczi.botond@tormasi.hu","","",$subject,$body_arpad)
	;~ 	Értékesítőknek
		_OutlookSendMail($oO,"kormoczi.botond@tormasi.hu","","",$subject,$body_ertek)
		if @error then SetError("10")
	EndIf

EndFunc

Func szalon()
	_FileReadToArray("N:\Botond\co2tervezoriport\mikor mi.csv",$array_data_sz,2,",")
	if @error Then SetError("11")
;~ 		_ArrayDisplay($array_data_sz)
	for $i = 1 to UBound($array_data_sz)-2
		if ($array_data_sz[$i])[2] = "01/A.-Telepi készlet-Kecskemét" And ($array_data_sz[$i])[5] then _ArrayAdd($array_szalon_AM,($array_data_sz[$i])[5])
	Next
	if @error then SetError("12")
;~ 		_ArrayDisplay($array_szalon_AM)

	$szalon_net = _INetGetSource("http://hex.hasznaltauto.hu/1.0/xml/tormasikft2_hex")
	if @error then SetError("13")

	$i = 1
	While 1
		if StringInStr($szalon_net,'Textbox225="',0,$i) <> 0 Then
			_ArrayAdd($array_szalon_net,StringMid($szalon_net,StringInStr($szalon_net,'Textbox225="',0,$i)+12,8))
			if @error then SetError("14")
		ElseIf StringInStr($szalon_net,'Textbox225="',0,$i) = 0 Then
			ExitLoop
		EndIf
		$i = $i + 1
	WEnd
	if $i=1 then SetError("15")

	for $i = 0 to UBound($array_szalon_net)-1
		if StringRight($array_szalon_net[$i],2) = '" ' Then $array_szalon_net[$i] = StringLeft($array_szalon_net[$i],6)
	Next
	if @error then SetError("16")
;~ 		_ArrayDisplay($array_szalon_net)

	$c = 0
	For $i = 0 To UBound($array_szalon_net)-1
		$found = _ArraySearch($array_szalon_AM, $array_szalon_net[$i])
		If $found <> -1 Then
			_ArrayDelete($array_szalon_AM, $found)
		Else
			$ambennincs &= $array_szalon_net[$i] & @CRLF
			$c = $c + 1
		EndIf
	Next
	if @error then SetError("17")

	if UBound($array_szalon_AM) > 1 Then
		$subject = "FIGYELEM! Eltérés a szalontauto.hu-n lévő autók és a nyílvántartásunk között"
		$body_arpad2 = "Az alábbi autók nincsenek fent a szalonauto.hu-n: "& @CRLF & _ArrayToString($array_szalon_AM,@CRLF) & @CRLF & @CRLF & "Az alábbi autók még fent vannak, de már nem kéne: " & @CRLF & $ambennincs
		$body_ertek2 = "Figyelem, " & UBound($array_szalon_AM) & " db autó nincs fent a szalonauto.hu-n, illetve "& $c & " db fent van, pedig nem kéne!"
		$oO = _OutlookOpen()
	;~ 	Árpádnak
		_OutlookSendMail($oO,"kormoczi.botond@tormasi.hu","","",$subject,$body_arpad2)
	;~ 	Értékesítőknek
		_OutlookSendMail($oO,"kormoczi.botond@tormasi.hu","","",$subject,$body_ertek2)
		if @error then SetError("18")
	EndIf

EndFunc
