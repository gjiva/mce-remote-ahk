;Win-Alt-Enter is the shortcut for greenbutton on the MCE Remote for Win32bit
#!Enter::
    SetTimer, ChangeButtonNames, 50 ;Timer that changes the button names
    MsgBox, 4, Home Theater, What do you want to watch?
    IfMsgBox, NO
    {
        ;Run MCE Live TV
        Run %windir%\ehome\ehshell.exe "/mcesuperbar://tv?live=true"
        return
    }
    else
    {
        ;Run XBMC
	IfWinNotExist XBMC.exe ;If XBMC is shutdown
		Run C:\Program Files\XBMC\XBMC.exe ;Start XBMC
		WinWait,XBMC,,8 ;wait for 8 seconds for XBMC to launch "increase the time if the script times out on your system"
		If ErrorLevel ;Display an error if XBMC does not load in time.
		{
		    MsgBox, XBMC Startup timed out.
		    return
		}
	WinActivate ;Activate and Refocus XBMC.
	WinShow ;Bring XBMC to front.
	WinGet, Style, Style, ahk_class XBMC
	if (Style & 0xC00000)  ;Detects if XBMC has a title bar.
	{
	    Send {VKDC}  ;Maximize XBMC to fullscreen mode if its in a window mode.
	}
	Return


		SetTitleMatchMode 2
		#IfWinActive XBMC ahk_class XBMC ; XBMC detection for XBMC/GSB Home Screen action.
		#!Enter::
		WinGet, Style, Style, ahk_class XBMC
		if (Style & 0xC00000)  ;Detects if XBMC has a title bar.
		{
    			Send {VKDC}  ;Maximize XBMC to fullscreen mode if its in a window mode.
		}
		WinMaximize ;Maximize XBMC if Windowed.
		send, ^!{VK74} ; if XBMC is Active (GSB Home Jump will activate)
		Return
		#IfWinActive ;


;Swap/Extend/activate & disable 2nd monitors script.
;Can be used by mapping one of your Remote buttons to [Control+F11] without the brackets. 
^VK7A::
	if toggle := !toggle
   		run % "displayswitch /" "extend"
		else
   		run % "displayswitch /" "external"
	
			return
    }

ChangeButtonNames: 
IfWinNotExist, Home Theater
    return  ; Keep waiting.
SetTimer, ChangeButtonNames, off 
WinActivate 
ControlSetText, Button1, &Videos 
ControlSetText, Button2, &LiveTV 
return

#IfWinActive, Windows Media Center
; fixes for MCE remote to pass the right hotkeys
s::WinClose  ; s is the power button on the MCE remote
c::Send ^g ;c is the guide button on the MCE remote and ctrl-g is the guide hotkey
#!Enter::Send !{Enter}  ;make green button toggle full screen
#IfWinActive
