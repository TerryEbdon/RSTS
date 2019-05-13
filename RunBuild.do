;;; @file
;;; @author     Terry Ebdon
;;; @date       13-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Build the system configured by the Q&A.
;;; @arg %1 source device
;;; @arg %2 control file
;;; @pre The primary run-time system is BASIC-PLUS.

if "%1"=="" set env msg=echo ?source device is mandatory
if "%2"=="" set env msg=echo ?Control file is mandatory

set env distDev=%1
set env ctlFile=%2

send "RUN %distDev%$BUILD\r"
expect "System Build <No> ?"                  send "YES\n"; go
expect "Source Input Device"                  send "%distDev%\r";  go
expect "Library Output Device <SY:> ?"        send "\n";    go
expect "Target System Device <SY0:> ?"        send "\n";    go
expect "Library Account <[1,2]> ?"            send "\n";    go
expect "Control File is ?"                    send "%ctlFile%\r";  go
expect "Locate logical 'LB:' on"              send "SY:[1,1]\r";   go
expect "Create account SY:[1,1]"              send "YES\r"; go
expect "Function (Build/Patch, Patch, Build)" send "\n";    go

expect "Patch file input location"            send "SY:[200,200]\r"; go

expect "Save patched sources"                 send "YES\r"; go
expect "Write patched sources to"             send "SY:[200,200]\r"; go
expect "Run-Time System "                     send "BASIC\r"; go
expect "Locate ERROR Package on"              send "SY:[2,3]\r"; go
expect "Create account SY:[2,3] <No>?"        send "YES\r"; go

expect "Additional Control File is"           send "\n"; go
expect "Processing ended" echo
