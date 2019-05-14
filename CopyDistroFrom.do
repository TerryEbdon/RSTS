;;; @file
;;; @author     Terry Ebdon
;;; @date       13-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Copy distribution kit to disk.
;;; @arg %1 Distribution device, e.g. MT0:
;;; @arg %2 Target device, e.g. DR1:
;;; @arg %3 target pack label. If provided then a MOUNT will be executed.
;;;
;;; @note Copy distribution kit to disk. This shouldn't be needed, but
;;; files on the RSTS V8 tape, from rsts.org, appear to be in the
;;; wrong order. This only matters because BUILD.BAS uses /MO:2
;;; when retrieving files. (Mode 2 prevents the tape from rewinding).
;;; To work around this I run REACT to create a new account, then
;;; use PIP to copy the files. This requires a combination of the
;;; BASIC and RT11 run-time systems, so UTILTY is also needed.
;;; @todo: Build a "repaired" distribution kit, to avoid this mess.

if "%1" == "" set env msg=echo Distribution device required as argument 1
if "%2" == "" set env msg=echo Target device required as argument 2
if "%msg%" != "" %msg%; return

set env cdfdb_disDev=%1
set env cdfdb_targetDev=%2
set env cdfdb_packLabel=%3

do common/SetVars.do

send 'KILL "UTILTY.BAC"\r'
expect "\r\nReady\r\n"
go
send "old %cdfdb_disDev%UTILTY\r"
; UTILTY refuses to run from source, it has to be compiled.
expect "\r\nReady\r\n" send "COMPILE\r"; go
expect "\r\nReady\r\n" send "RUN $UTILTY.bac\r"; go

; Make sure it stops at a prompt
%expectReady% set env msg=echo !!! ERROR premature exit from UTILTY
expect "#"
go

if "%msg%" != "" noexpect; %msg%
if "%msg%" != "" return

; Got a # prompt, so cancel the "Ready" expectation.
noexpect

send "ADD RT11\r"
expect "#" send "%CTRL-Z%"; go

expect "\r\nReady\r\n" send "OLD %cdfdb_disDev%REACT\r"; go
expect "\r\nReady\r\n" send "COMPILE\r"; go
expect "\r\nReady\r\n"
go
noexpect
send "! UTILTY and REACT are now available.\r!\r"
expect "?Pack IDs don't match\r\n" noexpect; set env msg=echo ?Bad pack label in arg 3 - %cdfdb_packLabel%
expect "?Account or device in use\r\n" noexpect; set env msg=echo ?Disk already mounted?
if "%3" != "" send "MOUNT %cdfdb_targetDev%%cdfdb_packLabel%\r"

do AddAccount.do [1,2] 16 %cdfdb_targetDev%*
if "%msg%" != "" nosend; noexpect; %msg%; return

expect "?Too many open files on unit" noexpect;  set env msg=echo ?Couldn't run PIP
send "run pip\r"
expect "\r\n*"                                send "%cdfdb_targetDev%[1,2] /ZE\r"; go
expect "Really zero %cdfdb_targetDev%[1,2] ?" send "YES\r"; go
expect "\r\n*"                                send "%cdfdb_targetDev%=%cdfdb_disDev% /LO\r"; go
expect "\r\n*"                                send "%CTRL-Z%\r"; go

expect "\r\nReady\r\n"
go
if "%msg%" != "" %msg%; %expectReady%; %abort%; go

noexpect
set env cdfdb_disDev
set env cdfdb_targetDev
set env cdfdb_packLabel
