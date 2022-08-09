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
    layoutWCtrlG := ""
    layoutTotalW := ""
    layoutTotalH := ""
    layoutWSpace := ""
    layoutWSpaceG := ""

    keyboardWindow := ""

    __New(options, title, eventObj){
        keyboardWindow := Gui(options, title, eventObj)
    }

    btnMsg(msg){
        MsgBox(msg,,)
    }

    buildKeyboard(keyGap, keyWidth, keyHeight, backSpaceWidth, tabWidth, capsWidth, shiftWidth, ctrlWidth){
        #include %A_WorkingDir%\Settings\Localization.ahk
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
        this.layoutWCtrlG := this.layoutWCtrl + this.layoutG

        this.layoutTotalW := this.layoutG + this.layoutWG * 13 + this.layoutWBSpc + this.layoutG
        this.layoutTotalH := this.layoutHG * 7 + this.layoutG

        this.layoutWSpace := this.layoutTotalW - this.layoutWCtrlG * 7 - this.layoutG * 2
        this.layoutWSpaceG := this.layoutWSpace + this.layoutG

        this.keyboardWindow.SetFont("s11 Bold", "Segoe UI")
        ;======== Esc Row
        bEsc := this.keyboardWindow.Add("Button", "x" . this.layoutG . " y" . this.layoutG . " w" . this.layoutW . " h" . this.layoutH . " -VScroll +Center +ReadOnly", "Esc")
        ogcButtonEsc.OnEvent("Click", this.btnMsg(mDescEsc))			;Esc
        this.keyboardWindow.Add("Edit", "xp+" . this.layoutWG . " yp w500 hp -VScroll +Center +ReadOnly", MenuDescFront)
        Temp := this.layoutTotalW - this.layoutWTab - this.layoutG
        ogcButtonAbout := this.keyboardWindow.Add("Button", "x" . Temp . " yp w" . this.layoutWTab . " hp -VScroll +Center", "About")
        ogcButtonAbout.OnEvent("Click", this.btnMsg(mTitleAbout,mDescAbout))
        Temp := Temp - this.layoutWTab - this.layoutG
        ogcCheckBoxMouseLock := this.keyboardWindow.Add("CheckBox", "x" . Temp . " yp wp hp -VScroll +Center", "Mouse Lock")
        ogcCheckBoxMouseLock.OnEvent("Click", this.btnMsg(pTitleMouseLock,mDescMouseLock))
        Temp := Temp - 140 - this.layoutG
        this.keyboardWindow.Add("Edit", "x" . Temp . " yp w140 hp -VScroll +Center +ReadOnly", MenuDescFront2)
        ;======== Number Row
        ogcEditKeyGrave := this.keyboardWindow.Add("Edit", "WantTab x" . this.layoutG . " yp+" . this.layoutHG . " w" . this.layoutW . " h" . this.layoutH . " -VScroll +Center vKeyGrave", KeyGrave)
        ogcEditKey1 := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey1", Key1)
        ogcEditKey2 := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey2", Key2)
        ogcEditKey3 := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey3", Key3)
        ogcEditKey4 := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey4", Key4)
        ogcEditKey5 := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey5", Key5)
        ogcButton := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "^( )")
        ogcButton.OnEvent("Click", this.btnMsg(mDescKey6))
        ogcEditKey7 := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey7", Key7)
        ogcEditKey8 := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey8", Key8)
        ogcEditKey9 := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey9", Key9)
        ogcEditKey0 := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKey0", Key0)
        ogcEditKeyHyphen := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyHyphen", KeyHyphen)
        ogcEditKeyEqual := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyEqual", KeyEqual)
        this.keyboardWindow.Add("Edit", "xp+" . this.layoutWG . " yp w" . this.layoutWBSpc . " hp -VScroll +Center +ReadOnly", "BackSpc")		;BackSpace
        ;======== QWERTY Row
        this.keyboardWindow.Add("Edit", "x" . this.layoutG . " yp+" . this.layoutHG . " w" . this.layoutWTab . " hp -VScroll +Center +ReadOnly", "Tab ??")
        ogcEditKeyQ := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWTabG . " yp w" . this.layoutW . " hp -VScroll +Center vKeyQ", KeyQ)						;Q
        ogcButtonMsLock := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp w" . this.layoutW . " hp -VScroll +Center  +ReadOnly", "Ms Lock")
        ogcButtonMsLock.OnEvent("Click", this.btnMsg(mDescMLock))		;W
        ogcButtonPanUp := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Pan Up")
        ogcButtonPanUp.OnEvent("Click", this.btnMsg(mDescPanUp))				;E
        ogcButtonScroll := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Scroll")
        ogcButtonScroll.OnEvent("Click", this.btnMsg(mDescScrollUp))			;R
        ogcUpDownUpScroll := this.keyboardWindow.Add("UpDown", "vUpScroll Range1-12", "6")
        ogcEditKeyT := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp h" . this.layoutH . " -VScroll +Center vKeyT", KeyT)						;T
        ogcEditKeyY := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyY", KeyY)								;Y
        ogcButtonPrev := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Prev")
        ogcButtonPrev.OnEvent("Click", this.btnMsg(mDescPrev))					;U
        ogcButton := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "?")
        ogcButton.OnEvent("Click", this.btnMsg(mDescUp))						;I
        ogcButtonNext := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Next")
        ogcButtonNext.OnEvent("Click", this.btnMsg(mDescNext))					;O
        ogcEditKeyP := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyP", KeyP)								;P
        ogcEditKeyLBracket := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyLBracket", KeyLBracket)					;[
        ogcEditKeyRBracket := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyRBracket", KeyRBracket)					;]
        ogcEditKeyBSlash := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp w" . this.layoutWBSlsh . " hp -VScroll +Center vKeyBSlash", KeyBSlash)			;\
        ;======== Caps Lock Row
        ogcButtonSpecial := this.keyboardWindow.Add("Button", "x" . this.layoutG . " yp+" . this.layoutHG . " w" . this.layoutWCaps . " hp -VScroll +Center  +ReadOnly cRed", "Special")
        ogcButtonSpecial.OnEvent("Click", this.btnMsg(mDescCaps))	;Caps Lock
        ogcEditKeyA := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWCapsG . " yp w" . this.layoutW . " hp -VScroll +Center vKeyA", KeyA)					;A
        ogcButtonSelect := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Sel ect")
        ogcButtonSelect.OnEvent("Click", this.btnMsg(mDescSelect))				;S
        ogcButtonPanDn := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Pan Dn")
        ogcButtonPanDn.OnEvent("Click", this.btnMsg(mDescPanDn))				;D
        ogcButtonScroll := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Scroll")
        ogcButtonScroll.OnEvent("Click", this.btnMsg(mDescScrollDn))			;F
        ogcUpDownDownScroll := this.keyboardWindow.Add("UpDown", "vDownScroll Range1-12", "6")															;F
        ogcEditKeyG := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyG", KeyG)								;G
        ogcButtonHome := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "Ho me")
        ogcButtonHome.OnEvent("Click", this.btnMsg(mDescHome))					;H
        ogcButton := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "?")
        ogcButton.OnEvent("Click", this.btnMsg(mDescLeft))						;J	
        ogcButton := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "?")
        ogcButton.OnEvent("Click", this.btnMsg(mDescDown))						;K
        ogcButton := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "?")
        ogcButton.OnEvent("Click", this.btnMsg(mDescRight))					;L
        ogcButtonEnd := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp wp hp -VScroll +Center  +ReadOnly", "End")
        ogcButtonEnd.OnEvent("Click", this.btnMsg(mDescEnd))					;Colon
        ogcEditKeyQuote := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyQuote", KeyQuote)						;Quotes
        this.keyboardWindow.Add("Edit", "xp+" . this.layoutWG . " yp w" . this.layoutWEnter . " hp -VScroll +Center +ReadOnly", "??Enter")				;Return key
        ;======== Shift Row
        ogcButtonLShift := this.keyboardWindow.Add("Button", "x" . this.layoutG . " yp+" . this.layoutHG . " w" . this.layoutWShift . " hp -VScroll +Center  +ReadOnly", "LShift ??")
        ogcButtonLShift.OnEvent("Click", this.btnMsg(mDescShift))
        ogcEditKeyZ := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWShiftG . " yp w" . this.layoutW . " hp -VScroll +Center vKeyZ", KeyZ)
        ogcEditKeyX := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyX", KeyX)
        ogcEditKeyC := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyC", KeyC)
        ogcEditKeyV := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyV", KeyV)
        ogcEditKeyB := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyB", KeyB)
        ogcEditKeyN := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyN", KeyN)
        ogcEditKeyM := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyM", KeyM)
        ogcEditKeyComma := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyComma", KeyComma)
        ogcEditKeyPeriod := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeyPeriod", KeyPeriod)
        ogcEditKeySlash := this.keyboardWindow.Add("Edit", "WantTab xp+" . this.layoutWG . " yp wp hp -VScroll +Center vKeySlash", KeySlash)
        ogcButtonRShift := this.keyboardWindow.Add("Button", "xp+" . this.layoutWG . " yp w" . this.layoutWRShift . " hp -VScroll +Center  +ReadOnly", "??RShift")
        ogcButtonRShift.OnEvent("Click", this.btnMsg(mDescShift))
        ;======== Ctrl Row
        this.keyboardWindow.Add("Edit", "x" . this.layoutG . " yp+" . this.layoutHG . " w" . this.layoutWCtrl . " hp -VScroll +Center +ReadOnly", "LCtrl")
        ogcButtonWin := this.keyboardWindow.Add("Button", "xp+" . this.layoutWCtrlG . " yp wp hp -VScroll +Center  +ReadOnly", "Win")
        ogcButtonWin.OnEvent("Click", this.btnMsg(mDescWin))
        ogcButtonLAlt := this.keyboardWindow.Add("Button", "xp+" . this.layoutWCtrlG . " yp wp hp -VScroll +Center  +ReadOnly", "LAlt")
        ogcButtonLAlt.OnEvent("Click", this.btnMsg(mDescLAlt))
        this.keyboardWindow.Add("Edit", "xp+" . this.layoutWCtrlG . " yp w" . this.layoutWSpace . " hp -VScroll +Center +ReadOnly", "Space")
        this.keyboardWindow.Add("Edit", "xp+" . this.layoutWSpaceG . " yp w" . this.layoutWCtrl . " hp -VScroll +Center +ReadOnly", "RAlt")
        this.keyboardWindow.Add("Edit", "xp+" . this.layoutWCtrlG . " yp wp hp -VScroll +Center +ReadOnly", "Fn")
        this.keyboardWindow.Add("Edit", "xp+" . this.layoutWCtrlG . " yp wp hp -VScroll +Center +ReadOnly", "Menu")
        this.keyboardWindow.Add("Edit", "xp+" . this.layoutWCtrlG . " yp wp hp -VScroll +Center +ReadOnly", "RCtrl")

        this.keyboardWindow.SetFont()
        ;======== Button Row
        this.keyboardWindow.SetFont("s10", "Segoe UI")
        Temp := this.layoutTotalW - this.layoutWBSpc - this.layoutG
        ogcButtonMenuButtonPause := this.keyboardWindow.Add("Button", "x" . Temp . " yp+" . this.layoutHG . " w" . this.layoutWBSpc . " hp -VScroll +Center", MenuButtonPause)
        ogcButtonMenuButtonPause.OnEvent("Click", this.btnMsg(mButtonPause))
        Temp := Temp - this.layoutWBSpc - this.layoutG
        ogcButtonMenuButtonCancel := this.keyboardWindow.Add("Button", "x" . Temp . " yp w" . this.layoutWBSpc . " hp -VScroll +Center", MenuButtonCancel)
        ogcButtonMenuButtonCancel.OnEvent("Click", this.btnMsg(mButtonCancel))
        Temp := Temp - this.layoutWBSpc - this.layoutG
        ogcButtonMenuButtonSave := this.keyboardWindow.Add("Button", "x" . Temp . " yp w" . this.layoutWBSpc . " hp -VScroll +Center", MenuButtonSave)
        ogcButtonMenuButtonSave.OnEvent("Click", this.btnMsg(mButtonSave))
        Temp := Temp - this.layoutWShift - this.layoutG
        ogcButtonMenuButtonDefaults := this.keyboardWindow.Add("Button", "x" . Temp . " yp w" . this.layoutWShift . " hp -VScroll +Center", MenuButtonDefaults)
        ogcButtonMenuButtonDefaults.OnEvent("Click", this.btnMsg(mButtonDefaults))
        this.keyboardWindow.SetFont()


    }

    update(){

    }
}