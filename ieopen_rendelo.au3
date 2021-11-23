#include <IE.au3>
#include <Array.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#Include <GuiListBox.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>


$url = "https://sp6005fd:Tormasi2@dealernet.suzuki.hu/dealernet/ui/sales/customerOrder/index_html"

$ohttp = ObjCreate("winhttp.winhttprequest.5.1")
$ohttp.open("get", $url, False)
$oHTTP.SetRequestHeader('Authorization', 'Basic c3A2MDA1ZmQ6VG9ybWFzaTI=')
$oHTTP.SetRequestHeader('Cookie', '_ZopeId="05368227A9jzqq5UAZk"')
global $c = 0

Global $kod[4] =  ["R3H926U", "R3H926U", "V30DZCD", "V30DA9N"]

While True
	$ohttp.send()
	$oReceived = $oHTTP.ResponseText

	for $elem in $kod
		if StringInStr($oReceived, $elem) > 0 Then
			RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE","iexplore.exe","REG_DWORD",0)
			local $oIEr = _IECreate ($url)
			RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE","iexplore.exe","REG_DWORD",1)
			$tags = $oIEr.document.GetElementsByName('orders.modelcode:string:records')
			for $tag in $tags
				$value = $tag.GetAttribute('value')
				if String($value)= $elem Then
					$radio = $oIEr.document.all($tag.sourceIndex+2)
					_IEAction($radio,"click")
					$submit = $oIEr.document.getElementById("submitButtonID")
					_IEAction($submit,"click")
					_IELoadWait($oIEr)
					$oForm = _IEFormGetObjByName($oIEr, "orderform")
					$odealercode = _IEFormElementGetObjByName($oForm, "dealercode")
					_IEFormElementSetValue($odealercode, "6005")
					$sorsz = _ArraySearch($kod,$elem)
					_ArrayDelete($kod,$sorsz)
				EndIf
			next

		EndIf
	Next
	$c = $c + 1
	ConsoleWrite($c&@CRLF)
	Sleep(500)
WEnd

