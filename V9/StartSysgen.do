;;; @file
;;; @author     Terry Ebdon
;;; @date       11-MAY-19
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Start RSTS/E V9.7 with SYSGEN.SIL to begin sysgen Q&A
;;; This will copy files from the distribution tape to
;;; the system disk and run the sysgen Q&A with
;;; appropriate responses.
;;; @arg %1 Device distribution kit is mounted on, defaults to MT0:
;;; @arg %2 For a disk distribution, the label of the pack to be mounted.

expect "?File _SY0:[0,1]START.COM not found" send "run [0,1]instal\r"; go

expect "Are you ready to proceed?" send "YES\r";  go
expect "Installation device"  send "MT1:\r";    go
expect "Target disk?"         send "SY:\r";     go
expect "Do you want to install the RSTS/E monitor?" send "YES\r"; go
expect "Use template monitor ?"       send "NO\r";    go
expect "New Monitor name ?"           send "RSTS\r";  go
expect "Accept defaults"              send "NO\r";    go
expect "Accept Terminal defaults"     send "NO\r";    go

do %~p0../common/SerialCards.do

expect "DZ11/DZV11/DZQ11's ?"         send "2\r";     go
expect "DHU11's ?"                    send "0\r";     go

do %~p0../common/TerminalOptions.do
expect "Accept Disk defaults ?" send "NO\r"; go
do %~p0../common/DiskOptions.do

expect "Disks on DR controller ?" send "08\r";  go
expect "Overlapped seek ?"        send "YES\r"; go
expect "Disks on DB controller ?" send "00\r";  go
expect "Overlapped seek ?"        send "YES\r"; go
expect "MSCP support ?"           send "YES\r"; go

expect "Accept Peripheral defaults ?" send "NO\r"; go

do %~p0../common/TapeOptions.do
expect "TMSCP tape drives ?"       send "1\r";    go

do %~p0../common/SlowMedia.do

do %~p0../common/MicroControllers.do
expect "DMV11's/DMP11's ?"            send "0\r";   go

expect "RJ2780 support ?"             send "NO\r";  go

expect "Accept Software defaults ?"   send "NO\r";  go

; Capacity and features
expect "Maximum jobs ?"       send "25\r";    go
expect "Small buffers ?"      send "542\r";   go
expect "Monitor statistics ?" send "NO\r";    go
expect "EMT Logging ?"        send "NO\r";    go

; System programs
expect "Do you want to install the System Program packages?" send "YES\r"; go
expect "Packages to install:"                                send "ALL\r"; go
expect "Proceed?"                                            send "YES\r"; go
expect "Do you want the I&D versions of tasks?"              send "YES\r"; go
expect "Use resident library version of RMS?"                send "YES\r"; go
expect "Use RMS resident libraries in DAP?"                  send "YES\r"; go
expect "Use RMS resident libraries in PBS?"                  send "YES\r"; go
expect "Use resident library version of EDT?"                send "YES\r"; go

; Layered products
expect "from the Installation kit?"             send "YES\r";     go
expect "Product updates to transfer:"           send "ALL\r";     go
expect "Proceed?"                               send "YES\r";     go
expect "Patch account <PATCH$:> :"              send "\r";        go
expect "New password:"                          send "system\r";  go
expect "New password again, for verification:"  send "system\r";  go
expect "Are you ready to proceed?"              send "YES\r";     go

expect "Do you want _SY0:SWAP1.SYS created?"    send "YES\r";     go
expect "Library device?"
go
; return back to caller for library tape to be mounted.
