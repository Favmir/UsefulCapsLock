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
Gui Add, Edit, x%Temp% yp w140 hp -VScroll +Center +ReadOnly, %MenuDescWin%
;======== Number Row
Gui Add, Edit, x%LayoutG% yp+%LayoutHG% w%LayoutW% h%LayoutH% -VScroll +Center vKeyGrave, %KeyGrave%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKey1, %Key1%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKey2, %Key2%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKey3, %Key3%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKey4, %Key4%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKey5, %Key5%
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescKey6 +ReadOnly, ^( )
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKey7, %Key7%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKey8, %Key8%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKey9, %Key9%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKey0, %Key0%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyHyphen, %KeyHyphen%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyEqual, %KeyEqual%
Gui Add, Edit, xp+%LayoutWG% yp w%LayoutWBSpc% hp -VScroll +Center +ReadOnly, BackSpc		;BackSpace
;======== QWERTY Row
Gui Add, Edit, x%LayoutG% yp+%LayoutHG% w%LayoutWTab% hp -VScroll +Center +ReadOnly, Tab ↹
Gui Add, Edit, xp+%LayoutWTabG% yp w%LayoutW% hp -VScroll +Center vKeyQ, %KeyQ%						;Q
Gui Add, Button, xp+%LayoutWG% yp w%LayoutW% hp -VScroll +Center gDescMLock +ReadOnly, Ms Lock		;W
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescPanUp +ReadOnly, Pan Up				;E
Gui, Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescScrollUp +ReadOnly, Scroll			;R
Gui, Add, UpDown, vUpScroll Range1-12, 6
Gui Add, Edit, xp+%LayoutWG% yp wp h%LayoutH% -VScroll +Center vKeyT, %KeyT%						;T
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyY, %KeyY%								;Y
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescPrev +ReadOnly, Prev					;U
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescUp +ReadOnly, ˄						;I
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescNext +ReadOnly, Next					;O
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyP, %KeyP%								;P
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyLBracket, %KeyLBracket%					;[
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyRBracket, %KeyRBracket%					;]
Gui Add, Edit, xp+%LayoutWG% yp w%LayoutWBSlsh% hp -VScroll +Center vKeyBSlash, %KeyBSlash%			;\
;======== Caps Lock Row
Gui Add, Button, x%LayoutG% yp+%LayoutHG% w%LayoutWCaps% hp -VScroll +Center gDescCaps +ReadOnly cRed, Special	;Caps Lock
Gui Add, Edit, xp+%LayoutWCapsG% yp w%LayoutW% hp -VScroll +Center vKeyA, %KeyA%					;A
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescSelect +ReadOnly, Sel ect				;S
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescPanDn +ReadOnly, Pan Dn				;D
Gui, Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescScrollDn +ReadOnly, Scroll			;F
Gui, Add, UpDown, vDownScroll Range1-12, 6															;F
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyG, %KeyG%								;G
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescHome +ReadOnly, Ho me					;H
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescLeft +ReadOnly, ˂						;J	
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescDown +ReadOnly, ˅						;K
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescRight +ReadOnly, ˃					;L
Gui Add, Button, xp+%LayoutWG% yp wp hp -VScroll +Center gDescEnd +ReadOnly, End					;Colon
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyQuote, %KeyQuote%						;Quotes
Gui Add, Edit, xp+%LayoutWG% yp w%LayoutWEnter% hp -VScroll +Center +ReadOnly, ↵ Enter				;Return key
;======== Shift Row
Gui Add, Button, x%LayoutG% yp+%LayoutHG% w%LayoutWShift% hp -VScroll +Center gDescShift +ReadOnly, LShift ⇧
Gui Add, Edit, xp+%LayoutWShiftG% yp w%LayoutW% hp -VScroll +Center vKeyZ, %KeyZ%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyX, %KeyX%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyC, %KeyC%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyV, %KeyV%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyB, %KeyB%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyN, %KeyN%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyM, %KeyM%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyComma, %KeyComma%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeyPeriod, %KeyPeriod%
Gui Add, Edit, xp+%LayoutWG% yp wp hp -VScroll +Center vKeySlash, %KeySlash%
Gui Add, Button, xp+%LayoutWG% yp w%LayoutWRShift% hp -VScroll +Center gDescShift +ReadOnly, ⇧ RShift
;======== Ctrl Row

Gui Font
;==
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