cls
@echo "Deleting shortcuts in %userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ ..."
@echo off
powershell Remove-Item '%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Useful Caps Lock.lnk'
cls
@echo Now Useful Caps Lock will no longer launch upon restart.
echo.
PAUSE