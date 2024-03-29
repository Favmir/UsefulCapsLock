﻿;==========================================
; Title:  Useful Caps Lock
; Author: Favmir (FavmirY@gmail.com)
; Description:
;	This scripts repurposes the CapsLock button so that
;	upon pressing it you enter a special input mode.
;	Press Windows/Alt + CapsLock to bring up the menu.
;	If you want to use the original CapsLock function, press Shift + CapsLock
;	When touchpad lock is activated, press CapsLock + W to use re-enable mouse.
;	(Only applies when enabled in options)
;==========================================
#Requires AutoHotkey v1.1

#MaxHotkeysPerInterval, 200	; Default is 70, which triggers warning when mouse scroll lock is activated and you scroll aggresively
#SingleInstance Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;BUT SendMode Input also causes input to leak through even when you're pressing capslock because it's too fast and has no delay.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;Don't replace A_ScriptDir with A_WorkingDir ! It doesn't compile.
SetBatchLines -1
SetKeyDelay, 20, 0 ; To fix the Ctrl held down bug (prevents touchpad scrolling and zoom. It goes away if you press hotkey that caused it)

;KeyHistory

#include %A_ScriptDir%\Settings\Localization

;for synaptics toucpad
;ToucpadToggle(1) enables, (0) disables, (else) toggles.
TouchpadToggle(setter) {
	Enabled := ComObjError(False)	; prevents the error message showing when synaptics driver isn't installed. try block below does the same job so this is for redundancy.
	
	try{
		SynAPI:=ComObjCreate("SynCtrl.SynAPICtrl"), SynDev:=ComObjCreate("SynCtrl.SynDeviceCtrl")
	}
	catch e{
		return
	}
	SynAPI.Initialize
	SynDev.Select(SynAPI.FindDevice(0,2,-1))
	if(setter == 0){
		SynDev.SetLongProperty(268435825, 1)
	}else if(setter == 1){
		SynDev.SetLongProperty(268435825, 0)
	}else{
		SynDev.SetLongProperty(268435825, State:=(!SynDev.GetLongProperty(268435825) ? 1 : 0))
	}
}



;============ Add Tray ============
Menu, Tray, Icon,,, 1	;freeze current icon
Menu, Tray, Icon, %A_ScriptDir%\Icons\icon(32x32).png, 1, 1
Menu, Tray, NoStandard
Menu, Tray, Click, 1
Menu, Tray, Add, %AppTitle%, TrayTitle
Menu, Tray, Disable, %AppTitle%
Menu, Tray, Add, %TrayMenuOpen%, TrayGui
Menu, Tray, Add, %TrayMenuPause%, TrayPause
Menu, Tray, Add, %TrayMenuQuit%, TrayQuit
Menu, Tray, Default, %TrayMenuPause%

;=========================== Initialize
isWelcomeDone := false
NoStartPop := 0
IniRead, NoStartPop, %A_ScriptDir%\Settings\Settings.ini, Start, NoWelcomePopup

if(NoStartPop != 1)
{
	MsgBox, 4097, %PopTitleWelcome%, %PopDescWelcome%,
	ifMsgBox, Cancel
	{
		NoStartPop := 1
		IniWrite, %NoStartPop%, %A_ScriptDir%\Settings\Settings.ini, Start, NoWelcomePopup
	}
}

isWelcomeDone := true
EnableHK := false
SetCapsLockState Off
EnableSuper := false

SettingsPath := A_ScriptDir . "\Settings\Settings.ini"
GoSub ReadSettings
#include %A_ScriptDir%\Scripts\BuildMainGui.ahk
if(LockMouse == true){
	GoSub ShowMLockGui
}




TrayTitle:
return

TrayGui:
	if A_IsSuspended=1
	{
		GoSub TrayPause
	}
	GoSub GuiOpen
return

TrayPause:
Menu, Tray, ToggleCheck, %TrayMenuPause%
if A_IsSuspended=1 
{
	Suspend Off
	Menu, Tray, Icon, %A_ScriptDir%\Icons\icon(32x32).png, 1, 1
}
else
{
	Menu, Tray, Icon, %A_ScriptDir%\Icons\icon_off(32x32).png, 1, 1
	Gui Show, Hide, %AppTitle%
	Suspend On
}
return

