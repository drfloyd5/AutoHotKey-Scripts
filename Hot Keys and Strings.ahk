#SingleInstance force
#Persistent
SetWorkingDir %A_ScriptDir%
SendMode Input
SetTitleMatchMode, RegEx

#MaxHotkeysPerInterval 300

Utilities_ShowInfo(A_ScriptName . " Loaded.")

;Menu, Tray, Icon, %A_ScriptDir%\Icons\IconGreen.ico

; ^+r::   ; The last reloaded script steals this hotkey.
;     Reload
;     Utilities_ShowToolTip("Reloaded")
;     return

; Hot Keys
;+Space::_ ; Seems cool. Is not.

;^Up::send ^{Home}
;^Down::send ^{End}

; Summon DuckDuckGo

!+d::
    browserSearchHandle:=0
    Utilities_ShowInfo("Opening DDG")
    Run, "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" about:blank --new-window 
return


; Application Specific =========================================

; Code / VS
; Replaced with Extend Layer Caps+Enter
;#IfWinActive, ahk_exe (Code\.exe|devenv.exe)
;`;::send, {end}{text};;;;; ; ; ; ; ;
;^`;::send, {text};lkjljklj


#IfWinNotActive USV04844708 - Desktop Viewer

; Hot Strings

; Samuel Renkert
:*:\me\::Samuel Renkert
:*:\em\::Renkert, Samuel
:*:\me@::harry@grinningwizards.com


; Text Shortcuts ###############################################

::atm::at the moment
::esp::especially

; Location Location ---------------------------------
:*:``\::C:\Users\harry\iCloudDrive\Home
:*:``tech::C:\Users\harry\iCloudDrive\Home\Tech
:*:``desk::C:\Users\harry\OneDrive\Desktop
:*:``down::C:\Users\harry\Downloads

; Manners --------------------------

:*c:ttyl::Talk to you later
:*c:ttyt::Talk to you then
:*c:ttyT::Talk to you tomorow
::ty::Thank you
::yw::You're welcome

; Symbol Shortcuts ###############################################

:*:~~=::≈
:*:==>::⇒
:*:-->::→  
:*:<<>::⇌  
:*:<>>::⇌  
:*:<==::⇐  
:*:==^::⇑
:*:==v::⇓  
:*:!!=::≠  
:*:++-::±
:*:--+::±  

; Accents ###############################################
:*:a''::á
:*:e''::é
:*:u::::ü

#if

#Include, %A_ScriptDir%\Utilities.ahk
