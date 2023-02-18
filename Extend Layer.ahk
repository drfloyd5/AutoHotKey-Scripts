/*
********************************************************************************

Use MS Powertoys to assign capslock to F13.
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

;SetCapsLockState, Off
;SetCapsLockState, AlwaysOff

;; Utilities_ShowInfo(A_ScriptName . " Loaded.")

;#if GetKeyState("F13","P")

; Keyboard Layer Keys ====================================

; Row 2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; asdf ghjk l;'E
; 1122 2222 2221
; ef01 2345 678C

; #IfWinNotActive USV04844708 - Desktop Viewer

; Function Keys ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;F13 & SC029:: ; esc
;F13 & SC003A:: ; F1
;F13 & SC003B:: ; F2
;F13 & SC003C:: ; F3
;F13 & SC003D:: ; F4
;F13 & SC003E:: ; F5
;F13 & SC003F:: ; F6
F13 & SC0040::Send {Media_Prev} ; F7 -> Rewind
F13 & SC0041::Send {Media_Play_Pause} ; F8 -> Play / Pause
F13 & SC0042::Send {Media_Next} ; F9 -> Fast Forward
F13 & SC0043::Send {Volume_Mute} ; F10 -> Mute
F13 & SC0044::Send {Volume_Down} ; F11 -> Volume Down
F13 & SC0045::Send {Volume_Up} ; F12 -> Volume Up
;F13 & SC0046:: ; Print Screen
;F13 & SC0047:: ; Scroll Lock
;F13 & SC0048:: ; Pause



; Numerber Line ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;F13 & SC035:: ; `
;F13 & SC002::F1 ; 1
;F13 & SC003::F2 ; 2
;F13 & SC004::F3 ; 3
;F13 & SC005::F4 ; 4
;F13 & SC006::F5 ; 5
;F13 & SC007::F6 ; 6
;F13 & SC008::F7 ; 7
;F13 & SC009::F8 ; 8
;F13 & SC00A::F9 ; 9
;F13 & SC00B::F10 ; 0
;F13 & SC00C::F11 ; -
;F13 & SC00D::F12 ; =
;SC00E::

; Row 1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; qwer tyui op[] |\
; 1111 1111 1111 |2
; 0123 4567 89AB |B

;F13 & SC002B:: ; Tab
F13 & SC010::Send, {Ctrl Down}a{Ctrl Up} ; 
F13 & SC011::esc
;SC012::
F13 & SC013::Send, #r
F13 & SC014::WheelUp
F13 & SC015::PgUp
F13 & SC016::Home
F13 & SC017::Up
F13 & SC018::End
;F13 & SC019::Delete
;SC01A::
;SC01B::
;SC02B::

; Row 2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; asdf ghjk l;'E
; 1122 2222 2221
; ef01 2345 678C
; a
F13 & SC01E::Send, {Blind}{Alt Down}
F13 & SC01E UP::Send, {Alt Up}
; s
F13 & SC01f::Send, {Blind}{Shift Down}
F13 & SC01f UP::Send, {Shift Up}
; d
F13 & SC020::Backspace
; f
F13 & SC021::Send, {Blind}{Ctrl Down}
F13 & SC021 UP::Send, {Ctrl Up}
;
F13 & SC022::WheelDown
F13 & SC023::PgDn
F13 & SC024::Left
F13 & SC025::Down
F13 & SC026::Right
F13 & SC027::Delete
; F13 & SC028::Send, {End}{Text};
; F13 & SC01C::
;     Send, {End}{text};
;     Send, {Enter}
; return

; Row 3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; zxcv bnm, ./
; 2222 3333 33
; cdef 0123 45

F13 & SC02C::Send, {Ctrl Down}z{Ctrl Up}
F13 & SC02D::Send, {Ctrl Down}x{Ctrl Up}
F13 & SC02E::Send, {Ctrl Down}c{Ctrl Up}
F13 & SC02F::Send, {Ctrl Down}v{Ctrl Up}
;SC030::
F13 & SC031::LButton
F13 & SC032::RButton
;SC033::
;SC034::
F13 & SC035::Send, {Shift Down}{F10}{Shift Up}

; Row 4 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    Space
;SC039
F13 & SC039::Enter

; Mouse ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
F13 & WheelDown::Tab
F13 & WheelUp::+Tab

#If

#include %A_ScriptDir%\Utilities.ahk