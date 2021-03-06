#SingleInstance force
#Persistent
SetWorkingDir %A_ScriptDir%
SendMode Input
SetTitleMatchMode, RegEx

#MaxHotkeysPerInterval 300

Menu, Tray, Icon, %A_ScriptDir%\Icons\IconGreen.ico

; ^+r::   ; The last reloaded script steals this hotkey.
;     Reload
;     Utilities_ShowToolTip("Reloaded")
;     return


:O:<div::<div class="">
:O:<row::<div class="form-row">
:O:<col::<div class="col">{left 2}
:O:<group::<div class="form-group">

; Hot Keys
;+Space::_ ; Seems cool. Is not.

;^Up::send ^{Home}
;^Down::send ^{End}

; Summon DuckDuckGo

!+d::
    browserSearchHandle:=0
    Utilities_ShowToolTip("Opening DDG")

    ; Make list of edge windows.
    WinGet, existingEdgeWindows, List, ahk_exe msedge.exe   
    ; Start Edge
    Run, "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" about:blank --new-window 
    return
    Sleep, 2500
    startLoop:=A_TickCount
    Loop {
         Sleep 500
         WinGet, nowEdgeWindows, List, ahk_exe msedge.exe
         For nowWindow in nowEdgeWindows {
            notFound:=1
            For existingWindow in existingEdgeWindows {
                if (nowWindow=existingWindow) {
                    notFound:=0
                }
            }
            if (notFound) {
                Utilities_ShowToolTip("Found")
                browserSearchHandle := existingWindow
                break
            }            
        }        
    } Until (browserSearchHandle or A_TickCount-startLoop >= 20000) ; 20 seconds
    Utilities_ShowToolTip("Out")
    if (browserSearchHandle) {
        WinActivate, ahk_id %browserSearchHandle%
        Sleep, 250
        Send, {ctrl Down}l{ctrl Up}
        Send, {Delete}
    } else {
        Utilities_ShowToolTip("Got Tired of Waiting for DDG")
    }
return


; Application Specific =========================================

; Code / VS
; Replaced with Extend Layer Caps+Enter
;#IfWinActive, ahk_exe (Code\.exe|devenv.exe)
;`;::send, {end}{text};;;;; ; ; ; ; ;
;^`;::send, {text};lkjljklj


; Lync / Skype - Block ESC from closing windows.
#IfWinActive ahk_exe lync.exe
Esc::return
^F4::send {escape} ; esc closes the window, let's make that the more traditional Ctrl-F4

#IfWinActive ahk_exe plsqldev.exe
+!f::
	Sleep, 500
	send, +^f
return

; Outlook
#IfWinActive ahk_exe outlook.exe
^w::send {delete}   
+^q::send +^1

; One Note
#IfWinActive ahk_exe, ONENOTE.EXE
^+!Right::send {F11}
^+!Left::send {F11}

#IfWinActive

; Hot Strings

:*:'asaiwant::AS A: {enter}I WANT: {enter}SO THAT: {up}{up}

; Monika Sharma
:*:\ms\::Monika Sharma
:*:\ms@::monika.sharma@credit-suisse.com
:*:\msp::m263099

; Matthias Flühmann
:*:\mfp::a574876
:*:\mf\::Matthias Flühmann
:*:\fm\::Flühmann, Matthias
:*:\f\::Flühmann
:*:\mf@::matthias.fluehmann@credit-suisse.com


; Jonathan Weichselbaum
:*:\jw\::Jonathan Weichselbaum
:*:\w\::Weichselbaum
:*:\@jw::@Weichselbaum
:*:\jwp::m093665

; Frans van Baaren
:*:\fvb\::Frans van Baaren
:*:\vbf\::van Baaren, Frans

; Samuel Renkert
:*:\me\::Samuel Renkert
:*:\em\::Renkert, Samuel
:*:\me@::samuel.renkert@credit-suisse.com
:*:\mep::m287695
:*:\men::n287695

; Deepthi Palla
:*:\dp\::Deepthi Palla
:*:\dp@::deepthi.palla@credit-suisse.com
:*:\dpp::m163477
:*:\dpn::n124249

; Lam, Liu-Wah
:*:\ll\::Lam, Liu-Wah
:*:\@ll::llam2
:*:\llp::m712272

; Aviv Yecheskel
:*:\av\::Aviv Yecheskel

; Ram
:*:\rgp::g170601
:*:\rg@::rameshwarnath.gupta@credit-suisse.com
:*:\ram::Ram Gupta
:*:\rg\::Rameshwar Gupta

;Jason Holland
:*:\jh\::Jason Holland
:*:\jhl::jholla16
:*:\jhp::g771130

;Preethi Devireddy 
:*:\pd\::Preethi Devireddy
:*:\pdp::g896251
:*:\pdl::pdevired

; Text Shortcuts ###############################################

; SPIDS

:*:\abspidt::S117151
:*:\abspidp::S117152
:*:\abftpspidt::S209420
:*:\abftpspidp::S207420

:*:\maspidt::S108846
:*:\maspidp::S108924

;ICTOs
:*:\ictoab::ICTO-33063
:*:\ictoma::ICTO-24071
:*:\ictooffice::ICTO-23327

:*:@cs::@credit-suisse.com
:*:\mn\::USV04844708

:c*:D!::DataOne

:c*:JAM::Juriba Application Manager

::appowner::Application Owner
:*:\story::AS A {enter}I WANT {enter}SO THAT{up 2}{end}


::snow::ServiceNow
::atm::at the moment
::ep::Express Packaging
::gpt::Global Packaging Team
::esp::especially

; Location Location ---------------------------------

:*:``od::c:\users\hrenkert\OneDrive - Credit Suisse\hostel
:*:~\::c:\data\home\
:*:``\::c:\data\home\
:*:``temp::c:\users\hrenkert\temp
:*:~desktop::M:\Desktop\
:*:``desktop::M:\Desktop\
:*:~hostel::M:\hostel\
:*:``hostel::M:\hostel\
:*:~ma::c:\data\home\code\myaaps\
:*:``ma::c:\data\home\code\myaaps\
:*:~ab::c:\data\home\code\AppBox\
:*:``ab::c:\data\home\code\AppBox\
:*:app05::24071CS0Application05
:*:apphsr::24071CS0ApplicationHSR
:*:appd1::24071CS0ApplicationD1HR

; Manners --------------------------

:*c:ttyl::Talk to you later
:*c:ttyt::Talk to you then
:*c:ttyT::Talk to you tomorow
::ty::Thank you
::yw::You're welcome

; Symbol Shortcuts ###############################################

:*:~~=::≈
:*:``=::≈
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

; Guid =====================

:*:\guid::
 send_guid() {
	TypeLib := ComObjCreate("Scriptlet.TypeLib")
	NewGUID := TypeLib.Guid
    send, {text}%NewGUID%
}


#Include, %A_ScriptDir%\Utilities.ahk
