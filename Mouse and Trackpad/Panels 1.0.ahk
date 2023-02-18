#Persistent
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#NoEnv


#MaxHotkeysPerInterval 300

; TrackPad Stuff ##############################
SendMode Input

; Public Config
tapTimeout := 2500
leftPanelPixelWidth := 700
rightPanelPixelWidth := 700
panelPaddingPixelWidth := 2

presentationWidth := 1920
presentationHeight := 1080

; private

;; Init {
lastAction := "none"
previousTapTicks := 0
;; } Initq

#if lastAction!="none"
$Escape::StopTriggeredAction()

#if

#IfWinNotActive USV04844708 - Desktop Viewer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Touch ;;;;;;;;;;;;;;;;;;;;;;;
;keys

^+#Left::
    ThrowActiveWindowLeft()
return

^#Left::
    ThrowActiveWindowLeftHalf()
return

^+#Right::
    ThrowActiveWindowRight()
return

^#Right::
    ThrowActiveWindowRightHalf()
return

^+#Down::
    MinimizeActiveWindow()
return

^+#Up::
    ThrowActiveWindowCenter()
return

^#Up::
    ThrowActiveWindowCenterRight()
return

^+#Space::
    ThrowActiveWindowPresentationLarge()
return

^#Space::
    ThrowActiveWindowPresentationSmall()
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Touch ;;;;;;;;;;;;;;;;;;;;;;;
;trippleTouch
+^F22::
    HandleSequence("Tripple Tap")
return

; quadTouch
+^F24::
    HandleSequence("Quad Tap")
return

XButton1::
    if (!HandleSequence("Back Button")) {
        Send, {XButton1}
    }
return

XButton2::
    if (!HandleSequence("Forward Button")) {
        Send, {XButton2}
    }
return

^XButton2::!esc
#if    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Methods ;;;;;;;;;;;;;;;;;;;;;;;;;

HandleSequence(currentAction) {
    global previousTapTicks, tapTimeout, lastAction

    nowTickCount := A_TickCount
    if (nowTickCount - previousTapTicks > tapTimeout || lastAction="none") {
        if (currentAction="Back Button") {
            return 0
        }
        StartTriggeredAction(currentAction)
        if (currentAction="Forward Button") {
            actionDescription := ActiveWindowCloseActionDescription()
            Utilities_ShowToolTip("Repeat: " actionDescription)
        } else if (currentAction="Quad Tap") {
            Utilities_ShowToolTip("Repeat: Close window.`nTripple Tap: Move window left.")
        } else if (currentAction="Tripple Tap") {
            Utilities_ShowToolTip("Repeat: Minimize.`nBack:Move window left.`nQuad Tap: Center window.`nForward: Move window right.")
        }

        return 1
    }

    if (lastAction="Forward Button" && currentAction="Forward Button") {
        CloseActiveWindow()
    } else if (lastAction="Quad Tap" && currentAction="Quad Tap") {
        CloseActiveWindow()
    } else if (lastAction="Quad Tap" && currentAction="Tripple Tap") {
        ThrowActiveWindowLeft()
    } else if (lastAction="Tripple Tap" && currentAction="Back Button") {
        ThrowActiveWindowLeft()
    } else if (lastAction="Tripple Tap" && currentAction="Quad Tap") {
        ThrowActiveWindowCenter()
    } else if (lastAction="Tripple Tap" && currentAction="Forward") {
        ThrowActiveWindowRight()
    } else if (lastAction="Tripple Tap" && currentAction="Tripple Tap") {
        MinimizeActiveWindow()
    }
    StopTriggeredAction()
return 1
}

CloseActiveWindow()
{
    ; Close
    ActiveWindowCloseAction()
}

MinimizeActiveWindow()
{
    WinMinimize, A
}

StopTriggeredAction() {
    global lastAction, previousTapTicks
    Utilities_HideToolTip()
    lastAction := "none"
    previousTapTicks := 0
}

StartTriggeredAction(fingers) {
    global lastAction, previousTapTicks
    lastAction := fingers
    previousTapTicks := A_TickCount
}

ThrowActiveWindowLeft() {
    global leftPanelPixelWidth
    global panelPaddingPixelWidth

    SysGet, workArea, MonitorWorkArea

    MoveActiveWindow(workAreaLeft, workAreaLeft+leftPanelPixelWidth-panelPaddingPixelWidth)
}

