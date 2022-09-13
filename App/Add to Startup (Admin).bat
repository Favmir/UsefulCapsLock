cls
@echo "Creating a shortcut in %userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ ..."
@echo off
powershell "$loc='%~dp0\Launch Useful Caps Lock (Admin).bat';$icon='%~dp0\Icons\icon.ico';$s=(New-Object -COM WScript.Shell).CreateShortcut('%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Useful Caps Lock (Admin).lnk');$s.TargetPath=$loc;$s.IconLocation=$icon;$s.Save()"
cls
@echo Now Useful Caps Lock (Admin) will launch every time you boot up the computer.
echo.
@echo If you don't want that, go to %userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ folder and delete the shortcut.
echo.
@echo ...or, just use the Remove from Startup.bat file.
echo.
PAUSE