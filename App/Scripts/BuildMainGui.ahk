Section := "Gui"
IniRead, Gap, %SettingsPath%, %Section%, Gap
IniRead, Width, %SettingsPath%, %Section%, Width
IniRead, Height, %SettingsPath%, %Section%, Height
IniRead, BackspaceWidth, %SettingsPath%, %Section%, BackspaceWidth
IniRead, TabWidth, %SettingsPath%, %Section%, TabWidth
IniRead, CapslockWidth, %SettingsPath%, %Section%, CapslockWidth
IniRead, LeftShiftWidth, %SettingsPath%, %Section%, LeftShiftWidth
IniRead, ControlWidth, %SettingsPath%, %Section%, ControlWidth
IniRead, ColorBg, %SettingsPath%, %Section%, ColorBg
IniRead, ColorTxt, %SettingsPath%, %Section%, ColorTxt
IniRead, ColorPanelTxt, %SettingsPath%, %Section%, ColorPanelTxt

TotalWidth := Width * 16 + Gap * 18 + BackspaceWidth
TotalHeight := Height * 7 + Gap * 8
;Multiplier for the GUI size to make it fill the screen. Value is 6 when on 1920 width monitor.
;Scale option in Display settings changes A_ScreenDPI. 100% scale is 96 DPI, 150% is 144 DPI.
GuiSize := Floor(Min((A_ScreenWidth / TotalWidth), (A_ScreenHeight / TotalHeight)) / (A_ScreenDPI/96))

LayoutG := Floor(Gap * GuiSize)				;Gap between keys
LayoutW := Floor(Width * GuiSize)				;Width of regular key
LayoutH := Floor(Height * GuiSize)				;Height of regular key
LayoutWBSpc := Floor(BackspaceWidth * GuiSize)			;Backspace Width: determines the total Keyboard width(13×LayoutW + 15×LayoutG + LayoutWBSpc). Has to be bigger than (LayoutWTab - LayoutW).
LayoutWTab := Floor(TabWidth * GuiSize)			;Tab Width
LayoutWCaps := Floor(CapsLockWidth * GuiSize)			;Caps Lock Width
LayoutWShift := Floor(LeftShiftWidth * GuiSize)			;Left Shift Width
LayoutWCtrl := Floor(ControlWidth * GuiSize)			;Left Ctrl(and other function keys like Windows) Width



LayoutWBSlsh := LayoutWBSpc + LayoutW - LayoutWTab
LayoutWEnter := LayoutWBSpc + LayoutW + LayoutW - LayoutWCaps + LayoutG
LayoutWRShift := LayoutWBSpc + LayoutW + LayoutW + LayoutW - LayoutWShift + LayoutG + LayoutG

LayoutWG := LayoutW + LayoutG
LayoutHG := LayoutH + LayoutG
LayoutWTabG := LayoutWTab + LayoutG
LayoutWBSlshG := LayoutWBSlsh + LayoutG
LayoutWCapsG :=  LayoutWCaps + LayoutG
LayoutWEnterG := LayoutWEnter + LayoutG
LayoutWShiftG := LayoutWShift + LayoutG
LayoutWRShiftG := LayoutWRShift + LayoutG
LayoutWCtrlG := LayoutWCtrl + LayoutG

LayoutTotalW := LayoutG + LayoutWG * 16 + LayoutWBSpc + LayoutG
LayoutTotalH := LayoutHG * 7 + LayoutG

LayoutWSpace := LayoutTotalW - LayoutWCtrlG * 7 - LayoutG*2 - LayoutWG*3
LayoutWSpaceG := LayoutWSpace + LayoutG

LayoutWDescFront := Floor(150 * GuiSize)
FontSize := Floor(11/4 * GuiSize)

;↹˄˂˅˃↵⇧
Uni_tab := Chr(0x21B9)
Uni_up := Chr(0x2C4)
Uni_left := Chr(0x2C2)
Uni_down := Chr(0x2C5)
Uni_right := Chr(0x2C3)
Uni_enter := Chr(0x21B5)
Uni_shift := Chr(0x21E7)
Uni_sub := Chr(0x2082)
Uni_super := Chr(0x00B2)


Gui, -SysMenu +AlwaysOnTop
Gui, Show, w%LayoutTotalW% h%LayoutTotalH% Hide, %AppTitle%
Gui, Color, %ColorBg%
Gui Font, s%FontSize% Bold, Segoe UI

