#SingleInstance force
#Include Class_GuiControlTips.ahk
#Include Anchor64.ahk
#Include ping4.ahk

version = 2017.03.11.1718_GEC

company = GEC

if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}
OnExit, ExitSub
RemDriveLetter = D
LocDriveLetter = D

IfWinActive, Program Manager
	WinMinimizeAllUndo
Else
{
	WinMinimizeAll
	WinActivate, Program Manager
}

GuiControlGet, LocDriveLetter
menu, FileMenu, add, File Selection, FSM
SelectedFileMain = %LocDriveLetter%:\%company%Tech\servers.txt
menu, FileMenu, add, Exit, ExitSub
menu, DangerZone, add, &Reboot Servers, REBOOT
menu, DangerZone, add, Stop/&Disable NICE Services, STOPALL
menu, DangerZone, add, Start/&Auto NICE Services, STARTALL
menu, DEPTOEmain, add, Disable DEP/TOE, DisableDEPTOE
menu, DEPTOEmain, add, Audit DEP, AuditDEPTOE
menu, HelpMenu, add, About, About
menu, MyMenuBar, Add, &File, :FileMenu
menu, MyMenuBar, Add, &DangerZone, :DangerZone
menu, MyMenuBar, Add, D&EP/TOE, :DEPTOEmain
menu, MyMenuBar, Add, &Help, :HelpMenu
gui, menu, MyMenuBar
Menu, Tray, Tip, CommandLoop

gui, font, s8, MS Shell Dlg
gui, add, Text, w300 h100 r1 vFile, %SelectedFileMain%
gui, add, edit, w300 h100 r1 vCommand
gui, add, button, hwndhbuttonrun gRUN, &Run
gui, add, button, hwndhbuttonlogoff gLOGOFF, &Logoff Servers
gui, add, button, hwndhbuttonnp gNP++, &Install NP++
gui, add, button, hwndhbutton7z g7z, Install 7&zip
gui, add, button, hwndhbuttonscc gscc, SCC Binding
gui, add, button, hwndhbuttonrdp grdp, RDP Man Setup
gui, add, button, x105 y52 hwndhbuttonpulog gLogoffLink, Push Logoff Link
;gui, add, button, x105 y52 hwndhbuttonfunc gFUNCTEST, &Push FuncTest Shortcut
gui, add, button, hwndhbuttonpunice gPushNiceTech, Push %company%Tech Folder
gui, add, button, hwndhbuttonserv gPushConfigMgr, Push NICE ServiceMgr
gui, add, button, hwndhbuttonsecpol gSecPol, Security Policies
gui, add, button, hwndhbuttonaddrolefeat gAddRoleFeat, Add Roles/Features
gui, add, button, hwndhbuttonperfcount gPerfCount, Reset PerfMon
gui, add, button, x240 y110 hwndhbuttonreg gRegistryChange, Update Registry
gui, add, button, hwndhbuttonregback gRegBackup, Backup Registry
gui, add, button, hwndhbuttonlogs gPushLogShortcut, Logs Shortcut
gui, add, DropDownList, x240 y52 w35 hwndhddlremotedriveletter vRemDriveLetter, D||E|F|G|H
gui, add, DropDownList, x280 y52 w35 hwndhddllocaldriveletter vLocDriveLetter gLocDrive, D||E|F|G|H
gui, add, checkbox, checked x240 y82 vMyCheckBox, Close CMD?

;Populate the TT's
AnytimeTipTxt := "Anytime"
AfterNDMTipTxt := "After NDM"
BeforeSRTTipTxt := "Before SRT"
RemoteDriveLetterTipTxt := "Remote install drive letter"
LocalDriveLetterTipTxt := "Local (Sentinel) install drive letter"
; Create a ToolTip control
TT := New GuiControlTips(HGUI)
; Set initial delay to .5 seconds (500 ms) and the pop-up duration to 10 seconds
TT.SetDelayTimes(500, 10000, -1)
; Attach the controls
TT.Attach(HButtonrun, AnytimeTipTxt)
TT.Update(HButtonrun, AnytimeTipTxt)
TT.Attach(HButtonlogoff, AnytimeTipTxt)
TT.Update(HButtonlogoff, AnytimeTipTxt)
TT.Attach(HButtonnp, AnytimeTipTxt)
TT.Update(HButtonnp, AnytimeTipTxt)
TT.Attach(HButton7z, AnytimeTipTxt)
TT.Update(HButton7z, AnytimeTipTxt)
TT.Attach(HButtonpulog, AnytimeTipTxt)
TT.Update(HButtonpulog, AnytimeTipTxt)
TT.Attach(HButtonpunice, BeforeSRTTipTxt)
TT.Update(HButtonpunice, BeforeSRTTipTxt)
TT.Attach(HButtonserv, AfterNDMTipTxt)
TT.Update(HButtonserv, AfterNDMTipTxt)
TT.Attach(HButtonsecpol, BeforeSRTTipTxt)
TT.Update(HButtonsecpol, BeforeSRTTipTxt)
TT.Attach(HButtonreg, AnytimeTipTxt)
TT.Update(HButtonreg, AnytimeTipTxt)
TT.Attach(HButtonlogs, AfterNDMTipTxt)
TT.Update(HButtonlogs, AfterNDMTipTxt)
TT.Attach(HButtonscc, AfterNDMTipTxt)
TT.Update(HButtonscc, AfterNDMTipTxt)
TT.Attach(HButtonaddrolefeat, BeforeSRTTipTxt)
TT.Update(HButtonaddrolefeat, BeforeSRTTipTxt)
TT.Attach(HButtonregback, AnytimeTipTxt)
TT.Update(HButtonregback, AnytimeTipTxt)
TT.Attach(HButtonrdp, AnytimeTipTxt)
TT.Update(HButtonrdp, AnytimeTipTxt)
TT.Attach(HButtonperfcount, AfterNDMTipTxt)
TT.Update(HButtonperfcount, AfterNDMTipTxt)
TT.Attach(HDdlRemoteDriveLetter, RemoteDriveLetterTipTxt)
TT.Update(HDdlRemoteDriveLetter, RemoteDriveLetterTipTxt)
TT.Attach(HDdlLocalDriveLetter, LocalDriveLetterTipTxt)
TT.Update(HDdlLocalDriveLetter, LocalDriveLetterTipTxt)

gui, show,, Command Loop
Return

LocDrive:
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
SelectedFileMain = %LocDriveLetter%:\%company%Tech\servers.txt
guicontrol, , File, %SelectedFileMain%
Return

RUN:
gui, submit
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
ErrRunServers = 
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
Loop, read, %SelectedFileMain%
{
	Gui,Loading:Destroy
	Gui, Loading:-Caption
	Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
	Gui, Loading:Add, Text,, Pinging %A_LoopReadLine%...
	Gui, Hide
	Gui, Loading:Show
	RTT := Ping4(A_LoopReadLine, PingResult)
	If ErrorLevel
	{
		ErrRunServers := ErrRunServers . "`n" . A_LoopReadLine
		Gui, Loading:Destroy
		continue
	}
	Gui, Loading:Destroy
	IfNotExist %LocDriveLetter%:\%company%Tech\Tools\PsTools\psexec.exe
	{
		If (MyCheckBox = 0)
			Run, %comspec% /k wmic /node:"%A_LoopReadLine%" process call create 'cmd.exe /k %command%'
		Else
		{
			Run, %comspec% /c wmic /node:"%A_LoopReadLine%" process call create 'cmd.exe /c %command%',, hide, pid
			Gui, Loading:-Caption
			Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
			Gui, Loading:Add, Text,, Running on %A_LoopReadLine%
			Gui, Hide
			Gui, Loading:Show
			ErrorLevel:=1
			While (ErrorLevel != 0)
			{
				Sleep, 20
				GuiControl,Loading:, lvl, 1
				Process, Exist, % pid
			}
			Gui,Loading:Destroy
		}
		Gui,Loading:Destroy
	}
	Else
	{
		If (MyCheckBox = 0)
			Run, %comspec% /k %LocDriveLetter%:\%company%Tech\Tools\PsTools\psexec.exe \\%A_LoopReadLine% %command%
		Else
		{
			Run, %comspec% /c %LocDriveLetter%:\%company%Tech\Tools\PsTools\psexec.exe \\%A_LoopReadLine% %command%,, hide, pid
			Gui, Loading:-Caption
			Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
			Gui, Loading:Add, Text,, Running on %A_LoopReadLine%
			Gui, Hide
			Gui, Loading:Show
			ErrorLevel:=1
			While (ErrorLevel != 0)
			{
				Sleep, 20
				GuiControl,Loading:, lvl, 1
				Process, Exist, % pid
			}
			Gui,Loading:Destroy
		}
		Gui,Loading:Destroy
	}
	Gui,Loading:Destroy
}
If ErrRunServers
{
	MsgBox,,Run Failures, Failed to ping: %ErrRunServers%
	MsgBox,,Run Command, Task Complete (With Failures).
}
Else
	MsgBox,,Run Command, Task Complete.
Gui, 1:Show
Return

LOGOFF:
gui, submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
ErrLogoffServers = 
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
Loop, read, %SelectedFileMain%
{
	If A_LoopReadLine = %A_ComputerName%
		continue
	Gui,Loading:Destroy
	Gui, Loading:-Caption
	Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
	Gui, Loading:Add, Text,, Pinging %A_LoopReadLine%...
	Gui, Hide
	Gui, Loading:Show
	RTT := Ping4(A_LoopReadLine, PingResult)
	If ErrorLevel
	{
		ErrLogoffServers := ErrLogoffServers . "`n" . A_LoopReadLine
		Gui, Loading:Destroy
		continue
	}
	Gui, Loading:Destroy
	If (MyCheckBox = 0)
	{
		Run, %comspec% /k wmic /node:"%A_LoopReadLine%" os where primary=true call win32shutdown 0
		Sleep, 300
		Run, %comspec% /k wmic /node:"%A_LoopReadLine%" os where primary=true call win32shutdown 0
	}
	Else
	{
		Run, %comspec% /c wmic /node:"%A_LoopReadLine%" os where primary=true call win32shutdown 0,, hide, pid
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, Logoff %A_LoopReadLine%
		Gui, Hide
		Gui, Loading:Show
		ErrorLevel:=1
		While (ErrorLevel != 0)
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			Process, Exist, % pid
		}
		Gui,Loading:Destroy
		;Sleep, 300
		;Run, %comspec% /c wmic /node:"%A_LoopReadLine%" os where primary=true call win32shutdown 0,, hide
	}
}
If ErrLogoffServers
{
	MsgBox,,Logoff Failures, Failed to ping: %ErrLogoffServers%
	MsgBox,,Logoff Servers, Task Complete (With Failures).
}
Else
	MsgBox,,Logoff Servers, Task Complete.
Gui, 1:Show
Return

REBOOT:
gui, submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
MsgBox,4,Reboot All, Are you sure?
IfMsgBox No
{
	Gui, 1:Show
	Return
}
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
ErrRebootServers =
Loop, read, %SelectedFileMain%
{
	If A_LoopReadLine = %A_ComputerName%
		continue
	Gui,Loading:Destroy
	Gui, Loading:-Caption
	Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
	Gui, Loading:Add, Text,, Pinging %A_LoopReadLine%...
	Gui, Hide
	Gui, Loading:Show
	RTT := Ping4(A_LoopReadLine, PingResult)
	If ErrorLevel
	{
		ErrRebootServers := ErrRebootServers . "`n" . A_LoopReadLine
		Gui, Loading:Destroy
		continue
	}
	Gui, Loading:Destroy
	If (MyCheckBox = 0)
	{
		Run, %comspec% /k wmic /node:"%A_LoopReadLine%" os where primary=true call win32shutdown 6
		Sleep, 300
		Run, %comspec% /k wmic /node:"%A_LoopReadLine%" os where primary=true call win32shutdown 6		
	}
	Else
	{
		Run, %comspec% /c wmic /node:"%A_LoopReadLine%" os where primary=true call win32shutdown 6,, hide, pid
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, Rebooting %A_LoopReadLine%
		Gui, Hide
		Gui, Loading:Show
		ErrorLevel:=1
		While (ErrorLevel != 0)
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			Process, Exist, % pid
		}
		Gui,Loading:Destroy
	}
}
If ErrRebootServers
{
	MsgBox,,Reboot Failures, Failed to ping: %ErrRebootServers%
	MsgBox,,Reboot Servers, Task Complete (With Failures).
}
Else
	MsgBox,,Reboot Servers, Task Complete.
Gui, 1:Show
Return

STOPALL:
gui, submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
MsgBox,4,Stop All NICE Services, Are you sure?
IfMsgBox No
	Return
