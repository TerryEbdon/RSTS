;;; @file
;;; @author Terry Ebdon
;;; @date   MAY-19
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Create new VHD and format it.
;;; @arg %1 simulated device ID
;;; @arg %2 Password for [1,2], default is no password.
;;; @arg %3 Suppress sending DSKINT command, defaults to NO. Set to YES for RSTS 9
;;;
;;; @note You must provide a password if this is the target
;;; drive for a sysgen. CREATE.SAV will fail if there is no
;;; [1,2] password.
;;; @warning This may leave unused expectations

do common/setVars.do

if "%1" == "" set env msg=echo ?No device ID in argument 1
if ( "%msg" != "" ) %msg; return

set env password=\n
if "%2" != "" set env password=%2\r

set env devToFormat=%1
echo ### Initialising disk %devToFormat% -- This will take a while...

if "%3" != "YES" send "DSKINT\r"; do InitDateTime.do

expect "?Illegal disk name\r\n" noexpect; set env msg=echo ?Bad disk name %devToFormat% in arg 1

expect "Disk? "                       send "%devToFormat%\r"; go
expect "Pack ID? "                    send "TEST\r"; noexpect "?Illegal disk name\r\n"; go
expect "Pack cluster size"            send "\n";              go
expect "MFD cluster size"             send "\n";              go
expect "SATT.SYS base"                send "\n";              go
expect "Pre-extend directories <NO>?" send "\n";              go
expect "PUB, PRI, or SYS"             send "\n";              go

; The next three questions will not be asked on V9 booted from tape.
; @todo Flush, or conditionally add, these expectations.
expect "Create account [1,1] <NO>?"   send "\n";              go
expect "Create account [1,2] <NO>?"   send "YES\r";           go
expect "[1,2] password <*>?"          send "%password%";      go

; [1,1] Cluster size asked only on V9?
expect "[1,1] cluster size"           LF; go
expect "[1,2] cluster size"           LF; noexpect "[1,1] cluster size"; go
expect "[1,1] and [1,2] account base" LF; noexpect "Create account [1,1] <NO>?"; go
expect "Date last modified"           LF; noexpect "Create account [1,2] <NO>?"; go
expect "New files first"              LF; noexpect "[1,2] password <*>?";        go
expect "Read-only <NO>?"              LF; go

; This is only asked if the pack
; already has bad block info... maybe.
expect "Use previous bad block info"  send "YES\r"; go

; The format question is not always asked.
; When booted from a tape it *is* asked.

expect "Format <NO>?"                 send "\n";      go

; Try with zero patterns, which is faster and will work if there's factory
; error information.

expect "Patterns <3>?"                send "0\r";     go
expect "Proceed (Y or N)?"            send "Y\r";     go

; If there's no factory error info,
; e.g. the set <dev> BADBLOCK command wasn't
; issued, then run the mandatory 3 patterns.
; Only prompts "Continue with DSKINT?" if there's *not*
; error info present.

expect "Continue with DSKINT?"        send "YES\r";   go
expect "Patterns <3>?"                send "\n";      go
expect "Proceed (Y or N)?"            send "Y\r";     go

; If there *was* factory error info present
; then flush the redundant expectations

expect "Disk pack serial number" noexpect "Continue with DSKINT?"; go
expect "Erasing disk" noexpect "Patterns <3>?"; noexpect "Proceed (Y or N)?"; go
