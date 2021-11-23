#include <GUIConstants.au3>
#include <String.au3>
#include <Misc.au3>
#include <Excel.au3>

Local $oExcel = _Excel_Open() ; open excel
Local $oWorkbook = _Excel_BookOpen($oExcel,"N:\Botond\ajanlatvelemeny_teszt.xlsx") ; open workbook

$oWorkbook.RefreshAll ; refresh

$dataArray = _Excel_RangeRead($oWorkbook,"Munka1","B2:B4")
;~ _ArrayDisplay($dataArray)
IniWrite("N:\Botond\ajanlatvelemeny.ini","1","0",$dataArray[0])
IniWrite("N:\Botond\ajanlatvelemeny.ini","1","1",$dataArray[1])
IniWrite("N:\Botond\ajanlatvelemeny.ini","1","BELSO",$dataArray[2])
IniWrite("N:\Botond\ajanlatvelemeny.ini","1","refreshdate",FileGetTime("N:\Botond\ajanlatvelemeny_teszt.xlsx",0,1))

_Excel_BookClose ( $oWorkbook , True ) ; Close workbook, save

_excel_close ($oExcel) ; close excel
