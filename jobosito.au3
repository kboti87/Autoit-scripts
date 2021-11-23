#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#include <Array.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <Misc.au3>
#include <GuiComboBox.au3>
#include <ButtonConstants.au3>
#include <ListViewConstants.au3>
#include <ComboConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <AutoItConstants.au3>
#include <StructureConstants.au3>
#include <String.au3>
#include <File.au3>
#include <Excel.au3>


local $excel = _Excel_Open(False)
Local $workbook = _Excel_BookOpen($excel,"N:\Botond\co2tervezoriport\Jármuértékesítési tervezés.xlsx",True,False)
Global $array =_Excel_RangeRead($workbook,Default,"C1:D800")
For $i = UBound($array) - 1 To 0 Step -1
    If $array[$i][1] = "" Then
        _ArrayDelete($array, $i)
    EndIf
Next
_Excel_BookClose($workbook,False)
_Excel_Close($excel,False)
$folder = FileSelectFolder("Válaszd ki a jobosítandó mappát","")
if $folder = "" then Exit
$filenames = _FileListToArray($folder)
for $j=1 to UBound($filenames)-1
	if StringRight($filenames[$j],3) <> "pdf" Then
			MsgBox(0,"Figyelem","A mappában van olyan file ami nem pdf" & @LF & "Olyan mappát válassz, amiben csak a jobosítandó pdf-ek vannak")
			Exit
	EndIf
	$oldname = $filenames[$j]
	$rendszam=StringLeft(StringStripWS($filenames[$j],8),6)
	$k = _ArraySearch($array,$rendszam,0,0,0,0,1,2)
	if $k < 1 Then
		MsgBox(0,"Figyelem","Hiba történt, biztos jó mappát választottál?" & @lf & "Ha igen, akkor szólj a Botinak")
		Exit
	EndIf
	$newname = $array[$k][0]
	FileMove($folder & "\" & $oldname,$folder & "\" & $newname & ".pdf",1)
Next
MsgBox(0,"Kész",(UBound($filenames)-1) & " db file jobosítás megtörtént")
