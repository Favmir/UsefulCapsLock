;==========================================
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
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.

#Include(A_WorkingDir . "\Settings\Localization.txt")

;============ Add Tray ============
TraySetIcon("","1")	;freeze current icon
Tray.Icon(A_WorkingDir . "\Icons\icon(32x32).png", "1", "1")
Tray.Delete() ; V1toV2: not 100% replacement of NoStandard, Only if NoStandard is used at the beginning
Tray.Click("1")
Tray.Add("&Open Useful Caps Lock", TrayGui)
Tray.Add("&Pause Program", TrayPause)
Tray.Add("&Quit", TrayQuit)
Tray.Default := "&Pause Program"



;=========================== Initialize
isWelcomeDone := false
IniRead()
if(NoStartPop == 0)
{
	msgResult := MsgBox(PopDescWelcome, PopTitleWelcome, 4097)
	if (msgResult = "Cancel")
	{
		FileDelete(A_ScriptDir "\Settings\NoStartPop.ucl")
		FileAppend("
		(
		NoStartPop := 1
		)", A_ScriptDir "\Settings\NoStartPop.ucl", "UTF-8")
	}
}
isWelcomeDone := true
EnableHK := false
SetCapsLockState("Off")
EnableSuper := false



#Include A_ScriptDir "\Settings\Keys.ucl"
#Include A_ScriptDir "\Scripts\BuildMainGui.ahk"

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

;======= Button Funcitions
DescKey6:
	MsgBox(MenuDescKey6, MenuTitleKeys, 4096)
return
} ; V1toV2: Added Bracket before label

DescCaps:
	MsgBox(MenuDescCaps, MenuTitleKeys, 4096)
return

DescShift:
	MsgBox(MenuDescShift, MenuTitleKeys, 4096)
return

DescWin:
	MsgBox(MenuDescWin, MenuTitleKeys, 4096)
return

DescLAlt:
	MsgBox(MenuDescLAlt, MenuTitleKeys, 4096)
return

DescMLock:
	MsgBox(MenuDescMLock, MenuTitleKeys, 4096)
return

DescSelect:
	MsgBox(MenuDescSelect, MenuTitleKeys, 4096)
return

DescPanUp:
DescPanDn:
	MsgBox(MenuDescPanUp, MenuTitleKeys, 4096)
return

DescScrollUp:
DescScrollDn:
	MsgBox(MenuDescScrollUp, MenuTitleKeys, 4096)
return

DescUp:
DescLeft:
DescDown:
DescRight:
	MsgBox(MenuDescUp, MenuTitleKeys, 4096)
return

DescPrev:
DescNext:
	MsgBox(MenuDescPrev, MenuTitleKeys, 4096)
return

DescHome:
DescEnd:
	MsgBox(MenuDescEnd, MenuTitleKeys, 4096)
return

GuiAbout:
	MsgBox(MenuDescAbout, MenuTitleAbout, 4096)
return

GuiDefault:
	FileCopy("Keys_Default.ucl", "Keys.ucl", 1)
	ReadDefaultSettings()
	GuiRefresh()
return

GuiSave:
	oSaved := myGui.Submit()
	WriteSettings()
	GuiRefresh()
return

GuiCancel:
	myGui.Title := "Useful Caps Lock"
	myGui.Show("Hide")
	GuiRefresh()
return

GuiRefresh()
{ ; V1toV2: Added bracket
	ogcUpScroll.Value := UpScroll
	ogcDownScroll.Value := DownScroll
	ogcKeyGrave.Value := KeyGrave
	ogcKey1.Value := Key1
	ogcKey2.Value := Key2
	ogcKey3.Value := Key3
	ogcKey4.Value := Key4
	ogcKey5.Value := Key5
	ogcKey7.Value := Key7
	ogcKey8.Value := Key8
	ogcKey9.Value := Key9
	ogcKey0.Value := Key0
	ogcKeyHypen.Value := KeyHyphen
	ogcKeyEqual.Value := KeyEqual
	ogcKeyQ.Value := KeyQ
	ogcKeyT.Value := KeyT
	ogcKeyY.Value := KeyY
	ogcKeyP.Value := KeyP
	ogcKeyLBracket.Value := KeyLBracket
	ogcKeyRBracket.Value := KeyRBracket
	ogcKeyBSlash.Value := KeyBSlash
	ogcKeyA.Value := KeyA
	ogcKeyG.Value := KeyG
	ogcKeyQuote.Value := KeyQuote
	ogcKeyZ.Value := KeyZ
	ogcKeyX.Value := KeyX
	ogcKeyC.Value := KeyC
	ogcKeyV.Value := KeyV
	ogcKeyB.Value := KeyB
	ogcKeyN.Value := KeyN
	ogcKeyM.Value := KeyM
	ogcKeyComma.Value := KeyComma
	ogcKeyPeriod.Value := KeyPeriod
	ogcKeySlash.Value := KeySlash
return
} ; V1toV2: Added Bracket before label

ReadSettings:
	#Include A_ScriptDir "\Settings\Keys.ucl"
