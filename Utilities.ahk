If (A_ScriptName="Utilities.ahk") {
    MsgBox, Don't run the Utilities Script.
    ExitApp
}

Utilities_ShowToolTip(tipText, hideToolTipDelay := 1500)

{
    reserveCoordModeMouse := A_CoordModeMouse
    reserveCoorModeTooltip := A_CoordModeTooltip
    CoordMode Mouse, Screen
    CoordMode Tooltip, Screen
    MouseGetPos, xpos, ypos
    ypos:=ypos+20
    SysGet, workArea, MonitorWorkArea
    ypos := min(ypos,workAreaBottom-30)
    ToolTip %tipText%, xpos, ypos
    CoordMode Mouse, reserveCoordModeMouse
    CoordMode Tooltip, reserveCoorModeTooltip
    SetTimer, Utilities_ToolTipOff, %hideToolTipDelay%
}

Utilities_HideToolTip() {
    SetTimer, Utilities_ToolTipOff, Off
    ToolTip
}

Utilities_ShowInfo(key, closeAfter:=2000) {
    
    workAreaMargin = 50

    textPaddingHeight = 5
    textPaddingWidth = 5

    
    fontSize = 16

    Utilities_GetTextSize(key,fontSize,Verdana,textHeight,textWidth)
    TextY = % textPaddingHeight*2
    textH = % textHeight
    textHeight = % textHeight + textPaddingHeight*2
    textWidth = % textWidth
    bgTopPadding = 5
    bgWidthPadding = 5
    bgHeight = % textHeight + bgTopPadding*2
    bgWidth = % textWidth + bgWidthPadding*2
    bgX = % bgTopPadding
    bgY = % bgWidthPadding
    
    SysGet, desktop, MonitorWorkArea
    yPlacement = % desktopBottom - bgHeight - workAreaMargin
    xPlacement = % desktopLeft + workAreaMargin
    Gui, Utilities_InfoWindow: New, +LastFound +AlwaysOnTop -Caption +ToolWindow
    ;Gui, Utilities_InfoWindow: New, +LastFound +AlwaysOnTop -Border -SysMenu +Owner -Caption +ToolWindow
    customColor = 375583
    Gui, Utilities_InfoWindow: Color, %CustomColor%
    Gui, Utilities_InfoWindow: Margin, 0, 0
    Gui, Utilities_InfoWindow: Add, Picture, x0 y0 w%bgWidth% h%bgHeight%, %A_ScriptDir%\Images\InfoWindow Background.png
    Gui, Utilities_InfoWindow: Font, s%fontSize% cWhite q5, Verdana
    ;Gui, Utilities_InfoWindow: Add, Text, xm y20 x50 ,%key%
    Gui, Utilities_InfoWindow: Add, Text, x%bgX% y%bgY% w%textWidth% h%textHeight% center
    Gui, Utilities_InfoWindow: Add, Text, x%bgX% y%TextY% w%textWidth% h%TextH% cCFCFCF center, %key%
    ;WinSet, TransColor, %CustomColor% 250
    Gui, Utilities_InfoWindow: Show, xCenter y%yPlacement% w%bgWidth% h%bgHeight% NoActivate 
    SetTimer, Utilities_RemoveGui, %closeAfter%
}

Utilities_GetTextSize(str, size, font,ByRef height,ByRef width) {
    Gui temp: Font, s%size% q5, %font%
    Gui temp:Add, Text, x0,y0 w1000 , %str%
    Gui temp:Add, Text, x0,y0 , %str%
    GuiControlGet T, temp:Pos, Static1
    Gui temp:Destroy
    height = % TH
    width = % TW
}

Utilities_RemoveGui:
    SetTimer, Utilities_RemoveGui, Off
    Gui,Utilities_InfoWindow: Destroy
return

Utilities_ToolTipOff:
    Utilities_HideToolTip()
return