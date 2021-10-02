﻿;==========================================
; Title:  Useful Caps Lock
; Author: Favmir (FavmirY@gmail.com)
; Description:
;	This scripts repurposes the CapsLock button so that
;	upon pressing it you enter a special input mode.
;	Press Windows/Alt + CapsLock to bring up the menu.
;	If you want to use the original CapsLock function, press Shift + CapsLock
;	When mouse is disabled, press CapsLock + W to use Mouse.
;	(only happens when enabled in options)
;==========================================

#SingleInstance Force
Menu, Tray, Icon,,, 1	;freeze current icon
Menu, Tray, Icon, %A_ScriptDir%\Icons\icon(32x32).png, 1, 1
Menu, Tray, NoStandard
Menu, Tray, Click, 1
Menu, Tray, Add, &Open Useful Caps Lock, TrayGui
Menu, Tray, Add, &Pause Program, TrayPause
Menu, Tray, Add, &Quit, TrayQuit
Menu, Tray, Default, &Pause Program

SetBatchLines -1

#include %A_ScriptDir%\Settings\Localization.settings
#include %A_ScriptDir%\Settings\Gui.settings
LayoutWBSlsh := LayoutWBSpc + LayoutW - LayoutWTab
LayoutWEnter := LayoutWBSpc + LayoutW + LayoutW - LayoutWCaps + LayoutG
LayoutWRShift := LayoutWBSpc + LayoutW + LayoutW + LayoutW - LayoutWShift + LayoutG + LayoutG

LayoutWG := LayoutW + LayoutG
LayoutHG := LayoutH + LayoutG
LayoutWTabG := LayoutWTab + LayoutG
LayoutWCapsG :=  LayoutWCaps + LayoutG
LayoutWShiftG := LayoutWShift + LayoutG

LayoutTotalW := LayoutG + LayoutWG * 13 + LayoutWBSpc + LayoutG
LayoutTotalH := LayoutHG * 6 + LayoutG

;=========================== Initialize
isWelcomeDone := false
#include %A_ScriptDir%\Settings\NoStartPop.settings
if(NoStartPop == 0)
{
	MsgBox, 4097, %PopTitleWelcome%, %PopDescWelcome%,
	ifMsgBox, Cancel
	{
		FileDelete %A_ScriptDir%\Settings\NoStartPop.settings
		FileAppend, 
		(
		NoStartPop := 1
		), %A_ScriptDir%\Settings\NoStartPop.settings, UTF-8
	}
}
isWelcomeDone := true
EnableHK := false
SetCapsLockState Off
EnableSuper := false


Gui -SysMenu
Gui, Show, w%LayoutTotalW% h%LayoutTotalH% Hide, Useful Caps Lock
#include %A_ScriptDir%\Settings\Keys.settings
#include %A_ScriptDir%\Scripts\BuildMainGui.ahk
#include %A_ScriptDir%\Scripts\BuildSideGui.ahk


return

TrayGui:
	if A_IsSuspended=1
	{
		GoSub TrayPause
	}
	GoSub GuiOpen
return

TrayPause:
Menu, Tray, ToggleCheck, &Pause Program
if A_IsSuspended=1 
{
	Suspend Off
	Menu, Tray, Icon, %A_ScriptDir%\Icons\icon(32x32).png, 1, 1
}
else
{
	Menu, Tray, Icon, %A_ScriptDir%\Icons\icon_off(32x32).png, 1, 1
	Gui Show, Hide, Useful Caps Lock
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
	MsgBox, 4096,%MenuTitleKeys%, %MenuDescCaps%,
return

DescShift:
	MsgBox, 4096,%MenuTitleKeys%, %MenuDescShift%,
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
	FileCopy Keys_Default.settings, Keys.settings, 1
	GoSub ReadDefaultSettings
	GoSub GuiRefresh
return

GuiSave:
	Gui Submit
	GoSub WriteSettings
	GoSub GuiRefresh
return

GuiCancel:
	Gui Show, Hide, Useful Caps Lock
	GoSub GuiRefresh
return

GuiRefresh:
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
return

ReadSettings:
	#include %A_ScriptDir%\Settings\Keys.settings
return

ReadDefaultSettings:
	#include %A_ScriptDir%\Settings\Keys_Default.settings
return

WriteSettings:
	FileDelete %A_ScriptDir%\Settings\Keys.settings
	FileAppend,
	(
UpScroll := %UpScroll%
DownScroll := %DownScroll%
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
KeyT = %KeyT%
KeyY = %KeyY%
KeyP = %KeyP%
KeyLBracket = %KeyLBracket%
KeyRBracket = %KeyRBracket%
KeyBSlash = %KeyBSlash%
KeyA = %KeyA%
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
	), %A_ScriptDir%\Settings\Keys.settings, UTF-8
return

GuiPause:
	GoSub TrayPause
return

GuiQuit:
	GoSub TrayQuit
return

;======== Pressing Hotkeys(Win+Caps) to show main menu.
!CapsLock::
#CapsLock::
GuiOpen:
if isWelcomeDone
{
	DisableMouse := false
	BlockInput, MouseMoveOff
	Gui, Show,, Useful Caps Lock
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
	MsgBox, 4096, %PopTitleMouseLock%, %PopDescMouseLock%
}
return

;=============== Main Fucntionality
CapsLock::
EnableHK := true
if LockMouse{
	DisableMouse := true
	BlockInput, MouseMove
}
return

CapsLock Up::
EnableHK := false
return

#If DisableMouse
LButton::return
RButton::return
BlockInput, MouseMove
return

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

#If EnableHK
w::
if LockMouse{
	DisableMouse := false
	BlockInput, MouseMoveOff
}
return

Up::
EnableSuper :=true
return
Down::
EnableSuper := false
return

6::
Clipboard := ""
Send ^{x}
SendRaw ^()
Send {Left}^{v}{Right}
Clipboard := ""
return

; Navigate: Press CapsLock and these keys to navigate without moving your hands.
i::Send {Up}
j::Send {Left}
k::Send {Down}
l::Send {Right}
e::Send ^{Up}
d::Send ^{Down}
r::Send {Up %UpScroll%}
f::Send {Down %DownScroll%}
u::Send ^{Left}
o::Send ^{Right}
h::Send {Home}
`;::Send {End}


; Selection: Pressing 's' while pressing CapsLock acts as selection key(what shift key does normally). 
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
