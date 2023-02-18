#SingleInstance force
#Persistent
SetWorkingDir %A_ScriptDir%
;Menu, Tray, Icon, "c:\data\home\bin\AutoHotKey\Icon_Blue.png", 0
#MaxHotkeysPerInterval 300
SendMode Input

#InstallKeybdHook

cstack := 0
isPressed := 0
wasUsed := 0

CapsLock::
    isPressed := 1
    cstack += 1
    wasUsed := 0
    KeyWait, CapsLock
    SetCapsLockState, Off
return

CapsLock UP::
    if (!wasUsed) {
        Send, {BackSpace}
    }
    isPressed := 0
    cstack -=1
return

#if %isPressed%

SC015:: ; y
    send, ^{home}
    wasUsed := 1
return

SC016:: ; u
send, {PgUp}
    wasUsed := 1
return

SC017:: ; i
    send, {up}
    wasUsed := 1
return

SC01E:: ; a
    send, {delete}
    wasUsed := 1
return

SC023:: ; h
    send, {home}
    wasUsed:=1
return

SC024:: ; j
    send, {left}
    wasUsed := 1
Return

SC025:: ; k
    send, {Down}
    wasUsed := 1
Return

SC026:: ; l
    send, {Right}
    wasUsed := 1
Return

SC027:: ; ;
    send, {end}
    wasUsed := 1
return

; SC028:: ; '
;     send, {end}
;     wasUsed := 1
; return

SC031:: ; n
    send, ^{end}
    wasUsed := 1
return

SC032:: ; m
    send, {PgDn}
    wasUsed := 1
return


SC035:: ; /
    send, {end}
    wasUsed := 1
return

#If

