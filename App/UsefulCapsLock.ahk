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
DescKey5:
	Msgbox, 4096, %MenuTitleKeys%, %MenuDescKey5%,
return

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
	GuiControl,, Key7, %Key7%
	GuiControl,, Key8, %Key8%
	GuiControl,, Key9, %Key9%
	GuiControl,, Key0, %Key0%
	GuiControl,, KeyHypen, %KeyHyphen%
	GuiControl,, KeyEqual, %KeyEqual%
	GuiControl,, KeyQ, %KeyQ%
	GuiControl,, KeyW, %KeyW%
	GuiControl,, KeyE, %KeyE%
	GuiControl,, KeyT, %KeyT%
	GuiControl,, KeyY, %KeyY%
	GuiControl,, KeyP, %KeyP%
	GuiControl,, KeyLBracket, %KeyLBracket%
	GuiControl,, KeyRBracket, %KeyRBracket%
	GuiControl,, KeyBSlash, %KeyBSlash%
	GuiControl,, KeyA, %KeyA%
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
	IniRead, Key7, %SettingsPath%, %Section%, Key7
	IniRead, Key8, %SettingsPath%, %Section%, Key8
	IniRead, Key9, %SettingsPath%, %Section%, Key9
	IniRead, Key0, %SettingsPath%, %Section%, Key0
	IniRead, KeyHyphen, %SettingsPath%, %Section%, KeyHyphen
	IniRead, KeyEqual, %SettingsPath%, %Section%, KeyEqual
	IniRead, KeyQ, %SettingsPath%, %Section%, KeyQ
	IniRead, KeyW, %SettingsPath%, %Section%, KeyW
	IniRead, KeyE, %SettingsPath%, %Section%, KeyE
	IniRead, KeyT, %SettingsPath%, %Section%, KeyT
	IniRead, KeyY, %SettingsPath%, %Section%, KeyY
	IniRead, KeyP, %SettingsPath%, %Section%, KeyP
	IniRead, KeyLBracket, %SettingsPath%, %Section%, KeyLBracket
	IniRead, KeyRBracket, %SettingsPath%, %Section%, KeyRBracket
	IniRead, KeyBSlash, %SettingsPath%, %Section%, KeyBSlash
	IniRead, KeyA, %SettingsPath%, %Section%, KeyA
	;IniRead, KeyS, %SettingsPath%, %Section%, KeyS
	IniRead, KeyD, %SettingsPath%, %Section%, KeyD
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
	IniWrite, %Key7%, %SettingsPath%, %Section%, Key7
	IniWrite, %Key8%, %SettingsPath%, %Section%, Key8
	IniWrite, %Key9%, %SettingsPath%, %Section%, Key9
	IniWrite, %Key0%, %SettingsPath%, %Section%, Key0
	IniWrite, %KeyHyphen%, %SettingsPath%, %Section%, KeyHyphen
	IniWrite, %KeyEqual%, %SettingsPath%, %Section%, KeyEqual
	IniWrite, %KeyQ%, %SettingsPath%, %Section%, KeyQ
	IniWrite, %KeyW%, %SettingsPath%, %Section%, KeyW
	IniWrite, %KeyE%, %SettingsPath%, %Section%, KeyE
	IniWrite, %KeyT%, %SettingsPath%, %Section%, KeyT
	IniWrite, %KeyY%, %SettingsPath%, %Section%, KeyY
	IniWrite, %KeyP%, %SettingsPath%, %Section%, KeyP
	IniWrite, %KeyLBracket%, %SettingsPath%, %Section%, KeyLBracket
	IniWrite, %KeyRBracket%, %SettingsPath%, %Section%, KeyRBracket
	IniWrite, %KeyBSlash%, %SettingsPath%, %Section%, KeyBSlash
	IniWrite, %KeyA%, %SettingsPath%, %Section%, KeyA
	;IniWrite, %KeyS%, %SettingsPath%, %Section%, KeyS
	IniWrite, %KeyD%, %SettingsPath%, %Section%, KeyD
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
~d::
~e::

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
Tab::
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

5::
Clipsaved := ClipboardAll
Clipboard := ""
Send ^{x}
ClipWait, 1

SubscriptTextBefore := "0123456789+-=()*aehijklmnoprstuvx"
SubscriptTextAfter  := "₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎͙ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ"

result := ""
canBeSubscript := true

Loop, Parse, Clipboard
{
	char := A_LoopField
	pos := InStr(SubscriptTextBefore, char)
	if (pos)
		result .= SubStr(SubscriptTextAfter, pos, 1)
	else {
		canBeSubscript := false
		break
	}
}

if (canBeSubscript) {
	SendRaw, % result
} else {
	if(RegExMatch(Clipboard, "`r`n") != 0){
		Clipboard := StrReplace(Clipboard, "`r`n", "",, Limit := -1)
		SendRaw _₍%Clipboard%₎`n
	}
	else SendRaw _₍%Clipboard%₎
}

Clipboard := Clipsaved
Clipsaved := ""
return

6::
Clipsaved := ClipboardAll
Clipboard := ""
Send ^{x}
ClipWait, 1

SuperscriptTextBefore := "0123456789+-=()*abcdefghijklmnopqrstuvwxyzABDEGHIJKLMNOPRTUVW"
SuperscriptTextAfter  := "⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾⃰ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖ𐞥ʳˢᵗᵘᵛʷˣʸᶻᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂ"

result := ""
canBeSuperscript := true

Loop, Parse, Clipboard
{
	char := A_LoopField
	pos := InStr(SuperscriptTextBefore, char)
	if (pos)
		result .= SubStr(SuperscriptTextAfter, pos, 1)
	else {
		canBeSuperscript := false
		break
	}
}

if (canBeSuperscript) {
	SendRaw, % result
} else {
	if(RegExMatch(Clipboard, "`r`n") != 0){
		Clipboard := StrReplace(Clipboard, "`r`n", "",, Limit := -1)
		SendRaw ^⁽%Clipboard%⁾`n
	}
	else SendRaw ^⁽%Clipboard%⁾
}

