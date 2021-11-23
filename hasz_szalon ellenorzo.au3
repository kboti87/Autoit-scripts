#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile_type=a3x
#AutoIt3Wrapper_Outfile=N:\Botond\autoit scriptek\hasz_szalon ellenorzo.a3x
#AutoIt3Wrapper_Res_Fileversion=0.0.0.19
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <Array.au3>
#include <String.au3>
#include <File.au3>
#include <Date.au3>
#include <INet.au3>
#include <Outlook.au3>

Local $array_data_sz, $array_szalon_AM[0][2], $array_szalon_net[0][2], $ambennincs, $ambennincs_h
Local $array_data_h, $array_hasznalt_AM[0], $array_hasznalt_net[0], $o,$s,$c,$co,$cs,$is,$cis, $c_h, $ujmodell

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
if @error = "19" then $hibauzi = "opel + suzuki + isuzu nem egyenlő az összessel (szalon), lehet új modell van: " & $ujmodell
if @error = "20" then $hibauzi = "nem frissült az adat, mikor mi vagy szabad gépjármű file régi"
if @error Then
	$oO = _OutlookOpen()
	_OutlookSendMail($oO,"kormoczi.botond@tormasi.hu","","","HIBA a használt/szalon autó programmban",$hibauzi)
	$a = FileOpen("hasz_szalon_log.txt",1)
	FileWriteLine($a,$hibauzi & " " & _NowDate)
	FileClose($a)
EndIf

;~ Ha a vége 1 akkor az teszt és az én mail címemre megy
email("használt",0)
email("szalon",0)

Func hasznalt()

	if StringLeft(FileGetTime("N:\Botond\co2tervezoriport\szabad_gepkocsik.xml",0,1),8) <> StringReplace(_NowcalcDate(),"/","",2) Then
		SetError("20")
		Return
	EndIf
    $file = FileOpen("N:\Botond\co2tervezoriport\szabad_gepkocsik.xml")
	if @error then SetError("1")
	$hasznalt_AM = FileRead($file)
	$hasznalt_net = _INetGetSource("http://hex.hasznaltauto.hu/1.0/xml/tormasikft2_hex")
	Local $aASCII = StringToASCIIArray($hasznalt_net, 0, StringLen($hasznalt_net), 1)
	$hasznalt_net = StringFromASCIIArray($aASCII, 0, -1, $SE_UTF8)
	if @error then SetError("2")

	$array_hasznalt_AM =_StringBetween($hasznalt_AM,'licno="','"')
;~ 	_ArrayDisplay($array_hasznalt_AM)


	$array_hasznalt_net =_StringBetween($hasznalt_net,'belsoazonosito="','"')
;~ 	_ArrayDisplay($array_hasznalt_net)
$c_h = 0
	For $i = 0 To UBound($array_hasznalt_net)-1
		$found = _ArraySearch($array_hasznalt_AM, $array_hasznalt_net[$i])
		If $found <> -1 Then
			_ArrayDelete($array_hasznalt_AM, $found)
		Else
			$ambennincs_h &= $array_hasznalt_net[$i] & @CRLF
			$c_h = $c_h + 1
		EndIf
	Next
	if @error then SetError("9")
;~ 	_ArrayDisplay($array_hasznalt_AM)
;~ 	MsgBox(0,"",$ambennincs_h)
EndFunc

Func szalon()
	if StringLeft(FileGetTime("N:\Botond\co2tervezoriport\mikor mi.csv",0,1),8) <> StringReplace(_NowcalcDate(),"/","",2) Then
		SetError("20")
		Return
	EndIf
	_FileReadToArray("N:\Botond\co2tervezoriport\mikor mi.csv",$array_data_sz,2,",")
	if @error Then SetError("11")
;~ 		_ArrayDisplay($array_data_sz)
	for $i = 1 to UBound($array_data_sz)-2
		if ($array_data_sz[$i])[2] = "01/A.-Telepi készlet-Kecskemét" And ($array_data_sz[$i])[5] then
			_ArrayAdd($array_szalon_AM,($array_data_sz[$i])[5]&","&($array_data_sz[$i])[0],0,",")
		EndIf
	Next
	if @error then SetError("12")
