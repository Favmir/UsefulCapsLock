cls
@echo "Creating a shortcut in %userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ ..."
@echo off
powershell "$loc='%~dp0\Launch Useful Caps Lock.bat';$icon='%~dp0\Icons\icon.ico';$s=(New-Object -COM WScript.Shell).CreateShortcut('%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Useful Caps Lock.lnk');$s.TargetPath=$loc;$s.IconLocation=$icon;$s.Save()"