IfNotExist %LocDriveLetter%:\%company%Tech\services.txt
	AppendServices()
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
ErrStopAll = 
Loop, read, %SelectedFileMain%
{
	line := A_LoopReadLine
	;If line = %A_ComputerName%
	;	continue
	Gui,Loading:Destroy
	Gui, Loading:-Caption
	Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
	Gui, Loading:Add, Text,, Pinging %A_LoopReadLine%...
	Gui, Hide
	Gui, Loading:Show
	RTT := Ping4(A_LoopReadLine, PingResult)
	If ErrorLevel
	{
		ErrStopAll := ErrStopAll . "`n" . A_LoopReadLine
		Gui, Loading:Destroy
		continue
	}
	Gui, Loading:Destroy
	If (MyCheckBox = 0)
	{
		Loop, read, %LocDriveLetter%:\%company%Tech\services.txt
		{
			IfExist %A_ScriptDir%\checksvc.txt
				FileDelete, %A_ScriptDir%\checksvc.txt
			RunWait, %comspec% /c sc \\%line% query %A_LoopReadLine% |findstr STATE > "%A_ScriptDir%\checksvc.txt",, hide
			FileGetSize, fsize, %A_ScriptDir%\checksvc.txt
			IfNotEqual, fsize, 0
				RunWait, %comspec% /k wmic /node:"%line%" process call create 'cmd.exe /k sc config %A_LoopReadLine% start= disabled'
			Else
				continue
		}
		Loop, read, %LocDriveLetter%:\%company%Tech\services.txt
		{
			IfExist %A_ScriptDir%\checksvc.txt
				FileDelete, %A_ScriptDir%\checksvc.txt
			RunWait, %comspec% /c sc \\%line% query %A_LoopReadLine% |findstr STATE > "%A_ScriptDir%\checksvc.txt",, hide
			FileGetSize, fsize, %A_ScriptDir%\checksvc.txt
			IfNotEqual, fsize, 0
				RunWait, %comspec% /k wmic /node:"%line%" process call create 'cmd.exe /k sc stop %A_LoopReadLine%'
			Else
				continue
		}
	}
	Else
	{
		Loop, read, %LocDriveLetter%:\%company%Tech\services.txt
		{
			IfExist %A_ScriptDir%\checksvc.txt
				FileDelete, %A_ScriptDir%\checksvc.txt
			RunWait, %comspec% /c sc \\%line% query %A_LoopReadLine% |findstr STATE > "%A_ScriptDir%\checksvc.txt",, hide
			FileGetSize, fsize, %A_ScriptDir%\checksvc.txt
			IfNotEqual, fsize, 0
			{
				Run, %comspec% /c wmic /node:"%line%" process call create 'cmd.exe /c sc config %A_LoopReadLine% start= disabled',, hide, pid
				Gui, Loading:-Caption
				Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
				Gui, Loading:Add, Text,, Disabling %A_LoopReadLine% on %line%
				Gui, Hide
				Gui, Loading:Show
				ErrorLevel:=1
				While (ErrorLevel != 0)
				{
					Sleep, 20
					GuiControl,Loading:, lvl, 1
					Process, Exist, % pid
				}
				Gui,Loading:Destroy
			}
			Else
				continue
		}
		Loop, read, %LocDriveLetter%:\%company%Tech\services.txt
		{
			IfExist %A_ScriptDir%\checksvc.txt
				FileDelete, %A_ScriptDir%\checksvc.txt
			RunWait, %comspec% /c sc \\%line% query %A_LoopReadLine% |findstr STATE > "%A_ScriptDir%\checksvc.txt",, hide
			FileGetSize, fsize, %A_ScriptDir%\checksvc.txt
			IfNotEqual, fsize, 0
			{
				Run, %comspec% /c wmic /node:"%line%" process call create 'cmd.exe /c sc stop %A_LoopReadLine%',, hide, pid
				Gui, Loading:-Caption
				Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
				Gui, Loading:Add, Text,, Stop %A_LoopReadLine% on %line%
				Gui, Hide
				Gui, Loading:Show
				ErrorLevel:=1
				While (ErrorLevel != 0)
				{
					Sleep, 20
					GuiControl,Loading:, lvl, 1
					Process, Exist, % pid
				}
				Gui,Loading:Destroy
			}
			Else
				continue
		}
	}
}
IfExist %A_ScriptDir%\checksvc.txt
	FileDelete, %A_ScriptDir%\checksvc.txt
If ErrStopAll
{
	MsgBox,,StopAll Failures, Failed to ping: %ErrStopAll%
	MsgBox,,StopAll Services, Task Complete (With Failures).
}
Else
	MsgBox,,StopAll Services, Task Complete.
Gui, 1:Show
Return

STARTALL:
gui, submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
MsgBox,4,Start all NICE Services, Are you sure?
IfMsgBox No
{
	Gui, 1:Show
	Return
}
IfNotExist %LocDriveLetter%:\%company%Tech\services.txt
	AppendServices()
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
ErrStartAll =
Loop, read, %SelectedFileMain%
{
	line := A_LoopReadLine
	If line = %A_ComputerName%
		continue
	Gui,Loading:Destroy
	Gui, Loading:-Caption
	Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
	Gui, Loading:Add, Text,, Pinging %A_LoopReadLine%...
	Gui, Hide
	Gui, Loading:Show
	RTT := Ping4(A_LoopReadLine, PingResult)
	If ErrorLevel
	{
		ErrStartAll := ErrStartAll . "`n" . A_LoopReadLine
		Gui, Loading:Destroy
		continue
	}
	Gui, Loading:Destroy
	If (MyCheckBox = 0)
	{
		Loop, read, %LocDriveLetter%:\%company%Tech\services.txt
		{
			IfExist %A_ScriptDir%\checksvc.txt
				FileDelete, %A_ScriptDir%\checksvc.txt
			RunWait, %comspec% /c sc \\%line% query %A_LoopReadLine% |findstr STATE > "%A_ScriptDir%\checksvc.txt",, hide
			FileGetSize, fsize, %A_ScriptDir%\checksvc.txt
			IfNotEqual, fsize, 0
				RunWait, %comspec% /k wmic /node:"%line%" process call create 'cmd.exe /k sc config %A_LoopReadLine% start= auto'
			Else
				continue
		}
		Loop, read, %LocDriveLetter%:\%company%Tech\services.txt
		{
			IfExist %A_ScriptDir%\checksvc.txt
				FileDelete, %A_ScriptDir%\checksvc.txt
			RunWait, %comspec% /c sc \\%line% query %A_LoopReadLine% |findstr STATE > "%A_ScriptDir%\checksvc.txt",, hide
			FileGetSize, fsize, %A_ScriptDir%\checksvc.txt
			IfNotEqual, fsize, 0
				RunWait, %comspec% /k wmic /node:"%line%" process call create 'cmd.exe /k sc start %A_LoopReadLine%'
			Else
				continue
		}
	}
	Else
	{
		Loop, read, %LocDriveLetter%:\%company%Tech\services.txt
		{
			IfExist %A_ScriptDir%\checksvc.txt
				FileDelete, %A_ScriptDir%\checksvc.txt
			RunWait, %comspec% /c sc \\%line% query %A_LoopReadLine% |findstr STATE > "%A_ScriptDir%\checksvc.txt",, hide
			FileGetSize, fsize, %A_ScriptDir%\checksvc.txt
			IfNotEqual, fsize, 0
			{
				Run, %comspec% /c wmic /node:"%line%" process call create 'cmd.exe /c sc config %A_LoopReadLine% start= auto',, hide, pid
				Gui, Loading:-Caption
				Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
				Gui, Loading:Add, Text,, Set %A_LoopReadLine% on %line% to auto
				Gui, Hide
				Gui, Loading:Show
				ErrorLevel:=1
				While (ErrorLevel != 0)
				{
					Sleep, 20
					GuiControl,Loading:, lvl, 1
					Process, Exist, % pid
				}
				Gui,Loading:Destroy
			}
			Else
				continue
		}
		Loop, read, %LocDriveLetter%:\%company%Tech\services.txt
		{
			IfExist %A_ScriptDir%\checksvc.txt
				FileDelete, %A_ScriptDir%\checksvc.txt
			RunWait, %comspec% /c sc \\%line% query %A_LoopReadLine% |findstr STATE > "%A_ScriptDir%\checksvc.txt",, hide
			FileGetSize, fsize, %A_ScriptDir%\checksvc.txt
			IfNotEqual, fsize, 0
			{
				Run, %comspec% /c wmic /node:"%line%" process call create 'cmd.exe /c sc start %A_LoopReadLine%',, hide, pid
				Gui, Loading:-Caption
				Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
				Gui, Loading:Add, Text,, Starting %A_LoopReadLine% on %line%
				Gui, Hide
				Gui, Loading:Show
				ErrorLevel:=1
				While (ErrorLevel != 0)
				{
					Sleep, 20
					GuiControl,Loading:, lvl, 1
					Process, Exist, % pid
				}
				Gui,Loading:Destroy
			}
			Else
				continue
		}
	}
}
IfExist %A_ScriptDir%\checksvc.txt
	FileDelete, %A_ScriptDir%\checksvc.txt
If ErrStopAll
{
	MsgBox,,StartAll Failures, Failed to ping: %ErrStartAll%
	MsgBox,,StartAll Services, Task Complete (With Failures).
}
Else
	MsgBox,,StartAll Services, Task Complete.
Gui, 1:Show
Return

DisableDEPTOE:
gui, submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
MsgBox,4,Disable DEP/TOE, Are you sure?
IfMsgBox No
	Return
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
Loop, read, %SelectedFileMain%
{
	If (MyCheckBox = 0)
	{
		Run, %comspec% /k wmic /node:"%A_LoopReadLine%" process call create 'cmd.exe /k bcdedit.exe /set {current} nx AlwaysOff'
		Run, %comspec% /k wmic /node:"%A_LoopReadLine%" process call create 'cmd.exe /k netsh int tcp set global chimney=disabled'
	}
	Else
	{
		Run, %comspec% /c wmic /node:"%A_LoopReadLine%" process call create 'cmd.exe /c bcdedit.exe /set {current} nx AlwaysOff',, hide, pid
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, Disable DEP on %A_LoopReadLine%
		Gui, Hide
		Gui, Loading:Show
		ErrorLevel:=1
		While (ErrorLevel != 0)
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			Process, Exist, % pid
		}
		Gui,Loading:Destroy
		Run, %comspec% /c wmic /node:"%A_LoopReadLine%" process call create 'cmd.exe /c netsh int tcp set global chimney=disabled',, hide, pid
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, Disable TCP Offload on %A_LoopReadLine%
		Gui, Hide
		Gui, Loading:Show
		ErrorLevel:=1
		While (ErrorLevel != 0)
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			Process, Exist, % pid
		}
		Gui,Loading:Destroy
	}
}
MsgBox,,Disable DEP/TOE, Task complete.
Gui, 1:Show
Return

AuditDEPTOE:
gui, submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
ErrDEPServers = 
IfExist %LocDriveLetter%:\%company%Tech\depstatus.txt
	FileDelete %LocDriveLetter%:\%company%Tech\depstatus.txt
FileAppend,
(
0 – AlwaysOff - DEP is disabled for all processes.
1 – AlwaysOn - DEP is enabled for all processes.
2 – OptIn - Only Windows system components and services have DEP applied. (Default)
3 – OptOut - DEP is enabled for all processes. Administrators can manually create a list of specific applications which do not have DEP applied


), %LocDriveLetter%:\%company%Tech\depstatus.txt
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
Loop, read, %SelectedFileMain%
{
	If (MyCheckBox = 0)
	{
		FileAppend, %A_LoopReadLine%`r`n, %LocDriveLetter%:\%company%Tech\depstatus.txt
		Run, %comspec% /k wmic /node:"%A_LoopReadLine%" OS Get DataExecutionPrevention_SupportPolicy > %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
		IfNotExist %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
			Sleep, 500
		IfNotExist %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
			Sleep, 1500
		IfNotExist %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
			Sleep, 1500
		FileGetSize, fsizedep, %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
		If fsizedep = 0
			Sleep, 500
		If fsizedep = 0
		{
			Sleep, 1500
			FileGetSize, fsizedep, %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
		}
		If fsizedep = 0
		{
			Sleep, 1500
			FileGetSize, fsizedep, %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
		}
		If fsizedep = 0
		{
			ErrDEPServers := ErrDEPServers . "`n" . A_LoopReadLine
			continue
		}
		FileRead, DEPs, %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
		if not ErrorLevel
			FileAppend, %DEPs%`r`n, %LocDriveLetter%:\%company%Tech\depstatus.txt
	}
	Else
	{
		FileAppend, %A_LoopReadLine%`r`n, %LocDriveLetter%:\%company%Tech\depstatus.txt
		Run, %comspec% /c wmic /node:"%A_LoopReadLine%" OS Get DataExecutionPrevention_SupportPolicy > %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt,, hide, pid
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, Audit DEP on %A_LoopReadLine%
		Gui, Hide
		Gui, Loading:Show
		ErrorLevel:=1
		While (ErrorLevel != 0)
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			Process, Exist, % pid
		}
		IfNotExist %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
			Sleep, 500
		IfNotExist %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
			Sleep, 1500
		IfNotExist %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
			Sleep, 1500
		FileGetSize, fsizedep, %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
		If fsizedep = 0
			Sleep, 500
		If fsizedep = 0
		{
			Sleep, 1500
			FileGetSize, fsizedep, %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
		}
		If fsizedep = 0
		{
			Sleep, 1500
			FileGetSize, fsizedep, %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
		}
		If fsizedep = 0
		{
			ErrDEPServers := ErrDEPServers . "`n" . A_LoopReadLine
			continue
		}
		FileRead, DEPs, %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
		If not ErrorLevel
			FileAppend, %DEPs%`r`n, %LocDriveLetter%:\%company%Tech\depstatus.txt
	}
	Sleep, 100
	FileDelete %LocDriveLetter%:\%company%Tech\depstatus_%A_LoopReadLine%.txt
	Gui,Loading:Destroy
}
MsgBox,,Audit DEP, Task Complete, look for %LocDriveLetter%:\%company%Tech\depstatus.txt
If ErrDEPServers
	MsgBox,,DEP Failures, Failed to pull DEP on: %ErrDEPServers%
Sleep, 100
FileDelete %LocDriveLetter%:\%company%Tech\depstatus_*.txt
Gui, 1:Show
Return

FSM:
Gui, Submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
FileSelectFile, SelectedFileMain, 3, %LocDriveLetter%:\%company%Tech\servers.txt, Open a file, Text Documents (*.txt)
if SelectedFileMain =
    MsgBox,,File Selection Main, The user didn't select anything.
GuiControl,, File, %SelectedFileMain%
Return

LoggerLoc:
gui, submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
MsgBox, 4, Logger Backup Location, Logger Backup is currently %logloc%.  Change?
	InputBox, logloc, New Logger Backup Location, Please enter a new logger backup location:
