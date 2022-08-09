class KeySection {
	iniPath := ""
	DefaultIniPath := ""
	iniSection := ""
	keyList := Array()

	__New(path, section){
		this.iniPath := path
		this.iniSection := section
		DefaultIniPath := RegExReplace(this.iniPath, "^([^\s]+)(.ini)$", "$1_Defaults$2", , ,)
	}

	setPath(path){
		this.iniPath := path
	}

	addKey(key, keyVarPointer){
		this.keyList.push(KeyUnit(this.iniPath, this.iniSection, key, keyVarPointer))
	}

	getKey(index){
		return this.keyList.get(index)
	}

	readAll(){
		Loop this.keyList.Length{
			this.keyList[A_Index].read()
		}
	}

	readDefaults(){
		temp := this.iniPath
		this.iniPath := this.DefaultIniPath
		this.readAll()
		this.iniPath := temp
	}

	writeAll(){
		Loop this.keyList.Length{
			this.keyList[A_Index].write()
		}
	}

}

class KeyUnit {
	btnType := ""
	btnWidth := ""
	btnHeight := ""
	btnDesc := ""
	btnEvent := ""

	iniPath := ""
	iniSection := ""
	iniKey := ""
	keyVarPointer := ""

	__New(path, section, key, keyVarPointer){
		this.iniPath := path
		this.iniSection := section
		this.iniKey := key
		this.keyVarPointer := keyVarPointer
	}

	setGuiProperty(keyType, width, height, desc, event){
		this.btnType := keyType
		this.btnWidth := width
		this.btnHeight := height
		this.btnDesc := desc
		this.btnEvent := event
	}

	read(){
		%this.keyVarPointer% := IniRead(this.iniPath, this.iniSection, this.iniKey)
	}

	write(){
		IniWrite(%this.keyVarPointer%, this.iniPath, this.iniSection, this.iniKey)
	}


}