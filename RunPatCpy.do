;;; @file
;;; @author     Terry Ebdon
;;; @date       13-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Copy packages, from tape to disk, with PATCPY.

SEND "run MT0:PATCPY\r"
expect "Enter distribution device/PPN" send "MT0:[1,2]\r"; go
expect "Enter output device/PPN" send "SY:[200,200]\r"; go
expect "Attempt to create account SY:[200,200]" send "YES\r"; go
expect "Packages to patch?" send "ALL\r"; go
expect "\r\nReady\r\n"
go

; Only asked if [200,200] doesn't already exist.
;
noexpect "Attempt to create account SY:[200,200]"
