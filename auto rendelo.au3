#include <IE.au3>
#include <Array.au3>
#include <Chrome.au3>

local $oIEr = _IECreate ("https://dealernet.suzuki.hu/dealernet/ui/sales/customerOrder/index_html",0,1,1)
#local $oIEe = _IECreate ("https://dealernet.suzuki.hu/dealernet/ui/sales/orders/viewOrders",1,1,1)

local $autokodok[2][9] = [["V30DZCD","V30DA9N","V30D26U","V30DZNL","V30DA9G","V30DZCC","V30DDBH","V30DDBF","V30DZCE"],["R3H9ZQ6","R3H9ZCD","R3H9ZNL","R3H9ZQ5","R3H9ZQ3","R3H9ZCC","R3H9ZQ4","R3H926U","R3H9ZCE"]]
;~ _ArrayDisplay($autokodok)


	$tags = $oIEr.document.GetElementsByName('orders.modelcode:string:records')
		for $tag in $tags
			$value = $tag.GetAttribute('value')
			for $j=0 to 1
				for $i=0 to 8
					if String($value)= $autokodok[$j][$i] Then
						$radio = $oIEr.document.all($tag.sourceIndex+2)
						_IEAction($radio,"click")
						$submit = $oIEr.document.getElementById("submitButtonID")
						_IEAction($submit,"click")
						$autokodok[$j][$i] = "ZERO"
						ExitLoop 2
					EndIf

				Next
			Next
		Next

	_IELoadWait($oIEr)
	Sleep(500)



#comments-start
https://dealernet.suzuki.hu/dealernet/ui/sales/orders/viewOrders
_IEAction($oIEr,"focus")
_IEAction($oIEr,"refresh")
_IELoadWait($oIEr)
Local $Text = _IEFormElementGetObjByName($oIEr,"orders.nonstandard:int:records")
#comments-end