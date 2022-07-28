class TrayShowGui{
	Call(A_ThisMenuItem, A_ThisMenuItemPos, MyMenu){
		MsgBox("SHOW GUI",,)
	}
}
class TrayPause{
	Call(A_ThisMenuItem, A_ThisMenuItemPos, MyMenu){
		if (A_IsSuspended == true){
			Suspend(false)
			TraySetIcon(A_WorkingDir . "\Icons\icon(32x32).png",1,1)
		}
		else{
			TraySetIcon(A_WorkingDir . "\Icons\icon_off(32x32).png",1,1)
			Suspend(true)
		}
	}
}
class TrayQuit{
	Call(A_ThisMenuItem, A_ThisMenuItemPos, MyMenu){
		ExitApp
	}
}

