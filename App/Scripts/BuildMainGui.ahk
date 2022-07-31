#include %A_ScriptDir%\Settings\Gui.ucl
LayoutWBSlsh := LayoutWBSpc + LayoutW - LayoutWTab
LayoutWEnter := LayoutWBSpc + LayoutW + LayoutW - LayoutWCaps + LayoutG
LayoutWRShift := LayoutWBSpc + LayoutW + LayoutW + LayoutW - LayoutWShift + LayoutG + LayoutG

LayoutWG := LayoutW + LayoutG
LayoutHG := LayoutH + LayoutG
LayoutWTabG := LayoutWTab + LayoutG
LayoutWCapsG :=  LayoutWCaps + LayoutG
LayoutWShiftG := LayoutWShift + LayoutG
LayoutWCtrlG := LayoutWCtrl + LayoutG

LayoutTotalW := LayoutG + LayoutWG * 13 + LayoutWBSpc + LayoutG
LayoutTotalH := LayoutHG * 7 + LayoutG

LayoutWSpace := LayoutTotalW - LayoutWCtrlG * 7 - LayoutG * 2
LayoutWSpaceG := LayoutWSpace + LayoutG

Gui, Color, %ColorBG%
;======== Esc Row
Gui Font, s11 Bold, Segoe UI
Gui Add, Button, x%LayoutG% y%LayoutG% w%LayoutW% h%LayoutH% -VScroll +Center +ReadOnly, Esc			;Esc
Gui Add, Edit, xp+%LayoutWG% yp w500 hp -VScroll +Center +ReadOnly, %MenuDescFront%
Temp := LayoutTotalW - LayoutWTab - LayoutG
Gui Add, Button, x%Temp% yp w%LayoutWTab% hp -VScroll +Center gGuiAbout, About
Temp := Temp - LayoutWTab - LayoutG
Gui Add, CheckBox, x%Temp% yp wp hp -VScroll +Center gGuiMLock, Mouse Lock
Temp := Temp - 140 - LayoutG
Gui Add, Edit, x%Temp% yp w140 hp -VScroll +Center +ReadOnly, %MenuDescFront2%
;======== Number Row
Gui Add, Edit, WantTab x%LayoutG% yp+%LayoutHG% w%LayoutW% h%LayoutH% -VScroll +Center vKeyGrave +WantTab, %KeyGrave%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKey1 +WantTab, %Key1%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKey2 +WantTab, %Key2%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKey3 +WantTab, %Key3%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKey4 +WantTab, %Key4%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKey5 +WantTab, %Key5%
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescKey6 +ReadOnly, ^( )
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKey7 +WantTab, %Key7%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKey8 +WantTab, %Key8%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKey9 +WantTab, %Key9%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKey0 +WantTab, %Key0%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyHyphen +WantTab, %KeyHyphen%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyEqual +WantTab, %KeyEqual%
Gui Add, Edit, xp+%LayoutWG% yp w%LayoutWBSpc% hp -VScroll +Center +ReadOnly, BackSpc		;BackSpace
;======== QWERTY Row
Gui Add, Edit, x%LayoutG% yp+%LayoutHG% w%LayoutWTab% hp -VScroll +Center +ReadOnly, Tab ↹
Gui Add, Edit, WantTab xp+%LayoutWTabG% yp w%LayoutW% hp -VScroll +Center vKeyQ +WantTab, %KeyQ%						;Q
Gui Add, Button, xp+%LayoutWG% yp w%LayoutW% hp -VScroll +Center gDescMLock +ReadOnly, Ms Lock		;W
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescPanUp +ReadOnly, Pan Up				;E
Gui, Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescScrollUp +ReadOnly, Scroll			;R
Gui, Add, UpDown, vUpScroll Range1-12, 6
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp h%LayoutH% -VScroll +Center vKeyT +WantTab, %KeyT%						;T
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyY +WantTab, %KeyY%								;Y
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescPrev +ReadOnly, Prev					;U
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescUp +ReadOnly, ˄						;I
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescNext +ReadOnly, Next					;O
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyP +WantTab, %KeyP%								;P
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyLBracket +WantTab, %KeyLBracket%					;[
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyRBracket +WantTab, %KeyRBracket%					;]
Gui Add, Edit, WantTab xp+%LayoutWG% yp w%LayoutWBSlsh% hp -VScroll +Center vKeyBSlash +WantTab, %KeyBSlash%			;\
;======== Caps Lock Row
Gui Add, Button, x%LayoutG% yp+%LayoutHG% w%LayoutWCaps% hp -VScroll +Center gDescCaps +ReadOnly cRed, Special	;Caps Lock
Gui Add, Edit, WantTab xp+%LayoutWCapsG% yp w%LayoutW% hp -VScroll +Center vKeyA +WantTab, %KeyA%					;A
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescSelect +ReadOnly, Sel ect				;S
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescPanDn +ReadOnly, Pan Dn				;D
Gui, Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescScrollDn +ReadOnly, Scroll			;F
Gui, Add, UpDown, vDownScroll Range1-12, 6															;F
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyG +WantTab, %KeyG%								;G
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescHome +ReadOnly, Ho me					;H
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescLeft +ReadOnly, ˂						;J	
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescDown +ReadOnly, ˅						;K
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescRight +ReadOnly, ˃					;L
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescEnd +ReadOnly, End					;Colon
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyQuote +WantTab, %KeyQuote%						;Quotes
Gui Add, Edit, xp+%LayoutWG% yp w%LayoutWEnter% hp -VScroll +Center +ReadOnly, ↵ Enter				;Return key
;======== Shift Row
Gui Add, Button, x%LayoutG% yp+%LayoutHG% w%LayoutWShift% hp -VScroll +Center gDescShift +ReadOnly, LShift ⇧
Gui Add, Edit, WantTab xp+%LayoutWShiftG% yp w%LayoutW% hp -VScroll +Center vKeyZ +WantTab, %KeyZ%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyX +WantTab, %KeyX%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyC +WantTab, %KeyC%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyV +WantTab, %KeyV%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyB +WantTab, %KeyB%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyN +WantTab, %KeyN%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyM +WantTab, %KeyM%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyComma +WantTab, %KeyComma%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeyPeriod +WantTab, %KeyPeriod%
Gui Add, Edit, WantTab xp+%LayoutWG% yp wp hp -VScroll +Center vKeySlash +WantTab, %KeySlash%
Gui Add, Button, xp+%LayoutWG% yp w%LayoutWRShift% hp -VScroll +Center gDescShift +ReadOnly, ⇧ RShift
;======== Ctrl Row
Gui Add, Edit, x%LayoutG% yp+%LayoutHG% w%LayoutWCtrl% hp -VScroll +Center +ReadOnly, LCtrl
Gui Add, Button, xp+%LayoutWCtrlG% yp wp hp -VScroll +Center gDescWin +ReadOnly, Win
Gui Add, Button, xp+%LayoutWCtrlG% yp wp hp -VScroll +Center gDescLAlt +ReadOnly, LAlt
Gui Add, Edit, xp+%LayoutWCtrlG% yp w%LayoutWSpace% hp -VScroll +Center +ReadOnly, Space
Gui Add, Edit, xp+%LayoutWSpaceG% yp w%LayoutWCtrl% hp -VScroll +Center +ReadOnly, RAlt
Gui Add, Edit, xp+%LayoutWCtrlG% yp wp hp -VScroll +Center +ReadOnly, Fn
Gui Add, Edit, xp+%LayoutWCtrlG% yp wp hp -VScroll +Center +ReadOnly, Menu
Gui Add, Edit, xp+%LayoutWCtrlG% yp wp hp -VScroll +Center +ReadOnly, RCtrl

Gui Font
;======== Button Row
Gui Font, s10, Segoe UI
Temp := LayoutTotalW - LayoutWBSpc - LayoutG
Gui Add, Button, x%Temp% yp+%LayoutHG% w%LayoutWBSpc% hp -VScroll +Center gGuiPause, %MenuButtonPause%
Temp := Temp - LayoutWBSpc - LayoutG
Gui Add, Button, x%Temp% yp w%LayoutWBSpc% hp -VScroll +Center gGuiCancel, %MenuButtonCancel%
Temp := Temp - LayoutWBSpc - LayoutG
Gui Add, Button, x%Temp% yp w%LayoutWBSpc% hp -VScroll +Center gGuiSave, %MenuButtonSave%
Temp := Temp - LayoutWShift - LayoutG
Gui Add, Button, x%Temp% yp w%LayoutWShift% hp -VScroll +Center gGuiDefault, %MenuButtonDefaults%
Gui Font