IfMsgBox Yes
	If ErrorLevel
		Return
Return

AddRoleFeat:
gui, submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
Loop, Read, %SelectedFileMain%
{
	If (MyCheckBox = 0)
	{
		Run powershell.exe -NoExit -Command Add-WindowsFeature -IncludeAllSubFeature SNMP-WMI-Provider`,NET-Framework-Core -ComputerName %A_LoopReadLine%,,, pid
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, SNMP/.NET for %A_LoopReadLine%
		Gui, Hide
		Gui, Loading:Show
		ErrorLevel:=1
		While (ErrorLevel != 0)
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			Process, Exist, % pid
		}
		Gui,Loading:Destroy
	}
	Else
	{
		Run powershell.exe -Command Add-WindowsFeature -IncludeAllSubFeature SNMP-WMI-Provider`,NET-Framework-Core -ComputerName %A_LoopReadLine%,,, pid
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, SNMP/.NET for %A_LoopReadLine%
		Gui, Hide
		Gui, Loading:Show
		ErrorLevel:=1
		While (ErrorLevel != 0)
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			Process, Exist, % pid
		}
		Gui,Loading:Destroy
	}
}
IISservers = 
Loop, Read, %SelectedFileMain%
	IISservers .= A_LoopReadLine "|"
Gui, IIS:+Resize -MaximizeBox -Caption
Gui, IIS:Add, Text, vIISText, Choose servers which need IIS:
Gui, IIS:Add, ListBox, vServerSelectionIIS 8 W130 H160, %IISservers%
Gui, IIS:Add, Button, vBtn gBtn, Finalize Selection
Gui, IIS:Show, W170 H220, IIS Servers
Return

Btn:
Gui, IIS:Submit
Gui, IIS:Destroy
IfNotExist %LocDriveLetter%:\%company%Tech\IISFeatures.txt
	FileAppend, Web-WebServer`,Web-Common-Http`,Web-Default-Doc`,Web-Dir-Browsing`,Web-Http-Errors`,Web-Static-Content`,Web-Http-Redirect`,Web-Health`,Web-Http-Logging`,Web-Log-Libraries`,Web-ODBC-Logging`,Web-Request-Monitor`,Web-Http-Tracing`,Web-Performance`,Web-Stat-Compression`,Web-Dyn-Compression`,Web-Security`,Web-Filtering`,Web-Basic-Auth`,Web-Client-Auth`,Web-Digest-Auth`,Web-Cert-Auth`,Web-IP-Security`,Web-Url-Auth`,Web-Windows-Auth`,Web-App-Dev`,Web-Net-Ext45`,Web-Asp-Net45`,Web-ISAPI-Ext`,Web-ISAPI-Filter`,SMTP-Server`,Web-Mgmt-Console`,Web-Mgmt-Compat`,Web-Metabase`,Web-Lgcy-Mgmt-Console`,Web-Lgcy-Scripting`,Web-WMI, %LocDriveLetter%:\%company%Tech\IISFeatures.txt
Loop, Read, %LocDriveLetter%:\%company%Tech\IISFeatures.txt
	IISFeatures = %A_LoopReadLine%
Loop, parse, ServerSelectionIIS, |
{
	If (MyCheckBox = 0)
	{	
		Run, powershell.exe -NoExit -Command Add-WindowsFeature %IISFeatures% -ComputerName %A_LoopField%,,, pid
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, IIS components on %A_LoopField%
		Gui, Hide
		Gui, Loading:Show
		ErrorLevel:=1
		While (ErrorLevel != 0)
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			Process, Exist, % pid
		}
		Gui,Loading:Destroy
	}
	Else
	{
		Run powershell.exe -Command Add-WindowsFeature %IISFeatures% -ComputerName %A_LoopField%,,, pid
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, IIS components on %A_LoopField%
		Gui, Hide
		Gui, Loading:Show
		ErrorLevel:=1
		While (ErrorLevel != 0)
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			Process, Exist, % pid
		}
		Gui,Loading:Destroy
	}
}
MsgBox,,Add Roles/Features, Task Complete.
Gui, 1:Show
Return

PerfCount:
Gui, Submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
DBservers = 
ErrDBServers = 
Loop, Read, %SelectedFileMain%
	DBservers .= A_LoopReadLine "|"
Gui, DB:+Resize -MaximizeBox -Caption
Gui, DB:Add, Text, vDBText, SQL nodes for counter reset:
Gui, DB:Add, ListBox, vServerSelectionDB 8 W130 H160, %DBservers%
Gui, DB:Add, Button, vDBBtn gDBbtn, Finalize Selection
Gui, DB:Show, W170 H220, DB Servers
Gui, 1:Hide
Return

DBbtn:
Gui, DB:Submit
Gui, DB:Destroy
If ServerSelectionDB =
{
	MsgBox,,Blank Host, Hostname cannot be blank!
	Gui, 1:Show
	Return
}
MsgBox, 3, SQL Restart, Restart SQL Services?
IfMsgBox Yes
	SQLRestart = 1
IfMsgBox No
	SQLRestart = 0
IfMsgBox Cancel
{
	Gui, 1:Show
	Return
}
Loop, parse, ServerSelectionDB, |
{
	IfNotExist \\%A_LoopField%\%RemDriveLetter%$\Program files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Binn\perf-MSSQLSERVERsqlctr.ini
	{	
		IfNotExist \\%A_LoopField%\%RemDriveLetter%$\Program files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Binn\perf-MSSQLSERVERsqlctr.ini
		{
			IfNotExist \\%A_LoopField%\%RemDriveLetter%$\Program files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Binn\perf-MSSQLSERVERsqlctr.ini
			{
				IfNotExist \\%A_LoopField%\%RemDriveLetter%$\Program files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\Binn\perf-MSSQLSERVERsqlctr.ini
				{
					MsgBox, 3, Defaults?, Are default instance name/paths used?  (Yes = failure for %A_LoopField%)
					IfMsgBox Yes
					{	
						ErrDBServers .= ErrDBServers . "`n" . A_LoopField
						continue
					}
					IfMsgBox No
						InputBox, dbpath, SQL Path, Enter SQL binary 'Binn' path (Ex D:\Program files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\Binn)
					IfMsgBox Cancel
						Return
				}
				Else
					dbpath = %RemDriveLetter%:\Program files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\Binn
			}
			Else
				dbpath = %RemDriveLetter%:\Program files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\Binn
		}
		Else
			dbpath = %RemDriveLetter%:\Program files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\Binn
	}
	Else
		dbpath = %RemDriveLetter%:\Program files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\Binn
	If (MyCheckBox = 0)
	{
		RunWait, %comspec% /k wmic /node:"%A_LoopField%" process call create 'cmd.exe /k unlodctr MSSQLSERVER'
		RunWait, %comspec% /k wmic /node:"%A_LoopField%" process call create 'cmd.exe /k lodctr "%dbpath%\perf-MSSQLSERVERsqlctr.ini"'
		RunWait, %comspec% /k wmic /node:"%A_LoopField%" process call create 'cmd.exe /k lodctr /R'
		If SQLRestart
		{
			RunWait, %comspec% /k wmic /node:"%A_LoopField%" process call create 'cmd.exe /k sc config MSSQLSERVER start= disabled'
			RunWait, %comspec% /k wmic /node:"%A_LoopField%" process call create 'cmd.exe /k sc config SQLSERVERAGENT start= disabled'
			Sleep, 500
			RunWait, %comspec% /k wmic /node:"%A_LoopField%" process call create 'cmd.exe /k sc stop SQLSERVERAGENT'
			RunWait, %comspec% /k wmic /node:"%A_LoopField%" process call create 'cmd.exe /k sc stop MSSQLSERVER'
			IfExist %A_ScriptDir%\sqlstatus.txt
				FileDelete %A_ScriptDir%\sqlstatus.txt
			IfExist %A_ScriptDir%\sqlresult.txt
				FileDelete %A_ScriptDir%\sqlresult.txt
			RunWait, %comspec% /c tasklist /s %A_LoopField% /fi "imagename eq sqlservr.exe" > "%A_ScriptDir%\sqlstatus.txt",, hide
			RunWait, %comspec% /c find /i "PID" < "%A_ScriptDir%\sqlstatus.txt" > "%A_ScriptDir%\sqlresult.txt",, hide
			FileGetSize, fsize, %A_ScriptDir%\sqlresult.txt
			Gui, Loading:-Caption
			Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
			Gui, Loading:Add, Text,, Waiting for SQL to stop on %A_LoopField%
			Gui, Hide
			Gui, Loading:Show
			While fsize <> 0
			{
				Sleep, 20
				GuiControl,Loading:, lvl, 1
				RunWait, %comspec% /c tasklist /s %A_LoopField% /fi "imagename eq sqlservr.exe" > "%A_ScriptDir%\sqlstatus.txt",, hide
				RunWait, %comspec% /c find /i "PID" < "%A_ScriptDir%\sqlstatus.txt" > "%A_ScriptDir%\sqlresult.txt",, hide
				FileGetSize, fsize, %A_ScriptDir%\sqlresult.txt
			}
			Gui,Loading:Destroy
			RunWait, %comspec% /k wmic /node:"%A_LoopField%" process call create 'cmd.exe /k sc config MSSQLSERVER start= auto'
			RunWait, %comspec% /k wmic /node:"%A_LoopField%" process call create 'cmd.exe /k sc config SQLSERVERAGENT start= auto'
			RunWait, %comspec% /k wmic /node:"%A_LoopField%" process call create 'cmd.exe /k sc start SQLSERVERAGENT'
		}
	}
	Else
	{
		RunWait, %comspec% /c wmic /node:"%A_LoopField%" process call create 'cmd.exe /c unlodctr MSSQLSERVER',, hide
		IfExist %A_ScriptDir%\sqlstatus.txt
			FileDelete %A_ScriptDir%\sqlstatus.txt
		IfExist %A_ScriptDir%\sqlresult.txt
			FileDelete %A_ScriptDir%\sqlresult.txt
		RunWait, %comspec% /c tasklist /s %A_LoopField% /fi "imagename eq unlodctr.exe" > "%A_ScriptDir%\sqlstatus.txt",, hide
		RunWait, %comspec% /c find /i "PID" < "%A_ScriptDir%\sqlstatus.txt" > "%A_ScriptDir%\sqlresult.txt",, hide
		FileGetSize, fsize, %A_ScriptDir%\sqlresult.txt
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, unlodctr on %A_LoopField%
		Gui, Hide
		Gui, Loading:Show
		Sleep, 20
		While fsize <> 0
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			RunWait, %comspec% /c tasklist /s %A_LoopField% /fi "imagename eq unlodctr.exe" > "%A_ScriptDir%\sqlstatus.txt",, hide
			RunWait, %comspec% /c find /i "PID" < "%A_ScriptDir%\sqlstatus.txt" > "%A_ScriptDir%\sqlresult.txt",, hide
			FileGetSize, fsize, %A_ScriptDir%\sqlresult.txt
		}
		Gui,Loading:Destroy
		RunWait, %comspec% /c wmic /node:"%A_LoopField%" process call create 'cmd.exe /c lodctr "%dbpath%\perf-MSSQLSERVERsqlctr.ini"',, hide
		IfExist %A_ScriptDir%\sqlstatus.txt
			FileDelete %A_ScriptDir%\sqlstatus.txt
		IfExist %A_ScriptDir%\sqlresult.txt
			FileDelete %A_ScriptDir%\sqlresult.txt
		RunWait, %comspec% /c tasklist /s %A_LoopField% /fi "imagename eq lodctr.exe" > "%A_ScriptDir%\sqlstatus.txt",, hide
		RunWait, %comspec% /c find /i "PID" < "%A_ScriptDir%\sqlstatus.txt" > "%A_ScriptDir%\sqlresult.txt",, hide
		FileGetSize, fsize, %A_ScriptDir%\sqlresult.txt
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, lodctr ini on %A_LoopField%
		Gui, Hide
		Gui, Loading:Show
		While fsize <> 0
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			RunWait, %comspec% /c tasklist /s %A_LoopField% /fi "imagename eq lodctr.exe" > "%A_ScriptDir%\sqlstatus.txt",, hide
			RunWait, %comspec% /c find /i "PID" < "%A_ScriptDir%\sqlstatus.txt" > "%A_ScriptDir%\sqlresult.txt",, hide
			FileGetSize, fsize, %A_ScriptDir%\sqlresult.txt
		}
		Gui,Loading:Destroy
		RunWait, %comspec% /c wmic /node:"%A_LoopField%" process call create 'cmd.exe /c lodctr /R',, hide
		IfExist %A_ScriptDir%\sqlstatus.txt
			FileDelete %A_ScriptDir%\sqlstatus.txt
		IfExist %A_ScriptDir%\sqlresult.txt
			FileDelete %A_ScriptDir%\sqlresult.txt
		RunWait, %comspec% /c tasklist /s %A_LoopField% /fi "imagename eq lodctr.exe" > "%A_ScriptDir%\sqlstatus.txt",, hide
		RunWait, %comspec% /c find /i "PID" < "%A_ScriptDir%\sqlstatus.txt" > "%A_ScriptDir%\sqlresult.txt",, hide
		FileGetSize, fsize, %A_ScriptDir%\sqlresult.txt
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, lodctr /R on %A_LoopField%
		Gui, Hide
		Gui, Loading:Show
		While fsize <> 0
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			RunWait, %comspec% /c tasklist /s %A_LoopField% /fi "imagename eq lodctr.exe" > "%A_ScriptDir%\sqlstatus.txt",, hide
			RunWait, %comspec% /c find /i "PID" < "%A_ScriptDir%\sqlstatus.txt" > "%A_ScriptDir%\sqlresult.txt",, hide
			FileGetSize, fsize, %A_ScriptDir%\sqlresult.txt
		}
		Gui,Loading:Destroy
		If SQLRestart
		{
			RunWait, %comspec% /c wmic /node:"%A_LoopField%" process call create 'cmd.exe /k sc config MSSQLSERVER start= disabled',, hide
			RunWait, %comspec% /c wmic /node:"%A_LoopField%" process call create 'cmd.exe /k sc config SQLSERVERAGENT start= disabled',, hide
			Sleep, 500
			RunWait, %comspec% /c wmic /node:"%A_LoopField%" process call create 'cmd.exe /k sc stop MSSQLSERVER',, hide
			RunWait, %comspec% /c wmic /node:"%A_LoopField%" process call create 'cmd.exe /k sc stop SQLSERVERAGENT',, hide
			IfExist %A_ScriptDir%\sqlstatus.txt
				FileDelete %A_ScriptDir%\sqlstatus.txt
			IfExist %A_ScriptDir%\sqlresult.txt
				FileDelete %A_ScriptDir%\sqlresult.txt
			RunWait, %comspec% /c tasklist /s %A_LoopField% /fi "imagename eq sqlservr.exe" > "%A_ScriptDir%\sqlstatus.txt",, hide
			RunWait, %comspec% /c find /i "PID" < "%A_ScriptDir%\sqlstatus.txt" > "%A_ScriptDir%\sqlresult.txt",, hide
			FileGetSize, fsize, %A_ScriptDir%\sqlresult.txt
			Gui, Loading:-Caption
			Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
			Gui, Loading:Add, Text,, Waiting for SQL to stop on %A_LoopField%
			Gui, Hide
			Gui, Loading:Show
			While fsize <> 0
			{
				Sleep, 20
				GuiControl,Loading:, lvl, 1
				RunWait, %comspec% /c tasklist /s %A_LoopField% /fi "imagename eq sqlservr.exe" > "%A_ScriptDir%\sqlstatus.txt",, hide
				RunWait, %comspec% /c find /i "PID" < "%A_ScriptDir%\sqlstatus.txt" > "%A_ScriptDir%\sqlresult.txt",, hide
				FileGetSize, fsize, %A_ScriptDir%\sqlresult.txt
			}
			Gui,Loading:Destroy
			RunWait, %comspec% /c wmic /node:"%A_LoopField%" process call create 'cmd.exe /k sc config MSSQLSERVER start= auto',, hide
			RunWait, %comspec% /c wmic /node:"%A_LoopField%" process call create 'cmd.exe /k sc config SQLSERVERAGENT start= auto',, hide
			RunWait, %comspec% /c wmic /node:"%A_LoopField%" process call create 'cmd.exe /k sc start SQLSERVERAGENT',, hide
		}
	}
}
If ErrDBServers
	MsgBox,,SQL Missing, SQL PerfMon ini missing on: %ErrDBServers%
