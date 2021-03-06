Utilities_ShowToolTip(tipText) {
    global Utilities_DefaultHideToolTipDelay
    if (!Utilities_DefaultHideToolTipDelay) {
        Utilities_DefaultHideToolTipDelay = 1500
    }
    Utilities_ShowToolTipForMilliseconds(tipText, Utilities_DefaultHideToolTipDelay)
}

Utilities_ShowToolTipForMilliseconds(tipText, hideToolTipDelay)
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

Utilities_CreateWindow(key){
    
    fontSize = 12
    Utilities_GetTextSize(key,fontSize,Verdana,height,width)
    bgTopPadding = 10
    bgWidthPadding = 10
    formMargin = 5
    bgHeight = % height + bgTopPadding*2
    bgWidth = % width + bgWidthPadding*2
    
    padding = 10
    
    SysGet, desktop, MonitorWorkArea
    yPlacement = % desktopBottom - bgHeight - padding
    xPlacement = % desktopLeft  + padding

    Gui, Utilities_InfoWindow: New, +LastFound +AlwaysOnTop -Border -SysMenu +Owner -Caption +ToolWindow
    Gui, Utilities_InfoWindow: Color, 00008c
    Gui, Utilities_InfoWindow: Margin, %formMargin%, %formMargin%
    ;Gui, Utilities_InfoWindow: Add, Picture, x0 y0 w%bgWidth% h%bgHeight%, Images\InfoWindow Background.png
    
    Gui, Utilities_InfoWindow: Font, s%fontSize% cWhite q5, Verdana
    ;Gui, Utilities_InfoWindow: Add, Text, xm y20 x50 ,%key%
    Gui, Utilities_InfoWindow: Add, Text, xm ym,%key%
    Gui, Utilities_InfoWindow: Show, x%xPlacement% y%yPlacement%
    SetTimer, Utilities_RemoveGui, 1000
}

Utilities_GetTextSize(str, size, font,ByRef height,ByRef width) {
    Gui temp: Font, s%size% q5, %font%
    Gui temp:Add, Text, x0,y0 , %str%
    GuiControlGet T, temp:Pos, Static1
    Gui temp:Destroy
    height = % TH
    width = % TW
}

Utilities_RemoveGui:
    Gui,Utilities_InfoWindow: Destroy
return

Utilities_ToolTipOff:
    Utilities_HideToolTip()
return

