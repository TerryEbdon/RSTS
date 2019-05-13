;;; @file
;;; @author     Terry Ebdon
;;; @date       13-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Delete account from a disk.
;;; @arg %1 PPN to be deleted.
;;; @arg %2 Device to be deleted from.

if "%1" == "" set env msg="echo PPN required as argument 1"
if "%2" == "" set env msg="echo Device required as argument 2"

if "%msg%" != "" %msg%; return

set env ppn=%1
set env device=%2
set env CTRL-C=\003
set env CTRL-Z=\032

send "%CTRL-C%"
expect "\r\nReady\r\n" send "RUN $REACT\r"; go
expect "Function?"     send "D\r";          go
expect "Proj,Prog?"    send "%ppn%\r";      go
expect "Disk?"         send "%device%\r";   go
expect "Proj,Prog?"    send "%CTRL-Z%";     go
pect "\r\nReady\r\n"
go
set env ppn
set env device
