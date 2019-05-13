;;; @file
;;; @author     Terry Ebdon
;;; @date       09-MAY-19
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Start RSTS/E with SYSGEN.SIL and run CREATE.SAV
;;; This will copy files from the distribution tape to
;;; the system disk and run the sysgen Q&A with
;;; appropriate responses.
;;; @arg %1 Device distribution kit is mounted on, defaults to MT0:
;;; @arg %2 For a disk distribution, the label of the pack to be mounted.

set env ddDev=MT0:
if "%1" != "" set env ddDev=%1

send "\n"
do InitDateTime.do

expect "?Can't find file or account" echo
if "%2" != "" send "MOUNT %ddDev%%2\r"
go
send "R %ddDev%CREATE.SAV\r"

expect "Form ?"         send "\n"; go
expect "Same system ?"  send "\n"; go

; This step may be an issue, as the distribution
; tape seems to have the files in the wrong order.
expect "Distribution medium ?"  send "\n"; go

expect "Output medium ?                 #SY#"    send "\n";  go
expect "Delete files ?                  #NO#"    send "\n";  go
expect "LP for SYSGEN ?                 #NO#"    send "\n";  go
expect "Generate monitor ?              #Y #"    send "\n";  go
expect "Monitor name ?                  #RSTS#"  send "\n";  go

; No patches on the distribution tape.
; I'll come back to this later.
expect "Monitor patching ?              #??#"    send "NO\r";  go

expect "Generate BASIC-PLUS ?           #Y #"    send "\n";  go
expect "BASIC-PLUS RTS name ?           #BASIC#" send "\n";  go

; No patches on the distribution tape.
; I'll come back to this later.
expect "BASIC-PLUS patching ?           #??#"    send "NO\r";  go
expect "RSX as default RTS ?            #NO#"    send "YES\r"; go
expect "RSX patching ?                  #??#"    send "NO\r";
go

; Start of hardware configuration

; Terminals
do %~p0../common/SerialCards.do

expect "DZ11/DZV11's ?                  *02*"   send "\n";    go
expect "Multiplexer type (DZ11/DZV11) ? #DZ11#" send "\n";    go
expect "2741 support ?                  #NO#"   send "\n";    go

do %~p0../common/TerminalOptions.do

; Disks
expect "RF/RS11's ?                     *NO*"   send "\n";    go
expect "RS03/RS04's ?                   *00*"   send "\n";    go

do %~p0../common/DiskOptions.do

expect "RM02/RM03/RM05/RM80's ?         *08*"   send "\n";    go
expect "Overlapped seek ?               *Y *"   send "\n";    go
expect "RP04/RP05/RP06's ?              *00*"   send "\n";    go
expect "MSCP controllers ?              *01*"   send "\n";    go

; Tapes
do %~p0../common/TapeOptions.do
expect "TU58's ?                        *00*"   send "\n";    go

do %~p0../common/SlowMedia.do
do %~p0../common/MicroControllers.do

expect "DECnet network support ?        #NO#"   send "\n";    go
expect "Maximum jobs ?                  #10#"   send "15\r";  go
expect "Small buffers ?                 #215"   send "\n";    go
expect "System wide logicals ?          #25#"   send "\n";    go
expect "Monitor statistics ?            #NO#"   send "\n";    go
expect "EMT Logging ?                   #NO#"   send "\n";    go
expect "Directory caching ?             #Y #"   send "\n";    go
expect "Data Caching ?                  #NO#"   send "\n";    go
expect "Resident libraries ?            #Y #"   send "\n";    go
expect "RSX directives ?                #Y #"   send "\n";    go
expect "Resident file open/close ?      #Y #"   send "\n";    go
expect "Resident send/receive ?         #Y #"   send "\n";    go
expect "Resident simple SYS calls ?     #Y #"   send "\n";    go
expect "Resident file delete/rename ?   #Y #"   send "\n";    go
expect "Resident attribute ?            #Y #"   send "\n";    go
expect "Resident directory lookup ?     #Y #"   send "\n";    go

; BASIC-PLUS
expect "FPP ?                           *Y *"   send "\n";    go
expect "Math precision ?                #02#"   send "\n";    go
expect "Log functions ?                 #Y #"   send "\n";    go
expect "Trig functions ?                #Y #"   send "\n";    go
expect "Print using ?                   #Y #"   send "\n";    go
expect "Matrices ?                      #NO#"   send "YES\r"; go
expect "String arithmetic ?             #NO#"   send "\n";    go

expect "RUN $SYSBAT" echo
go
