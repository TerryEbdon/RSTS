;;; @file
;;; @author     Terry Ebdon
;;; @date       13-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Copy packages, from tape to disk, with PATCPY.
;;; @arg %1 Device distribution kit is mounted on.
;;; @arg %2 PPN containing distribution kit.

if "%1" == "" set env msg=echo ?arg 1 should be the device ID for distribution kit
if "%2" == "" set env msg=echo ?arg 2 should PPN the for distribution kit
if "%msg%" != "" %msg%; return

set env distroDevice=%1
set env distroPpn=%2

expect "?Program lost-Sorry\r\n" noexpect; set env msg=echo ?Couldn't run PATCPY
send "run %distroDevice%PATCPY\r"
expect "Enter distribution device/PPN" send "%distroDevice%%distroPpn%\r"; go
expect "Enter output device/PPN" send "SY:[200,200]\r"; go
expect "Attempt to create account SY:[200,200]" send "YES\r"; go
expect "Packages to patch?" send "ALL\r"; go
expect "\r\nReady\r\n"
go
if "%msg%" != "" ignore; %msg%

; Only asked if [200,200] doesn't already exist.
;
noexpect "Attempt to create account SY:[200,200]"

set env distroDevice
set env distroPpn
