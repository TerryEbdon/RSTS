;;; @file
;;; @author     Terry Ebdon
;;; @date       09-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Sysgen RSTS/E V8 from tape on an 11/84.

set noverify
set noverbose
set message
set quiet

do Configure1184.do

set env sv8_diskImage=sysgen_v8_rm03.dsk

do CreateSysgenPack.do    %sv8_diskImage%
do AttachSysgenMediaV8.do %sv8_diskImage%

if "%msg%" != "" exit

do BootDevice.do TM0

; RSTS refers to RP0: as DR0:
; Must provide a [1,2] password to avoid CREATE.SAV failing in a later step.
do Dskint.do DR0 SYSTEM
expect "Option: " echo
go

noexpect
do CopySystemTo.do DR0:

noexpect
do InstallSil.do SYSGEN
do SetDefaults.do
do AddSwapAndCrashFiles.do 256 260
do BootDevice.do           RP0
do StartSysgen.do
do RunSysbat.do