TrayQuit:
	ExitApp
return

;======= Button Funcitions
DescKey6:
	Msgbox, 4096, %MenuTitleKeys%, %MenuDescKey6%,
return

DescCaps:
	MsgBox, 4096, %MenuTitleKeys%, %MenuDescCaps%,
return

DescShift:
	MsgBox, 4096, %MenuTitleKeys%, %MenuDescShift%,
return

DescLCtrl:
	MsgBox, 4096, %MenuTitleKeys%, %MenuDescLCtrl%,
return

DescWin:
	MsgBox, 4096, %MenuTitleKeys%, %MenuDescWin%,
return

DescLAlt:
	MsgBox, 4096, %MenuTitleKeys%, %MenuDescLAlt%,
return

DescMLock:
	MsgBox, 4096,%MenuTitleKeys%, %MenuDescMLock%,
return

DescSelect:
	MsgBox, 4096,%MenuTitleKeys%, %MenuDescSelect%,
return

DescPanUp:
DescPanDn:
	MsgBox, 4096,%MenuTitleKeys%, %MenuDescPanUp%,
return

DescScrollUp:
DescScrollDn:
	MsgBox, 4096,%MenuTitleKeys%, %MenuDescScrollUp%,
return

DescUp:
DescLeft:
DescDown:
DescRight:
	MsgBox, 4096,%MenuTitleKeys%, %MenuDescUp%,
return

DescPrev:
DescNext:
	MsgBox, 4096,%MenuTitleKeys%, %MenuDescPrev%,
return

DescHome:
DescEnd:
	MsgBox, 4096,%MenuTitleKeys%, %MenuDescEnd%,
return


GuiAbout:
	MsgBox, 4096,%MenuTitleAbout%, %MenuDescAbout%,
return

GuiDefault:
	SettingsPath := A_ScriptDir . "\Settings\Settings_Default.ini"
	GoSub ReadSettings

	SettingsPath := A_ScriptDir . "\Settings\Settings.ini"
	GoSub WriteSettings
	
	GoSub GuiRefresh
return

GuiSave:
	Gui Submit
	SettingsPath := A_ScriptDir . "\Settings\Settings.ini"
	GoSub WriteSettings
	if(LockMouse == true)
	{
		GoSub ShowMLockGui
	}
	GoSub GuiRefresh
return

GuiCancel:
	Gui Show, Hide, %AppTitle%
	GoSub ShowMLockGui
	GoSub GuiRefresh
return

GuiRefresh:
	GuiControl,, Mouse Lock, %LockMouse%
	GuiControl,, UpScroll, %UpScroll%
	GuiControl,, DownScroll, %DownScroll%
	GuiControl,, KeyGrave, %KeyGrave%
	GuiControl,, Key1, %Key1%
	GuiControl,, Key2, %Key2%
	GuiControl,, Key3, %Key3%
	GuiControl,, Key4, %Key4%
	GuiControl,, Key5, %Key5%
	GuiControl,, Key7, %Key7%
	GuiControl,, Key8, %Key8%
	GuiControl,, Key9, %Key9%
	GuiControl,, Key0, %Key0%
	GuiControl,, KeyHypen, %KeyHyphen%
	GuiControl,, KeyEqual, %KeyEqual%
	GuiControl,, KeyQ, %KeyQ%
	GuiControl,, KeyT, %KeyT%
	GuiControl,, KeyY, %KeyY%
	GuiControl,, KeyP, %KeyP%
	GuiControl,, KeyLBracket, %KeyLBracket%
	GuiControl,, KeyRBracket, %KeyRBracket%
	GuiControl,, KeyBSlash, %KeyBSlash%
	GuiControl,, KeyA, %KeyA%
	GuiControl,, KeyG, %KeyG%
	GuiControl,, KeyQuote, %KeyQuote%
	GuiControl,, KeyZ, %KeyZ%
	GuiControl,, KeyX, %KeyX%
	GuiControl,, KeyC, %KeyC%
	GuiControl,, KeyV, %KeyV%
	GuiControl,, KeyB, %KeyB%
	GuiControl,, KeyN, %KeyN%
	GuiControl,, KeyM, %KeyM%
	GuiControl,, KeyComma, %KeyComma%
	GuiControl,, KeyPeriod, %KeyPeriod%
	GuiControl,, KeySlash, %KeySlash%
	GuiControl,, KeyNumpad1, %KeyNumpad1%
	GuiControl,, KeyNumpad2, %KeyNumpad2%
	GuiControl,, KeyNumpad3, %KeyNumpad3%
	GuiControl,, KeyNumpad4, %KeyNumpad4%
	GuiControl,, KeyNumpad5, %KeyNumpad5%
	GuiControl,, KeyNumpad6, %KeyNumpad6%
	GuiControl,, KeyNumpad7, %KeyNumpad7%
	GuiControl,, KeyNumpad8, %KeyNumpad8%
	GuiControl,, KeyNumpad9, %KeyNumpad9%