Clipboard := Clipsaved
Clipsaved := ""
return


; Navigate: Press CapsLock and these keys to navigate without moving your hands.
i::Up
j::Left
k::Down
l::Right
;e::Send ^{Up}
;d::Send ^{Down}
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
`::
if (KeyGrave != "")
	Send {Space}{Backspace}%KeyGrave%
return
1::
if (Key1 != "")
	Send {Space}{Backspace}%Key1%
return
2::
if (Key2 != "")
	Send {Space}{Backspace}%Key2%
return
3::
if (Key3 != "")
	Send {Space}{Backspace}%Key3%
return
4::
if (Key4 != "")
	Send {Space}{Backspace}%Key4%
return
7::
if (Key7 != "")
	Send {Space}{Backspace}%Key7%
return
8::
if (Key8 != "")
	Send {Space}{Backspace}%Key8%
return
9::
if (Key9 != "")
	Send {Space}{Backspace}%Key9%
return
0::
if (Key0 != "")
	Send {Space}{Backspace}%Key0%
return
-::
if (KeyHyphen != "")
	Send {Space}{Backspace}%KeyHyphen%
return
=::
if (KeyEqual != "")
	Send {Space}{Backspace}%KeyEqual%
return
q::
if (KeyQ != "")
	Send {Space}{Backspace}%KeyQ%
return
w::
if (KeyW != "")
	Send {Space}{Backspace}%KeyW%
return
e::
if (KeyE != "")
	Send {Space}{Backspace}%KeyE%
return
;r::if (KeyR != "") Send {Space}{Backspace}%KeyR%
t::
if (KeyT != "")
	Send {Space}{Backspace}%KeyT%
return
y::
if (KeyY != "")
	Send {Space}{Backspace}%KeyY%
return
;u::if (KeyU != "") Send {Space}{Backspace}%KeyU%
;i::if (KeyI != "") Send {Space}{Backspace}%KeyI%
;o::if (KeyO != "") Send {Space}{Backspace}%KeyO%
p::
if (KeyP != "")
	Send {Space}{Backspace}%KeyP%
return
[::
if (KeyLBracket != "")
	Send {Space}{Backspace}%KeyLBracket%
return
]::
if (KeyRBracket != "")
	Send {Space}{Backspace}%KeyRBracket%
return
\::
if (KeyBSlash != "")
	Send {Space}{Backspace}%KeyBSlash%
return
a::
if (KeyA != "")
	Send {Space}{Backspace}%KeyA%
return
;s::if (KeyS != "") Send {Space}{Backspace}%KeyS%
d::
if (KeyD != "")
	Send {Space}{Backspace}%KeyD%
return
;f::if (KeyF != "") Send {Space}{Backspace}%KeyF%
g::
if (KeyG != "")
	Send {Space}{Backspace}%KeyG%
return
;h::if (KeyH != "") Send {Space}{Backspace}%KeyH%
;j::if (KeyJ != "") Send {Space}{Backspace}%KeyJ%
;k::if (KeyK != "") Send {Space}{Backspace}%KeyK%
;l::if (KeyL != "") Send {Space}{Backspace}%KeyL%
;`;::if (KeyColon != "") Send {Space}{Backspace}%KeyColon%
':: 
if (KeyQuote != "")
	Send {Space}{Backspace}%KeyQuote%
return
z::
if (KeyZ != "")
	Send {Space}{Backspace}%KeyZ%
return
x::
if (KeyX != "")
	Send {Space}{Backspace}%KeyX%
return
c::
if (KeyC != "")
	Send {Space}{Backspace}%KeyC%
return
v::
if (KeyV != "")
	Send {Space}{Backspace}%KeyV%
return
b::
if (KeyB != "")
	Send {Space}{Backspace}%KeyB%
return
n::
if (KeyN != "")
	Send {Space}{Backspace}%KeyN%
return
m::
if (KeyM != "")
	Send {Space}{Backspace}%KeyM%
return
,::
if (KeyComma != "")
	Send {Space}{Backspace}%KeyComma%
return
.::
if (KeyPeriod != "")
	Send {Space}{Backspace}%KeyPeriod%
return
/::
if (KeySlash != "")
	Send {Space}{Backspace}%KeySlash%
return
Numpad1::
if (KeyNumpad1 != "")
	Send {Space}{Backspace}%KeyNumpad1%
return
Numpad2::
if (KeyNumpad2 != "")
	Send {Space}{Backspace}%KeyNumpad2%
return
Numpad3::
if (KeyNumpad3 != "")
	Send {Space}{Backspace}%KeyNumpad3%
return
Numpad4::
if (KeyNumpad4 != "")
	Send {Space}{Backspace}%KeyNumpad4%
return
Numpad5::
if (KeyNumpad5 != "")
	Send {Space}{Backspace}%KeyNumpad5%
return
Numpad6::
if (KeyNumpad6 != "")
	Send {Space}{Backspace}%KeyNumpad6%
return
Numpad7::
if (KeyNumpad7 != "")
	Send {Space}{Backspace}%KeyNumpad7%
return
Numpad8::
if (KeyNumpad8 != "")
	Send {Space}{Backspace}%KeyNumpad8%
return
Numpad9::
if (KeyNumpad9 != "")
	Send {Space}{Backspace}%KeyNumpad9%
return
