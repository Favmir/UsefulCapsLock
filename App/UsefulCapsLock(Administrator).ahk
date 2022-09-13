If !A_IsAdmin
	Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
Process, Priority, , H

#include %A_ScriptDir%\UsefulCapsLock.ahk