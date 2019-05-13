;;; @file
;;; @author Terry Ebdon
;;; @date   09-MAY-19
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Boot Add a system file using REFRESH
;;; @arg %1 Name of file to create
;;; @arg %2 Size of file to create file
;;; @warning
;;; - If the file exists it will be deleted and recreated.
;;; - This script will flush all prior expectations.
;;; - There will be an unfulfilled expectation if the file does **not** exist.

if "%1" == "" set env msg=echo ?arg 1 must be a valid system file name
if "%2" == "" set env msg=echo ?arg 2 must be a valid size for the system file
if ( "%msg" != "" ) %msg; return

send "REFRESH\r"
do InitDateTime.do
expect "Disk?"              send "\n";   go
expect "Rebuild?"           send "\n";   go
expect "REFRESH suboption?" send "FI\r"; go

expect "File name?"              send "%1\r";  go
expect "File exists. Delete it?" send "YES\r"; go

; File name re-prompted after a deletion
expect "File name?"              send "%1\r";  go
expect "Size?"                   send "%2\r";

go
; If the file did *not* previously exist the there will be an unfulfilled
; expectation for "File name?". This has to be flushed to allow a clean
; escape from REFRESH.
noexpect

expect "Base?"                   send "\n";    go
expect "Deletable?"              send "\n";    go
expect "File name?"              send "\n";    go

expect "REFRESH suboption?"      send "\n";    go
expect "Option: " echo
go
