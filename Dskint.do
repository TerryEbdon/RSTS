;;; @file
;;; @author Terry Ebdon
;;; @date   MAY-19
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Create new VHD and format it.
;;; @arg %1 simulated device ID
;;; @arg %2 Password for [1,2], defsult is no password.
;;; @note You must provide a password if this is the target
;;; drive for a sysgen. CREATE.SAV will fail if there is no
;;; [1,2] password.
;;; @warning This may leave unused expectations

if "%1" == "" set env msg=echo ?No device ID in argument 1
if ( "%msg" != "" ) %msg; return

set env password=\n
if "%2" != "" set env password=%2\r

set env devToFormat=%1
echo ### Initialising disk %devToFormat% -- This will take a while...

send "DSKINT\r"
do InitDateTime.do
expect "Disk? "                       send "%devToFormat%\r"; go
expect "Pack ID? "                    send "TEST\r";          go
expect "Pack cluster size"            send "\n";              go
expect "MFD cluster size"             send "\n";              go
expect "SATT.SYS base"                send "\n";              go
expect "Pre-extend directories <NO>?" send "\n";              go
expect "PUB, PRI, or SYS <PRI>?"      send "\n";              go
expect "Create account [1,1] <NO>?"   send "\n";              go
expect "Create account [1,2] <NO>?"   send "YES\r";           go
expect "[1,2] password <*>?"          send "%password%";      go
expect "[1,2] cluster size"           send "\n";              go
expect "[1,1] and [1,2] account base" send "\n";              go
expect "Date last modified"           send "\n";              go
expect "New files first"              send "\n";              go
expect "Read-only <NO>?"              send "\n";              go


; This is only asked if the pack
; already has bad block info.
expect "Use previous bad block info"  send "YES\r"             go

; The format question is not always asked.
; When booted from tape it *is* asked.

expect "Format <NO>?"                 send "\n";      go
expect "Patterns <3>?"                send "\n";      go
expect "Continue with DSKINT?"        send "YES\r";   go
expect "Proceed (Y or N)?"            send "Y\r";     go
expect "Patterns <3>?"                send "\n";      go
expect "Proceed (Y or N)?"            send "Y\r";     go
