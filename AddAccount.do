;;; @file
;;; @author     Terry Ebdon
;;; @date       13-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Create new account from on a disk.
;;; @arg %1 PPN to be created.
;;; @arg %2 Cluster size.
;;; @arg %3 Device & password as DEV:PWD, e.g. DR1:*. Defaults to SY:*

do common/SetVars.do
if "%1" == "" set env msg=echo PPN required as argument 1
if "%2" == "" set env msg=echo cluster size required as argument 2

if "%msg%" != "" %msg%; return

set env ppn=%1
set env devPwd=SY:*
set env clusterSize=%2
if "%2" !="" set env devPwd=%3

;send "%CTRL-C%"
;expect "\r\nReady\r\n"                  send "RUN $REACT\r";    go
send "RUN $REACT\r"
expect "?Disk pack is not mounted\r\n" noexpect; set env msg=echo ?Disk not mounted: %devPwd%
expect "?Illegal Command" noexpect; set env msg=echo ?Command sequencing error?
expect "Function?"                      send "E\r";             go
expect "Proj,Prog?"                     send "%ppn%\r";         go
expect "Disk:Password?"                 send "%devPwd%\r";      go
expect "Quota <0> ?"                    send "\n";              go
expect "Cluster Size <0> ?"             send "%clusterSize%\r"; go
expect "Number of Clusters (0-7) <1> ?" send "\n";              go
expect "Position <0> ?"                 send "\n";              go
expect "Account Name?"                  send "\n";              go
expect "Proj,Prog?"                     send "%CTRL-Z%";        go

expect "\r\nReady\r\n"
go
set env ppn
set env devPwd
set env clusterSize
