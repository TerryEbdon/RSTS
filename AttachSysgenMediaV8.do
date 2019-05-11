;;; @file
;;; @author     Terry Ebdon
;;; @date       MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Attach RSTS/E V8 sysgen and system disk
;;; @arg %1 Disk image file name. Abort if it doesn't exist, default to V8 disk
;;; @arg %2 Tape image file name. Aborts if it doesn't exist, default to v8 tape

echo ### Attach RSTS/E V8 sysgen sysgen media

set env tapeToAttach=V8SYSGNK.TAP

if ( "%2" != "" ) set env tapeToAttach=%2
if not exist "%tapeToAttach%" set env msg=echo ?Tape file does not exist: %tapeToAttach%

if ( "%msg" != "" ) %msg; return

echo --- Attach RSTS/E sysgen tape %tapeToAttach% to MT0:
attach -r TM0 %tapeToAttach%
;show TM0

set env diskToAttach=RSTSV8_System.dsk

if ( "%1" != "" ) set env diskToAttach=%1

echo --- Attach RSTS/E V8 sysgen RM03 image to %diskToAttach% to RP0

if not exist "%diskToAttach%" set env msg=echo ?VHD does not exist: %diskToAttach%

if ( "%msg" != "" ) %msg; return

attach RP0 %diskToAttach%
;show RP0