;change edit regex
;before:		\nGui Add, Edit, c%ColorTxt% x([^ ]+) y([^ ]+) w([^ ]+) h([^ ]+) -VScroll \+Center vKey([^ ]+) \+WantTab -Theme, %Key([^ ]+)%
;after:			\nGui Add, Edit, c%ColorTxt% x$1 y$2 w$3 h$4 -VScroll +Center vKey$5 +WantTab -Theme, %Key$6%

;======== Esc Row
Gui Add, Button, x%LayoutG% y%LayoutG% w%LayoutW% h%LayoutH% -VScroll +Center, Esc			;Esc
Gui Add, Edit, c%ColorPanelTxt% Background xp+%LayoutWG% yp w%LayoutWDescFront% hp -VScroll +Center +ReadOnly -Theme, %MenuDescFront%
Temp := LayoutTotalW - LayoutWTab - LayoutG
Gui Add, Button, x%Temp% yp w%LayoutWTab% hp -VScroll +Center gGuiAbout, About
Temp := Temp - LayoutWTab - LayoutG
Gui Add, CheckBox, x%Temp% yp wp hp -VScroll +Center vLockMouse Checked%LockMouse%, Mouse Lock
Temp := (Temp - LayoutWDescFront - LayoutWG - LayoutG*3)
Temp2 := LayoutWG + LayoutWDescFront + LayoutG*2
Gui Add, Edit, c%ColorPanelTxt% x%Temp2% yp w%Temp% hp -VScroll +Center +ReadOnly -Theme, %MenuDescFront2%
;======== Number Row
Gui Add, Edit, c%ColorTxt% x%LayoutG% yp+%LayoutHG% w%LayoutW% h%LayoutH% -VScroll +Center vKeyGrave +WantTab -Theme, %KeyGrave%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKey1 +WantTab -Theme, %Key1%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKey2 +WantTab -Theme, %Key2%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKey3 +WantTab -Theme, %Key3%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKey4 +WantTab -Theme, %Key4%
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescKey5 +ReadOnly, X%Uni_sub%
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescKey6 +ReadOnly, X%Uni_super%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKey7 +WantTab -Theme, %Key7%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKey8 +WantTab -Theme, %Key8%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKey9 +WantTab -Theme, %Key9%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKey0 +WantTab -Theme, %Key0%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyHyphen +WantTab -Theme, %KeyHyphen%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyEqual +WantTab -Theme, %KeyEqual%
Gui Add, Button, xp+%LayoutWG% yp w%LayoutWBSpc% hp -VScroll +Center +ReadOnly, BackSpc		;BackSpace
;======== QWERTY Row
Gui Add, Button, x%LayoutG% yp+%LayoutHG% w%LayoutWTab% hp -VScroll +Center gDescMLock +ReadOnly, Tab %Uni_tab% MLock		;Tab
Gui Add, Edit, c%ColorTxt% xp+%LayoutWTabG% yp w%LayoutW% hp -VScroll +Center vKeyQ +WantTab -Theme, %KeyQ%						;Q
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp w%LayoutW% hp -VScroll +Center vKeyW +WantTab -Theme, %KeyW%		;W
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyE +WantTab -Theme, %KeyE%				;E
Gui, Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescScrollUp +ReadOnly, Scroll			;R
Gui, Add, UpDown, vUpScroll Range1-12, %UpScroll%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp h%LayoutH% -VScroll +Center vKeyT +WantTab -Theme, %KeyT%						;T
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyY +WantTab -Theme, %KeyY%								;Y
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescPrev +ReadOnly, Prev					;U
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescUp +ReadOnly, %Uni_up%						;I
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescNext +ReadOnly, Next					;O
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyP +WantTab -Theme, %KeyP%								;P
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyLBracket +WantTab -Theme, %KeyLBracket%					;[
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyRBracket +WantTab -Theme, %KeyRBracket%					;]
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp w%LayoutWBSlsh% hp -VScroll +Center vKeyBSlash +WantTab -Theme, %KeyBSlash%			;\

Gui Add, Edit, c%ColorTxt% xp+%LayoutWBSlshG% yp w%LayoutW% hp -VScroll +Center vKeyNumpad7 +WantTab -Theme, %KeyNumpad7%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyNumpad8 +WantTab -Theme, %KeyNumpad8%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyNumpad9 +WantTab -Theme, %KeyNumpad9%

