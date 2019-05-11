;;; @file
;;; @author     Terry Ebdon
;;; @date       11-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Sysgen RSTS/E V9 from tape on an 11/84.

set noverify
set noverbose
set message
set quiet

set env rstsVersion=V95
set env distroFolder=distro/rsts.org/
set env diskImage=sysgen_%rstsVersion%_rm03.dsk
set env bootTapeImage=%distroFolder%%rstsVersion%BOOT.TAP
set env ansiTapeImage=%distroFolder%%rstsVersion%ANSI.TAP
set env libTapeImage=%distroFolder%V9LIB.TAP

echo ### Installing RSTS %rstsVersion% from %bootTapeImage% to %diskImage%
do Configure1184.do
;;; -----------------------------------------
;;; do CreateSysgenPack.do    %diskImage%
;;; -----------------------------------------
echo ANSI tape image: "%ansiTapeImage%"
set noquiet
do AttachSysgenMediaV8.do %diskImage% %bootTapeImage%
if exist "%ansiTapeImage%" attach -r TM1 %ansiTapeImage%
if NOT exist "%libTapeImage%"  echo !!! ERROR -- Missing library tape
if NOT exist "%libTapeImage%"  exit

show TM0
show TM1
show TM2
show RP0
;return
do InitDateTime.do
expect "Installing RSTS on a new system disk? <Yes>" send "\n"
do BootDevice.do TM0

do Dskint.do DR0 SYSTEM YES
expect "Start timesharing? <Yes>"
go
; RSTS V9 runs performs COPY automatically.
send "\n"
noexpect
do V9/StartSysgen.do
go
detach tm1
attach -r TM2 %libTapeImage%

do V9/BasicPlusGeneration.do
;
; should be at the install sort/merge message.
noexpect
nosend
expect "Do you want to proceed with the default installation" send "YES\r"; go
expect "ARE THE ABOVE DEFAULTS THE DESIRED ONES" send "YES\r"; go
expect "System tape label default set to DOS"
;
; @todo shutdown
; @todo install RSTS.SIL
