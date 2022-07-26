
IniWrite(3, "Test.ini", "firstSection", "firstvalue")
IniWrite("haha", "Test.ini", "firstSection", "secondvalue")
IniWrite("boo", "Test.ini", "secondSection", "firstvalue")

IniWrite(true,A_ScriptDir "\Settings\Test.ini","booleanSection", "booleanTrue")
scrollUp := ""
scrollDown := ""
keyGrave := ""
key1 := "o"

readKBSettings(){
    ;[Scroll]
    scrollUp := IniRead("\Settings\Gui.ini","Scroll", scrollUp)
    scrollDown := IniRead("\Settings\Gui.ini","Scroll", scrollDown)
    ;[Keybind]
    keyGrave := IniRead("\Settings\Gui.ini","Keybind", keyGrave)
    key1 := IniRead("\Settings\Gui.ini","Keybind", key1)
}


readKBSettings()
MsgBox(key1,"","")