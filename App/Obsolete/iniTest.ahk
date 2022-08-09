
IniWrite(3, "Test.ini", "firstSection", "firstvalue")
IniWrite("haha", "Test.ini", "firstSection", "secondvalue")
IniWrite("boo", "Test.ini", "secondSection", "firstvalue")

IniWrite(true,A_ScriptDir "\Settings\Test.ini","booleanSection", "booleanTrue")
scrollUp := ""
scrollDown := ""
keyGrave := ""
key1 := "o"


for (key)
    key := IniRead("\Settings\Gui.ini",section, key)

}

readKBSettings()
MsgBox(key1,"","")