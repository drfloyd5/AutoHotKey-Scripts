#SingleInstance, Force
SetTitleMatchMode, 2

revisionGraphWindow := WinExist("Revision Graph ahk_exe TortoiseGitProc.exe")

if (revisionGraphWindow) {
	ControlSend, ahk_parent, {F5}, ahk_id %revisionGraphWindow%
	WinActivate
}