$hova = FileSelectFolder("A telepítéshez válassz ki egy mappát","")

FileInstall("C:\Users\kormoczi.botond\Desktop\autoit-v3\install\global_login.exe",$hova&"\")
FileCreateShortcut($hova&"\global_login.exe",@DesktopDir & "\GlobalLogin.lnk")