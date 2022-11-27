;==========================================
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
SetBatchLines -1

;KeyHistory

#include %A_ScriptDir%\Settings\Localization

;for synaptics toucpad
;ToucpadToggle(1) enables, (0) disables, (else) toggles.
TouchpadToggle(setter) {
	Enabled := ComObjError(False)
	SynAPI:=ComObjCreate("SynCtrl.SynAPICtrl"), SynDev:=ComObjCreate("SynCtrl.SynDeviceCtrl")
	SynAPI.Initialize
	SynDev.Select(SynAPI.FindDevice(0,2,-1))
	if(setter == 0){
		SynDev.SetLongProperty(268435825, 1)
	}else if(setter == 1){
		SynDev.SetLongProperty(268435825, 0)
	}else{
		SynDev.SetLongProperty(268435825, State:=(!SynDev.GetLongProperty(268435825) ? 1 : 0))
	}
	Return
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
#include %A_ScriptDir%\Settings\NoStartPop

if(NoStartPop == 0)
{
	MsgBox, 4097, %PopTitleWelcome%, %PopDescWelcome%,
	ifMsgBox, Cancel
	{
		FileDelete %A_ScriptDir%\Settings\NoStartPop
		FileAppend, 
		(
		NoStartPop := 1
		), %A_ScriptDir%\Settings\NoStartPop, UTF-8
	}
}

/*

if(NoStartPop == 0){
	Gui, WelcomeWin:New, +AlwaysOnTop -Sysmenu, %PopTitleWelcome%
	Gui, Font, s12, Segoe UI
	Gui, Add, Text,, %PopDescWelcome%
	Gui, Font, s15 Bold, Segoe UI
	Gui, Add, Checkbox, Center vNeverShow, %PopButtonWelcomeNever%
	Gui, Add, Button, Center gWelcomeCheck, %PopButtonWelcomeOK%
}
Gui, WelcomeWin:Show
return


WelcomeCheck:
	if(NeverShow == 1)
	{
		FileDelete %A_ScriptDir%\Settings\NoStartPop
		FileAppend, 
		(
		NoStartPop := 1
		), %A_ScriptDir%\Settings\NoStartPop, UTF-8
	}
	Gui, WelcomeWin:Hide
return
*/

isWelcomeDone := true
EnableHK := false
SetCapsLockState Off
EnableSuper := false

#include %A_ScriptDir%\Settings\Keys
#include %A_ScriptDir%\Scripts\BuildMainGui.ahk


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

DescModify:
	MsgBox, 4096, %MenuTitleKeys%, %MenuDescModify%,
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
	FileDelete %A_ScriptDir%\Settings\Keys
	FileCopy %A_ScriptDir%\Settings\Keys_Default, %A_ScriptDir%\Settings\Keys, 1
	GoSub ReadSettings
	GoSub GuiRefresh
return

GuiSave:
	Gui Submit
	GoSub WriteSettings
	GoSub GuiRefresh
return

GuiCancel:
	Gui Show, Hide, %AppTitle%
	GoSub GuiRefresh
return

GuiRefresh:
	GuiControl,, UpScroll, %UpScroll%
	GuiControl,, DownScroll, %DownScroll%
	GuiControl,, LeftScroll, %LeftScroll%
	GuiControl,, RightScroll, %RightScroll%
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
	GuiControl,, KeyE, %KeyE%
	GuiControl,, KeyT, %KeyT%
	GuiControl,, KeyY, %KeyY%
	GuiControl,, KeyP, %KeyP%
	GuiControl,, KeyLBracket, %KeyLBracket%
	GuiControl,, KeyRBracket, %KeyRBracket%
	GuiControl,, KeyBSlash, %KeyBSlash%
	GuiControl,, KeyD, %KeyD%
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

ReadSettings:
	#IncludeAgain, %A_ScriptDir%\Settings\Keys
return

WriteSettings:
	FileDelete %A_ScriptDir%\Settings\Keys
	FileAppend,
	(
UpScroll := %UpScroll%
DownScroll := %DownScroll%
LeftScroll := %LeftScroll%
RightScroll := %RightScroll%
KeyGrave = %KeyGrave%
Key1 = %Key1%
Key2 = %Key2%
Key3 = %Key3%
Key4 = %Key4%
Key5 = %Key5%
Key7 = %Key7%
Key8 = %Key8%
Key9 = %Key9%
Key0 = %Key0%
KeyHyphen = %KeyHyphen%
KeyEqual = %KeyEqual%
KeyQ = %KeyQ%
KeyE = %KeyE%
KeyT = %KeyT%
KeyY = %KeyY%
KeyP = %KeyP%
KeyLBracket = %KeyLBracket%
KeyRBracket = %KeyRBracket%
KeyBSlash = %KeyBSlash%
KeyD = %KeyD%
KeyG = %KeyG%
KeyQuote = %KeyQuote%
KeyZ = %KeyZ%
KeyX = %KeyX%
KeyC = %KeyC%
KeyV = %KeyV%
KeyB = %KeyB%
KeyN = %KeyN%
KeyM = %KeyM%
KeyComma = %KeyComma%
KeyPeriod = %KeyPeriod%
KeySlash = %KeySlash%
KeyNumpad1 = %KeyNumpad1%
KeyNumpad2 = %KeyNumpad2%
KeyNumpad3 = %KeyNumpad3%
KeyNumpad4 = %KeyNumpad4%
KeyNumpad5 = %KeyNumpad5%
KeyNumpad6 = %KeyNumpad6%
KeyNumpad7 = %KeyNumpad7%
KeyNumpad8 = %KeyNumpad8%
KeyNumpad9 = %KeyNumpad9%
	), %A_ScriptDir%\Settings\Keys, UTF-8
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
if isWelcomeDone ;Make sure GUI doesn't appear before Welcome Msgbox is gone
{
	DisableMouse := false
	BlockInput, MouseMoveOff
	if (WinExist("Useful Caps Lock")){
        Gui, Show, Hide,
	}else{
        Gui, Show,, %AppTitle%
	}
}
return

;======== Mouse Lock Menu
LockMouse := false
DisableMouse := false
GuiMLock:
if LockMouse{
	LockMouse := false
	DisableMouse := false
}
else{
	LockMouse := true
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
if LockMouse{
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
Send {CtrlUp}
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

~b::
~c::
~d::
~e::
~f::
~g::
~h::
~i::
~j::
~k::
~l::
~m::
~n::
~o::
~p::
~q::
~r::

~t::
~u::
~v::
~w::
~x::
~y::
~z::
~,::
~.::
~/::
~`;::
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
DisableMouse := true
BlockInput, MouseMove
TouchpadToggle(0)
Return


#If EnableHK
w::
if LockMouse{
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
e::^Up
d::^Down
r::Send {Up %UpScroll%}
f::Send {Down %DownScroll%}
u::Send {Left %LeftScroll%}
o::Send {Right %RightScroll%}
h::Home
`;::End

; Pressing 'a' acts as Contorl
a::Ctrl

; Selection: Pressing either 'Shift' or 's' while pressing CapsLock acts as selection key(what shift key does normally). 
s::Shift

^r::Send ^{Up %UpScroll%}
^f::Send ^{Down %DownScroll%}
^u::Send ^{Left %LeftScroll%}
^o::Send ^{Right %RightScroll%}

+r::Send +{Up %UpScroll%}
+f::Send +{Down %DownScroll%}
+u::Send +{Left %LeftScroll%}
+o::Send +{Right %RightScroll%}

^+r::Send ^+{Up %UpScroll%}
^+f::Send ^+{Down %DownScroll%}
^+u::Send ^+{Left %LeftScroll%}
^+o::Send ^+{Right %RightScroll%}




; Custom Keybinds
`::Send %KeyGrave%
1::Send %Key1%
2::Send %Key2%
3::Send %Key3%
4::Send %Key4%
5::Send %Key5%
;6::Send %Key6%
7::Send %Key7%
8::Send %Key8%
9::Send %Key9%
0::Send %Key0%
-::Send %KeyHyphen%
=::Send %KeyEqual%
q::Send %KeyQ%
;w::Send %KeyW%
e::Send %KeyE%
;r::Send %KeyR%
t::Send %KeyT%
y::Send %KeyY%
;u::Send %KeyU%
;i::Send %KeyI%
;o::Send %KeyO%
p::Send %KeyP%
[::Send %KeyLBracket%
]::Send %KeyRBracket%
\::Send %KeyBSlash%
;a::Send %KeyA%
;s::Send %KeyS%
d::Send %KeyD%
;f::Send %KeyF%
g::Send %KeyG%
;h::Send %KeyH%
;j::Send %KeyJ%
;k::Send %KeyK%
;l::Send %KeyL%
;`;::Send %KeyColon%
'::Send %KeyQuote%
z::Send %KeyZ%
x::Send %KeyX%
c::Send %KeyC%
v::Send %KeyV%
b::Send %KeyB%
n::Send %KeyN%
m::Send %KeyM%
,::Send %KeyComma%
.::Send %KeyPeriod%
/::Send %KeySlash%

Numpad1::Send %KeyNumpad1%
Numpad2::Send %KeyNumpad2%
Numpad3::Send %KeyNumpad3%
Numpad4::Send %KeyNumpad4%
Numpad5::Send %KeyNumpad5%
Numpad6::Send %KeyNumpad6%
Numpad7::Send %KeyNumpad7%
Numpad8::Send %KeyNumpad8%
Numpad9::Send %KeyNumpad9%
