; AutoHotkey Version: 1.x
; Language:	English
; Platform:	WindowsXP/Vista/7/8/8.1/10
; Author:	 MPagel	
; Website:	http://www.github.com/MPagel/vue-to-cftc/<scriptName>.ahk
;
; Script Purpose: Maximize VUE window labelled "Edit and Import VRL Files"

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir% 							; Ensures a consistent starting directory.

; ;;;;;;;;;;;;;;;;;;
; fill a bunch of variables with the size of the available desktop minus the systray/taskbar. Fills _Left _Right _Top _Bottom
; ;;;;;;;;;;;;;;;;;;
SysGet, _ , MonitorWorkArea 							; Grabs the size of the primary display - not sure how this script will react if you use VUE on a secondary monitor. see waw and wah

; ;;;;;;;;;;;;;;;;;;
; find current window height/width
; ;;;;;;;;;;;;;;;;;;
DetectHiddenWindows, On								; this subwindow of VUE isn't docked with the taskbar or systray, so we won't find it unless we detectHidden
SetWinDelay, 10									; don't wait too long (10ms) after screen refresh to start moving things around
WinActivate, Edit and Import VRL Files						; Make "A" refer to the desired window
WinWaitActive, Edit and Import VRL Files , , 5					; should be active by the time WinDelay expires...but just in case, wait for 5 more seconds
IfWinActive, Edit and Import VRL Files						; otherwise the window doesn't exist or something else is on top
{					
	WinGetPos, x0, , w0, , A						; we care about the left side and the width
; ;;;;;;;;;;;;;;;;;;
; set some fixed values. Note these may be only valid for my desktop mode, so if VUE explicitly sets font sizes or if they need to be grabbed from Windows classes, these need to be modified to lookups
; ;;;;;;;;;;;;;;;;;;
	titleBarSize := 26
	fontSize := 12
	vertSpacer := 16
	lineHeight := 21
	windowBorder := 3
	horizSpacer := 10								; box indentation on the side
	buttonHeight := 26								; verify size. may be off by 1 or two, but with minButtonPadding this seems to work
	minButtonPadding := 4								; default padding around top and bottom of each button. This is a minimum (minus object border).

; ;;;;;;;;;;;;;;;;;;
; 2nd order calculated values
; ;;;;;;;;;;;;;;;;;;
	waw := w0									; we'd rather just keep the width the same as VUE's default
	wah := _Bottom - _Top - titleBarSize 						; window height: ...subtract windowBorder too?
	box1VStart := titleBarSize + vertSpacer - fontSize // 2				; or 36 on my screen
	filelistVStart := titleBarSize + vertSpacer * 2 				; or 60 ; or box1VStart + 24
	importCancel := buttonHeight + minButtonPadding * 2 				; size reserved for import and cancel buttons
	box2Height := 6 * lineHeight 							; approximate size of "When importing VRL data set that already exists" prompt box, might need to be a multiple of fontsize
	box1Height := wah - box2Height - box1VStart - importCancel - windowBorder	; use the rest of the screen for the filelist + autocorrect/help/reset buttons
	filelistHeightMax := box1Height + box1Vstart - filelistVStart - buttonHeight - minButtonPadding * 2

; ;;;;;;;;;;;;;;;;;;
; In this next section, we trim the size of the file listing box to allow only whole lines to display.
; ;;;;;;;;;;;;;;;;;;
	filelistLines := filelistHeightMax // lineHeight			; // 2 if you want to force pairing of .vrl with matching _edited.vrl
	filelistHeight := filelistLines * lineHeight + 2			; * 2 on left side if paired
	buttonPadding2 := box1Height + box1VStart - filelistVStart - filelistHeight - buttonHeight
	buttonPadding := buttonPadding2 // 2					; recenter vertically
	rightAlnDetails := waw - 97						; could look up right boundary of TAdvStringGrid1 (Xg+Wg=Rg) after its control move as well as size (Wb) of TButton1. then rightAlnDetails := Rg-Wb
	box3VStart := box1VStart + box1Height + vertSpacer + box2Height + 1	; box3 = import/cancel
	box3VEnd := wah + titleBarSize - windowBorder
	box3Pad2 := box3VEnd - box3VStart - buttonHeight
	box3Pad := box3Pad2 // 2						; recenter vertically

; MsgBox, %filelistHeightMax% %filelistHeight% %buttonPadding2% %box1Height% %box1VStart% %filelistVStart%		; debug use: display some of the above

; ;;;;;;;;;;;;;;;;;;
; Actually move stuff around
; ;;;;;;;;;;;;;;;;;;
	WinMove, A, , x0, _Top, waw, wah + titleBarSize			 ; use VUE width
	SetControlDelay, 0							; once one object moved, immediately go to the next one, as none of them should be dependant on relative positions anymore
	SetWinDelay, 1								; really don't wait long at all
	ControlMove, TGroupBox1, windowBorder + horizSpacer, box1VStart, , box1Height, A				; box1 is 975 in height on my monitor.
	ControlMove, TAdvStringGrid1, horizSpacer * 2 + windowBorder, filelistVStart, , filelistHeight, A		; file list box 
	ControlMove, TButton4, horizSpacer * 2 + windowBorder, filelistHeight + filelistVStart + buttonPadding , , , A	; Details button
	ControlMove, TButton3, , filelistHeight + filelistVStart + buttonPadding , , , A				; Auto Correct
	ControlMove, TButton2, , filelistHeight + filelistVStart + buttonPadding , , , A 				; Reset
	ControlMove, TButton1, rightAlnDetails, filelistHeight + filelistVStart + buttonPadding, , , A 			; Help
	ControlMove, TGroupBox2, windowBorder + horizSpacer, box1VStart + box1Height + vertSpacer, , box2Height, A	; "when importing a VRL data set that already exists in the database" box
	ControlMove, TPanel1, , box1VStart + box1Height + vertSpacer + box2Height + 1 + box3Pad,	, importCancel , A	; Import and Cancel buttonsSee below ExitApp for more details.
	ControlMove, TPanel2, , , , lineHeight * 4 + lineHeight // 2, A 	; 4.5 * LH... may be 5 * fontSize instead
	WinSet, Redraw								; make sure these changes display
	SetControlDelay, 0							; default is 20, but using that seems to cause a lag in button response? should be resolved once this app exits
	SetWinDelay, 0								; default is 100
}
ExitApp

; ;;;;;;;;;;;;;;;;;;
; END CODE
; ;;;;;;;;;;;;;;;;;;