IfExist %A_ScriptDir%\sqlresult.txt
	FileDelete %A_ScriptDir%\sqlresult.txt
IfExist %A_ScriptDir%\sqlstatus.txt
	FileDelete %A_ScriptDir%\sqlstatus.txt
MsgBox,,Reset PerfMon, Task Complete.
Gui, 1:Show
Return

NP++:
gui, Submit, nohide
ErrNPServers =
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
IfNotExist %LocDriveLetter%:\%company%Tech\Tools\npp*Installer.exe
{
	MsgBox,,NP++ Install, Please put Notepad++ installer in %LocDriveLetter%:\%company%Tech\Tools and push to remote nodes
	Return
}
Loop, %LocDriveLetter%:\%company%Tech\Tools\npp*Installer.exe
{
	nppver = %A_LoopFileName%
	MsgBox,4,NP++ Install, Valid NP++ install file?  %nppver%
	IfMsgBox No
	{	
		nppver =
		continue
	}
	Else
		break
}
If nppver =
{
	MsgBox,,NP++ Install, No valid NP++ installer selected!
	Return
}
Loop, read, %SelectedFileMain%
{
	IfExist %A_ScriptDir%\checkos.txt
	FileDelete, %A_ScriptDir%\checkos.txt
	IfExist %A_ScriptDir%\result.txt
		FileDelete, %A_ScriptDir%\result.txt
	RunWait, %comspec% /c reg.exe query \\%A_LoopReadLine%\HKLM\Hardware\Description\System\CentralProcessor\0 > "%A_ScriptDir%\checkos.txt",, hide
	RunWait, %comspec% /c find /i "x86" < "%A_ScriptDir%\checkos.txt" > "%A_ScriptDir%\result.txt",, hide
	FileGetSize, fsize, %A_ScriptDir%\result.txt
	If ErrorLevel
		Return
	IfNotExist \\%A_LoopReadLine%\%RemDriveLetter%$\%company%Tech\Tools\%nppver%
	{
		ErrNPServers := ErrNPServers . "`n" . A_LoopReadLine
		continue
	}
	If (MyCheckBox = 0)
	{
		If fsize = 0
		{
			If A_LoopReadLine = %A_ComputerName%
				Run, %comspec% /k "cmd.exe /k %LocDriveLetter%:\%company%Tech\tools\%nppver% /S /D=%LocDriveLetter%:\Program Files (x86)\Notepad++"
			Else
				Run, %comspec% /k wmic /node:"%A_LoopReadLine%" process call create "cmd.exe /k %RemDriveLetter%:\%company%Tech\tools\%nppver% /S /D=%RemDriveLetter%:\Program Files (x86)\Notepad++"
		}
		Else
		{
			If A_LoopReadLine = %A_ComputerName%
				Run, %comspec% /k "cmd.exe /k %LocDriveLetter%:\%company%Tech\tools\%nppver% /S /D=%LocDriveLetter%:\Program Files\Notepad++"
			Else
				Run, %comspec% /k wmic /node:"%A_LoopReadLine%" process call create "cmd.exe /k %RemDriveLetter%:\%company%Tech\tools\%nppver% /S /D=%RemDriveLetter%:\Program Files\Notepad++"
		}
	}
	Else
	{
		If fsize = 0
		{
			If A_LoopReadLine = %A_ComputerName%
				Run, %comspec% /c "cmd.exe /c %LocDriveLetter%:\%company%Tech\tools\%nppver% /S /D=%LocDriveLetter%:\Program Files (x86)\Notepad++",, hide
			Else
				Run, %comspec% /c wmic /node:"%A_LoopReadLine%" process call create "cmd.exe /c %RemDriveLetter%:\%company%Tech\tools\%nppver% /S /D=%RemDriveLetter%:\Program Files (x86)\Notepad++",, hide
		}
		Else
		{
			If A_LoopReadLine = %A_ComputerName%
				Run, %comspec% /c "cmd.exe /c %LocDriveLetter%:\%company%Tech\tools\%nppver% /S /D=%LocDriveLetter%:\Program Files\Notepad++",, hide
			Else
				Run, %comspec% /c wmic /node:"%A_LoopReadLine%" process call create "cmd.exe /c %RemDriveLetter%:\%company%Tech\tools\%nppver% /S /D=%RemDriveLetter%:\Program Files\Notepad++",, hide
		}
	}
}
If ErrNPServers
	MsgBox,,NP++ Missing, Failed to find %nppver% on: %ErrNPServers%
IfExist %A_ScriptDir%\checkos.txt
	FileDelete, %A_ScriptDir%\checkos.txt
IfExist %A_ScriptDir%\result.txt
	FileDelete, %A_ScriptDir%\result.txt
MsgBox,,Install NP++, Task complete.
Return

7z:
gui, Submit, nohide
ErrServers7z =
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
IfNotExist %LocDriveLetter%:\%company%Tech\Tools\7z*.exe
{
	MsgBox,,7zip Missing, Please put 7zip installer (.exe) in %LocDriveLetter%:\%company%Tech\Tools and push to remote nodes
	Return
}
Loop, %LocDriveLetter%:\%company%Tech\Tools\7z*.exe
{

	7zver = %A_LoopFileName%
	MsgBox,4,7zip Install, Valid 7zip install file?  %7zver%
	IfMsgBox No
	{
		7zver = 
		continue
	}
	Else
		break
}
If 7zver =
{
	MsgBox,,7zip Missing, No valid 7zip installer selected!
	Return
}
Loop, read, %SelectedFileMain%
{
	;IfExist %A_ScriptDir%\checkos.txt
		;FileDelete, %A_ScriptDir%\checkos.txt
	;IfExist %A_ScriptDir%\result.txt
		;FileDelete, %A_ScriptDir%\result.txt
	;RunWait, %comspec% /c reg.exe query \\%A_LoopReadLine%\HKLM\Hardware\Description\System\CentralProcessor\0 > "%A_ScriptDir%\checkos.txt",, hide
	;RunWait, %comspec% /c find /i "x86" < "%A_ScriptDir%\checkos.txt" > "%A_ScriptDir%\result.txt",, hide
	;FileGetSize, fsize, %A_ScriptDir%\result.txt
	If ErrorLevel
		Return
	IfNotExist \\%A_LoopReadLine%\%RemDriveLetter%$\%company%Tech\Tools\%7zver%
	{
		ErrServers7z := ErrServers7z . "`n" . A_LoopReadLine
		continue
	}
	If (MyCheckBox = 0)
	{
		;If fsize = 0
		;{
		;	If A_LoopReadLine = %A_ComputerName%
		;		Run, %comspec% /k "cmd /k %LocDriveLetter%:\%company%Tech\Tools\%7zver% /S /D="%LocDriveLetter%:\Program Files\7-zip\""
		;	Else
		;		Run, %comspec% /k wmic /node:"%A_LoopReadLine%" process call create "cmd /k %RemDriveLetter%:\%company%Tech\tools\%7zver% /S /D="%RemDriveLetter%:\Program Files\7-zip\""
		;}
		;Else
		;{
			If A_LoopReadLine = %A_ComputerName%
				RunWait, %comspec% /k "cmd /k %LocDriveLetter%:\%company%Tech\Tools\%7zver% /S /D="%LocDriveLetter%:\Program Files\7-zip\""
			Else
				RunWait, %comspec% /k wmic /node:"%A_LoopReadLine%" process call create 'cmd /k %RemDriveLetter%:\%company%Tech\tools\%7zver% /S /D="%RemDriveLetter%:\Program Files\7-zip\"'
		;}
	}
	Else
	{
		;If fsize = 0
		;{
		;	If A_LoopReadLine = %A_ComputerName%
		;		Run, %comspec% /c "msiexec /i %LocDriveLetter%:\%company%Tech\tools\7z920-x64.msi /quiet INSTALLDIR=\"%LocDriveLetter%:\Program Files\7-zip\"",, hide
		;	Else
		;		Run, %comspec% /c wmic /node:"%A_LoopReadLine%" process call create "msiexec /i %RemDriveLetter%:\%company%Tech\tools\7z920-x64.msi /quiet INSTALLDIR=\"%RemDriveLetter%:\Program Files\7-zip\"',, hide
		;}
		;Else
		;{
			If A_LoopReadLine = %A_ComputerName%
			{
				Run, %comspec% /c "cmd /c %LocDriveLetter%:\%company%Tech\Tools\%7zver% /S /D="%LocDriveLetter%:\Program Files\7-zip\"",, hide, pid
				Gui, Loading:-Caption
				Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
				Gui, Loading:Add, Text,, Installing 7zip on %A_LoopReadLine%
				Gui, Hide
				Gui, Loading:Show
				ErrorLevel:=1
				While (ErrorLevel != 0)
				{
					Sleep, 20
					GuiControl,Loading:, lvl, 1
					Process, Exist, % pid
				}
				Gui,Loading:Destroy
				EnvSet, PATH, %LocDriveLetter%:\Program Files\7-zip\
			}
			Else
			{
				Run, %comspec% /c wmic /node:"%A_LoopReadLine%" process call create 'cmd /c %RemDriveLetter%:\%company%Tech\tools\%7zver% /S /D="%RemDriveLetter%:\Program Files\7-zip\"',, hide, pid
				Gui, Loading:-Caption
				Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
				Gui, Loading:Add, Text,, Installing 7zip on %A_LoopReadLine%
				Gui, Hide
				Gui, Loading:Show
				ErrorLevel:=1
				While (ErrorLevel != 0)
				{
					Sleep, 20
					GuiControl,Loading:, lvl, 1
					Process, Exist, % pid
				}
				Gui,Loading:Destroy
			}
		;}
	}
}
If ErrServers7z
	MsgBox,,7zip Missing, Failed to find %7zver% on: %ErrServers7z%
IfExist %A_ScriptDir%\checkos.txt
	FileDelete, %A_ScriptDir%\checkos.txt
IfExist %A_ScriptDir%\result.txt
	FileDelete, %A_ScriptDir%\result.txt
MsgBox,,Install 7zip, Task complete.
Gui, 1:Show
Return

scc:
gui, Submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
ErrCertInfo =
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
MsgBox, 3, SCC Binding, Are you doing a full binding (yes) or just checking the status (no)
IfMsgBox Yes
	FullBind = 1
IfMsgBox No
	FullBind = 0
IfMsgBox Cancel
	Return
If (FullBind = 1)
{
	IfNotExist %LocDriveLetter%:\%company%Tech\Tools\cert_thumb.ps1
	{
		FileAppend,
	(
$computerName = $Env:Computername
$domainName = $Env:UserDnsDomain
write-host "CN=$computername.$domainname"
$getThumb = Get-ChildItem -path cert:\LocalMachine\My | where { $_.Subject -match "CN\=$Computername\.$DomainName" }
$getThumb.thumbprint | out-file %RemDriveLetter%:\%company%Tech\cert_$computerName.txt
	), %LocDriveLetter%:\%company%Tech\Tools\cert_thumb.ps1
	}
}
Bindservers = 
Loop, Read, %SelectedFileMain%
	Bindservers .= A_LoopReadLine "|"