return

ReadDefaultSettings()
{ ; V1toV2: Added bracket
	#Include A_ScriptDir "\Settings\Keys_Default.ucl"
return
} ; V1toV2: Added Bracket before label

WriteSettings()
{ ; V1toV2: Added bracket
	FileDelete(A_ScriptDir "\Settings\Keys.ucl")
	FileAppend("
	(
UpScroll := " UpScroll "
DownScroll := " DownScroll "
KeyGrave = " KeyGrave "
Key1 = " Key1 "
Key2 = " Key2 "
Key3 = " Key3 "
Key4 = " Key4 "
Key5 = " Key5 "
Key7 = " Key7 "
Key8 = " Key8 "
Key9 = " Key9 "
Key0 = " Key0 "
KeyHyphen = " KeyHyphen "
KeyEqual = " KeyEqual "
KeyQ = " KeyQ "
KeyT = " KeyT "
KeyY = " KeyY "
KeyP = " KeyP "
KeyLBracket = " KeyLBracket "
KeyRBracket = " KeyRBracket "
KeyBSlash = " KeyBSlash "
KeyA = " KeyA "
KeyG = " KeyG "
KeyQuote = " KeyQuote "
KeyZ = " KeyZ "
KeyX = " KeyX "
KeyC = " KeyC "
KeyV = " KeyV "
KeyB = " KeyB "
KeyN = " KeyN "
KeyM = " KeyM "
KeyComma = " KeyComma "
KeyPeriod = " KeyPeriod "
KeySlash = " KeySlash "
	)", A_ScriptDir "\Settings\Keys.ucl", "UTF-8")
return
} ; V1toV2: Added Bracket before label

GuiPause:
	TrayPause()
return

GuiQuit:
	TrayQuit()
return

;======== Pressing Hotkeys(Win+Caps) to show main menu.
!CapsLock::
#CapsLock::
GuiOpen(*)
{ ; V1toV2: Added bracket
if isWelcomeDone
{
	DisableMouse := false
	BlockInput("MouseMoveOff")
	myGui.Title := "Useful Caps Lock"
	myGui.Show()
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
	BlockInput("MouseMove")
	MsgBox(PopDescMouseLock, PopTitleMouseLock, 4096)
}
return

;=============== Main Fucntionality
} ; V1toV2: Added Bracket before hotkey or Hotstring
CapsLock::
{ ; V1toV2: Added bracket
EnableHK := true
if LockMouse{
	DisableMouse := true
	BlockInput("MouseMove")
}
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

CapsLock Up::
{ ; V1toV2: Added bracket
EnableHK := false
return

#HotIf DisableMouse
} ; V1toV2: Added Bracket before hotkey or Hotstring
LButton::return
RButton::return
BlockInput("MouseMove")
return

#HotIf EnableSuper
`::Send("≈")
1::Send("¹")
2::Send("²")
3::Send("³")
4::Send("⁴")
5::Send("⁵")
6::Send("⁶")
7::Send("⁷")
8::Send("⁸")
9::Send("⁹")
0::Send("⁰")
-::Send("⁻")
=::Send("⁺")
q::Send("∈")
w::Send("∋")
e::Send("∃")
;r::Send(KeyR)
t::Send("∴")
y::Send("∵")
;u::Send(KeyU)
i::Send("ⁱ")
;o::Send("∅")
;p::Send(KeyP)
[::Send("⁽")
]::Send("⁾")
\::Send("√")
a::Send("∀")
s::Send("∆")
d::Send("∂")
f::Send("∫")
g::Send("∝")
;h::Send(KeyH)
;j::Send(KeyJ)
;k::Send(KeyK)
;l::Send(KeyL)
;`;::Send(KeyColon)
;'::Send(KeyQuote)
;z::Send(KeyZ)
;x::Send(KeyX)
;c::Send()
;v::Send(KeyV)
b::Send("∞")
n::Send("ⁿ")
m::Send("∑,::Send ≤.::Send ≥")
/::Send("÷")

#HotIf EnableHK
w::
{ ; V1toV2: Added bracket
if LockMouse{
	DisableMouse := false
	BlockInput("MouseMoveOff")
}
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

Up::
{ ; V1toV2: Added bracket
EnableSuper := true
return
} ; V1toV2: Added Bracket before hotkey or Hotstring
Down::
{ ; V1toV2: Added bracket
EnableSuper := false
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

6::
{ ; V1toV2: Added bracket
Clipsaved := ClipboardAll()
A_Clipboard := ""
Send("^{x}")
Errorlevel := !ClipWait(1)
if(RegExMatch(A_Clipboard, "[^0-9+\-\(\)=ni]") == 0){ ;can be superscriptified ⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ⁿⁱ
	;Msgbox, "Can be superscriptized" + %Clipboard%
	A_Clipboard := StrReplace(A_Clipboard, "0", "⁰", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "1", "¹", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "2", "²", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "3", "³", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "4", "⁴", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "5", "⁵", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "6", "⁶", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "7", "⁷", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "8", "⁸", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "9", "⁹", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "+", "⁺", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "-", "⁻", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "=", "⁼", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "(", "⁽", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, ")", "⁾", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "n", "ⁿ", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "i", "ⁱ", , , Limit := -1)
	;ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖ𐞥ʳˢᵗᵘᵛʷˣʸᶻ
	A_Clipboard := StrReplace(A_Clipboard, "x", "ˣ", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "y", "ʸ", , , Limit := -1)
	A_Clipboard := StrReplace(A_Clipboard, "z", "ᶻ", , , Limit := -1)
	;Msgbox, %Clipboard%
	Send("{Raw}"  A_Clipboard")
}else{
	;Msgbox, "Cannot be superscriptized"
	if(RegExMatch(A_Clipboard, "`r`n") != 0){
		A_Clipboard := StrReplace(A_Clipboard, "`r`n", "", , , Limit := -1)
		Send("{Raw}^(" A_Clipboard ")`n")
	}
	else 	Send("{Raw}^(" A_Clipboard ")")
}
A_Clipboard := Clipsaved
Clipsaved := ""	;free up memory
return
;=== commented out buggy version ==
;6::
;Clipsaved := ClipboardAll()
;A_Clipboard := ""
;Send ^{c}
;Clipwait
;A_Clipboard := "^(" A_Clipboard ")"
;SendRaw %A_Clipboard%
;A_Clipboard := Clipsaved
;return

; Navigate: Press CapsLock and these keys to navigate without moving your hands.
} ; V1toV2: Added Bracket before hotkey or Hotstring
i::Send("{Up}")
j::Send("{Left}")
k::Send("{Down}")
l::Send("{Right}")
e::Send("^{Up}")
d::Send("^{Down}")
r::Send("{Up " UpScroll "}")
f::Send("{Down " DownScroll "}")
u::Send("^{Left}")
o::Send("^{Right}")
h::Send("{Home}")
`;::Send("{End}")


; Selection: Pressing 's' while pressing CapsLock acts as selection key(what shift key does normally). 
s & i::Send("+{Up}")
s & j::Send("+{Left}")
s & k::Send("+{Down}")
s & l::Send("+{Right}")
s & r::Send("+{Up " UpScroll "}")
s & f::Send("+{Down " DownScroll "}")
s & u::Send("+^{Left}")
s & o::Send("+^{Right}")
s & h::Send("+{Home}")
s & `;::Send("+{End}")


; Custom Keybinds
`::Send("{Space}{Backspace}" KeyGrave)
1::Send("{Space}{Backspace}" Key1)
2::Send("{Space}{Backspace}" Key2)
3::Send("{Space}{Backspace}" Key3)
4::Send("{Space}{Backspace}" Key4)
5::Send("{Space}{Backspace}" Key5)
;6::Send("{Space}{Backspace}" Key6)
7::Send("{Space}{Backspace}" Key7)
8::Send("{Space}{Backspace}" Key8)
9::Send("{Space}{Backspace}" Key9)
0::Send("{Space}{Backspace}" Key0)
-::Send("{Space}{Backspace}" KeyHyphen)
=::Send("{Space}{Backspace}" KeyEqual)
q::Send("{Space}{Backspace}" KeyQ)
;w::Send("{Space}{Backspace}" KeyW)
;e::Send("{Space}{Backspace}" KeyE)
;r::Send("{Space}{Backspace}" KeyR)
t::Send("{Space}{Backspace}" KeyT)
y::Send("{Space}{Backspace}" KeyY)
;u::Send("{Space}{Backspace}" KeyU)
;i::Send("{Space}{Backspace}" KeyI)
;o::Send("{Space}{Backspace}" KeyO)
p::Send("{Space}{Backspace}" KeyP)
[::Send("{Space}{Backspace}" KeyLBracket)
]::Send("{Space}{Backspace}" KeyRBracket)
\::Send("{Space}{Backspace}" KeyBSlash)
a::Send("{Space}{Backspace}" KeyA)
;s::Send("{Space}{Backspace}" KeyS)
;d::Send("{Space}{Backspace}" KeyD)
;f::Send("{Space}{Backspace}" KeyF)
g::Send("{Space}{Backspace}" KeyG)
;h::Send("{Space}{Backspace}" KeyH)
;j::Send("{Space}{Backspace}" KeyJ)
;k::Send("{Space}{Backspace}" KeyK)
;l::Send("{Space}{Backspace}" KeyL)
;`;::Send("{Space}{Backspace}" KeyColon)
'::Send("{Space}{Backspace}" KeyQuote)
z::Send("{Space}{Backspace}" KeyZ)
x::Send("{Space}{Backspace}" KeyX)
c::Send("{Space}{Backspace}" KeyC)
v::Send("{Space}{Backspace}" KeyV)
b::Send("{Space}{Backspace}" KeyB)
n::Send("{Space}{Backspace}" KeyN)
m::Send("{Space}{Backspace}" KeyM ",::Send {Space}{Backspace}" KeyComma ".::Send {Space}{Backspace}" KeyPeriod)
/::Send("{Space}{Backspace}" KeySlash)