;~ 		_ArrayDisplay($array_szalon_AM)

	$szalon_net = _INetGetSource("https://hex.hasznaltauto.hu/1.0/xml/sztormasi2_hex")
	if @error then SetError("13")

	$i = 1
	While 1
		if StringInStr($szalon_net,'belsoazonosito="',0,$i) <> 0 Then
			_ArrayAdd($array_szalon_net,StringMid($szalon_net,StringInStr($szalon_net,'belsoazonosito="',0,$i)+16,8)&","&StringMid($szalon_net,StringInStr($szalon_net,'gyartmany="',0,$i)+11,1),0,",")
			if @error then SetError("6")
		ElseIf StringInStr($szalon_net,'belsoazonosito="',0,$i) = 0 Then
			ExitLoop
		EndIf
		$i = $i + 1
	WEnd
	if $i=1 then SetError("15")

	for $i = 0 to UBound($array_szalon_net)-1
		if StringRight($array_szalon_net[$i][0],2) = '">' Then $array_szalon_net[$i][0] = StringLeft($array_szalon_net[$i][0],6)
	Next
	if @error then SetError("16")
;~ 		_ArrayDisplay($array_szalon_net)

	$o = 0
	$s = 0
	$is = 0
	$co = 0
	$cs = 0
	$cis = 0
	For $i = 0 To UBound($array_szalon_net)-1
		$found = _ArraySearch($array_szalon_AM, $array_szalon_net[$i][0])
		If $found <> -1 Then
			_ArrayDelete($array_szalon_AM, $found)
		Else
			$ambennincs &= $array_szalon_net[$i][0] & @CRLF
			if $array_szalon_net[$i][1] = "O" Then $co = $co + 1
			if $array_szalon_net[$i][1] = "S" Then $cs = $cs + 1
			if $array_szalon_net[$i][1] = "I" Then $cis = $cis + 1
			$c = $c + 1
		EndIf
	Next
	if @error then SetError("17")
	for $i = 0 to UBound($array_szalon_AM)-1
		if StringLeft($array_szalon_AM[$i][1],3) = "COR" or StringLeft($array_szalon_AM[$i][1],3) = "Gra" or StringLeft($array_szalon_AM[$i][1],3) = "COM" or StringLeft($array_szalon_AM[$i][1],3) = "VIV" or StringLeft($array_szalon_AM[$i][1],3) = "Ast" or StringLeft($array_szalon_AM[$i][1],3) = "CRO" or StringLeft($array_szalon_AM[$i][1],3) = "Ins" or StringLeft($array_szalon_AM[$i][1],3) = "MOV" or StringLeft($array_szalon_AM[$i][1],3) = "MOK" Then
			$o = $o + 1
		elseif StringLeft($array_szalon_AM[$i][1],3) = "SWI" or StringLeft($array_szalon_AM[$i][1],3) = "SX4" or StringLeft($array_szalon_AM[$i][1],3) = "VIT" or StringLeft($array_szalon_AM[$i][1],3) = "Ign" or StringLeft($array_szalon_AM[$i][1],3) = "Swa" or StringLeft($array_szalon_AM[$i][1],3) = "Acr" then
			$s = $s + 1
		elseif StringLeft($array_szalon_AM[$i][1],3) = "D-M" then
			$is = $is + 1
		Else
			$ujmodell = StringLeft($array_szalon_AM[$i][1],3)
		EndIf

	Next
	if $s + $o + $is <> UBound($array_szalon_AM) Then SetError("19")
	if $co + $cs + $cis <> $c then SetError("19")
;~   	_ArrayDisplay($array_szalon_AM)

EndFunc

