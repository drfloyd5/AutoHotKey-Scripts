#Persistent
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#NoEnv

; TrackPad Stuff ##############################
SendMode Input


; Public Config
tapTimeout := 2500
leftPanelPixelWidth := 700
rightPanelPixelWidth := 700
panelPaddingPixelWidth := 2

presentationWidth := 1920
presentationHeight := 1080

targetWindow :=0

; private

;; Init {
lastAction := "none"
previousTapTicks := 0
;; } Init

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

+XButton2::
    if (!HandleSequence("Shift Forward Button")) {
        Send, +{XButton2}
    }
return

XButton2::
    if (!HandleSequence("Forward Button")) {
        Send, {XButton2}
    }
return

+^!RButton::
    if (!HandleSequence("Shift Forward Button")) {
        Send, {^!RButton}
    } 
Return

^!RButton::
    if (!HandleSequence("Forward Button")) {
        Send, {^!RButton}
    } 
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Methods ;;;;;;;;;;;;;;;;;;;;;;;;;

HandleSequence(currentAction) {
    global previousTapTicks, tapTimeout, lastAction, targetWindow

    nowTickCount := A_TickCount
    if (nowTickCount - previousTapTicks > tapTimeout || lastAction="none") {
        targetWindow := WinExist("A")
        startedAction := StartTriggeredAction(currentAction)
        if (!startedAction) 
            WaitForNewTriggeredAction()
        return startedAction
    }

    currentActiveWindow := WinExist("A")
    didSomething := 0
    if (targetWindow = currentActiveWindow) {
        didSomething := DoTriggeredAction(lastAction, currentAction)
    } 
    WaitForNewTriggeredAction()
return didSomething
}

DoTriggeredAction(lastAction, currentAction) {
    if (lastAction="Shift Forward Button" && currentAction="Shift Forward Button") {
        WinClose, A
        return 1 
    } else if ((lastAction="Forward Button" || lastAction="Shift Forward Button") && currentAction="Forward Button") {
        DismissActiveWindow()
        return 1
    } else if (lastAction="Quad Tap" && currentAction="Quad Tap") {
        DismissActiveWindow()
        return 1
    } else if (lastAction="Quad Tap" && currentAction="Tripple Tap") {
        ThrowActiveWindowLeft()
        return 1
    } else if (lastAction="Tripple Tap" && currentAction="Back Button") {
        ThrowActiveWindowLeft()
        return 1
    } else if (lastAction="Tripple Tap" && currentAction="Quad Tap") {
        ThrowActiveWindowCenter()
        return 1
    } else if (lastAction="Tripple Tap" && currentAction="Forward") {
        ThrowActiveWindowRight()
        return 1
    } else if (lastAction="Tripple Tap" && currentAction="Tripple Tap") {
        MinimizeActiveWindow()
        return 1
    } 
return 0

}



ShowActionHints(initialAction) {
    global actionType
    SetTitleMatchMode RegEx

    actionDescription := ""
    activeTitle := ""
    

    appDescription := ""
    actionType:="Close Window"
    altActionType:="Close Window"
    
    if (WinActive("ahk_exe devenv.exe")) {
        actionType:="Close Tab"
        appDescription := "Visual Studio"
    } else if (WinActive("ahk_exe Code.exe")) {
        actionType:="Close Tab"
        appDescription := "Visual Studio Code"
    } else if (WinActive("ahk_exe chrome.exe")) {
        actionType:="Close Tab"
        appDescription := "Chrome"
    } else if (WinActive("ahk_exe msedge.exe")) {
        actionType:="Close Tab"
        appDescription := "Edge"
    } else if (WinActive("ahk_class LyncTabFrameHostWindowClass")) {
        actionType:="Minimize"
        appDescription := "Skype Conversation"
    } else if (WinActive("- Outlook$")) {
        actionType:="Minimize"
        appDescription := "Skype Conversation"
    }
    else if (WinActive("ahk_exe Teams.exe")) {
        actionType:="Minimize"
        appDescription := "Teams"
    }
    else if (WinActive("Skype for Business")) {
        actionType:="Minimize"
        appDescription := "Skype Contacts"
    } else {
        WinGetActiveTitle, appDescription
    }
    
    } else if (initialAction = "Quad Tap") {
        altActionType := "Tripple Tab: Move window left."
    }
    
    repeatDescription := initialAction="Shift Forward Button" ? "`nRepeat w/o Shift: " : "`nRepeat w/ Shift: "
    
    actionDescription := "Repeat: " 
        . actionType
        . appDescription 
        . actionType!=altActionType
            ?""
            :altActionType="Close Window"
                ?repeatDescription . "Close Window"
                :altActionType="Close Tab"
                    ?repeatDescription . "Close Tab"
                    :altActionType="Minimize"
                        ?repeatDescription . "Minimize"
                        :""
    } else if (initialAction = "Quad Tap") {
        actionDescription := actionDescription "`nTripple Tap: Move window left."
    } else if (initialAction="Tripple Tap") {
        actionDescription := "Minimize " activeTitle "`nBack:Move window left.`nQuad Tap: Center window.`nForward: Move window right."
    }

    if (actionDescription) {
        Utilities_ShowToolTip(actionDescription)
        return 1
    }
return 0
}

DismissActiveWindow()
{
    SetTitleMatchMode RegEx

    if (WinActive("ahk_exe devenv.exe")) {
        Send ^{F4}
    } else if (WinActive("ahk_exe Code.exe")) {
        Send ^{F4}
    } else if (WinActive("ahk_exe chrome.exe")) {
        Send ^{F4}
    } else if (WinActive("ahk_exe msedge.exe")) {
        Send ^{F4}
    } else if (WinActive("ahk_class LyncTabFrameHostWindowClass")) {
        Send {esc}
    } else if (WinActive("- Outlook$")) { 
        MinimizeActiveWindow()
    } else if (WinActive("ahk_exe Teams.exe")) { 
        MinimizeActiveWindow()
    } else if (WinActive("Skype for Business")) {
        MinimizeActiveWindow()
    } else {
        WinClose, A
    }
}

WaitForNewTriggeredAction() {
    global lastAction, previousTapTicks, targetWindow
    HideToolTip()
    lastAction := "none"
    targetWindow := 0
    previousTapTicks := 0
}

StartTriggeredAction(currentAction) {
    global lastAction, previousTapTicks
    lastAction := currentAction
    previousTapTicks := A_TickCount
return ShowActionHints(currentAction)
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

MoveActiveWindow(panelStartPixel, panelEndPixel)
{
    SysGet, workArea, MonitorWorkArea

    windowTop := workAreaTop + 10
    windowWidth := panelEndPixel - panelStartPixel
    windowHeight := workAreaBottom - workAreaTop - 20

    WinMove,A, , %panelStartPixel%, %windowTop% , %windowWidth%, %windowHeight%
}

MinimizeActiveWindow() {
    WinMinimize, A 
}