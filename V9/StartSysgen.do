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

expect "Do you want to perform an installation or an update?" send "INSTALLATION\r"; go
expect "Installation device?" send "MT0\r"; go
if exist "%ansiTapeImage%" expect "Where can this volume be located?" send "MT1\r"; go
expect "$ " send "RUN [0,1]INSTAL"; go
expect "Are you ready to proceed?" send "YES";  go
expect "Installation device"  send "MT1:\r";    go
expect "Target disk?"         send "SY:\r";     go
expect "Do you want to install the RSTS/E monitor?" send "YES\r"; go
expect "Use template monitor ?"       send "NO\r";    go
expect "New Monitor name ?"           send "RSTS\r";  go
expect "Accept defaults"              send "NO\r";    go
expect "Accept Terminal defaults"     send "NO\r";    go
expect "DL11A compatible lines ?"     send "1\r";     go
expect "DL11C, DL11D's ?"             send "0\r";     go
expect "DL11E,DLV11E's ?"             send "0\r";     go
expect "DJ11's ?"                     send "0\r";     go
expect "DH11's ?"                     send "0\r";     go
expect "DZ11/DZV11/DZQ11's ?"         send "2\r";     go
expect "DZ11/DZV11/DZQ11's ?"         send "2\r";     go
expect "DZ11 unit 00 lines enabled ?" send "8\r";     go
expect "DZ11 unit 01 lines enabled ?" send "8\r";     go
expect "Dataset support for DZ11's ?" send "NO\r";     go
expect "DHU11's ?"                    send "0\r";     go

;;; @todo This section is re-usable for V8.0
;;;
expect "Pseudo keyboards ?"             send "\n";    go
expect "Multi-terminal service ?"       send "\n";    go
expect "Echo control ?"                 send "\n";    go
expect "One-line status report ?"       send "\n";    go
expect "FMS-11 support ?"               send "\n";    go
expect "Multiple private delimiters ?"  send "\n"
go

; Disks
;;; @todo this section is re-usable for V8.0
;;;
expect "RK05's ?"            send "08\r";     go
expect "Overlapped seek ?"   send "YES\r";    go
expect "RL01/RL02's ?"       send "4\r";      go
expect "Overlapped seek ?"   send "YES\r";    go
expect "RK06/RK07's ?"       send "8\r";      go
expect "Overlapped seek ?"   send "YES\r";    go
expect "RP02/RP03's ?"       send "0\r";      go

expect "Disks on DR controller ?" send "08\r";  go
expect "Overlapped seek ?"        send "YES\r"; go
expect "Disks on DB controller ?" send "00\r";  go
expect "Overlapped seek ?"        send "YES\r"; go
expect "MSCP support ?"           send "YES\r"; go

expect "Accept Peripheral defaults ?" send "NO\r"; go

; Tapes
;;; @todo this section is re-usable for V8.0
;;;
expect "TU16/TE16/TU45/TU77's ?"   send "0\r";    go
expect "TU10/TE10/TS03's ?"        send "8\r";    go
expect "TS11/TSV05/TU80's ?"       send "0\r";    go
expect "DECtapes ?"                send "0\r";    go

expect "TMSCP tape drives ?"       send "1\r";    go

; Printers, floppies & punch devices
;;; @todo this section is re-usable for V8.0
;;;
expect "Printers ?"                send "1\r";    go
expect "RX01/RX02's ?"             send "8\r";    go
expect "CR11/CM11 card reader ?"   send "YES\r";  go
expect "CD11 card reader ?"        send "NO\r";   go
expect "Card decode ?"             send "ANSI\r"; go
expect "P.T. reader / punch ?"     send "YES\r";  go

;;; @todo this section is re-usable for V8.0
;;;
expect "DMC11's/DMR11's ?"           send "0\r";    go
expect "KMC11's ?"                   send "0\r";    go
expect "Extended buffering for LP ?" send "YES\r";  go

; **NOT** asked in V8
expect "DMV11's/DMP11's ?"            send "0\r";   go
expect "RJ2780 support ?"             send "NO\r";  go

expect "Accept Software defaults ?"   send "NO\r";  go

; Capacity and features
expect "Maximum jobs ?"       send "25\r";    go
expect "Small buffers ?"      send "355\r";   go
expect "Monitor statistics ?" send "NO\r";    go
expect "EMT Logging ?"        send "NO\r";    go

; System programs
expect "Do you want to install the System Program packages?" send "YES\r"; go
expect "Packages to install: ?"                              send "ALL\r"; go
expect "Proceed?"                                            send "YES\r"; go
expect "Do you want the I&D versions of tasks?"              send "YES\r"; go
expect "Use resident library version of RMS?"                send "YES\r"; go
expect "Use RMS resident libraries in DAP?"                  send "YES\r"; go
expect "Use RMS resident libraries in PBS?"                  send "YES\r"; go
expect "Use resident library version of EDT?"                send "YES\r"; go

; Layered products
expect "from the Installation kit?"             send "YES\r";     go
expect "Product updates to transfer:"           send "ALL";       go
expect "Proceed?"                               send "YES\r";     go
expect "Patch account <PATCH$:> :"              send "\r";        go
expect "New password:"                          send "system\r";  go
expect "New password again, for verification:"  send "system\r";  go
expect "Are you ready to proceed?"              send "YES\r";     go

expect "Do you want _SY0:SWAP1.SYS created?"    send "YES\r";     go
expect "Library device?"
go
; return back to caller for library tape to be mounted.
