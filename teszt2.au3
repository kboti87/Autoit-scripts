$arr = "9987177, PCM463 - Munkalap - Munkaidõ foglalás - Tormsad"
$val = StringTrimRight($arr, StringLen($arr)-StringInStr($arr, '-')+2 )
ConsoleWrite($val & @LF)
