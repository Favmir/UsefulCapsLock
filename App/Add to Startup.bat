cls

@echo "Checking for existing shortcut in %userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ ..."
if exist "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Useful Caps Lock.lnk" (
    del "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Useful Caps Lock.lnk"
    @echo Existing shortcut deleted.
) else (
    @echo No existing shortcut found.
)
echo.

@echo "Creating a shortcut in %userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ ..."
@echo off
powershell "$loc='%~dp0\UsefulCapsLock.exe';$icon='%~dp0\Icons\icon.ico';$s=(New-Object -COM WScript.Shell).CreateShortcut('%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Useful Caps Lock.lnk');$s.TargetPath=$loc;$s.IconLocation=$icon;$s.Save()"
cls
@echo Now Useful Caps Lock will launch every time you boot up the computer.
echo.
@echo If you don't want that, go to %userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ folder and delete the shortcut.
echo.
@echo ...or, just use the Remove from Startup.bat file.
echo.
PAUSE