return

;use SettingsPath := A_ScriptDir . "\Settings\Settings.ini" before running this routine
ReadSettings:
	IniRead, MouseLockOnStart, %SettingsPath%, Start, MouseLockOnStart
	if(MouseLockOnStart == 1){
		LockMouse := true
	}else{
		LockMouse := false
	}

	IniRead, UpScroll, %SettingsPath%, Scroll, UpScroll
	IniRead, DownScroll, %SettingsPath%, Scroll, DownScroll

	Section := "HotKey"
	IniRead, KeyGrave, %SettingsPath%, %Section%, KeyGrave
	IniRead, Key1, %SettingsPath%, %Section%, Key1
	IniRead, Key2, %SettingsPath%, %Section%, Key2
	IniRead, Key3, %SettingsPath%, %Section%, Key3
	IniRead, Key4, %SettingsPath%, %Section%, Key4
	IniRead, Key5, %SettingsPath%, %Section%, Key5
	IniRead, Key7, %SettingsPath%, %Section%, Key7
	IniRead, Key8, %SettingsPath%, %Section%, Key8
	IniRead, Key9, %SettingsPath%, %Section%, Key9
	IniRead, Key0, %SettingsPath%, %Section%, Key0
	IniRead, KeyHyphen, %SettingsPath%, %Section%, KeyHyphen
	IniRead, KeyEqual, %SettingsPath%, %Section%, KeyEqual
	IniRead, KeyQ, %SettingsPath%, %Section%, KeyQ
	IniRead, KeyT, %SettingsPath%, %Section%, KeyT
	IniRead, KeyY, %SettingsPath%, %Section%, KeyY
	IniRead, KeyP, %SettingsPath%, %Section%, KeyP
	IniRead, KeyLBracket, %SettingsPath%, %Section%, KeyLBracket
	IniRead, KeyRBracket, %SettingsPath%, %Section%, KeyRBracket
	IniRead, KeyBSlash, %SettingsPath%, %Section%, KeyBSlash
	IniRead, KeyA, %SettingsPath%, %Section%, KeyA
	IniRead, KeyG, %SettingsPath%, %Section%, KeyG
	IniRead, KeyQuote, %SettingsPath%, %Section%, KeyQuote
	IniRead, KeyZ, %SettingsPath%, %Section%, KeyZ
	IniRead, KeyX, %SettingsPath%, %Section%, KeyX
	IniRead, KeyC, %SettingsPath%, %Section%, KeyC
	IniRead, KeyV, %SettingsPath%, %Section%, KeyV
	IniRead, KeyB, %SettingsPath%, %Section%, KeyB
	IniRead, KeyN, %SettingsPath%, %Section%, KeyN
	IniRead, KeyM, %SettingsPath%, %Section%, KeyM
	IniRead, KeyComma, %SettingsPath%, %Section%, KeyComma
	IniRead, KeyPeriod, %SettingsPath%, %Section%, KeyPeriod
	IniRead, KeySlash, %SettingsPath%, %Section%, KeySlash
	IniRead, KeyNumpad1, %SettingsPath%, %Section%, KeyNumpad1
	IniRead, KeyNumpad2, %SettingsPath%, %Section%, KeyNumpad2
	IniRead, KeyNumpad3, %SettingsPath%, %Section%, KeyNumpad3
	IniRead, KeyNumpad4, %SettingsPath%, %Section%, KeyNumpad4
	IniRead, KeyNumpad5, %SettingsPath%, %Section%, KeyNumpad5
	IniRead, KeyNumpad6, %SettingsPath%, %Section%, KeyNumpad6
	IniRead, KeyNumpad7, %SettingsPath%, %Section%, KeyNumpad7
	IniRead, KeyNumpad8, %SettingsPath%, %Section%, KeyNumpad8
	IniRead, KeyNumpad9, %SettingsPath%, %Section%, KeyNumpad9