ThrowActiveWindowLeftHalf() {
    global leftPanelPixelWidth
    global panelPaddingPixelWidth

    SysGet, workArea, MonitorWorkArea

    MoveActiveWindow(workAreaLeft, (workAreaLeft+workAreaRight)/2 - panelPaddingPixelWidth)
}

ThrowActiveWindowRightHalf() {
    global rightPanelPixelWidth
    global panelPaddingPixelWidth
    SysGet, workArea, MonitorWorkArea
    MoveActiveWindow((workAreaRight+workAreaLeft)/2 +panelPaddingPixelWidth,workAreaRight)
}

ThrowActiveWindowPresentationSmall() {
    SysGet, workArea, MonitorWorkArea

    workAreaHorzontalCenter := (workAreaLeft + workAreaRight)/2
    workAreaVerticleCenter := (workAreaTop + workAreaBottom)/2

    global presentationWidth
    global presentationHeight

    windowLeft := workAreaHorzontalCenter - ( presentationWidth/ 2)
    windowTop := workAreaVerticleCenter - ( presentationHeight / 2)

    WinMove,A, , windowLeft, windowTop , presentationWidth, presentationHeight
}

ThrowActiveWindowPresentationLarge() {
    SysGet, workArea, MonitorWorkArea

    workAreaHorzontalCenter := (workAreaLeft + workAreaRight)/2
    workAreaVerticleCenter := (workAreaTop + workAreaBottom)/2

    width := (workAreaRight - workAreaLeft) * 0.80
    height := (workAreaBottom - workAreaTop) * 0.95

    windowLeft := workAreaHorzontalCenter - (width / 2)
    windowTop := workAreaVerticleCenter - (height / 2)

    WinMove,A, , windowLeft, windowTop , width, height
}

ThrowActiveWindowCenter() {
    global leftPanelPixelWidth
    global rightPanelPixelWidth
    global panelPaddingPixelWidth

    SysGet, workArea, MonitorWorkArea

    MoveActiveWindow(workAreaLeft+leftPanelPixelWidth+panelPaddingPixelWidth, workAreaRight-rightPanelPixelWidth-panelPaddingPixelWidth)
}

ThrowActiveWindowCenterRight() {
    global leftPanelPixelWidth
    global rightPanelPixelWidth
    global panelPaddingPixelWidth

    SysGet, workArea, MonitorWorkArea

    MoveActiveWindow(workAreaLeft+leftPanelPixelWidth+panelPaddingPixelWidth, workAreaRight-panelPaddingPixelWidth)
}

ThrowActiveWindowRight() {
    global rightPanelPixelWidth
    global panelPaddingPixelWidth

    SysGet, workArea, MonitorWorkArea

    MoveActiveWindow(workAreaRight-rightPanelPixelWidth+panelPaddingPixelWidth,workAreaRight)
}

ActiveWindowCloseActionDescription() {
    SetTitleMatchMode RegEx
    if (WinActive("- Outlook$")) 
        return "Minimze Outlook Window"
    if (WinActive("Skype for Business"))
        return "Minimze Skype Window"
    if (WinActive("ahk_exe chrome.exe"))
        return "Close Chrome Tab"
    if (WinActive("ahk_exe msedge.exe"))
        return "Close Edge Tab"
    WinGetActiveTitle, activeTitle
return "Close Window " activetitle
}

ActiveWindowCloseAction() {
    SetTitleMatchMode RegEx
    if (WinActive("- Outlook$")) {
        MinimizeActiveWindow()
    } else if (WinActive("Skype for Business")) {
        MinimizeActiveWindow()
    } else if (WinActive("ahk_exe chrome.exe")) {
        Send,^{F4}
    } else if (WinActive("ahk_exe msedge.exe")) {
        Send,^{F4}
    } else {
        WinGetTitle, activeWindowTitle, A
        WinClose, A
    }
}

MoveActiveWindow(panelStartPixel, panelEndPixel)
{
    SysGet, workArea, MonitorWorkArea

    windowTop := workAreaTop + 10
    windowWidth := panelEndPixel - panelStartPixel
    windowHeight := workAreaBottom - workAreaTop - 20

    WinMove,A, , %panelStartPixel%, %windowTop% , %windowWidth%, %windowHeight%
}

