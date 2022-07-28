class KeyboardGui{
    layoutG := ""
	layoutW := ""
	layoutH := ""
	layoutWBSpc := ""
	layoutWTab := ""
	layoutWCaps := ""
	layoutWShift := ""
	layoutWCtrl := ""

    layoutWBSlsh := ""
    layoutWEnter := ""
    layoutWRShift := ""
    layoutWG := ""
    layoutHG := ""
    layoutWTabG := ""
    layoutWCapsG := ""
    layoutWShiftG := ""
    layoutWCtrlayoutG := ""
    layoutTotalW := ""
    layoutTotalH := ""
    layoutWSpace := ""
    layoutWSpaceG := ""

    keyboardWindow := ""

    __New(options, title, eventObj){
        keyboardWindow := Gui(options, title, eventObj)
    }

    buildKeyboard(keyGap, keyWidth, keyHeight, backSpaceWidth, tabWidth, capsWidth, shiftWidth, ctrlWidth){
        this.layoutG := keyGap
        this.layoutW := keyWidth
        this.layoutH := keyHeight
        this.layoutWBSpc := backSpaceWidth
        this.layoutWTab := tabWidth
        this.layoutWCaps := capsWidth
        this.layoutWShift := shiftWidth
        this.layoutWCtrl := ctrlWidth

        this.layoutWBSlsh := this.layoutWBSpc + this.layoutW - this.layoutWTab
        this.layoutWEnter := this.layoutWBSpc + this.layoutW + this.layoutW - this.layoutWCaps + this.layoutG
        this.layoutWRShift := this.layoutWBSpc + this.layoutW + this.layoutW + this.layoutW - this.layoutWShift + this.layoutG + this.layoutG
        
        this.layoutWG := this.layoutW + this.layoutG
        this.layoutHG := this.layoutH + this.layoutG
        this.layoutWTabG := this.layoutWTab + this.layoutG
        this.layoutWCapsG :=  this.layoutWCaps + this.layoutG
        this.layoutWShiftG := this.layoutWShift + this.layoutG
        this.layoutWCtrlayoutG := this.layoutWCtrl + this.layoutG

        this.layoutTotalW := this.layoutG + this.layoutWG * 13 + this.layoutWBSpc + this.layoutG
        this.layoutTotalH := this.layoutHG * 7 + this.layoutG

        this.layoutWSpace := this.layoutTotalW - this.layoutWCtrlayoutG * 7 - this.layoutG * 2
        this.layoutWSpaceG := this.layoutWSpace + this.layoutG

        myGui := Gui()
        ;======== Esc Row
        myGui.SetFont("s11 Bold", "Segoe UI")
        ogcButtonEsc := myGui.Add("Button", "x" . this.layoutG . " y" . this.layoutG . " w" . this.layoutW . " h" . this.layoutH . " -VScroll +Center +ReadOnly", "Esc")
        ogcButtonEsc.OnEvent("Click", ButtonEsc.Bind("Normal"))			;Esc
        myGui.Add("Edit", "xp+" . this.layoutWG . " yp w500 hp -VScroll +Center +ReadOnly", MenuDescFront)
        Temp := this.layoutTotalW - this.layoutWTab - this.layoutG
        ogcButtonAbout := myGui.Add("Button", "x" . Temp . " yp w" . this.layoutWTab . " hp -VScroll +Center", "About")
        ogcButtonAbout.OnEvent("Click", GuiAbout.Bind("Normal"))
        Temp := Temp - this.layoutWTab - this.layoutG
        ogcCheckBoxMouseLock := myGui.Add("CheckBox", "x" . Temp . " yp wp hp -VScroll +Center", "Mouse Lock")
        ogcCheckBoxMouseLock.OnEvent("Click", GuiMLock.Bind("Normal"))
        Temp := Temp - 140 - this.layoutG
        myGui.Add("Edit", "x" . Temp . " yp w140 hp -VScroll +Center +ReadOnly", MenuDescFront2)
        ;======== Number Row
        ogcEditKeyGrave := myGui.Add("Edit", "WantTab x" . this.layoutG . " yp+" . this.layoutHG . " w" . this.layoutW . " h" . this.layoutH . " -VScroll +Center vKeyGrave", KeyGrave)
        ogcEditKey1 := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey1", Key1)
        ogcEditKey2 := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey2", Key2)
        ogcEditKey3 := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey3", Key3)
        ogcEditKey4 := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey4", Key4)
        ogcEditKey5 := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey5", Key5)
        ogcButton := myGui.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "^( )")
        ogcButton.OnEvent("Click", DescKey6.Bind("Normal"))
        ogcEditKey7 := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey7", Key7)
        ogcEditKey8 := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey8", Key8)
        ogcEditKey9 := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey9", Key9)
        ogcEditKey0 := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey0", Key0)
        ogcEditKeyHyphen := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyHyphen", KeyHyphen)
        ogcEditKeyEqual := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyEqual", KeyEqual)
        myGui.Add("Edit", "xp+" . this.layoutWG . " yp w" . this.layoutWBSpc . " hp -VScroll +Center +ReadOnly", "BackSpc")		;BackSpace
        ;======== QWERTY Row
        myGui.Add("Edit", "x" . this.layoutG . " yp+" . this.layoutHG . " w" . this.layoutWTab . " hp -VScroll +Center +ReadOnly", "Tab ??")
        ogcEditKeyQ := myGui.Add("Edit", "WantTab xp+" . this.layoutWTabG . " yp w" . this.layoutW . " hp -VScroll +Center vKeyQ", KeyQ)						;Q
        ogcButtonMsLock := myGui.Add("Button", "xp+" . this.layoutWG . " yp w" . this.layoutW . " hp -VScroll +Center  +ReadOnly", "Ms Lock")
        ogcButtonMsLock.OnEvent("Click", DescMLock.Bind("Normal"))		;W
        ogcButtonPanUp := myGui.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Pan Up")
        ogcButtonPanUp.OnEvent("Click", DescPanUp.Bind("Normal"))				;E
        ogcButtonScroll := myGui.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Scroll")
        ogcButtonScroll.OnEvent("Click", DescScrollUp.Bind("Normal"))			;R
        ogcUpDownUpScroll := myGui.Add("UpDown", "vUpScroll Range1-12", "6")
        ogcEditKeyT := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp h" . this.layoutH . " -VScroll +Center vKeyT", KeyT)						;T
        ogcEditKeyY := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyY", KeyY)								;Y
        ogcButtonPrev := myGui.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Prev")
        ogcButtonPrev.OnEvent("Click", DescPrev.Bind("Normal"))					;U
        ogcButton := myGui.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "?")
        ogcButton.OnEvent("Click", DescUp.Bind("Normal"))						;I
        ogcButtonNext := myGui.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Next")
        ogcButtonNext.OnEvent("Click", DescNext.Bind("Normal"))					;O
        ogcEditKeyP := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyP", KeyP)								;P
        ogcEditKeyLBracket := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyLBracket", KeyLBracket)					;[
        ogcEditKeyRBracket := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyRBracket", KeyRBracket)					;]
        ogcEditKeyBSlash := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp w" . this.layoutWBSlsh . " hp -VScroll +Center vKeyBSlash", KeyBSlash)			;\
        ;======== Caps Lock Row
        ogcButtonSpecial := myGui.Add("Button", "x" . this.layoutG . " yp+" . this.layoutHG . " w" . this.layoutWCaps . " hp -VScroll +Center  +ReadOnly cRed", "Special")
        ogcButtonSpecial.OnEvent("Click", DescCaps.Bind("Normal"))	;Caps Lock
        ogcEditKeyA := myGui.Add("Edit", "WantTab xp+" . this.layoutWCapsG . " yp w" . this.layoutW . " hp -VScroll +Center vKeyA", KeyA)					;A
        ogcButtonSelect := myGui.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Sel ect")
        ogcButtonSelect.OnEvent("Click", DescSelect.Bind("Normal"))				;S
        ogcButtonPanDn := myGui.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Pan Dn")
        ogcButtonPanDn.OnEvent("Click", DescPanDn.Bind("Normal"))				;D
        ogcButtonScroll := myGui.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Scroll")
        ogcButtonScroll.OnEvent("Click", DescScrollDn.Bind("Normal"))			;F
        ogcUpDownDownScroll := myGui.Add("UpDown", "vDownScroll Range1-12", "6")															;F
        ogcEditKeyG := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyG", KeyG)								;G
        ogcButtonHome := myGui.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Ho me")
        ogcButtonHome.OnEvent("Click", DescHome.Bind("Normal"))					;H
        ogcButton := myGui.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "?")
        ogcButton.OnEvent("Click", DescLeft.Bind("Normal"))						;J	
        ogcButton := myGui.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "?")
        ogcButton.OnEvent("Click", DescDown.Bind("Normal"))						;K
        ogcButton := myGui.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "?")
        ogcButton.OnEvent("Click", DescRight.Bind("Normal"))					;L
        ogcButtonEnd := myGui.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "End")
        ogcButtonEnd.OnEvent("Click", DescEnd.Bind("Normal"))					;Colon
        ogcEditKeyQuote := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyQuote", KeyQuote)						;Quotes
        myGui.Add("Edit", "xp+" . this.layoutWG . " yp w" . this.layoutWEnter . " hp -VScroll +Center +ReadOnly", "??Enter")				;Return key
        ;======== Shift Row
        ogcButtonLShift := myGui.Add("Button", "x" . this.layoutG . " yp+" . this.layoutHG . " w" . this.layoutWShift . " hp -VScroll +Center  +ReadOnly", "LShift ??")
        ogcButtonLShift.OnEvent("Click", DescShift.Bind("Normal"))
        ogcEditKeyZ := myGui.Add("Edit", "WantTab xp+" . this.layoutWShiftG . " yp w" . this.layoutW . " hp -VScroll +Center vKeyZ", KeyZ)
        ogcEditKeyX := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyX", KeyX)
        ogcEditKeyC := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyC", KeyC)
        ogcEditKeyV := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyV", KeyV)
        ogcEditKeyB := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyB", KeyB)
        ogcEditKeyN := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyN", KeyN)
        ogcEditKeyM := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyM", KeyM)
        ogcEditKeyComma := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyComma", KeyComma)
        ogcEditKeyPeriod := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyPeriod", KeyPeriod)
        ogcEditKeySlash := myGui.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeySlash", KeySlash)
        ogcButtonRShift := myGui.Add("Button", "xp+" . this.layoutWG . " yp w" . this.layoutWRShift . " hp -VScroll +Center  +ReadOnly", "??RShift")
        ogcButtonRShift.OnEvent("Click", DescShift.Bind("Normal"))
        ;======== Ctrl Row
        myGui.Add("Edit", "x" . this.layoutG . " yp+" . this.layoutHG . " w" . this.layoutWCtrl . " hp -VScroll +Center +ReadOnly", "LCtrl")
        ogcButtonWin := myGui.Add("Button", "xp+" . this.layoutWCtrlayoutG . " yp wp hp -VScroll +Center  +ReadOnly", "Win")
        ogcButtonWin.OnEvent("Click", DescWin.Bind("Normal"))
        ogcButtonLAlt := myGui.Add("Button", "xp+" . this.layoutWCtrlayoutG . " yp wp hp -VScroll +Center  +ReadOnly", "LAlt")
        ogcButtonLAlt.OnEvent("Click", DescLAlt.Bind("Normal"))
        myGui.Add("Edit", "xp+" . this.layoutWCtrlayoutG . " yp w" . this.layoutWSpace . " hp -VScroll +Center +ReadOnly", "Space")
        myGui.Add("Edit", "xp+" . this.layoutWSpaceG . " yp w" . this.layoutWCtrl . " hp -VScroll +Center +ReadOnly", "RAlt")
        myGui.Add("Edit", "xp+" . this.layoutWCtrlayoutG . " yp wp hp -VScroll +Center +ReadOnly", "Fn")
        myGui.Add("Edit", "xp+" . this.layoutWCtrlayoutG . " yp wp hp -VScroll +Center +ReadOnly", "Menu")
        myGui.Add("Edit", "xp+" . this.layoutWCtrlayoutG . " yp wp hp -VScroll +Center +ReadOnly", "RCtrl")

        myGui.SetFont()
        ;======== Button Row
        myGui.SetFont("s10", "Segoe UI")
        Temp := this.layoutTotalW - this.layoutWBSpc - this.layoutG
        ogcButtonMenuButtonPause := myGui.Add("Button", "x" . Temp . " yp+" . this.layoutHG . " w" . this.layoutWBSpc . " hp -VScroll +Center", MenuButtonPause)
        ogcButtonMenuButtonPause.OnEvent("Click", GuiPause.Bind("Normal"))
        Temp := Temp - this.layoutWBSpc - this.layoutG
        ogcButtonMenuButtonCancel := myGui.Add("Button", "x" . Temp . " yp w" . this.layoutWBSpc . " hp -VScroll +Center", MenuButtonCancel)
        ogcButtonMenuButtonCancel.OnEvent("Click", GuiCancel.Bind("Normal"))
        Temp := Temp - this.layoutWBSpc - this.layoutG
        ogcButtonMenuButtonSave := myGui.Add("Button", "x" . Temp . " yp w" . this.layoutWBSpc . " hp -VScroll +Center", MenuButtonSave)
        ogcButtonMenuButtonSave.OnEvent("Click", GuiSave.Bind("Normal"))
        Temp := Temp - this.layoutWShift - this.layoutG
        ogcButtonMenuButtonDefaults := myGui.Add("Button", "x" . Temp . " yp w" . this.layoutWShift . " hp -VScroll +Center", MenuButtonDefaults)
        ogcButtonMenuButtonDefaults.OnEvent("Click", GuiDefault.Bind("Normal"))
        myGui.SetFont()


    }

    update(){

    }
}