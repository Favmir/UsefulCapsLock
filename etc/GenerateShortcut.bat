cls
@echo "Creating a shortcut..."
powershell "$loc='%~dp0\App\UsefulCapsLock.exe';$icon='%~dp0\App\Icons\icon.ico';$s=(New-Object -COM WScript.Shell).CreateShortcut('%~dp0\Useful Caps Lock.lnk');$s.TargetPath=$loc;$s.IconLocation=$icon;$s.Save()"
PAUSE