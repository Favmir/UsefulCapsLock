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
#Include %A_WorkingDir%\Tray.ahk
#Include %A_WorkingDir%\Keyboard.ahk

TraySetIcon(A_WorkingDir . "\Icons\icon(32x32).png",1,1)
A_TrayMenu.Delete()
A_TrayMenu.Add("Open Useful Caps Lock", TrayShowGui(),)
A_TrayMenu.Add("Pause Program", TrayPause(),)
A_TrayMenu.Add("Quit", TrayQuit(),)
A_TrayMenu.Default := "Pause Program"
A_TrayMenu.ClickCount := 1


win := Keyboard("", "kTtle","", "", "")
win.show()


p::{
send "p"
}
/*


;=========================== Initialize

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