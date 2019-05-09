;;; @file
;;; @author Terry Ebdon
;;; @date   MAY-19
;;; Copy a minimal system from the boot device
;;; @arg RSTS device to copy to, e.g. DR0:

if "%1" == "" set env msg=echo ?No device ID in argument 1
if ( "%msg" != "" ) %msg; return
set env targetDevice=%1

echo ### Copying minimal system to %targetDevice%

send "COPY\r"
do InitDateTime.do
expect "To which disk" send "%targetDevice%\r"; go

; If the disk has already been initialised then...
;
expect "File INIT.SYS already exists. SUPERSEDE?" send "YES\r"; go
expect "File ERR.ERR already exists. SUPERSEDE?" send "YES\r";  go
expect "File SYSGEN.SIL already exists. SUPERSEDE?" send "YES\r";  go
expect "File RT11.RTS already exists. SUPERSEDE?" send "YES\r";  go

expect "Option: " echo
go
set env targetDevice=
