;;; @file
;;; @author Terry Ebdon
;;; @date   08-MAY-19
;;; Create new VHD and format it.
;;; @arg %1 simulated device ID
;;; @arg %2 VHD file to create
;;; @return error message in environment variable msg

set env msg=
if "%1" == "" set env msg=echo ?No device ID in argument 1
if "%2" == "" set env msg=echo ?No VHD file name in argument 2
if exist "%2" set env msg=echo ?VHD already exists

if ( "%msg" != "" ) %msg; return 12

set env devToFormat=%1
set env vhdFile=%2

attach -I -N %devToFormat %vhdFile

send "DSKINT\r"
expect "?"                            send "%DATE_DD%-%DATE_MMM%-99\r"; go
expect "?"	                          send "%TIME_HH%:%TIME_MM%\r";     go
expect "Disk? "                       send "DL3:\r";  go
expect "Pack ID? "                    send "TEST\r";  go
expect "Pack cluster size"            send "\n";      go
expect "MFD cluster size"             send "\n";      go
expect "SATT.SYS base"                send "\n";      go
expect "Pre-extend directories <NO>?" send "\n";      go
expect "PUB, PRI, or SYS <PRI>?"      send "\n";      go
expect "Create account [1,1] <NO>?"   send "\n";      go
expect "Create account [1,2] <NO>?"   send "YES\r";   go
expect "[1,2] password <*>?"          send "\n";      go
expect "[1,2] cluster size"           send "\n";      go
expect "[1,1] and [1,2] account base" send "\n";      go
expect "Date last modified"           send "\n";      go
expect "New files first"              send "\n";      go
expect "Read-only <NO>?"              send "\n";      go
expect "Patterns <3>?"                send "\n";      go
expect "Continue with DSKINT?"        send "YES\r";   go
expect "Proceed (Y or N)?"            send "Y\r";     go
expect "Patterns <3>?"                send "\n";      go
expect "Proceed (Y or N)?"            send "Y\r";     go

go