return

WriteSettings:
	SettingsPath := A_ScriptDir . "\Settings\Settings.ini"
	
	if(LockMouse == true)
	{
		IniWrite, 1, %SettingsPath%, Start, MouseLockOnStart
	}
	else
	{
		IniWrite, 0, %SettingsPath%, Start, MouseLockOnStart
	}
	IniWrite, %UpScroll%, %SettingsPath%, Scroll, UpScroll
	IniWrite, %DownScroll%, %SettingsPath%, Scroll, DownScroll

	Section := "HotKey"
	IniWrite, %KeyGrave%, %SettingsPath%, %Section%, KeyGrave
	IniWrite, %Key1%, %SettingsPath%, %Section%, Key1
	IniWrite, %Key2%, %SettingsPath%, %Section%, Key2
	IniWrite, %Key3%, %SettingsPath%, %Section%, Key3
	IniWrite, %Key4%, %SettingsPath%, %Section%, Key4
	IniWrite, %Key5%, %SettingsPath%, %Section%, Key5
	IniWrite, %Key7%, %SettingsPath%, %Section%, Key7
	IniWrite, %Key8%, %SettingsPath%, %Section%, Key8
	IniWrite, %Key9%, %SettingsPath%, %Section%, Key9
	IniWrite, %Key0%, %SettingsPath%, %Section%, Key0
	IniWrite, %KeyHyphen%, %SettingsPath%, %Section%, KeyHyphen
	IniWrite, %KeyEqual%, %SettingsPath%, %Section%, KeyEqual
	IniWrite, %KeyQ%, %SettingsPath%, %Section%, KeyQ
	IniWrite, %KeyT%, %SettingsPath%, %Section%, KeyT
	IniWrite, %KeyY%, %SettingsPath%, %Section%, KeyY
	IniWrite, %KeyP%, %SettingsPath%, %Section%, KeyP
	IniWrite, %KeyLBracket%, %SettingsPath%, %Section%, KeyLBracket
	IniWrite, %KeyRBracket%, %SettingsPath%, %Section%, KeyRBracket
	IniWrite, %KeyBSlash%, %SettingsPath%, %Section%, KeyBSlash
	IniWrite, %KeyA%, %SettingsPath%, %Section%, KeyA
	IniWrite, %KeyG%, %SettingsPath%, %Section%, KeyG
	IniWrite, %KeyQuote%, %SettingsPath%, %Section%, KeyQuote
	IniWrite, %KeyZ%, %SettingsPath%, %Section%, KeyZ
	IniWrite, %KeyX%, %SettingsPath%, %Section%, KeyX
	IniWrite, %KeyC%, %SettingsPath%, %Section%, KeyC
	IniWrite, %KeyV%, %SettingsPath%, %Section%, KeyV
	IniWrite, %KeyB%, %SettingsPath%, %Section%, KeyB
	IniWrite, %KeyN%, %SettingsPath%, %Section%, KeyN
	IniWrite, %KeyM%, %SettingsPath%, %Section%, KeyM
	IniWrite, %KeyComma%, %SettingsPath%, %Section%, KeyComma
	IniWrite, %KeyPeriod%, %SettingsPath%, %Section%, KeyPeriod
	IniWrite, %KeySlash%, %SettingsPath%, %Section%, KeySlash
	IniWrite, %KeyNumpad1%, %SettingsPath%, %Section%, KeyNumpad1
	IniWrite, %KeyNumpad2%, %SettingsPath%, %Section%, KeyNumpad2
	IniWrite, %KeyNumpad3%, %SettingsPath%, %Section%, KeyNumpad3
	IniWrite, %KeyNumpad4%, %SettingsPath%, %Section%, KeyNumpad4
	IniWrite, %KeyNumpad5%, %SettingsPath%, %Section%, KeyNumpad5
	IniWrite, %KeyNumpad6%, %SettingsPath%, %Section%, KeyNumpad6
	IniWrite, %KeyNumpad7%, %SettingsPath%, %Section%, KeyNumpad7
	IniWrite, %KeyNumpad8%, %SettingsPath%, %Section%, KeyNumpad8
	IniWrite, %KeyNumpad9%, %SettingsPath%, %Section%, KeyNumpad9

