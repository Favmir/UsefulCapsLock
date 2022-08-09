
buildKeyboard(keyGap, keyWidth, keyHeight, backSpaceWidth, tabWidth, capsWidth, shiftWidth, ctrlWidth){
    lG := keyGap
    lW := keyWidth
    lH := keyHeight
    lWBSpc := backSpaceWidth
    lWTab := tabWidth
    lWCaps := capsWidth
    lWShift := shiftWidth
    lWCtrl := ctrlWidth

    lWBSlsh := lWBSpc + lW - lWTab
    lWEnter := lWBSpc + lW + lW - lWCaps + lG
    lWRShift := lWBSpc + lW + lW + lW - lWShift + lG + lG
    
    lWG := lW + lG
    lHG := lH + lG
    lWTabG := lWTab + lG
    lWCapsG :=  lWCaps + lG
    lWShiftG := lWShift + lG
    lWCtrlG := lWCtrl + lG

    lTotalW := lG + lWG * 13 + lWBSpc + lG
    lTotalH := lHG * 7 + lG

    lWSpace := lTotalW - lWCtrlG * 7 - lG * 2
    lWSpaceG := lWSpace + lG

    Gui, Color, %ColorBG%
    ;======== Esc Row
    Gui Font, s11 Bold, Segoe UI
    Gui Add, Button, x%lG% y%lG% w%lW% h%lH% -VScroll +Center +ReadOnly, Esc			;Esc
    Gui Add, Edit, xp+%lWG% yp w500 hp -VScroll +Center +ReadOnly, %MenuDescFront%
    Temp := lTotalW - lWTab - lG
    Gui Add, Button, x%Temp% yp w%lWTab% hp -VScroll +Center gGuiAbout, About
    Temp := Temp - lWTab - lG
    Gui Add, CheckBox, x%Temp% yp wp hp -VScroll +Center gGuiMLock, Mouse Lock
    Temp := Temp - 140 - lG
    Gui Add, Edit, x%Temp% yp w140 hp -VScroll +Center +ReadOnly, %MenuDescFront2%
    ;======== Number Row
    Gui Add, Edit, WantTab x%lG% yp+%lHG% w%lW% h%lH% -VScroll +Center vKeyGrave, %KeyGrave%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKey1, %Key1%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKey2, %Key2%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKey3, %Key3%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKey4, %Key4%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKey5, %Key5%
    Gui Add, Button, xp+%lWG% yp wp hp -VScroll +Center gDescKey6 +ReadOnly, ^( )
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKey7, %Key7%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKey8, %Key8%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKey9, %Key9%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKey0, %Key0%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyHyphen, %KeyHyphen%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyEqual, %KeyEqual%
    Gui Add, Edit, xp+%lWG% yp w%lWBSpc% hp -VScroll +Center +ReadOnly, BackSpc		;BackSpace
    ;======== QWERTY Row
    Gui Add, Edit, x%lG% yp+%lHG% w%lWTab% hp -VScroll +Center +ReadOnly, Tab ↹
    Gui Add, Edit, WantTab xp+%lWTabG% yp w%lW% hp -VScroll +Center vKeyQ, %KeyQ%						;Q
    Gui Add, Button, xp+%lWG% yp w%lW% hp -VScroll +Center gDescMLock +ReadOnly, Ms Lock		;W
    Gui Add, Button, xp+%lWG% yp wp hp -VScroll +Center gDescPanUp +ReadOnly, Pan Up				;E
    Gui, Add, Button, xp+%lWG% yp wp hp -VScroll +Center gDescScrollUp +ReadOnly, Scroll			;R
    Gui, Add, UpDown, vUpScroll Range1-12, 6
    Gui Add, Edit, WantTab xp+%lWG% yp wp h%lH% -VScroll +Center vKeyT, %KeyT%						;T
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyY, %KeyY%								;Y
    Gui Add, Button, xp+%lWG% yp wp hp -VScroll +Center gDescPrev +ReadOnly, Prev					;U
    Gui Add, Button, xp+%lWG% yp wp hp -VScroll +Center gDescUp +ReadOnly, ˄						;I
    Gui Add, Button, xp+%lWG% yp wp hp -VScroll +Center gDescNext +ReadOnly, Next					;O
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyP, %KeyP%								;P
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyLBracket, %KeyLBracket%					;[
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyRBracket, %KeyRBracket%					;]
    Gui Add, Edit, WantTab xp+%lWG% yp w%lWBSlsh% hp -VScroll +Center vKeyBSlash, %KeyBSlash%			;\
    ;======== Caps Lock Row
    Gui Add, Button, x%lG% yp+%lHG% w%lWCaps% hp -VScroll +Center gDescCaps +ReadOnly cRed, Special	;Caps Lock
    Gui Add, Edit, WantTab xp+%lWCapsG% yp w%lW% hp -VScroll +Center vKeyA, %KeyA%					;A
    Gui Add, Button, xp+%lWG% yp wp hp -VScroll +Center gDescSelect +ReadOnly, Sel ect				;S
    Gui Add, Button, xp+%lWG% yp wp hp -VScroll +Center gDescPanDn +ReadOnly, Pan Dn				;D
    Gui, Add, Button, xp+%lWG% yp wp hp -VScroll +Center gDescScrollDn +ReadOnly, Scroll			;F
    Gui, Add, UpDown, vDownScroll Range1-12, 6															;F
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyG, %KeyG%								;G
    Gui Add, Button, xp+%lWG% yp wp hp -VScroll +Center gDescHome +ReadOnly, Ho me					;H
    Gui Add, Button, xp+%lWG% yp wp hp -VScroll +Center gDescLeft +ReadOnly, ˂						;J	
    Gui Add, Button, xp+%lWG% yp wp hp -VScroll +Center gDescDown +ReadOnly, ˅						;K
    Gui Add, Button, xp+%lWG% yp wp hp -VScroll +Center gDescRight +ReadOnly, ˃					;L
    Gui Add, Button, xp+%lWG% yp wp hp -VScroll +Center gDescEnd +ReadOnly, End					;Colon
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyQuote, %KeyQuote%						;Quotes
    Gui Add, Edit, xp+%lWG% yp w%lWEnter% hp -VScroll +Center +ReadOnly, ↵ Enter				;Return key
    ;======== Shift Row
    Gui Add, Button, x%lG% yp+%lHG% w%lWShift% hp -VScroll +Center gDescShift +ReadOnly, LShift ⇧
    Gui Add, Edit, WantTab xp+%lWShiftG% yp w%lW% hp -VScroll +Center vKeyZ, %KeyZ%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyX, %KeyX%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyC, %KeyC%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyV, %KeyV%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyB, %KeyB%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyN, %KeyN%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyM, %KeyM%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyComma, %KeyComma%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeyPeriod, %KeyPeriod%
    Gui Add, Edit, WantTab xp+%lWG% yp wp hp -VScroll +Center vKeySlash, %KeySlash%
    Gui Add, Button, xp+%lWG% yp w%lWRShift% hp -VScroll +Center gDescShift +ReadOnly, ⇧ RShift
    ;======== Ctrl Row
    Gui Add, Edit, x%lG% yp+%lHG% w%lWCtrl% hp -VScroll +Center +ReadOnly, LCtrl
    Gui Add, Button, xp+%lWCtrlG% yp wp hp -VScroll +Center gDescWin +ReadOnly, Win
    Gui Add, Button, xp+%lWCtrlG% yp wp hp -VScroll +Center gDescLAlt +ReadOnly, LAlt
    Gui Add, Edit, xp+%lWCtrlG% yp w%lWSpace% hp -VScroll +Center +ReadOnly, Space
    Gui Add, Edit, xp+%lWSpaceG% yp w%lWCtrl% hp -VScroll +Center +ReadOnly, RAlt
    Gui Add, Edit, xp+%lWCtrlG% yp wp hp -VScroll +Center +ReadOnly, Fn
    Gui Add, Edit, xp+%lWCtrlG% yp wp hp -VScroll +Center +ReadOnly, Menu
    Gui Add, Edit, xp+%lWCtrlG% yp wp hp -VScroll +Center +ReadOnly, RCtrl

    Gui Font
    ;======== Button Row
    Gui Font, s10, Segoe UI
    Temp := lTotalW - lWBSpc - lG
    Gui Add, Button, x%Temp% yp+%lHG% w%lWBSpc% hp -VScroll +Center gGuiPause, %MenuButtonPause%
    Temp := Temp - lWBSpc - lG
    Gui Add, Button, x%Temp% yp w%lWBSpc% hp -VScroll +Center gGuiCancel, %MenuButtonCancel%
    Temp := Temp - lWBSpc - lG
    Gui Add, Button, x%Temp% yp w%lWBSpc% hp -VScroll +Center gGuiSave, %MenuButtonSave%
    Temp := Temp - lWShift - lG
    Gui Add, Button, x%Temp% yp w%lWShift% hp -VScroll +Center gGuiDefault, %MenuButtonDefaults%
    Gui Font
}