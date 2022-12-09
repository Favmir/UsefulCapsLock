2022/12/09 v1.7.4
- Changed SetKeyDelay to 20, 0 and removed e,d,r,f,h,i,j,k,l,; from the 'mouse disabling key list' like s already was. All to get that annoying Ctrl stuck bug.

2022/12/01 v1.7.3
- Added SetKeyDelay, 0, 0 because the Ctrl held down bug kept happening occasionally(this time it was something with Caps Lock + U/O).

2022/11/14 v1.7.2
- Removed SendMode Input to add more delay, which fixes the bug where continously pressing CapsLock+Bound key sometimes sends the original key input instead of the hotkey.

2022/11/06 v1.7.1
- Updated GUI. It's lavender blue now.

2022/11/03	v1.7.0
- Added GUI Size Setting
- Added Text Color Setting
- Improved GUI consistency
- Compiled the program
- Fixed a bug where it'd take 2 tries to open GUI if it was closed via save/cancel button
- Shortcuts changed to be read-only to avoid commit clutter

2022/10/17	v1.6.1
- [Caps Lock + Shift + Ctrl + h/;] now works

2022/10/17	v1.6.0
- Implemented Synaptics driver disable function.
- Which finally fixed that Ctrl held bug(how to reproduce: try to use pinch zoom on touchpad, and while the fingers are still touching the pad, use caps lock + ijkl to navigate).

2022/09/29	v1.5.7
- Temporary fix for Ctrl held bug

2022/09/15	v1.5.6
- Fixed reading saved keys and restore default function.

2022/09/13	v1.5.5
- Numpad 1–9 keys added.
- Hopefully fixed the annoying bug where the script stopped working, and only could be fixed by saving the settings again. Probably didn't.

2022/09/01	v1.5.4
- Localization updated. Can now hide GUI with Win/Alt + Caps lock

2022/08/18	v1.5.3
- Mouse Lock also disables mouse scrolling.

2022/08/11	v1.5.2
- When Mouse Lock is enabled, typing in general disables mouse(instead of only Caps Lock)

2022/07/31	v1.5.1
- Improved Touchpad Lock tutorial window(no longer can be closed with keyboard)
- Can now assign Tab characters on a key
- Added localization functionality for tray menu
- Command prompt no longer shows on startup

2022/07/26	v1.5.0
- Improved ^() key function (Now uses unicode superscripts if possible)

2021/12/XX	v1.4.0
- Improved ^() key function
- Added Ctrl row to GUI

2021/10/03	v1.3.1
- Fixed new bug introduced in recent Windows update
- Added option to disable startup popup message box

2020/09/XX	v1.1.6
- Opening GUI now cancels script suspend
- Added App folder
- Added "Useful Caps Lock" shortcut to take batch file's place
- Renamed "AddButtons.ahk" to "BuildButtons.ahk"
- Assigned ^() function to Key6
- Added second math layout

2020/09/27	v1.1.5
- Added "Add to Startup.bat"
- Added "Launch Useful Caps Lock.bat"
- Moved script components into separate folders(Scripts, Settings, Icons)
- Added custom tray icon and menu
- Added Background color setting

2020/09/XX	v1.1
- General code cleanup.
- Added settings save&load functionality
- Added "AddButtons.ahk" to separate GUI initial build code
- Added "Changelog.txt"
- Added "GuiSize.settings"
- Added "Keys.settings"
- Added "Keys_Default.settings"
- Added "Localization.settings"

2020/09/15	v1.0
- Code cleanup
- Enhanced keyboard GUI
- Removed previous main menu(made obsolete by the keyboard GUI)

2020/09/XX	v0.9
- Added button to bring up custom keyboard GUI to the main menu
- Removed options submenu(made obsolete by the new keyboard GUI)

2020/09/09	v0.6
- Added special characters input functionality

2020/08/25	v0.5
- Added localization support

2020/08/06	v0.3
- Added menu that can be brought up with Win+CapsLock

2020/08/03	v0.1
- Program created