return

GuiPause:
	GoSub TrayPause
return

GuiQuit:
	GoSub TrayQuit
return

;======== Pressing Hotkeys(Alt/Win+Caps) to show main menu.
!CapsLock::
#CapsLock::
GuiOpen:
if( isWelcomeDone && (WinExist(PopTitleMouseLock) == 0) ) ;Make sure GUI doesn't appear before Welcome Msgbox is gone
{
	DisableMouse := false
	BlockInput, MouseMoveOff
	if (WinActive(AppTitle)){
        Gui, Show, Hide,
		GoSub ShowMLockGui
	}else {
		GuiControl,, Mouse Lock, %LockMouse%
        Gui, Show,, %AppTitle%
	}
}
return

;======== Mouse Lock Menu
LockMouse := false
DisableMouse := false

ShowMLockGui:
if LockMouse{
	DisableMouse := true
	BlockInput, MouseMove
	TouchpadToggle(0)
	Gui, MLWin:New, +AlwaysOnTop -Sysmenu, %PopTitleMouseLock%
	Gui, Font, s12, Segoe UI
	Gui, Add, Text,, %PopDescMouseLock%
	Gui, Font, s15 Bold, Segoe UI
	Gui, Add, Button, Center, %PopButtonMouseLock%
	Gui, Show
	mousegetpos, sx, sy
	settimer, MouseMoveCheck, 250
}
else
{
	DisableMouse := false
}
return

MouseMoveCheck:
mousegetpos, cx, cy
if (cx != sx or cy != sy)
{
  ; mouse has moved, calculate by how much
  if (cx > (sx+50) or cx < (sx-50) or cy > (sy+50) or cy < (sy-50))
  {
	Gui, MLWin:Destroy
	SetTimer , MouseMoveCheck, Delete,
  }  
}
return

;=============== Main Fucntionality

CapsLock::
EnableHK := true
if( LockMouse && (WinActive(AppTitle) == 0)){
	DisableMouse := true
	BlockInput, MouseMove
	TouchpadToggle(0)
}
return

CapsLock Up::
EnableHK := false
return
/*
SHIFT+F1=F13
SHIFT+F2=F14
SHIFT+F3=F15
SHIFT+F4=f16
SHIFT+F5=F17
SHIFT+F6=F18
SHIFT+F7=F19
SHIFT+F8=F20
SHIFT+F9=F21
SHIFT+F10=F22
SHIFT+F11=F23
SHIFT+F12=F24
*/

#If DisableMouse	;Synaptics Clickpad driver's wheel scroll is undetectable by AHK
TouchpadToggle(0)
BlockInput, MouseMove
*LButton::
*RButton::
*WheelUp::
*WheelDown::
*Wheelleft::
*Wheelright::
*MButton::
*NumpadLeft::	;Synaptics Clickpad driver uses NumpadLeft and NumpadRight for horizontal scroll
*NumpadRight::
*NumpadUp::
*NumpadDown::
	;Synaptics Clickpad driver has priority on Mouse wheel Roll for its own two-fingered vertical scroll and pinch zoom, so this script cannot disable two fingered gestures completely.
return


