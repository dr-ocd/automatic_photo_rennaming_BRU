#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, Force

;code by dr-ocd on the 05/08/2021

bulkRenameUtilityExePath = "C:\Program Files\Bulk Rename Utility\Bulk Rename Utility.exe" ; Very Important that this is set the the location of the Bulk Rename Utility exe file!!!

^Esc:: ;fail-safe, Ctrl+Esc will terminate the script
Msgbox,,Auto BRU, BRU Auto Rename script terminated.
Exitapp

^!r:: ;Ctrl + Alt + R to start
keyWait, Control ;waits for user to releases keys, so it doesn't mess things up later
keyWait, Alt
keyWait, r
try {
	run, %bulkRenameUtilityExePath% ;runs Bulk Rename Utility
}
winWaitActive, ahk_exe Bulk Rename Utility.exe,, 3 ;waits for the Bulk Rename Utility to be the active window
if (ErrorLevel == 1) {
	msgBox,,Auto BRU - Error Running Bulk Rename Utility, You may have entered the wrong path to the Bulk Rename Utility.`nThis is what it is currently set to:`n%bulkRenameUtilityExePath%
} else {
	autoBRU()
}
return

autoBRU() {
	inputBox, orginal_name, Auto Rename, Enter the orginal name...`n`nThis is case sensitive, , 300, 180 ;opens input box for user to enter the orginal file name eg. if the file was originally called IMG_0042.JPG the user would type IMG
	if (ErrorLevel == 1) {
		send, !{F4}
		return
	}
	inputBox, target_name, Auto Rename, Enter the target name...`n`nThis is case sensitive, , 300, 180 ;;opens input box for user to enter the processed file name eg. if the user wants the file to be CAN_0042.JPG type CAN
	if (ErrorLevel == 1) {
		send, !{F4}
		return
	}
	inputBox, photo_loaction, Auto Rename, Where are the photos Located?`neg. C:\Users\YOUR-USERNAME\Pictures, , 300, 180
	if (ErrorLevel == 1) {
		send, !{F4}
		return
	}
	loop, 3 {
		send, +`t
	}
	send, %photo_loaction%`n ;sets the target folder
	loop, 10 {
		send, `t
	}
	send, %orginal_name%`t%target_name% ;replaces the defult filename with whatever was inputed
	loop, 31 {
		send, `t
	}
	send, s`tm`t`t_`t- ;sets the date mode to when it was modifided and the seperator to "_" and segmentation to "-"
	Exitapp
}