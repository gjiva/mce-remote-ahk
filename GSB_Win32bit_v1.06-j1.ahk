;Ctrl-Alt-Enter is the shortcut for greenbutton on the MCE Remote for Win32bit
^!Enter::
    SetTimer, ChangeButtonNames, 50 ;Timer that changes the button names
    MsgBox, 3, Home Theater, What do you want to watch?
    IfMsgBox, Yes
    {
        ;Run Plex
	IfWinNotExist Plex Home Theater.exe ;If Plex is shutdown
		Run C:\Program Files (x86)\Plex Home Theater\Plex Home Theater.exe ;Start XBMC
		WinWait,Plex Home Theater,,8 ;wait for 8 seconds for Plex to launch "increase the time if the script times out on your system"
		If ErrorLevel ;Display an error if Plex does not load in time.
		{
		    MsgBox, Plex Startup timed out.
		    return
		}
	WinActivate ;Activate and Refocus Plex.
	WinShow ;Bring Plex to front.
	WinGet, Style, Style, ahk_class Plex Home Theater
	if (Style & 0xC00000)  ;Detects if Plex has a title bar.
	{
	    Send {VKDC}  ;Maximize Plex to fullscreen mode if its in a window mode.
	}
	Return


		SetTitleMatchMode 2
		#IfWinActive Plex Home Theater ahk_class Plex Home Theater; Plex detection for Plex/GSB Home Screen action.
		#!Enter::
		WinGet, Style, Style, ahk_class Plex
		if (Style & 0xC00000)  ;Detects if Plex has a title bar.
		{
    			Send {VKDC}  ;Maximize Plex to fullscreen mode if its in a window mode.
		}
		WinMaximize ;Maximize Plex if Windowed.
		send, ^!{VK74} ; if Plex is Active (GSB Home Jump will activate)
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
    IfMsgBox, No
    {
        ;Start WMC in Recorded TV
        Run %windir%\ehome\ehshell.exe /nostartupanimation /directmedia:tv
        return
    }
    else IfMsgBox, Cancel
    {
        ;Start WMC in the TV Guide
        Run %windir%\ehome\ehshell.exe /nostartupanimation /mcesuperbar://guide
        ;Or straight into Live TV
        ;Run %windir%\ehome\ehshell.exe "/mcesuperbar://tv?live=true"
        return
    }

ChangeButtonNames: 
IfWinNotExist, Home Theater
    return  ; Keep waiting.
SetTimer, ChangeButtonNames, off 
WinActivate 
ControlSetText, Button1, &Plex 
ControlSetText, Button2, &Recorded TV 
ControlSetText, Button3, &Live TV Guide
return

#IfWinActive, Windows Media Center
; fixes for MCE remote to pass the right hotkeys
c::Send ^g ;c is the guide button on the MCE remote and ctrl-g is the guide hotkey
^!Enter::WinClose  ;make green button turn MCE off
#IfWinActive

#IfWinActive, Plex Home Theater
; fixes for MCE remote to pass the right hotkeys
^l::Send \  ; backslash toggles full screen in Plex and XBMC and the green button has been mapped to ctrl-l 
^y::Send c  ; c is the context button in Plex and XBMC
^!Enter::WinClose  ;make green button turn MCE off
#IfWinActive
