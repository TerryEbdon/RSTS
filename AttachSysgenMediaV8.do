;;; @file
;;; @author     Terry Ebdon
;;; @date       MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Attach RSTS/E V8 sysgen and system disk

echo ### Attach RSTS/E V8 sysgen tape image to MT0:

set env msg=
attach -r TM0 V8SYSGNK.TAP
;show TM0

set env diskToAttach=RSTSV8_System.dsk

if ( "%1" != "" ) set env diskToAttach=%1

echo ### Attach RSTS/E V8 sysgen RM03 image to %diskToAttach% to RP0

if not exist "%diskToAttach%" set env msg=echo ?VHD does not exist: %diskToAttach%

if ( "%msg" != "" ) %msg; return

attach RP0 %diskToAttach%
;show RP0
