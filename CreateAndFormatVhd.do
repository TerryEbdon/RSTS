;;; @file
;;; @author Terry Ebdon
;;; @date   08-MAY-19
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Create new VHD and format it.
;;; @arg %1 simulated device ID
;;; @arg %2 VHD file to create
;;; @return error message in environment variable msg

set env msg=
if "%1" == "" set env msg=echo ?No device ID in argument 1
if "%2" == "" set env msg=echo ?No VHD file name in argument 2
if exist "%2" set env msg=echo ?VHD already exists

if ( "%msg" != "" ) %msg; return 12

; DSKINT will treat DL3 and RL3 as the same device. A colon is not required.

set env devToFormat=%1
set env vhdFile=%2

attach -I -N %devToFormat %vhdFile

do Dskint.do %devToFormat%
go
