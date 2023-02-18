#SingleInstance force
#Persistent
SetWorkingDir %A_ScriptDir%
;Menu, Tray, Icon, "c:\data\home\bin\AutoHotKey\Icon_Blue.png", 0
#MaxHotkeysPerInterval 300
SendMode Input



capsPressed := 0ss
capsUsed := 0

#if !WinActive("ahk_exe CDViewer.exe")
~CapsLock::
    SetCapsLockState, Off
    capsPressed := 1
    capsUsed := 0
return

~CapsLock Up::
    if (capsPressed && !capsUsed) {
        send, {BackSpace}
    }
    capsPressed:=0
    capsUsed := 0

    SetCapsLockState, Off
Return

+CapsLock::
          send, {Delete}
return

#if 

#if capsPressed
SC024::
    send, {left}
    capsUsed := 1
Return

SC027::
    send, {Right}
    capsUsed := 1
Return

SC025::
    send, {Up}
    capsUsed := 1
Return

SC026::
    send, {Down}
    capsUsed := 1
Return


#If