;======== Caps Lock Row
Gui Add, Button, x%LayoutG% yp+%LayoutHG% w%LayoutWCaps% hp -VScroll +Center gDescCaps +ReadOnly cRed, Special	;Caps Lock
Gui Add, Edit, c%ColorTxt% xp+%LayoutWCapsG% yp w%LayoutW% hp -VScroll +Center vKeyA +WantTab -Theme, %KeyA%					;A
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescSelect +ReadOnly, Shift				;S
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyD +WantTab -Theme, %KeyD%			;D
Gui, Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescScrollDn +ReadOnly, Scroll			;F
Gui, Add, UpDown, vDownScroll Range1-12, %DownScroll%														;F
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyG +WantTab -Theme, %KeyG%								;G
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescHome +ReadOnly, Home					;H
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescLeft +ReadOnly, %Uni_left%						;J	
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescDown +ReadOnly, %Uni_down%						;K
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescRight +ReadOnly, %Uni_right%					;L
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescEnd +ReadOnly, End					;Colon
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyQuote +WantTab -Theme, %KeyQuote%						;Quotes
Gui Add, Button, xp+%LayoutWG% yp w%LayoutWEnter% hp -VScroll +Center +ReadOnly, %Uni_enter% Enter				;Return key

Gui Add, Edit, c%ColorTxt% xp+%LayoutWEnterG% yp w%LayoutW% hp -VScroll +Center vKeyNumpad4 +WantTab -Theme, %KeyNumpad4%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyNumpad5 +WantTab -Theme, %KeyNumpad5%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyNumpad6 +WantTab -Theme, %KeyNumpad6%
;======== Shift Row
Gui Add, Button, x%LayoutG% yp+%LayoutHG% w%LayoutWShift% hp -VScroll +Center gDescShift +ReadOnly, LShift %Uni_shift%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWShiftG% yp w%LayoutW% hp -VScroll +Center vKeyZ +WantTab -Theme, %KeyZ%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyX +WantTab -Theme, %KeyX%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyC +WantTab -Theme, %KeyC%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyV +WantTab -Theme, %KeyV%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyB +WantTab -Theme, %KeyB%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyN +WantTab -Theme, %KeyN%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyM +WantTab -Theme, %KeyM%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyComma +WantTab -Theme, %KeyComma%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyPeriod +WantTab -Theme, %KeyPeriod%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeySlash +WantTab -Theme, %KeySlash%
Gui Add, Button, xp+%LayoutWG% yp w%LayoutWRShift% hp -VScroll +Center gDescShift +ReadOnly, %Uni_shift% RShift

Gui Add, Edit, c%ColorTxt% xp+%LayoutWRShiftG% yp w%LayoutW% hp -VScroll +Center vKeyNumpad1 +WantTab -Theme, %KeyNumpad1%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyNumpad2 +WantTab -Theme, %KeyNumpad2%
Gui Add, Edit, c%ColorTxt% xp+%LayoutWG% yp wp hp -VScroll +Center vKeyNumpad3 +WantTab -Theme, %KeyNumpad3%
;======== Ctrl Row
Gui Add, Button, x%LayoutG% yp+%LayoutHG% w%LayoutWCtrl% hp -VScroll +Center gDescLCtrl +ReadOnly, LCtrl
Gui Add, Button, xp+%LayoutWCtrlG% yp wp hp -VScroll +Center gDescWin +ReadOnly, Win
Gui Add, Button, xp+%LayoutWCtrlG% yp wp hp -VScroll +Center gDescLAlt +ReadOnly, LAlt
Gui Add, Button, xp+%LayoutWCtrlG% yp w%LayoutWSpace% hp -VScroll +Center +ReadOnly, Space
Gui Add, Button, xp+%LayoutWSpaceG% yp w%LayoutWCtrl% hp -VScroll +Center +ReadOnly, RAlt
Gui Add, Button, xp+%LayoutWCtrlG% yp wp hp -VScroll +Center +ReadOnly, Fn
Gui Add, Button, xp+%LayoutWCtrlG% yp wp hp -VScroll +Center +ReadOnly, Menu
Gui Add, Button, xp+%LayoutWCtrlG% yp wp hp -VScroll +Center +ReadOnly, RCtrl

;======== Button Row
Temp := LayoutTotalW - LayoutWBSpc - LayoutG
Gui Add, Button, x%Temp% yp+%LayoutHG% w%LayoutWBSpc% hp -VScroll +Center gGuiPause, %MenuButtonPause%
Temp := Temp - LayoutWBSpc - LayoutG
Gui Add, Button, x%Temp% yp w%LayoutWBSpc% hp -VScroll +Center gGuiCancel, %MenuButtonCancel%
Temp := Temp - LayoutWBSpc - LayoutG
Gui Add, Button, x%Temp% yp w%LayoutWBSpc% hp -VScroll +Center gGuiSave, %MenuButtonSave%
Temp := Temp - LayoutWShift - LayoutG
Gui Add, Button, x%Temp% yp w%LayoutWShift% hp -VScroll +Center gGuiDefault, %MenuButtonDefaults%


