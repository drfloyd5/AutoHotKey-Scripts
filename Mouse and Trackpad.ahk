SetWorkingDir %A_ScriptDir%

; Menu, Tray, Icon, %A_ScriptDir%\Icons\IconRed.ico

; ^+r::   ; The last reloaded script steals this hotkey.
;     Reload
;     Utilities_ShowToolTip("Reloaded")
;     return


#Include, %A_ScriptDir%\Mouse and Trackpad\Panels 1.0.ahk
#Include, %A_ScriptDir%\Utilities.ahk