/*
#If EnableSuper
`::Send ≈
1::Send ¹
2::Send ²
3::Send ³
4::Send ⁴
5::Send ⁵
6::Send ⁶
7::Send ⁷
8::Send ⁸
9::Send ⁹
0::Send ⁰
-::Send ⁻
=::Send ⁺
q::Send ∈
w::Send ∋
e::Send ∃
;r::Send %KeyR%
t::Send ∴
y::Send ∵
;u::Send %KeyU%
i::Send ⁱ
;o::Send ∅
;p::Send %KeyP%
[::Send ⁽
]::Send ⁾
\::Send √
a::Send ∀
s::Send ∆
d::Send ∂
f::Send ∫
g::Send ∝
;h::Send %KeyH%
;j::Send %KeyJ%
;k::Send %KeyK%
;l::Send %KeyL%
;`;::Send %KeyColon%
;'::Send %KeyQuote%
;z::Send %KeyZ%
;x::Send %KeyX%
;c::Send 
;v::Send %KeyV%
b::Send ∞
n::Send ⁿ
m::Send ∑
,::Send ≤
.::Send ≥
/::Send ÷
*/
#If !EnableHK && LockMouse
~a::
~b::
~c::



~g::





~m::
~n::

~p::
~q::


~t::

~v::
~w::
~x::
~y::
~z::
~,::
~.::
~/::

~'::
~[::
~]::
~`::
~1::
~2::
~3::
~4::
~5::
~6::
~7::
~8::
~9::
~0::
~-::
~=::
~\::
if( WinActive(AppTitle) == 0){
	DisableMouse := true
	BlockInput, MouseMove
	TouchpadToggle(0)
}
Return


#If EnableHK
;Send {CtrlUp}{ShiftUp}{AltUp}
w::
if (LockMouse){
	DisableMouse := false
	BlockInput, MouseMoveOff
	TouchpadToggle(1)
}
return

/*
Up::
EnableSuper := true
return
Down::
EnableSuper := false
return
*/

6::
Clipsaved := ClipboardAll
Clipboard := ""
Send ^{x}
ClipWait, 1
if(RegExMatch(Clipboard, "[^0-9+\-\(\)=nijklmxyz]") == 0){ ;can be superscriptified ⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ⁿⁱ
	;Msgbox, "Can be superscriptized" + %Clipboard%
	Clipboard := StrReplace(Clipboard, "0", "⁰",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "1", "¹",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "2", "²",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "3", "³",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "4", "⁴",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "5", "⁵",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "6", "⁶",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "7", "⁷",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "8", "⁸",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "9", "⁹",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "+", "⁺",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "-", "⁻",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "=", "⁼",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "(", "⁽",, Limit := -1)
	Clipboard := StrReplace(Clipboard, ")", "⁾",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "n", "ⁿ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "i", "ⁱ",, Limit := -1)
	;ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖ𐞥ʳˢᵗᵘᵛʷˣʸᶻ
	Clipboard := StrReplace(Clipboard, "j", "ʲ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "k", "ᵏ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "l", "ˡ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "m", "ᵐ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "x", "ˣ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "y", "ʸ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "z", "ᶻ",, Limit := -1)
/*
	Clipboard := StrReplace(Clipboard, "a", "ᵃ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "b", "ᵇ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "c", "ᶜ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "d", "ᵈ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "e", "ᵉ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "f", "ᶠ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "g", "ᵍ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "h", "ʰ",, Limit := -1)

	Clipboard := StrReplace(Clipboard, "o", "ᵒ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "p", "ᵖ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "q", "𐞥",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "r", "ʳ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "s", "ˢ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "t", "ᵗ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "u", "ᵘ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "v", "ᵛ",, Limit := -1)
	Clipboard := StrReplace(Clipboard, "w", "ʷ",, Limit := -1)
*/
	;Msgbox, %Clipboard%
	SendRaw, % Clipboard
}else{
	;Msgbox, "Cannot be superscriptized"
	if(RegExMatch(Clipboard, "`r`n") != 0){
		Clipboard := StrReplace(Clipboard, "`r`n", "",, Limit := -1)
		SendRaw ^(%Clipboard%)`n
	}
	else SendRaw ^(%Clipboard%)
}
Clipboard := Clipsaved
Clipsaved := ""	;free up memory
return

