$arr = "9987177, PCM463 - Munkalap - Munkaid� foglal�s - Tormsad"
$val = StringTrimRight($arr, StringLen($arr)-StringInStr($arr, '-')+2 )
ConsoleWrite($val & @LF)
