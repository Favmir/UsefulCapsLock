;==========================================
; Title:  Useful Caps Lock (rewritten in AHK v2)
; Author: Favmir (FavmirY@gmail.com)
; Description:
;	This scripts repurposes the CapsLock button so that
;	upon pressing it you enter a special input mode.
;	Press Windows/Alt + CapsLock to bring up the menu.
;	If you want to use the original CapsLock function, press Shift + CapsLock
;	When mouse is disabled, press CapsLock + W to use Mouse.
;	(only happens when enabled in options)
;	.ini files MUST be in Unicode 16! Unicode 8 doesn't work!
;==========================================
#Requires AutoHotkey v2.0-beta


#SingleInstance Force
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.

#Include %A_WorkingDir%\Settings\Localization.ahk
#Include %A_WorkingDir%\KeyUnit.ahk
#Include %A_WorkingDir%\Tray.ahk
#Include %A_WorkingDir%\KeyboardGui.ahk


btnLayout := [
	[]
	[]
	[]
	[]
]

;[Scroll]
scrollSettings := KeySection(A_WorkingDir . "\Settings\Keys.ini", "Scroll")
scrollSettings.addKey("scrollUp", &scrollUp)
scrollSettings.addKey("scrollDown", &scrollDown)

;[Keybind]
keySettings := KeySection(A_WorkingDir . "\Settings\Keys.ini", "Keybind")
keySettings.addKey("keyGrave", &keyGrave)
keySettings.addKey("key1", &key1)
keySettings.addKey("key2", &key2)
keySettings.addKey("key3", &key3)
keySettings.addKey("key4", &key4)
keySettings.addKey("key5", &key5)
keySettings.addKey("key7", &key7)
keySettings.addKey("key8", &key8)
keySettings.addKey("key9", &key9)
keySettings.addKey("key0", &key0)
keySettings.addKey("keyHyphen", &keyHyphen)
keySettings.addKey("keyEqual", &keyEqual)
keySettings.addKey("keyQ", &keyQ)
keySettings.addKey("keyT", &keyT)
keySettings.addKey("keyY", &keyY)
keySettings.addKey("keyP", &keyP)
keySettings.addKey("keyLBracket", &keyLBracket)
keySettings.addKey("keyRBracket", &keyRBracket)
keySettings.addKey("keyBSlash", &keyBSlash)
keySettings.addKey("keyA", &keyA)
keySettings.addKey("keyG", &keyG)
keySettings.addKey("keyQuote", &keyQuote)
keySettings.addKey("keyZ", &keyZ)
keySettings.addKey("keyX", &keyX)
keySettings.addKey("keyC", &keyC)
keySettings.addKey("keyV", &keyV)
keySettings.addKey("keyB", &keyB)
keySettings.addKey("keyN", &keyN)
keySettings.addKey("keyM", &keyM)
keySettings.addKey("keyComma", &keyComma)
keySettings.addKey("keyPeriod", &keyPeriod)
keySettings.addKey("keySlash", &keySlash)



guiSettings := KeySection(A_WorkingDir . "\Settings\Gui.ini", "Layout")
guiSettings.addKey("lG", &lG)				;Gap between keys
guiSettings.addKey("lW", &lW)				;Width of regular key
guiSettings.addKey("lH", &lH)				;Height of regular key
guiSettings.addKey("lWBSpc", &lWBSpc)			;Backspace Width: determines the total Keyboard width(13×lW + 15×lG + lWBSpc). Has to be bigger than (lWTab - lW).
guiSettings.addKey("lWTab", &lWTab)			;Tab Width
guiSettings.addKey("lWCaps", &lWCaps)			;Caps Lock Width
guiSettings.addKey("lWShift", &lWShift)			;Left Shift Width
guiSettings.addKey("lWCtrl", &lWCtrl)			;Left Ctrl(and other function keys like Windows) Width

guiSettings.readAll()



mainGui := KeyboardGui("+AlwaysOnTop -Caption", "Useful Caps Lock v2", "")
maiGui.setTheme()
mainGui.buildKeyboard(lG, lW, lH, lWBSpc, lWTab, lWCaps, lWShift, lWCtrl)

;read settings
;scrollSettings.readAll()

;write settings
;scrollSettings.writeAll()


TraySetIcon(A_WorkingDir . "\Icons\icon(32x32).png",1,1)
A_TrayMenu.Delete()
A_TrayMenu.Add("Open Useful Caps Lock", TrayShowGui(),)
A_TrayMenu.Add("Pause Program", TrayPause(),)
A_TrayMenu.Add("Quit", TrayQuit(),)
A_TrayMenu.Default := "Pause Program"
A_TrayMenu.ClickCount := 1


n::
{
	Send "nn"
}



/*





;============ Add Tray ============
TraySetIcon("%A_WorkingDir%\Icons\icon(32x32).png",,)
A_TrayMenu.Delete() ; V1toV2: not 100% replacement of NoStandard, Only if NoStandard is used at the beginning
A_TrayMenu.ClickCount("1")
A_TrayMenu.Add("&Open Useful Caps Lock", TrayGui)
A_TrayMenu.Add("&Pause Program", TrayPause)
A_TrayMenu.Add("&Quit", TrayQuit)
A_TrayMenu.Default := "&Pause Program"


;=========================== Initialize
isWelcomeDone := false
noStartPop := IniRead("\Settings\Gui.ini","Start",noStartPop)
if(noStartPop == false)
{
	msgResult := MsgBox(pDescWelcome, pTitleWelcome, 4097)
	if (msgResult == "Cancel")
	{
		IniWrite(true,A_ScriptDir "\Settings\Gui.ini","Start", "noStartPop")
	}
}
isWelcomeDone := true
EnableHK := false
SetCapsLockState("Off")
EnableSuper := false



MsgBox(keySlash,"",)

;#Include %A_ScriptDir%"\Scripts\BuildMainGui.ahk"

myGui := Gui()
myGui.Opt("-SysMenu")
myGui.Title := "Useful Caps Lock"
myGui.Show("w" . LayoutTotalW . " h" . LayoutTotalH . " Hide")

return

TrayGui(A_ThisMenuItem, A_ThisMenuItemPos, MyMenu)
{ ; V1toV2: Added bracket
	if (A_IsSuspended = 1)
	{
		TrayPause()
	}
	GuiOpen()
return
} ; V1toV2: Added Bracket before label

TrayPause(A_ThisMenuItem, A_ThisMenuItemPos, MyMenu)
{ ; V1toV2: Added bracket
Tray.ToggleCheck("&Pause Program")
if (A_IsSuspended = 1)
{
	Suspend(false)
	Tray.Icon(A_ScriptDir . "\Icons\icon(32x32).png", "1", "1")
}
else
{
	Tray.Icon(A_ScriptDir . "\Icons\icon_off(32x32).png", "1", "1")
	myGui.Title := "Useful Caps Lock"
	myGui.Show("Hide")
	Suspend(true)
}
return
} ; V1toV2: Added Bracket before label

TrayQuit(A_ThisMenuItem, A_ThisMenuItemPos, MyMenu)
{ ; V1toV2: Added bracket
	ExitApp()
return
*/