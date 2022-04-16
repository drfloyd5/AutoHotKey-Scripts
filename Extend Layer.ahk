/*
********************************************************************************


Use MS Powertoys to assign capslock to f13.
This is necessary when running script on Work PC
otherwhise capslock light has a seizure.


*********************************************************************************
*/

#SingleInstance force
#Persistent
SetWorkingDir %A_ScriptDir%
SendMode Input
#InstallKeybdHook

;Menu, Tray, Icon, %A_ScriptDir%\icons\IconBlue.ico


SetCapsLockState, Off
SetCapsLockState, AlwaysOff

Utilities_CreateWindow("Extend Layer Loaded.")


; Keyboard Layer Keys ====================================

#InputLevel, 1

*CapsLock::Send, {F13 down}
*CapsLock Up::Send, {F13 up}

#InputLevel, 0

; Row 2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; asdf ghjk l;'E
; 1122 2222 2221
; ef01 2345 678C


;       Alt (a)jlljjlljjjjj
F13 & SC01e::
    Send, {Blind}{Alt Down}
    Return
F13 & SC01e UP::
    Send, {Alt Up}
    return

;       Shift (d)
F13 & SC020::
    Send, {Blind}{Shift Down}
    Return
F13 & SC020 UP::
    Send, {Shift Up}
    return

;       Ctrl (f)
F13 & SC021::
    Send, {Blind}{Ctrl Down}
    Return
F13 & SC021 UP::
    Send, {Ctrl Up}
    return

;       Ctrl-Tab (e)

; F13 & SC012::
;     if (!ctrlDown) {
;         Send, {Ctrl Down}    
;         ctrlDown:=1
;     }
;     Send, {blind}{tab}
;     return

; ^F13 UP::
;     Utilities_ShowToolTip("Up")
;     Send, {Ctrl Up}
;     ctrlDown := 0
; return


;#If GetKeyState("F13","P")




; Row -1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Row 0 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; `123 4567 890- =b
; 2000 0000 0000 00kkk
; 9234 5678 9ABC DE

;F13 & SC029::
F13 & SC002::F1
F13 & SC003::F2
F13 & SC004::F3
F13 & SC005::F4
F13 & SC006::F5
F13 & SC007::F6
F13 & SC008::F7
F13 & SC009::F8
F13 & SC00A::F9
F13 & SC00B::F10
F13 & SC00C::F11
F13 & SC00D::F12
;F13 & SC00E::






; Row 1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; qwer tyui op[] |\
; 1111 1111 1111 |2
; 0123 4567 89AB |B
F13 & SC010::Send, {Ctrl Down}a{Ctrl Up}
F13 & SC011::esc
;F13 & SC012::    See Keyboard Layer Keys above.
F13 & SC013::Send, #r
F13 & SC014::WheelUp
F13 & SC015::PgUp
F13 & SC016::Home
F13 & SC017::Up
F13 & SC018::End
F13 & SC019::Delete
;F13 & SC01A::
;F13 & SC01B::
;F13 & SC02B::

; Row 2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; asdf ghjk l;'E
; 1122 2222 2221
; ef01 2345 678C

;F13 & SC01E:: See Keyboard Layer Keys above.
F13 & SC01f:: BackSpace
;F13 & SC020:: See Keyboard Layer Keys above.
;F13 & SC021::BackSpace
F13 & SC022::WheelDown
F13 & SC023::PgDn
F13 & SC024::Left
F13 & SC025::Down
F13 & SC026::Right
F13 & SC027::Delete
F13 & SC028::Send, {End}{Text};
F13 & SC01c::
    Send, {End}{text};
    Send, {Enter}
    return

; Row 3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; zxcv bnm, ./
; 2222 3333 33
; cdef 0123 45

F13 & SC02c::^z
F13 & SC02d::^x
F13 & SC02e::^c
F13 & SC02f::^v
;F13 & SC030::
F13 & SC031::LButton
F13 & SC032::RButton
;F13 & SC035::
;F13 & SC035::,
F13 & SC035::Send, {Shift Down}{F10}{Shift Up}

; Row 4 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    Space
;F13 & SC039
F13 & SC039::Enter


; Mouse ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
F13 & WheelDown::Tab
F13 & WheelUp::+Tab

#If

#include %A_ScriptDir%\Utilities.ahk