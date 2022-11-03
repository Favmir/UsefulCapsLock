# UsefulCapsLock
![Gui](/etc/V170GUI.png)

An AutoHotKey Script that helps you edit text.

I made this script to solve my problem of
1. palm grazing my laptop touchpad constantly
2. arrow keys are in such inconvient places when you need to move your cursor through text a lot
3. Wasted time and effort when I want to use a character that isn't present in my keyboard (Em Dash, for example, which I use for every day writing)

Some people solve these problems via a Pointing Stick(a.k.a. red nipple) but I prefer my solution.

## Installation
Well, this is a portable program, so you don't need to 'install' this per se.
* Start the program by running `Useful Caps Lock.lnk` shortcut.
* Run `App\Add to Startup.bat` to make this script automatically run when starting the computer.
* If you don't want it on your computer anymore, use `App\Remove from Startup.bat` to delete the shortcut.

## How to Use
* `[LAlt + Caps Lock]` brings out the GUI menu above. 
* `[Caps Lock + Editable key]` sends the allocated text.
* `[Caps Lock + Buttoned key]` carries out pre-determined functions. For example, press Caps Lock + IJKL to move your cursor. You can see which key exactly does what by clicking on the key buttons.
* `[Mouse Lock]` checkbox disables mouse input and only re-enables it when you press `[Caps Lock + W]`, so you won’t have to suffer from Touchpad palm press syndrome anymore.
* `[Shift + Caps Lock]` carries out the original Caps Lock function

## Issues (with games)
I've left this script running while playing games, and so far had no problem at all with single-player games.

I've only tested a few multiplayer games:
* Monster Hunter World/Rise - Hotkeys don't work on text boxes for some reason. No negative consequences(Monster Hunter doesn't ban cheats at all anyways).
* Overwatch - Works. Doesn't detect this as a cheating software.
* Team Fortress 2 - No problem.
* Lost Ark - Detects any autohotkey process on launch and refuses to log you in. You have to quit the script to run the game.

## Changelog
[Open Changelog](Changelog.md)

## To Do List
- [ ] Rewrite this botched mess of a code in AHK v2
- [ ] Add Unicode character browser