Gui, SCC:+Resize -MaximizeBox -Caption
Gui, SCC:Add, Text, vBindText, Choose servers for SCC:
Gui, SCC:Add, ListBox, vBindServerSelection 8 W130 H160, %Bindservers%
Gui, SCC:Add, Button, vBindBtn gBindBtn, Finalize Selection
Gui, SCC:Show, W170 H220, SCC Servers
Return

BindBtn:
Gui, SCC:Submit
Gui, SCC:Destroy
If BindServerSelection =
{
	MsgBox,,Blank Host, Hostname cannot be blank!
	Gui, 1:Show
	Exit
}
Loop, parse, BindServerSelection, |
{
	IfNotExist \\%A_LoopField%\%RemDriveLetter%$\%company%Tech\Tools\cert_thumb.ps1
		RunWait, %comspec% /c "robocopy /ETA %LocDriveLetter%:\%company%Tech\Tools \\%A_LoopField%\%RemDriveLetter%$\%company%Tech\Tools cert_thumb.ps1",, hide
	If (FullBind = 1)
	{
		If (MyCheckBox = 0)
		{
			RunWait, %comspec% /k wmic /node:"%A_LoopField%" process call create 'powershell.exe %RemDriveLetter%:\%company%Tech\Tools\cert_thumb.ps1'
			RunWait, %comspec% /k "robocopy /ETA \\%A_LoopField%\%RemDriveLetter%$\%company%Tech\ %LocDriveLetter%:\%company%Tech\RemoteNodeCerts cert_%A_LoopField%.txt"
			IfNotExist %LocDriveLetter%:\%company%Tech\RemoteNodeCerts\cert_%A_LoopField%.txt
			{
				Sleep, 1000
				RunWait, %comspec% /k "robocopy /ETA \\%A_LoopField%\%RemDriveLetter%$\%company%Tech\ %LocDriveLetter%:\%company%Tech\RemoteNodeCerts cert_%A_LoopField%.txt"
			}
			IfNotExist %LocDriveLetter%:\%company%Tech\RemoteNodeCerts\cert_%A_LoopField%.txt
			{
				Sleep, 2000
				RunWait, %comspec% /k "robocopy /ETA \\%A_LoopField%\%RemDriveLetter%$\%company%Tech\ %LocDriveLetter%:\%company%Tech\RemoteNodeCerts cert_%A_LoopField%.txt"
			}
			IfNotExist %LocDriveLetter%:\%company%Tech\RemoteNodeCerts\cert_%A_LoopField%.txt
				MsgBox,,Certificate Thumbprint, Pull thumbprint manually from %A_LoopField%
		}
		Else
		{
			RunWait, %comspec% /c wmic /node:"%A_LoopField%" process call create 'powershell.exe %RemDriveLetter%:\%company%Tech\Tools\cert_thumb.ps1',, hide
			RunWait, %comspec% /c "robocopy /ETA \\%A_LoopField%\%RemDriveLetter%$\%company%Tech\ %LocDriveLetter%:\%company%Tech\RemoteNodeCerts cert_%A_LoopField%.txt",, hide
			IfNotExist %LocDriveLetter%:\%company%Tech\RemoteNodeCerts\cert_%A_LoopField%.txt
			{
				Sleep, 1000
				RunWait, %comspec% /c "robocopy /ETA \\%A_LoopField%\%RemDriveLetter%$\%company%Tech\ %LocDriveLetter%:\%company%Tech\RemoteNodeCerts cert_%A_LoopField%.txt",, hide
			}
			IfNotExist %LocDriveLetter%:\%company%Tech\RemoteNodeCerts\cert_%A_LoopField%.txt
			{
				Sleep, 2000
				RunWait, %comspec% /c "robocopy /ETA \\%A_LoopField%\%RemDriveLetter%$\%company%Tech\ %LocDriveLetter%:\%company%Tech\RemoteNodeCerts cert_%A_LoopField%.txt",, hide
			}
			IfNotExist %LocDriveLetter%:\%company%Tech\RemoteNodeCerts\cert_%A_LoopField%.txt
				MsgBox,,Thumbprint, Pull thumbprint manually from %A_LoopField%
		}
		InputBox, certhash, Cert Hash, Enter certificate hash for %A_LoopField% (Check %LocDriveLetter%:\%company%Tech\RemoteNodeCerts):
		If ErrorLevel
			Return
		StringReplace, certhash, certhash, %A_Space%,,All
		InputBox, ports, Ports, Ports to bind to %A_LoopField% (comma separated):
		If ErrorLevel
			Return
		StringReplace, ports, ports, %A_Space%,,All
		hostname = %A_LoopField%
		Loop, parse, ports, `,
		{
			If (MyCheckBox = 0)
				RunWait, %comspec% /k wmic /node:"%hostname%" process call create 'cmd.exe /k netsh http add sslcert ipport=0.0.0.0:%A_LoopField% certhash=%certhash% appid={00000000-0000-0000-0000-000000000000}'
			Else
				RunWait, %comspec% /c wmic /node:"%hostname%" process call create 'cmd.exe /c netsh http add sslcert ipport=0.0.0.0:%A_LoopField% certhash=%certhash% appid={00000000-0000-0000-0000-000000000000}',, hide
		}
	}
	If (MyCheckBox = 0)
	{
		IfNotExist %LocDriveLetter%:\%company%Tech\Tools\PsTools\psexec.exe
		{
			MsgBox,,PsExec Missing, PsExec (PsTools) missing in %LocDriveLetter%:\%company%Tech\Tools\PsTools\
			continue
		}
		If A_LoopField = %A_ComputerName%
			RunWait, %comspec% /k netsh http show sslcert > %LocDriveLetter%:\%company%Tech\RemoteNodeCerts\certinfo_%A_LoopField%.txt
		Else
		{
			RunWait, %comspec% /k %LocDriveLetter%:\%company%Tech\Tools\PsTools\psexec.exe \\%A_LoopField% netsh http show sslcert > %LocDriveLetter%:\%company%Tech\RemoteNodeCerts\certinfo_%A_LoopField%.txt
			Sleep, 200
			IfNotExist %LocDriveLetter%:\%company%Tech\RemoteNodeCerts\certinfo_%A_LoopField%.txt
			{
				ErrCertInfo := ErrCertInfo . "`n" . A_LoopField
				continue
			}
		}
	}
	Else
	{
		IfNotExist %LocDriveLetter%:\%company%Tech\Tools\PsTools\psexec.exe
		{
			MsgBox,,PsExec Missing, PsExec (PsTools) missing in %LocDriveLetter%:\%company%Tech\Tools\PsTools\
			continue
		}
		If A_LoopField = %A_ComputerName%
			RunWait, %comspec% /c netsh http show sslcert > %LocDriveLetter%:\%company%Tech\RemoteNodeCerts\certinfo_%A_LoopField%.txt,, hide
		Else
		{
			RunWait, %comspec% /c %LocDriveLetter%:\%company%Tech\Tools\PsTools\psexec.exe \\%A_LoopField% netsh http show sslcert > %LocDriveLetter%:\%company%Tech\RemoteNodeCerts\certinfo_%A_LoopField%.txt,, hide
			Sleep, 200
			IfNotExist %LocDriveLetter%:\%company%Tech\RemoteNodeCerts\certinfo_%A_LoopField%.txt
			{
				ErrCertInfo := ErrCertInfo . "`n" . A_LoopField
				continue
			}
		}
	}
}
If ErrCertInfo
	MsgBox,,CertInfo Fail, Failed to pull certinfo on: %ErrCertInfo%
MsgBox,,SCC Binding, Task Complete.
Gui, 1:Show
Return

rdp:
gui, Submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
IfExist %LocDriveLetter%:\%company%Tech\AllServers-%A_UserName%.rdg
	MsgBox,4,Overwrite, Overwrite old RDG file?
IfMsgBox No
	Return
IfMsgBox Yes
	FileDelete %LocDriveLetter%:\%company%Tech\AllServers-%A_UserName%.rdg
IfExist %LocDriveLetter%:\%company%Tech\RDPMan.ps1
	FileDelete %LocDriveLetter%:\%company%Tech\RDPMan.ps1
FileAppend, 
(
<#
    .SYNOPSIS
    This generates a Remote Desktop Manager file for computer names from a text file.
    .DESCRIPTION
    This generates a Remote Desktop Manager file for computer names from a text file.
    Pass values required to the function rather than the script.
    It is based off "New-RDCManFile.ps1" by: Jan Egil Ring.
    .PARAMETER debugScript
    Switch on Write-Debug output. Default is No.
    .EXAMPLE
    C:\PS> New-RDCManFile.ps1
    .NOTES
    Author: Jan Egil Ring | Robin Malik | powershell slack peeps
#>

#*=============================================================================
#* DEFINE GLOBAL VARIABLES
#*=============================================================================
$startDateTime = Get-Date
$EnableEmail = 1
$DebugPreference = "SilentlyContinue"

#let's define the file here, it should be a param, but this is a messed up script

# Pull server list from existing txt file
$computerFilePath = "%SelectedFileMain%"

if `("Yes" -eq $debugScript`)
{
    $DebugPreference = "Continue"   # Write-Debug commands.
    $EnableEmail = Read-Host "Enable email, 0 = No, 1 = Yes [0/1]: "
}