; Navigate: Press CapsLock and these keys to navigate without moving your hands.
i::Up
j::Left
k::Down
l::Right
e::Send ^{Up}
d::Send ^{Down}
r::Send {Up %UpScroll%}
f::Send {Down %DownScroll%}
u::^Left
o::^Right
h::Home
`;::End

; Selection: Pressing either 'Shift' or 's' while pressing CapsLock acts as selection key(what shift key does normally). 
;s::Shift
s & i::Send +{Up}
s & j::Send +{Left}
s & k::Send +{Down}
s & l::Send +{Right}
s & r::Send +{Up %UpScroll%}
s & f::Send +{Down %DownScroll%}
s & u::Send +^{Left}
s & o::Send +^{Right}
s & h::Send +{Home}
s & `;::Send +{End}
+r::Send +{Up %UpScroll%}
+f::Send +{Down %DownScroll%}

; Custom Keybinds
`::Send {Space}{Backspace}%KeyGrave%
1::Send {Space}{Backspace}%Key1%
2::Send {Space}{Backspace}%Key2%
3::Send {Space}{Backspace}%Key3%
4::Send {Space}{Backspace}%Key4%
5::Send {Space}{Backspace}%Key5%
;6::Send {Space}{Backspace}%Key6%
7::Send {Space}{Backspace}%Key7%
8::Send {Space}{Backspace}%Key8%
9::Send {Space}{Backspace}%Key9%
0::Send {Space}{Backspace}%Key0%
-::Send {Space}{Backspace}%KeyHyphen%
=::Send {Space}{Backspace}%KeyEqual%
q::Send {Space}{Backspace}%KeyQ%
;w::Send {Space}{Backspace}%KeyW%
;e::Send {Space}{Backspace}%KeyE%
;r::Send {Space}{Backspace}%KeyR%
t::Send {Space}{Backspace}%KeyT%
y::Send {Space}{Backspace}%KeyY%
;u::Send {Space}{Backspace}%KeyU%
;i::Send {Space}{Backspace}%KeyI%
;o::Send {Space}{Backspace}%KeyO%
p::Send {Space}{Backspace}%KeyP%
[::Send {Space}{Backspace}%KeyLBracket%
]::Send {Space}{Backspace}%KeyRBracket%
\::Send {Space}{Backspace}%KeyBSlash%
a::Send {Space}{Backspace}%KeyA%
;s::Send {Space}{Backspace}%KeyS%
;d::Send {Space}{Backspace}%KeyD%
;f::Send {Space}{Backspace}%KeyF%
g::Send {Space}{Backspace}%KeyG%
;h::Send {Space}{Backspace}%KeyH%
;j::Send {Space}{Backspace}%KeyJ%
;k::Send {Space}{Backspace}%KeyK%
;l::Send {Space}{Backspace}%KeyL%
;`;::Send {Space}{Backspace}%KeyColon%
'::Send {Space}{Backspace}%KeyQuote%
z::Send {Space}{Backspace}%KeyZ%
x::Send {Space}{Backspace}%KeyX%
c::Send {Space}{Backspace}%KeyC%
v::Send {Space}{Backspace}%KeyV%
b::Send {Space}{Backspace}%KeyB%
n::Send {Space}{Backspace}%KeyN%
m::Send {Space}{Backspace}%KeyM%
,::Send {Space}{Backspace}%KeyComma%
.::Send {Space}{Backspace}%KeyPeriod%
/::Send {Space}{Backspace}%KeySlash%

Numpad1::Send {Space}{Backspace}%KeyNumpad1%
Numpad2::Send {Space}{Backspace}%KeyNumpad2%
Numpad3::Send {Space}{Backspace}%KeyNumpad3%
Numpad4::Send {Space}{Backspace}%KeyNumpad4%
Numpad5::Send {Space}{Backspace}%KeyNumpad5%
Numpad6::Send {Space}{Backspace}%KeyNumpad6%
Numpad7::Send {Space}{Backspace}%KeyNumpad7%
Numpad8::Send {Space}{Backspace}%KeyNumpad8%
Numpad9::Send {Space}{Backspace}%KeyNumpad9%
