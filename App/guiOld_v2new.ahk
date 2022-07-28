
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

    myGui := Gui()
    myGui.BackColor := ColorBG
    ;======== Esc Row
    myGui.SetFont("s11 Bold", "Segoe UI")
    ogcButtonEsc := myGui.Add("Button", "x" . lG . " y" . lG . " w" . lW . " h" . lH . " -VScroll +Center +ReadOnly", "Esc")
    ogcButtonEsc.OnEvent("Click", ButtonEsc.Bind("Normal"))			;Esc
    myGui.Add("Edit", "xp+" . lWG . " yp w500 hp -VScroll +Center +ReadOnly", MenuDescFront)
    Temp := lTotalW - lWTab - lG
    ogcButtonAbout := myGui.Add("Button", "x" . Temp . " yp w" . lWTab . " hp -VScroll +Center", "About")
    ogcButtonAbout.OnEvent("Click", GuiAbout.Bind("Normal"))
    Temp := Temp - lWTab - lG
    ogcCheckBoxMouseLock := myGui.Add("CheckBox", "x" . Temp . " yp wp hp -VScroll +Center", "Mouse Lock")
    ogcCheckBoxMouseLock.OnEvent("Click", GuiMLock.Bind("Normal"))
    Temp := Temp - 140 - lG
    myGui.Add("Edit", "x" . Temp . " yp w140 hp -VScroll +Center +ReadOnly", MenuDescFront2)
    ;======== Number Row
    ogcEditKeyGrave := myGui.Add("Edit", "WantTab x" . lG . " yp+" . lHG . " w" . lW . " h" . lH . " -VScroll +Center vKeyGrave", KeyGrave)
    ogcEditKey1 := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKey1", Key1)
    ogcEditKey2 := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKey2", Key2)
    ogcEditKey3 := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKey3", Key3)
    ogcEditKey4 := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKey4", Key4)
    ogcEditKey5 := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKey5", Key5)
    ogcButton := myGui.Add("Button", "xp+" . lWG . " yp wp hp -VScroll +Center  +ReadOnly", "^( )")
    ogcButton.OnEvent("Click", DescKey6.Bind("Normal"))
    ogcEditKey7 := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKey7", Key7)
    ogcEditKey8 := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKey8", Key8)
    ogcEditKey9 := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKey9", Key9)
    ogcEditKey0 := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKey0", Key0)
    ogcEditKeyHyphen := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyHyphen", KeyHyphen)
    ogcEditKeyEqual := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyEqual", KeyEqual)
    myGui.Add("Edit", "xp+" . lWG . " yp w" . lWBSpc . " hp -VScroll +Center +ReadOnly", "BackSpc")		;BackSpace
    ;======== QWERTY Row
    myGui.Add("Edit", "x" . lG . " yp+" . lHG . " w" . lWTab . " hp -VScroll +Center +ReadOnly", "Tab ??")
    ogcEditKeyQ := myGui.Add("Edit", "WantTab xp+" . lWTabG . " yp w" . lW . " hp -VScroll +Center vKeyQ", KeyQ)						;Q
    ogcButtonMsLock := myGui.Add("Button", "xp+" . lWG . " yp w" . lW . " hp -VScroll +Center  +ReadOnly", "Ms Lock")
    ogcButtonMsLock.OnEvent("Click", DescMLock.Bind("Normal"))		;W
    ogcButtonPanUp := myGui.Add("Button", "xp+" . lWG . " yp wp hp -VScroll +Center  +ReadOnly", "Pan Up")
    ogcButtonPanUp.OnEvent("Click", DescPanUp.Bind("Normal"))				;E
    ogcButtonScroll := myGui.Add("Button", "xp+" . lWG . " yp wp hp -VScroll +Center  +ReadOnly", "Scroll")
    ogcButtonScroll.OnEvent("Click", DescScrollUp.Bind("Normal"))			;R
    ogcUpDownUpScroll := myGui.Add("UpDown", "vUpScroll Range1-12", "6")
    ogcEditKeyT := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp h" . lH . " -VScroll +Center vKeyT", KeyT)						;T
    ogcEditKeyY := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyY", KeyY)								;Y
    ogcButtonPrev := myGui.Add("Button", "xp+" . lWG . " yp wp hp -VScroll +Center  +ReadOnly", "Prev")
    ogcButtonPrev.OnEvent("Click", DescPrev.Bind("Normal"))					;U
    ogcButton := myGui.Add("Button", "xp+" . lWG . " yp wp hp -VScroll +Center  +ReadOnly", "?")
    ogcButton.OnEvent("Click", DescUp.Bind("Normal"))						;I
    ogcButtonNext := myGui.Add("Button", "xp+" . lWG . " yp wp hp -VScroll +Center  +ReadOnly", "Next")
    ogcButtonNext.OnEvent("Click", DescNext.Bind("Normal"))					;O
    ogcEditKeyP := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyP", KeyP)								;P
    ogcEditKeyLBracket := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyLBracket", KeyLBracket)					;[
    ogcEditKeyRBracket := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyRBracket", KeyRBracket)					;]
    ogcEditKeyBSlash := myGui.Add("Edit", "WantTab xp+" . lWG . " yp w" . lWBSlsh . " hp -VScroll +Center vKeyBSlash", KeyBSlash)			;\
    ;======== Caps Lock Row
    ogcButtonSpecial := myGui.Add("Button", "x" . lG . " yp+" . lHG . " w" . lWCaps . " hp -VScroll +Center  +ReadOnly cRed", "Special")
    ogcButtonSpecial.OnEvent("Click", DescCaps.Bind("Normal"))	;Caps Lock
    ogcEditKeyA := myGui.Add("Edit", "WantTab xp+" . lWCapsG . " yp w" . lW . " hp -VScroll +Center vKeyA", KeyA)					;A
    ogcButtonSelect := myGui.Add("Button", "xp+" . lWG . " yp wp hp -VScroll +Center  +ReadOnly", "Sel ect")
    ogcButtonSelect.OnEvent("Click", DescSelect.Bind("Normal"))				;S
    ogcButtonPanDn := myGui.Add("Button", "xp+" . lWG . " yp wp hp -VScroll +Center  +ReadOnly", "Pan Dn")
    ogcButtonPanDn.OnEvent("Click", DescPanDn.Bind("Normal"))				;D
    ogcButtonScroll := myGui.Add("Button", "xp+" . lWG . " yp wp hp -VScroll +Center  +ReadOnly", "Scroll")
    ogcButtonScroll.OnEvent("Click", DescScrollDn.Bind("Normal"))			;F
    ogcUpDownDownScroll := myGui.Add("UpDown", "vDownScroll Range1-12", "6")															;F
    ogcEditKeyG := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyG", KeyG)								;G
    ogcButtonHome := myGui.Add("Button", "xp+" . lWG . " yp wp hp -VScroll +Center  +ReadOnly", "Ho me")
    ogcButtonHome.OnEvent("Click", DescHome.Bind("Normal"))					;H
    ogcButton := myGui.Add("Button", "xp+" . lWG . " yp wp hp -VScroll +Center  +ReadOnly", "?")
    ogcButton.OnEvent("Click", DescLeft.Bind("Normal"))						;J	
    ogcButton := myGui.Add("Button", "xp+" . lWG . " yp wp hp -VScroll +Center  +ReadOnly", "?")
    ogcButton.OnEvent("Click", DescDown.Bind("Normal"))						;K
    ogcButton := myGui.Add("Button", "xp+" . lWG . " yp wp hp -VScroll +Center  +ReadOnly", "?")
    ogcButton.OnEvent("Click", DescRight.Bind("Normal"))					;L
    ogcButtonEnd := myGui.Add("Button", "xp+" . lWG . " yp wp hp -VScroll +Center  +ReadOnly", "End")
    ogcButtonEnd.OnEvent("Click", DescEnd.Bind("Normal"))					;Colon
    ogcEditKeyQuote := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyQuote", KeyQuote)						;Quotes
    myGui.Add("Edit", "xp+" . lWG . " yp w" . lWEnter . " hp -VScroll +Center +ReadOnly", "??Enter")				;Return key
    ;======== Shift Row
    ogcButtonLShift := myGui.Add("Button", "x" . lG . " yp+" . lHG . " w" . lWShift . " hp -VScroll +Center  +ReadOnly", "LShift ??")
    ogcButtonLShift.OnEvent("Click", DescShift.Bind("Normal"))
    ogcEditKeyZ := myGui.Add("Edit", "WantTab xp+" . lWShiftG . " yp w" . lW . " hp -VScroll +Center vKeyZ", KeyZ)
    ogcEditKeyX := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyX", KeyX)
    ogcEditKeyC := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyC", KeyC)
    ogcEditKeyV := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyV", KeyV)
    ogcEditKeyB := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyB", KeyB)
    ogcEditKeyN := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyN", KeyN)
    ogcEditKeyM := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyM", KeyM)
    ogcEditKeyComma := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyComma", KeyComma)
    ogcEditKeyPeriod := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeyPeriod", KeyPeriod)
    ogcEditKeySlash := myGui.Add("Edit", "WantTab xp+" . lWG . " yp wp hp -VScroll +Center vKeySlash", KeySlash)
    ogcButtonRShift := myGui.Add("Button", "xp+" . lWG . " yp w" . lWRShift . " hp -VScroll +Center  +ReadOnly", "??RShift")
    ogcButtonRShift.OnEvent("Click", DescShift.Bind("Normal"))
    ;======== Ctrl Row
    myGui.Add("Edit", "x" . lG . " yp+" . lHG . " w" . lWCtrl . " hp -VScroll +Center +ReadOnly", "LCtrl")
    ogcButtonWin := myGui.Add("Button", "xp+" . lWCtrlG . " yp wp hp -VScroll +Center  +ReadOnly", "Win")
    ogcButtonWin.OnEvent("Click", DescWin.Bind("Normal"))
    ogcButtonLAlt := myGui.Add("Button", "xp+" . lWCtrlG . " yp wp hp -VScroll +Center  +ReadOnly", "LAlt")
    ogcButtonLAlt.OnEvent("Click", DescLAlt.Bind("Normal"))
    myGui.Add("Edit", "xp+" . lWCtrlG . " yp w" . lWSpace . " hp -VScroll +Center +ReadOnly", "Space")
    myGui.Add("Edit", "xp+" . lWSpaceG . " yp w" . lWCtrl . " hp -VScroll +Center +ReadOnly", "RAlt")
    myGui.Add("Edit", "xp+" . lWCtrlG . " yp wp hp -VScroll +Center +ReadOnly", "Fn")
    myGui.Add("Edit", "xp+" . lWCtrlG . " yp wp hp -VScroll +Center +ReadOnly", "Menu")
    myGui.Add("Edit", "xp+" . lWCtrlG . " yp wp hp -VScroll +Center +ReadOnly", "RCtrl")

    myGui.SetFont()
    ;======== Button Row
    myGui.SetFont("s10", "Segoe UI")
    Temp := lTotalW - lWBSpc - lG
    ogcButtonMenuButtonPause := myGui.Add("Button", "x" . Temp . " yp+" . lHG . " w" . lWBSpc . " hp -VScroll +Center", MenuButtonPause)
    ogcButtonMenuButtonPause.OnEvent("Click", GuiPause.Bind("Normal"))
    Temp := Temp - lWBSpc - lG
    ogcButtonMenuButtonCancel := myGui.Add("Button", "x" . Temp . " yp w" . lWBSpc . " hp -VScroll +Center", MenuButtonCancel)
    ogcButtonMenuButtonCancel.OnEvent("Click", GuiCancel.Bind("Normal"))
    Temp := Temp - lWBSpc - lG
    ogcButtonMenuButtonSave := myGui.Add("Button", "x" . Temp . " yp w" . lWBSpc . " hp -VScroll +Center", MenuButtonSave)
    ogcButtonMenuButtonSave.OnEvent("Click", GuiSave.Bind("Normal"))
    Temp := Temp - lWShift - lG
    ogcButtonMenuButtonDefaults := myGui.Add("Button", "x" . Temp . " yp w" . lWShift . " hp -VScroll +Center", MenuButtonDefaults)
    ogcButtonMenuButtonDefaults.OnEvent("Click", GuiDefault.Bind("Normal"))
    myGui.SetFont()
}


