#*=============================================================================
#* Function:    New-LURDCMFile
#* ============================================================================
function New-RDCManFile
{
    <#
    .SYNOPSIS
    This generates a Remote Desktop Manager file for computer names from a text file.
    .DESCRIPTION
    This generates a Remote Desktop Manager file for computer names from a text file.
    .PARAMETER username
    This username that you wish to be present in the RDG file by default.
    .PARAMETER outputPath
    The output path for the file `(e.g. D:\`).
    .PARAMETER computerArray
    Array of strings - computer names to add to the RDG file
    .EXAMPLE
    New-RDCManFile -Username "admin" -OutputPath "D:\" -ComputerArray @`('comp1','comp2'`)
    #>


    # Leave previous two lines blank
    param`(
        [Parameter`(Mandatory=$true, HelpMessage="Admin account."`)]
        [String]
        $Username,

        [Parameter`(Mandatory=$true, HelpMessage="Output Path for file."`)]
        [String]
        $OutputPath,

        [Parameter`(Mandatory=$true, HelpMessage="Array of computers."`)]
        [Array]
        $ComputerArray
    `)

# Create a template XML. This needs to be indented to the margin so that the output XML file has no indent.
$template = @'
<?xml version="1.0" encoding="utf-8"?>
<RDCMan schemaVersion="1">
    <version>2.2</version>
    <file>
        <properties>
            <name></name>
            <expanded>True</expanded>
            <comment />
            <logonCredentials inherit="FromParent" />
            <connectionSettings inherit="FromParent" />
            <gatewaySettings inherit="FromParent" />
            <remoteDesktop inherit="FromParent" />
            <localResources inherit="FromParent" />
            <securitySettings inherit="FromParent" />
            <displaySettings inherit="FromParent" />
        </properties>
        <group>
            <properties>
                <name></name>
                <expanded>True</expanded>
                <comment />
                <logonCredentials inherit="None">
                    <userName></userName>
                    <domain></domain>
                    <password storeAsClearText="False"></password>
                </logonCredentials>
                <connectionSettings inherit="FromParent" />
                <gatewaySettings inherit="None">
                    <userName></userName>
                    <domain></domain>
                    <password storeAsClearText="False" />
                    <enabled>False</enabled>
                    <hostName />
                    <logonMethod>4</logonMethod>
                    <localBypass>False</localBypass>
                    <credSharing>False</credSharing>
                </gatewaySettings>
                <remoteDesktop inherit="FromParent" />
                <localResources inherit="FromParent" />
                <securitySettings inherit="FromParent" />
                <displaySettings inherit="FromParent" />
            </properties>
            <server>
                <name></name>
                <displayName></displayName>
                <comment />
                <logonCredentials inherit="FromParent" />
                <connectionSettings inherit="FromParent" />
                <gatewaySettings inherit="FromParent" />
                <remoteDesktop inherit="FromParent" />
                <localResources inherit="FromParent" />
                <securitySettings inherit="FromParent" />
                <displaySettings inherit="FromParent" />
            </server>
        </group>
    </file>
</RDCMan>
'@

    $outputFile = "$outputPath-$username.rdg"

    # Output $template to a temporary XML file:
    $template | Out-File $home\RDCMan-template.xml -Encoding UTF8

    # Load the XML template into XML object:
    $xml = New-Object xml
    $xml.Load`("$home\RDCMan-template.xml"`)

    # Set the file properties:
    $file = `(@`($xml.RDCMan.file.properties`)[0]`).Clone`(`)
    $file.name = $domain
    $xml.RDCMan.file.properties | Where-Object { "" -eq $_.Name } | ForEach-Object  { [void]$xml.RDCMan.file.ReplaceChild`($file,$_`) }

    # Set the group properties
    $group = `(@`($xml.RDCMan.file.group.properties`)[0]`).Clone`(`)
    $group.name = $env:userdomain
    $group.logonCredentials.Username = $username
    $group.logonCredentials.Domain   = $domain

    $xml.RDCMan.file.group.properties | Where-Object { "" -eq $_.Name } | ForEach-Object  { [void]$xml.RDCMan.file.group.ReplaceChild`($group, $_`) }

    # Use template to add servers from Active Directory to the XML
    $server = `(@`($xml.RDCMan.file.group.server`)[0]`).Clone`(`)

    $computerArray | ForEach-Object {
        
        $server = $server.clone`(`)
        [string]$server.DisplayName = $_
        [string]$server.Name = $_

        $xml.RDCMan.file.group.AppendChild`($server`) > $null
    }
    
    # Remove template server
    $xml.RDCMan.file.group.server | Where-Object { "" -eq $_.Name } | ForEach-Object { [void]$xml.RDCMan.file.group.RemoveChild`($_`) 
    }

    # Save the XML object to a file
    $xml.Save`($outputFile`)

    # Remove the temporary XML file:
    Remove-Item $home\RDCMan-template.xml -Force
}

#*=============================================================================
#* END OF FUNCTION LISTINGS
#*=============================================================================

#*=============================================================================
#* SCRIPT BODY
#*=============================================================================
$domain = $Env:USERDOMAIN
$username = $Env:USERNAME
# Base output path:
$outputPath = "%LocDriveLetter%:\%company%Tech"

# Example to get a list of MemberServers and Domain Controllers:
#$computerObjects1 = Get-ADComputer -SearchBase "OU=MemberServers,DC=lunet,DC=lboro,DC=ac,DC=uk" -LDAPFilter "`(operatingsystem=*Windows server*`)"  | Select-Object -property name,dnshostname

# Update to script - get server list from %SelectedFileMain%
$allcomputers  = Get-Content $computerFilePath 

## if you want to retain properties, its more like this#####
<#
$array = @`(
  @{
    name='server123'
    hostname='server123.whatever.com'
    description="im cool!"
  },
  @{
    name='server321'
    hostname='server321.whatever.com'
    description="im cool!"
  }
`)

$array[0].name # etc etc
#>
######

# Call the function to generate the file:
$filePrefix = "AllServers"
New-RDCManFile -username "$username" -outputPath "$outputPath\$filePrefix" -computerArray $allComputers
#New-RDCManFile -username "useraccount2-admin" -outputPath "$outputPath\$filePrefix" -computerArray $allComputers


# Example to output a list of all SQL servers `(from an AD security group`):
#$filePrefix = "sqlservers"
#$sqlservers = Get-ADGroupMember -Identity "sql-servers" | Get-ADComputer | Select-Object -property name,dnshostname | Sort-Object -Property name
# Call the function to generate the file:
#New-RDCManFile -username "useraccount-admin" -outputPath "$outputPath\$filePrefix" -computerArray $sqlservers

# Optional block to output script execution time:
#$endDateTime = Get-Date
#$scriptExecutionMin = `($endDateTime.Subtract`($startDateTime`).Minutes`)
#$scriptExecutionSec = `($endDateTime.Subtract`($startDateTime`).Seconds`)
#Write-Output "Script execution time: $scriptExecutionMin min $scriptExecutionSec sec."
#*=============================================================================
#* END SCRIPT BODY
#*=============================================================================

#*=============================================================================
#* END OF SCRIPT
#*=============================================================================
), %LocDriveLetter%:\%company%Tech\RDPMan.ps1
IfNotExist %LocDriveLetter%:\%company%Tech\RDPMan.ps1
	Sleep, 200
IfNotExist %LocDriveLetter%:\%company%Tech\RDPMan.ps1
	Sleep, 2000
IfNotExist %LocDriveLetter%:\%company%Tech\RDPMan.ps1
{
	MsgBox,,PS Fail,Creation of PS Script failed.  Cannot create RDG file.
	Return
}
If MyCheckBox = 0
	RunWait powershell.exe -NoExit -Command %LocDriveLetter%:\%company%Tech\RDPMan.ps1
Else
	RunWait powershell.exe -Command %LocDriveLetter%:\%company%Tech\RDPMan.ps1,,hide
IfExist %LocDriveLetter%:\%company%Tech\RDPMan.ps1
	FileDelete, %LocDriveLetter%:\%company%Tech\RDPMan.ps1
IfNotExist %LocDriveLetter%:\%company%Tech\AllServers-%A_UserName%.rdg
	MsgBox,,Failure, Task Fail - Perhaps Server2008, please enable PS (Set-ExecutionPolicy Unresctricted)
Else
	MsgBox,,RDP Man, Task Complete - check %LocDriveLetter%:\%company%Tech for AllServers-%A_UserName%.rdg
Gui, 1:Show
Return

LogoffLink:
gui, Submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}

IfNotExist, %LocDriveLetter%:\%company%Tech
	FileCreateDir, %LocDriveLetter%:\%company%Tech
IfNotExist, %LocDriveLetter%:\%company%Tech\Logoff.lnk
	FileCreateShortcut, C:\Windows\System32\shutdown.exe, %LocDriveLetter%:\%company%Tech\Logoff.lnk, , /l /f
Loop, read, %SelectedFileMain%
{
	If (MyCheckBox = 0)
		Run, %comspec% /k "robocopy /ETA %LocDriveLetter%:\%company%Tech \\%A_LoopReadLine%\c$\Users\Public\Desktop Logoff.lnk"
	Else
		Run, %comspec% /c "robocopy /ETA %LocDriveLetter%:\%company%Tech \\%A_LoopReadLine%\c$\Users\Public\Desktop Logoff.lnk",, hide
}
Sleep, 500
IfExist %A_ScriptDir%\Logoff.lnk
	FileDelete, %A_ScriptDir%\Logoff.lnk
MsgBox,,Logoff Link, Task complete.
Return

FUNCTEST:
gui, Submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
Loop, read, %SelectedFileMain%
{
	IfNotExist, %LocDriveLetter%:\%company%Tech\FuncTstr.lnk
		FileCreateShortcut, %LocDriveLetter%:\NTLogger\Logger\Testers\APITesters\FuncTstr.exe, %LocDriveLetter%:\%company%Tech\FuncTstr.lnk
	IfNotExist, %LocDriveLetter%:\%company%Tech\address.dat
		FileAppend, 127.0.0.1, %LocDriveLetter%:\%company%Tech\address.dat
	If (MyCheckBox = 0)
	{
		Run, %comspec% /k robocopy /ETA %LocDriveLetter%:\%company%Tech \\%A_LoopReadLine%\c$\Users\Public\Desktop FuncTstr.lnk
		Run, %comspec% /k robocopy /ETA %LocDriveLetter%:\%company%Tech \\%A_LoopReadLine%\d$\NTLogger\Logger\Testers\APITesters Address.dat
	}
	Else
	{
		Run, %comspec% /c robocopy /ETA %LocDriveLetter%:\%company%Tech \\%A_LoopReadLine%\c$\Users\Public\Desktop FuncTstr.lnk,, hide
		Run, %comspec% /c robocopy /ETA %LocDriveLetter%:\%company%Tech \\%A_LoopReadLine%\d$\NTLogger\Logger\Testers\APITesters Address.dat,, hide
	}
}
Sleep, 500
IfExist %A_ScriptDir%\FuncTstr.lnk
	FileDelete, %A_ScriptDir%\FuncTstr.lnk
MsgBox,,FuncTest Push, Task complete.
Return

PushNiceTech:
Gui, Submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
Loop, read, %SelectedFileMain%
{
	If A_LoopReadLine = %A_ComputerName%
	{
		IfNotExist %LocDriveLetter%:\%company%Tech
			FileCreateDir, %LocDriveLetter%:\%company%Tech
		IfNotExist %LocDriveLetter%:\%company%Tech\LicenseKeys
			FileCreateDir, %LocDriveLetter%:\%company%Tech\LicenseKeys\Archive
		IfNotExist %LocDriveLetter%:\%company%Tech\SDC_Zip
		{
			FileCreateDir, %LocDriveLetter%:\%company%Tech\SDC_Zip\Deployment Tools
			FileCreateDir, %LocDriveLetter%:\%company%Tech\SDC_Zip\SP\Sentinel
			FileCreateDir, %LocDriveLetter%:\%company%Tech\SDC_Zip\SP\LanguagePacks
			FileCreateDir, %LocDriveLetter%:\%company%Tech\SDC_Zip\SP\Engage
			FileCreateDir, %LocDriveLetter%:\%company%Tech\SDC_Zip\SP\Engage Search
			FileCreateDir, %LocDriveLetter%:\%company%Tech\SDC_Zip\Sentinel
			FileCreateDir, %LocDriveLetter%:\%company%Tech\SDC_Zip\Client Side
			FileCreateDir, %LocDriveLetter%:\%company%Tech\SDC_Zip\Server Side
			FileCreateDir, %LocDriveLetter%:\%company%Tech\SDC_Zip\SQL AutoSetup
		}
		IfNotExist %LocDriveLetter%:\%company%Tech\Deployment Tools
		{
			FileCreateDir, %LocDriveLetter%:\%company%Tech\Deployment Tools\NDM
			FileCreateDir, %LocDriveLetter%:\%company%Tech\Deployment Tools\SRT
		}
		IfNotExist %LocDriveLetter%:\%company%Tech\Installation Files
		{
			FileCreateDir, %LocDriveLetter%:\%company%Tech\Installation Files\CP\Archive
			FileCreateDir, %LocDriveLetter%:\%company%Tech\Installation Files\NDMInstallReport\UPx
			FileCreateDir, %LocDriveLetter%:\%company%Tech\Installation Files\SRTReadinessReport
			FileCreateDir, %LocDriveLetter%:\%company%Tech\Installation Files\SiteMap
			FileCreateDir, %LocDriveLetter%:\%company%Tech\Installation Files\SRTExport
			FileCreateDir, %LocDriveLetter%:\%company%Tech\Installation Files\SRTSavedSession
		}
		IfNotExist %LocDriveLetter%:\%company%Tech\SiteDocCollector
			FileCreateDir, %LocDriveLetter%:\%company%Tech\SiteDocCollector
		IfNotExist %LocDriveLetter%:\%company%Tech\HandoverDocs
			FileCreateDir, %LocDriveLetter%:\%company%Tech\HandoverDocs
		continue
	}
	IfNotExist %LocDriveLetter%:\%company%Tech\Tools
	{
		MsgBox,,Tools Missing, Cannot push from %LocDriveLetter%:\%company%Tech\Tools
		Return
	}
	If (MyCheckBox = 0)
		Run, %comspec% /k "robocopy /E /ETA %LocDriveLetter%:\%company%Tech\Tools \\%A_LoopReadLine%\%RemDriveLetter%$\%company%Tech\Tools"
	Else
	{
		Run, %comspec% /c "robocopy /E /ETA %LocDriveLetter%:\%company%Tech\Tools \\%A_LoopReadLine%\%RemDriveLetter%$\%company%Tech\Tools",, hide, pid
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, Pushing Tools to %A_LoopReadLine%
		Gui, Hide
		Gui, Loading:Show
		ErrorLevel:=1
		While (ErrorLevel != 0)
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			Process, Exist, % pid
		}
		Gui,Loading:Destroy
	}
}
MsgBox,,Push %company%Tech, Task complete.
Gui, 1:Show
Return

PushConfigMgr:
Gui, Submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
IfNotExist, %LocDriveLetter%:\Program Files\NICE Systems\Nice Services Configuration Manager\Nice Services Configuration Manager.exe
{
	appservers = 
	Loop, Read, %SelectedFileMain%
		appservers .= A_LoopReadLine "|"
	Gui, APP:+Resize -MaximizeBox -Caption
	Gui, APP:Add, Text, vAPPText, Choose APP server:
	Gui, APP:Add, ListBox, vappnode W130 H160, %appservers%
	Gui, APP:Add, Button, vAppBtn gAppBtn, Finalize Selection
	Gui, APP:Show, W170 H220, App Server
	Return
	AppBtn:
	Gui, APP:Submit
	Gui, APP:Destroy
	If appnode =
	{
		MsgBox,,Blank Host, Hostname cannot be blank!
		Gui, 1:Show
		Return
	}
	IfNotExist, \\%appnode%\%RemDriveLetter%$\Program Files\NICE Systems\Applications\Tools\Nice Services Configuration Manager
	{
		MsgBox,,Config Manager Missing, Local node and/or %appnode% do not have ConfigMgr!  (Have you deployed yet?)
		Return
	}
	If (MyCheckBox = 0)
		Run, %comspec% /k robocopy /E /ETA "\\%appnode%\%RemDriveLetter%$\Program Files\NICE Systems\Applications\Tools\Nice Services Configuration Manager" "%LocDriveLetter%:\Program Files\NICE Systems\Nice Services Configuration Manager"
	Else
	{
		Run, %comspec% /c robocopy /E /ETA "\\%appnode%\%RemDriveLetter%$\Program Files\NICE Systems\Applications\Tools\Nice Services Configuration Manager" "%LocDriveLetter%:\Program Files\NICE Systems\Nice Services Configuration Manager",, hide, pid
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, Pulling ConfigMgr from %appnode%
		Gui, Hide
		Gui, Loading:Show
		ErrorLevel:=1
		While (ErrorLevel != 0)
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			Process, Exist, % pid
		}
		Gui,Loading:Destroy
	}
	IfNotExist, %A_ScriptDir%\Nice Services Configuration Manager.lnk
	FileCreateShortcut, %LocDriveLetter%:\Program Files\NICE Systems\Nice Services Configuration Manager\Nice Services Configuration Manager.exe, %LocDriveLetter%:\%company%Tech\Nice Services Configuration Manager.lnk
	Sleep, 200
	Loop, read, %SelectedFileMain%
	{
		If (MyCheckBox = 0)
		{
			If A_LoopReadLine = %A_ComputerName%
				Run, %comspec% /k robocopy /ETA %LocDriveLetter%:\%company%Tech C:\Users\Public\Desktop "Nice Services Configuration Manager.lnk"
			Else
			{
				RunWait, %comspec% /k taskkill /S %A_LoopReadLine% /IM "Nice Services Configuration Manager.exe"
				Sleep, 200
				Run, %comspec% /k robocopy /E /ETA "%LocDriveLetter%:\Program Files\NICE Systems\Nice Services Configuration Manager" "\\%A_LoopReadLine%\%RemDriveLetter%$\Program Files\NICE Systems\Nice Services Configuration Manager"
				Sleep, 200
				Run, %comspec% /k robocopy /ETA %LocDriveLetter%:\%company%Tech \\%A_LoopReadLine%\c$\Users\Public\Desktop "Nice Services Configuration Manager.lnk"
			}
		}
		Else
		{
			If A_LoopReadLine = %A_ComputerName%
				RunWait, %comspec% /c robocopy /ETA %LocDriveLetter%:\%company%Tech C:\Users\Public\Desktop "Nice Services Configuration Manager.lnk",, hide
			Else
			{
				RunWait, %comspec% /c taskkill /S %A_LoopReadLine% /IM "Nice Services Configuration Manager.exe",, hide, pid
				Gui, Loading:-Caption
				Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
				Gui, Loading:Add, Text,, Killing ConfigMgr on %A_LoopReadLine%
				Gui, Hide
				Gui, Loading:Show
				ErrorLevel:=1
				While (ErrorLevel != 0)
				{
					Sleep, 20
					GuiControl,Loading:, lvl, 1
					Process, Exist, % pid
				}
				Gui,Loading:Destroy
				Sleep, 200
				Run, %comspec% /c robocopy /E /ETA "%LocDriveLetter%:\Program Files\NICE Systems\Nice Services Configuration Manager" "\\%A_LoopReadLine%\%RemDriveLetter%$\Program Files\NICE Systems\Nice Services Configuration Manager",, hide, pid
				Gui, Loading:-Caption
				Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
				Gui, Loading:Add, Text,, Pushing ConfigMgr to %A_LoopReadLine%
				Gui, Hide
				Gui, Loading:Show
				ErrorLevel:=1
				While (ErrorLevel != 0)
				{
					Sleep, 20
					GuiControl,Loading:, lvl, 1
					Process, Exist, % pid
				}
				Gui,Loading:Destroy
				Sleep, 200
				Run, %comspec% /c robocopy /ETA %LocDriveLetter%:\%company%Tech \\%A_LoopReadLine%\c$\Users\Public\Desktop "Nice Services Configuration Manager.lnk",, hide, pid
				Gui, Loading:-Caption
				Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
				Gui, Loading:Add, Text,, Pushing link to %A_LoopReadLine%
				Gui, Hide
				Gui, Loading:Show
				ErrorLevel:=1
				While (ErrorLevel != 0)
				{
					Sleep, 20
					GuiControl,Loading:, lvl, 1
					Process, Exist, % pid
				}
				Gui,Loading:Destroy
			}
		}
	}
	Sleep, 500
	IfExist %A_ScriptDir%\Nice Services Configuration Manager.lnk
		FileDelete, %A_ScriptDir%\Nice Services Configuration Manager.lnk
	MsgBox,,Configuration Manager, Task Complete.
	Gui, 1:Show
	Return
}
IfNotExist, %A_ScriptDir%\Nice Services Configuration Manager.lnk
	FileCreateShortcut, %LocDriveLetter%:\Program Files\NICE Systems\Nice Services Configuration Manager\Nice Services Configuration Manager.exe, %LocDriveLetter%:\%company%Tech\Nice Services Configuration Manager.lnk
Sleep, 200
Loop, read, %SelectedFileMain%
{
	If (MyCheckBox = 0)
	{
		If A_LoopReadLine = %A_ComputerName%
			Run, %comspec% /k robocopy /ETA %LocDriveLetter%:\%company%Tech C:\Users\Public\Desktop "Nice Services Configuration Manager.lnk"
		Else
		{
			RunWait, %comspec% /k taskkill /S %A_LoopReadLine% /IM "Nice Services Configuration Manager.exe"
			Sleep, 200
			Run, %comspec% /k robocopy /E /ETA "%LocDriveLetter%:\Program Files\NICE Systems\Nice Services Configuration Manager" "\\%A_LoopReadLine%\%RemDriveLetter%$\Program Files\NICE Systems\Nice Services Configuration Manager"
			Sleep, 200
			Run, %comspec% /k robocopy /ETA %LocDriveLetter%:\%company%Tech \\%A_LoopReadLine%\c$\Users\Public\Desktop "Nice Services Configuration Manager.lnk"
		}
	}
	Else
	{
		If A_LoopReadLine = %A_ComputerName%
			Run, %comspec% /c robocopy /ETA %LocDriveLetter%:\%company%Tech C:\Users\Public\Desktop "Nice Services Configuration Manager.lnk",, hide
		Else
		{
			Run, %comspec% /c taskkill /S %A_LoopReadLine% /IM "Nice Services Configuration Manager.exe",, hide, pid
			Gui, Loading:-Caption
			Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
			Gui, Loading:Add, Text,, Killing ConfigMgr on %A_LoopReadLine%
			Gui, Hide
			Gui, Loading:Show
			ErrorLevel:=1
			While (ErrorLevel != 0)
			{
				Sleep, 20
				GuiControl,Loading:, lvl, 1
				Process, Exist, % pid
			}
			Gui,Loading:Destroy
			Sleep, 200
			Run, %comspec% /c robocopy /E /ETA "%LocDriveLetter%:\Program Files\NICE Systems\Nice Services Configuration Manager" "\\%A_LoopReadLine%\%RemDriveLetter%$\Program Files\NICE Systems\Nice Services Configuration Manager",, hide, pid
			Gui, Loading:-Caption
			Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
			Gui, Loading:Add, Text,, Pushing ConfigMgr to %A_LoopReadLine%
			Gui, Hide
			Gui, Loading:Show
			ErrorLevel:=1
			While (ErrorLevel != 0)
			{
				Sleep, 20
				GuiControl,Loading:, lvl, 1
				Process, Exist, % pid
			}
			Gui,Loading:Destroy
			Sleep, 200
			Run, %comspec% /c robocopy /ETA %LocDriveLetter%:\%company%Tech \\%A_LoopReadLine%\c$\Users\Public\Desktop "Nice Services Configuration Manager.lnk",, hide, pid
			Gui, Loading:-Caption
			Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
			Gui, Loading:Add, Text,, Pushing link to %A_LoopReadLine%
			Gui, Hide
			Gui, Loading:Show
			ErrorLevel:=1
			While (ErrorLevel != 0)
			{
				Sleep, 20
				GuiControl,Loading:, lvl, 1
				Process, Exist, % pid
			}
			Gui,Loading:Destroy
		}
	}
}
Sleep, 500
IfExist %A_ScriptDir%\Nice Services Configuration Manager.lnk
	FileDelete, %A_ScriptDir%\Nice Services Configuration Manager.lnk
MsgBox,,Configuration Manager, Task Complete.
Gui, 1:Show
Return

RegistryChange:
gui, submit, nohide
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
IfNotExist, %LocDriveLetter%:\%company%Tech\Tools\Registry_Setup.exe
{
	MsgBox,,Registry Setup Missing, Please put Registry_Setup.exe in %LocDriveLetter%:\%company%Tech\Tools\ and push folder to remote nodes
	Return
}
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
Loop, read, %SelectedFileMain%
{
	IfNotExist \\%A_LoopReadLine%\%RemDriveLetter%$\%company%Tech\Tools\Registry_Setup.exe
	{
		ErrRegServers := ErrRegServers . "`n" . A_LoopReadLine
		continue
	}
	If (MyCheckBox = 0)
	{
		If A_LoopReadLine = %A_ComputerName%
			Run, %comspec% /k "cmd.exe /k %LocDriveLetter%:\%company%Tech\Tools\Registry_Setup.exe"
		Else
			Run, %comspec% /k wmic /node:"%A_LoopReadLine%" process call create "cmd.exe /k %RemDriveLetter%:\%company%Tech\Tools\Registry_Setup.exe"
	}
	Else
	{
		If A_LoopReadLine = %A_ComputerName%
			Run, %comspec% /c "cmd.exe /c %LocDriveLetter%:\%company%Tech\Tools\Registry_Setup.exe",, hide
		Else
		{
			Run, %comspec% /c wmic /node:"%A_LoopReadLine%" process call create "cmd.exe /c %RemDriveLetter%:\%company%Tech\Tools\Registry_Setup.exe",, hide, pid
			Gui, Loading:-Caption
			Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
			Gui, Loading:Add, Text,, Running registry setup on %A_LoopReadLine%
			Gui, Hide
			Gui, Loading:Show
			ErrorLevel:=1
			While (ErrorLevel != 0)
			{
				Sleep, 20
				GuiControl,Loading:, lvl, 1
				Process, Exist, % pid
			}
			Gui,Loading:Destroy
		}
	}
}
If ErrRegServers
	MsgBox,,Registry Setup Missing, Failed to find Registry_Setup.exe on: %ErrRegServers%
MsgBox,,Registry Update, Task Complete.
Gui, 1:Show
Return

RegBackup:
gui, submit, nohide
Err7zServers = 
ErrregbackupServers =
ErrhkcuServers =
ErrhklmServers =
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
GuiControlGet, RemDriveLetter
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
MsgBox,3,Zip Files,Would you like to compress the files? (7-zip required)
IfMsgBox No
	ZipFiles = 0
IfMsgBox Yes
	ZipFiles = 1
IfMsgBox Cancel
	Return
Loop, read, %SelectedFileMain%
{
	line := A_LoopReadLine
	GuiControlGet, MyCheckBox
	If (MyCheckBox = 0)
	{
		IfNotExist \\%line%\%RemDriveLetter%$\%company%Tech\RegBackup
			RunWait, %comspec% /k wmic /node:"%line%" process call create 'cmd.exe /c mkdir %RemDriveLetter%:\%company%Tech\RegBackup'
		IfExist \\%line%\%RemDriveLetter%$\%company%Tech\RegBackup\hklm_%line%.reg
			RunWait, %comspec% /k wmic /node:"%line%" process call create 'cmd.exe /c del /F /Q %RemDriveLetter%:\%company%Tech\RegBackup\hklm_%line%.reg'
		RunWait, %comspec% /k wmic /node:"%line%" process call create 'cmd.exe /c reg export hklm %RemDriveLetter%:\%company%Tech\RegBackup\hklm_%line%.reg'
		IfExist \\%line%\%RemDriveLetter%$\%company%Tech\RegBackup\hkcu_%line%.reg
			RunWait, %comspec% /k wmic /node:"%line%" process call create 'cmd.exe /c del /F /Q %RemDriveLetter%:\%company%Tech\RegBackup\hkcu_%line%.reg'
		RunWait, %comspec% /k wmic /node:"%line%" process call create 'cmd.exe /c reg export hkcu %RemDriveLetter%:\%company%Tech\RegBackup\hkcu_%line%.reg'
		If ZipFiles = 1
		{
			IfExist \\%line%\%RemDriveLetter%$\%company%Tech\RegBackup\regbackup_%line%.zip
				RunWait, %comspec% /k wmic /node:"%line%" process call create 'cmd.exe /c del /F /Q %RemDriveLetter%:\%company%Tech\RegBackup\regbackup_%line%.zip'
			RunWait, %comspec% /k wmic /node:"%line%" process call create 'cmd.exe /c "%RemDriveLetter%:\Program Files\7-zip\7z.exe" a %RemDriveLetter%:\%company%Tech\RegBackup\regbackup_%line%.zip %RemDriveLetter%:\%company%Tech\RegBackup\*.reg'
		}
	}
	Else
	{
		IfNotExist \\%line%\%RemDriveLetter%$\%company%Tech\RegBackup
		{
			Run, %comspec% /c wmic /node:"%line%" process call create 'cmd.exe /c mkdir %RemDriveLetter%:\%company%Tech\RegBackup',, hide, pid
			Gui, Loading:-Caption
			Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
			Gui, Loading:Add, Text,, Creating folder on %line%
			Gui, Hide
			Gui, Loading:Show
			ErrorLevel:=1
			While (ErrorLevel != 0)
			{
				Sleep, 20
				GuiControl,Loading:, lvl, 1
				Process, Exist, % pid
			}
			Gui,Loading:Destroy
		}
		Else
			RunWait, %comspec% /c wmic /node:"%line%" process call create 'cmd.exe /c del /F /Q %RemDriveLetter%:\%company%Tech\RegBackup\*.*',,hide
		IfExist \\%line%\%RemDriveLetter%$\%company%Tech\RegBackup\hklm_%line%.reg
			RunWait, %comspec% /c wmic /node:"%line%" process call create 'cmd.exe /c del /F /Q %RemDriveLetter%:\%company%Tech\RegBackup\hklm_%line%.reg',, hide
		Run, %comspec% /c wmic /node:"%line%" process call create 'cmd.exe /c reg export hklm %RemDriveLetter%:\%company%Tech\RegBackup\hklm_%line%.reg',, hide, pid
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, Backup HKLM on %line%
		Gui, Hide
		Gui, Loading:Show
		ErrorLevel:=1
		While (ErrorLevel != 0)
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			Process, Exist, % pid
		}
		Gui,Loading:Destroy
		IfExist \\%line%\%RemDriveLetter%$\%company%Tech\RegBackup\hkcu_%line%.reg
			RunWait, %comspec% /c wmic /node:"%line%" process call create 'cmd.exe /c del /F /Q %RemDriveLetter%:\%company%Tech\RegBackup\hkcu_%line%.reg',, hide
		Run, %comspec% /c wmic /node:"%line%" process call create 'cmd.exe /c reg export hkcu %RemDriveLetter%:\%company%Tech\RegBackup\hkcu_%line%.reg',, hide, pid
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, Backup HKCU on %line%
		Gui, Hide
		Gui, Loading:Show
		ErrorLevel:=1
		While (ErrorLevel != 0)
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			Process, Exist, % pid
		}
		Gui,Loading:Destroy
	}
	Gui, Loading:-Caption
	Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
	Gui, Loading:Add, Text,,  Waiting for HKLM to finish on %line%
	Gui, Hide
	Gui, Loading:Show
	HKLM_Exist = 0
	While HKLM_Exist = 0
	{	
		IfExist \\%line%\%RemDriveLetter%$\%company%Tech\RegBackup\hklm_%line%.reg
			HKLM_Exist = 1
		GuiControl,Loading:, lvl, 1
		Sleep 20
	}
	Gui,Loading:Destroy
	IfNotExist \\%line%\%RemDriveLetter%$\%company%Tech\RegBackup\hklm_%line%.reg
	{
		ErrhklmServers := ErrhklmServers . "`n" . line
		continue
	}
	Gui, Loading:-Caption
	Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
	Gui, Loading:Add, Text,, Waiting for HKCU to finish on %line%
	Gui, Hide
	Gui, Loading:Show
	HKCU_Exist = 0
	While HKCU_Exist = 0
	{	
		IfExist \\%line%\%RemDriveLetter%$\%company%Tech\RegBackup\hkcu_%line%.reg
			HKCU_Exist = 1
		GuiControl,Loading:, lvl, 1
		Sleep 20
	}
	Gui,Loading:Destroy
	IfNotExist \\%line%\%RemDriveLetter%$\%company%Tech\RegBackup\hkcu_%line%.reg
	{
		ErrhkcuServers := ErrhkcuServers . "`n" . line
		continue
	}
	If ZipFiles = 1
	{
		IfExist \\%line%\%RemDriveLetter%$\Program Files\7-zip\7z.exe
		{
			IfExist %A_ScriptDir%\7zstatus.txt
				FileDelete %A_ScriptDir%\7zstatus.txt
			IfExist %A_ScriptDir%\result.txt
				FileDelete %A_ScriptDir%\result.txt
			RunWait, %comspec% /c wmic /node:"%line%" process call create 'cmd.exe /c "%RemDriveLetter%:\Program Files\7-zip\7z.exe" a %RemDriveLetter%:\%company%Tech\RegBackup\regbackup_%line%.zip %RemDriveLetter%:\%company%Tech\RegBackup\*.reg',, hide
			RunWait, %comspec% /c tasklist /s %line% /fi "imagename eq 7z.exe" > "%A_ScriptDir%\7zstatus.txt",, hide
			RunWait, %comspec% /c find /i "PID" < %A_ScriptDir%\7zstatus.txt > "%A_ScriptDir%\result.txt",, hide
			FileGetSize, fsize, %A_ScriptDir%\result.txt
			Gui, Loading:-Caption
			Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
			Gui, Loading:Add, Text,, Zipping files on %line%
			Gui, Hide
			Gui, Loading:Show
			While fsize <> 0
			{
				Sleep, 20
				GuiControl,Loading:, lvl, 1
				RunWait, %comspec% /c tasklist /s %line% /fi "imagename eq 7z.exe" > "%A_ScriptDir%\7zstatus.txt",, hide
				RunWait, %comspec% /c find /i "PID" < "%A_ScriptDir%\7zstatus.txt" > "%A_ScriptDir%\result.txt",, hide
				FileGetSize, fsize, %A_ScriptDir%\result.txt
			}
			Gui,Loading:Destroy
			IfNotExist \\%line%\%RemDriveLetter%$\%company%Tech\RegBackup\regbackup_%line%.zip
			{
				ErrregbackupServers := ErrregbackupServers . "`n" . line
				continue
			}
		}
		Else
		{
			Err7zServers := Err7zServers . "`n" . line
			continue
		}
	}
}
If ErrhklmServers
	MsgBox,,HKLM Backup, HKLM failed to backup on: %ErrhklmServers%
If ErrhkcuServers
	MsgBox,,HKCU Backup, HKCU failed to backup on: %ErrhkcuServers%
If ErrregbackupServers
	MsgBox,,Zip Failure, Zip does not exist on: %ErrregbackupServers%
If Err7zServers
	MsgBox,,7z Missing, 7-zip not installed on: %Err7zServers%
FileDelete %A_ScriptDir%\7zstatus.txt
FileDelete %A_ScriptDir%\result.txt
MsgBox,,Registry Backup, Task Complete.
Gui, 1:Show
Return

LoggerBack:
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
Loop, read, %SelectedFileMain%
{
	line := A_LoopReadLine
	If ErrorLevel
		break
	IfNotExist, \\%line%\d$\NTLogger
	{
		ErrLoggerBackServers := ErrLoggerBackServers . "`n" . line
		continue
	}
	Else
	{
		GuiControlGet, MyCheckBox
		If (MyCheckBox = 0)
			Run, %comspec% /k robocopy /E /ETA \\%line%\d$\NTLogger %logloc%\%line%\NTLogger
		Else
			Run, %comspec% /c robocopy /E /ETA \\%line%\d$\NTLogger %logloc%\%line%\NTLogger,, hide
	}
}
If ErrLoggerBackServers 
	MsgBox,,NTLogger Folder, NTLogger folder does not exist in D:\ OR cannot access folder on: %ErrLoggerBackServers%
MsgBox,,Logger Backup, Task Complete.
Return

SecPol:
InputBox, user, User Account, Please enter (comma separated) user account(s) (domain\user):
If ErrorLevel
	Return
If user = 
{
	MsgBox,,User Blank, User account cannot be blank!
	Return
}
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
Loop, read, %SelectedFileMain%
{
	IfNotExist, C:\Program Files (x86)\Windows Resource Kits\Tools
	{
		MsgBox,,Resource Kit, Please install Windows Resource Kit locally to C:\Program Files (x86)\Windows Resource Kits\Tools
		Return
	}
	If ErrorLevel
		Return
	line := A_LoopReadLine
	Loop, parse, user, `,
	{
		GuiControlGet, MyCheckBox
		If (MyCheckBox = 0)
		{
			Run, %comspec% /k ntrights -m \\%line% -u %A_LoopField% +r SeTcbPrivilege
			Run, %comspec% /k ntrights -m \\%line% -u %A_LoopField% +r SeIncreaseQuotaPrivilege
			Run, %comspec% /k ntrights -m \\%line% -u %A_LoopField% +r SeCreateGlobalPrivilege
			Run, %comspec% /k ntrights -m \\%line% -u %A_LoopField% +r SeChangeNotifyPrivilege
			Run, %comspec% /k ntrights -m \\%line% -u %A_LoopField% +r SeImpersonatePrivilege
			Run, %comspec% /k ntrights -m \\%line% -u %A_LoopField% +r SeBatchLogonRight
			Run, %comspec% /k ntrights -m \\%line% -u %A_LoopField% +r SeServiceLogonRight
			Run, %comspec% /k ntrights -m \\%line% -u %A_LoopField% +r SeSecurityPrivilege
			Run, %comspec% /k ntrights -m \\%line% -u %A_LoopField% +r SeAssignPrimaryTokenPrivilege
			Run, %comspec% /k wmic /node:"%line%" process call create "cmd.exe /k net localgroup Administrators "%A_LoopField%" /add"
		}
		Else
		{
			Run, %comspec% /c ntrights -m \\%line% -u %A_LoopField% +r SeTcbPrivilege,, hide
			Run, %comspec% /c ntrights -m \\%line% -u %A_LoopField% +r SeIncreaseQuotaPrivilege,, hide
			Run, %comspec% /c ntrights -m \\%line% -u %A_LoopField% +r SeCreateGlobalPrivilege,, hide
			Run, %comspec% /c ntrights -m \\%line% -u %A_LoopField% +r SeChangeNotifyPrivilege,, hide
			Run, %comspec% /c ntrights -m \\%line% -u %A_LoopField% +r SeImpersonatePrivilege,, hide
			Run, %comspec% /c ntrights -m \\%line% -u %A_LoopField% +r SeBatchLogonRight,, hide
			Run, %comspec% /c ntrights -m \\%line% -u %A_LoopField% +r SeServiceLogonRight,, hide
			Run, %comspec% /c ntrights -m \\%line% -u %A_LoopField% +r SeSecurityPrivilege,, hide
			Run, %comspec% /c ntrights -m \\%line% -u %A_LoopField% +r SeAssignPrimaryTokenPrivilege,, hide
			Run, %comspec% /c wmic /node:"%line%" process call create "cmd.exe /c net localgroup Administrators "%A_LoopField%" /add",, hide
		}
	}
}
MsgBox,,Security Policies, Task complete.
Return

PushLogShortcut:
gui, Submit, nohide
IfNotExist, %SelectedFileMain%
{
	MsgBox,,File Selection, No Server List found %SelectedFileMain%
	Gui, 1:Show
	Return
}
GuiControlGet, MyCheckBox
GuiControlGet, LocDriveLetter
IfNotExist, %LocDriveLetter%:\%company%Tech
	FileCreateDir, %LocDriveLetter%:\%company%Tech
IfNotExist, %LocDriveLetter%:\Program Files\NICE Systems\Logs
	FileCreateDir, %LocDriveLetter%:\Program Files\NICE Systems\Logs
IfNotExist, %LocDriveLetter%:\%company%Tech\Logs.lnk
	FileCreateShortcut, %LocDriveLetter%:\Program Files\NICE Systems\Logs, %LocDriveLetter%:\%company%Tech\Logs.lnk
Loop, read, %SelectedFileMain%
{
	If (MyCheckBox = 0)
		RunWait, %comspec% /k "robocopy /ETA %LocDriveLetter%:\%company%Tech \\%A_LoopReadLine%\c$\Users\Public\Desktop Logs.lnk"
	Else
	{
		Run, %comspec% /c "robocopy /ETA %LocDriveLetter%:\%company%Tech \\%A_LoopReadLine%\c$\Users\Public\Desktop Logs.lnk",, hide, pid
		Gui, Loading:-Caption
		Gui, Loading:Add, Progress, vlvl -Smooth 0x8 w250 h18 ; PBS_MARQUEE = 0x8
		Gui, Loading:Add, Text,, Pushing logs link to %A_LoopReadLine%
		Gui, Hide
		Gui, Loading:Show
		ErrorLevel:=1
		While (ErrorLevel != 0)
		{
			Sleep, 20
			GuiControl,Loading:, lvl, 1
			Process, Exist, % pid
		}
		Gui,Loading:Destroy
	}
}
MsgBox,,Log Shortcut, Task complete.
Gui, 1:Show
Return

AppendServices()
{
GuiControlGet, LocDriveLetter
FileAppend, 
(
AASearchController
ActiveMQ
AuditTrailService
CLSCoreService
CLSDBSrvrService
CLSMonitorService
CLSRCMService
CIMService
CoachingServerService
ContentAnalysisService
EnrollmentService
EvaluationServerService
FLM
FTFQueryServerService
IntegrationBusMasterService_10.0.0.3
IntegrationBusNode_COREIN
IntegrationsDispatch
InvestigationsServerService
IPCapture
LogService
MMLLogger
MMLTrayIcon
MonitorServerService
MQ_NICEMQ
NBAService
NICEAgentCenter
"NICE Archiving Manager"
"NICE BSF Server"
"NICE Connection Manager Service"
"NICE IP Capture"
"NICE MediaCollectionServer"
"Nice Minibus Server"
NiceIPPhoneApplications
NiceKeepAliveService
NiceJmxAgent
NiceMyUniverse
"NICE Recorder Administrator"
"NICE Recording Sessions Manager"
NiceRetentionService
"NICE Retriever"
"NICE Screen Capture"
"NICE ScreenCapture AIR"
NICETextCaptureAIR
NotificationService
NTLoggerSvc
PlaybackAdministration
PlaybackStreaming
RuleEngineService
RulesManagerService
SCLoader
SearchTomcat7
Searchzookeeper
SystemAdminService
TextAnalysisService
TRSService
), %LocDriveLetter%:\%company%Tech\services.txt
}

APPGuiSize:
	Anchor("appnode", "hw", true)
	Anchor("AppBtn", "xy", true)
Return

IISGuiSize:
	Anchor("ServerSelectionIIS", "hw", true)
	Anchor("Btn", "xy", true)
Return

DBGuiSize:
	Anchor("ServerSelectionDB", "hw", true)
	Anchor("DBBtn", "xy", true)
Return

SCCGuiSize:
	Anchor("BindServerSelection", "hw", true)
	Anchor("BindBtn", "xy", true)
Return

AppGuiClose:
AppGuiEscape:
Gui, App:Destroy
Gui, 1:Show
Return

IISGuiClose:
IISGuiEscape:
Gui, IIS:Destroy
Gui, 1:Show
Return

DBGuiClose:
DBGuiEscape:
Gui, DB:Destroy
Gui, 1:Show
Return

SCCGuiClose:
SCCGuiEscape:
Gui, SCC:Destroy
Gui, 1:Show
Return

About:
MsgBox,, CommandLoop, Version: %version% `n`nCopyright 2017 Scott Brescia `n`nLicensed under the Apache License, Version 2.0 (the "License"); `nyou may not use this file except in compliance with the License. `n You may obtain a copy of the License at `n`nhttp://www.apache.org/licenses/LICENSE-2.0 `n`nUnless required by applicable law or agreed to in writing, software `ndistributed under the License is distributed on an "AS IS" BASIS, `nWITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, `neither express or implied. See the License for the `nspecific language governing permissions and limitations `nunder the License.
Return

ExitSub:
GuiClose:
GuiEscape:
IfExist %A_ScriptDir%\checkos.txt
	FileDelete, %A_ScriptDir%\checkos.txt
IfExist %A_ScriptDir%\result.txt
	FileDelete, %A_ScriptDir%\result.txt
IfExist %A_ScriptDir%\Logs.lnk
	FileDelete, %A_ScriptDir%\Logs.lnk
IfExist %A_ScriptDir%\FuncTstr.lnk
	FileDelete, %A_ScriptDir%\FuncTstr.lnk
IfExist %A_ScriptDir%\Nice Services Configuration Manager.lnk
	FileDelete, %A_ScriptDir%\Nice Services Configuration Manager.lnk
IfExist %A_ScriptDir%\Logoff.lnk
	FileDelete, %A_ScriptDir%\Logoff.lnk
Gui, Destroy
Gui, IIS:Destroy
ExitApp
Exit