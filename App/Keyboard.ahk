class Keyboard extends Gui{
	row1 := ["~","1","2","3","4","5","6","7","8","9","0","-","=","BSpc"]
	row2 := ["Tab","q","w","e","r","t","y","u","i","o","p","[","]","\"]
	row3 := ["Caps","a","s","d","f","g","h","j","k","l",";","'","Enter"]
	row4 := ["LShift","z","x","c","v","b","n","m",",",".","/","RShift"]
	row5 := ["LCtrl","Win","LAlt",  "Spacebar"  ,"RAlt","Func","RCtrl"]

	layout := [this.row1, this.row2, this.row3, this.row4, this.row5]

	keyList := Array()

	scale := 12					;total width is about (130 * scale) pixels
	lG := 1 * this.scale				;1 Gap between keys
	lW := 5 * this.scale				;5 Width of regular key
	lH := 5 * this.scale				;5 Height of regular key
	lWBSpc := 10 * this.scale		;10 Backspace Width: determines the total Keyboard width(13×lW + 15×lG + lWBSpc). Has to be bigger than (lWTab - lW).
	lWTab := 8 * this.scale			;8 Tab Width
	lWCaps := 9.5 * this.scale		;9-9.5 Caps Lock Width
	lWLShift := 12 * this.scale		;12 Left Shift Width
	lWCtrl := 6 * this.scale			;6 Left Ctrl(and other function keys like Windows) Width

	lWBSlsh := this.lWBSpc + this.lW - this.lWTab
	lWEnter := this.lWBSpc + this.lW * 2 - this.lWCaps + this.lG
	lWRShift := this.lWBSpc + this.lW * 3 - this.lWLShift + this.lG * 2
	lTotalW := this.lG*15 + this.lW * 13 + this.lWBSpc
	lTotalH := this.lH * 7 + this.lG*8
	lWSpace := this.lTotalW - this.lWCtrl * 7 - this.lG * 11

	__New(options, title, eventObj, path, sec){
		super(options, title, eventObj)

		endPos := [this.lG,this.lG]
		Loop this.layout.Length{
			y := A_Index
			Loop this.layout[y].Length{
				txt := this.layout[y][A_Index]
				
				Switch txt, "On" {
					Case "BSpc":
						val := ["Button", this.lWBSpc]
					Case "Tab":
						val := ["Button", this.lWTab]
					Case "/":
						val := ["Edit", this.lW]
					Case "Caps":
						val := ["Button", this.lWCaps]
					Case "Enter":
						val := ["Button", this.lWEnter]
					Case "LShift":
						val := ["Button", this.lWLShift]
					Case "RShift":
						val := ["Button", this.lWRShift]
					Case "LCtrl":
						val := ["Button", this.lWCtrl]
					Case "Win":
						val := ["Button", this.lW]
					Case "LAlt":
						val := ["Button", this.lW]
					Case "Spacebar":
						val := ["Button", this.lWSpace]
					Case "RAlt":
						val := ["Button", this.lW]
					Case "Func":
						val := ["Button", this.lW]
					Case "RCtrl":
						val := ["Button", this.lWCtrl]
					Default:
						val := ["Text", this.lW]
				}
				endPos := [endPos[1] + val[2], endPos[2]]
				
				if A_Index == 1
					super.Add(val[1], "W" . val[2] . " H" . this.lH . " X" . this.lG . " Y+" . this.lG,)
				Else
					super.Add(val[1], "W" . val[2] . " H" . this.lH . " X+" . this.lG . " YP", txt)
				
			}
		}

	}
	


}

class KeyUnit {
	btnType := ""
	btnWidth := ""
	btnHeight := ""
	btnDesc := ""
	btnEvent := ""

	btnPos := [0,0]
	btnEndPos := [0,0]

	iniPath := ""
	iniSection := ""
	iniKey := ""
	

	__New(btnPos, btnType, btnWidth, btnHeight){
		this.btnPos := btnPos
		this.btnType := btnType
		this.btnWidth := btnWidth
		this.btnHeight := btnHeight

	}

	setIni(path, section, key){
		this.iniPath := path
		this.iniSection := section
		this.iniKey := key
	}

	
	setGuiProperty(keyType, width, height, desc, event){
		this.btnType := keyType
		this.btnWidth := width
		this.btnHeight := height
		this.btnDesc := desc
		this.btnEvent := event
	}

	read(){
		return IniRead(this.iniPath, this.iniSection, this.iniKey)
	}

	write(value){
		IniWrite(value, this.iniPath, this.iniSection, this.iniKey)
	}


}