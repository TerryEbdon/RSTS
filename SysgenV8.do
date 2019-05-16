;;; @file
;;; @author     Terry Ebdon
;;; @date       09-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Sysgen RSTS/E V8 from tape on an 11/84.

do common/SetVars.do
set noverify
set noverbose
set message
set quiet

; Reset
noexpect
nosend
det RP0
det HK1
det TM0

set env consolePort=8001
set env logDir=logs
set env logPrefix=%logDir%/%~n0
set env debugLog=%logPrefix%_debug.log
set env puttyLog=%logPrefix%_putty.log

;if not exist "%logDir%" !mkdir %logDir%
!mkdir %logDir%
if exist "%debugLog%" delete %debugLog%
if exist "%puttyLog%" delete %puttyLog%
set debug %debugLog%

; PuTTY will not be attached to the console until RSTS/E boots.
; This avoids having a distracting blank window hanging around.,

set env msg=
set env varsSet
do common/SetVars.do

do Configure1184.do

set env sv8_diskImage=sysgen_v8_rm03.dsk

do CreateSysgenPack.do    %sv8_diskImage%
do AttachSysgenMediaV8.do %sv8_diskImage%
if "%msg%" != "" return

echo ### Creating scratch pack, to contain a working copy of the distro.

do common/AttachScratchDisk.do HK1 scratch_rk07.dsk
if "%msg%" != "" return

; Until now there was nothing to display on an attached console.
; Once the system boots it will see ativity.
set console telnet=%consolePort%
!start putty -sessionlog %puttyLog% -telnet localhost %consolePort%

do common/BootDevice.do TM0

; RSTS refers to RP0: as DR0:
; Must provide a [1,2] password to avoid CREATE.SAV failing in a later step.

do Dskint.do DR0 SYSTEM
do common/ExpectOptionPrompt.do
if "%msg%" != "" ignore; msg; exit

do Dskint.do DM1 *
do common/ExpectOptionPrompt.do
if "%msg%" != "" ignore; msg; return

noexpect
do CopySystemTo.do DR0:

noexpect
do InstallSil.do SYSGEN
do SetDefaults.do
do AddSwapAndCrashFiles.do 256 260
do common/BootDevice.do RP0
do V8/StartSysgen.do
do RunSysbat.do
go

echo At this point the new SIL has been built. Let's try using it...

noexpect
do common/UtShutup.do

nosend
do InstallSil.do  RSTS
do SetDefaults.do BASIC
; SWAP and CRASH files were created in an earlier step.
; Now start the system running the new SIL and RTS...
send "\n"
do InitDateTime.do
expect "Ready"
go
do CopyDistroFrom.do  MT0: DM1: TEST
if "%msg%" != "" ignore; msg; exit

do RunPatCpy.do       DM1: [1,2]
if "%msg%" != "" ignore; msg; exit

do RunBuild.do        DM1: BUILD
if "%msg%" != "" ignore; msg; exit