Func email($melyik, $teszt)
	if $melyik = "használt" Then
		if UBound($array_hasznalt_AM) >= 1 Then
			$subject = "FIGYELEM! Eltérés a hasznaltauto.hu-n lévő autók és a nyilvántartásunk között"
			$body_arpad = "Figyelem, " & UBound($array_hasznalt_AM) & "db autó nincs fent a hasznaltauto.hu-n, illetve "& $c_h & " db fent van, pedig nem kéne!" & @CRLF & @CRLF & "Az alábbi autók nincsenek fent a hasznaltauto.hu-n ("&UBound($array_hasznalt_AM)&" db): "& @CRLF & _ArrayToString($array_hasznalt_AM,@CRLF) & @CRLF & @CRLF & "Az alábbi autók még fent vannak, de már nem kéne: " & @CRLF & $ambennincs_h
			$oO = _OutlookOpen()
			if $teszt = 0 Then
			;~ 	Árpádnak
				_OutlookSendMail($oO,"fruttus.arpad@tormasi.hu","","",$subject,$body_arpad)
			;~ 	Értékesítőknek
				_OutlookSendMail($oO,"fekete.laszlo@tormasi.hu","","",$subject,$body_arpad)
			ElseIf $teszt = 1 Then
				_OutlookSendMail($oO,"kormoczi.botond@tormasi.hu","","",$subject,$body_arpad)
			EndIf
			if @error then SetError("10")
		EndIf
	ElseIf $melyik = "szalon" Then
		if UBound($array_szalon_AM) >= 1 Then
			$subject = "FIGYELEM! Eltérés a szalontauto.hu-n lévő autók és a nyilvántartásunk között"
			$body_arpad2 = "Az alábbi autók nincsenek fent a szalonauto.hu-n ("&UBound($array_szalon_AM)&" db): "& @CRLF & _ArrayToString($array_szalon_AM,"  ") & @CRLF & @CRLF & "Az alábbi autók még fent vannak, de már nem kéne ("&$c&" db): " & @CRLF & $ambennincs
			$body_ertek2_opel = "Figyelem, " & $o & " db Opel autó nincs fent a szalonauto.hu-n, illetve "& $co & " db fent van, pedig nem kéne!"
			$body_ertek2_suzuki = "Figyelem, " & $s & " db Suzuki autó nincs fent a szalonauto.hu-n, illetve "& $cs & " db fent van, pedig nem kéne!"
			$body_ertek2_isuzu = "Figyelem, " & $is & " db Isuzu autó nincs fent a szalonauto.hu-n, illetve "& $cis & " db fent van, pedig nem kéne!"
			$oO = _OutlookOpen()
			if $teszt = 0 Then
			;~ 	Árpádnak
				if $o > 0 or $co > 0 or $s > 0 or $cs > 0 Then
					_OutlookSendMail($oO,"fruttus.arpad@tormasi.hu","","",$subject,$body_ertek2_opel & @CRLF & @CRLF & $body_ertek2_suzuki & @CRLF & @CRLF & $body_ertek2_isuzu & @CRLF & @CRLF & $body_arpad2)
					_OutlookSendMail($oO,"m.istvan@tormasi.hu","","",$subject,$body_arpad2)
				EndIf
			;~ 	Értékesítőknek
				if $o > 0 or $co > 0 then _OutlookSendMail($oO,"kaczko.norbert@tormasi.hu","","",$subject,$body_ertek2_opel)
				if $s > 0 or $cs > 0 Then _OutlookSendMail($oO,"fakan.dezsone@tormasi.hu;safar.attila@tormasi.hu;tokay.janos@tormasi.hu","","",$subject,$body_ertek2_suzuki)
			ElseIf $teszt = 1 Then
					_OutlookSendMail($oO,"kormoczi.botond@tormasi.hu","","",$subject,$body_ertek2_opel & @CRLF & @CRLF & $body_ertek2_suzuki & @CRLF & @CRLF & $body_ertek2_isuzu & @CRLF & @CRLF & $body_arpad2)
			EndIf
			if @error then SetError("18")
		EndIf
	EndIf
EndFunc