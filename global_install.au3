$hova = FileSelectFolder("A telep�t�shez v�lassz ki egy mapp�t","")

FileInstall("C:\Users\kormoczi.botond\Desktop\autoit-v3\install\global_login.exe",$hova&"\")
FileCreateShortcut($hova&"\global_login.exe",@DesktopDir & "\GlobalLogin.lnk")