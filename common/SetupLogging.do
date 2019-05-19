;;; @file
;;; @author     Terry Ebdon
;;; @date       18-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Setup debug logging and prepare for console logging.

if "%1" == "" echof "Arg 1 must be the log name prefix, e.g. SysgenV9"; exit

set env consolePort=8001
set env logDir=logs
set env logPrefix=%logDir%/%~n1
set env debugLog=%logPrefix%_debug.log
set env puttyLog=%logPrefix%_putty.log

;if not exist "%logDir%" !mkdir %logDir%
!mkdir %logDir%
if exist "%debugLog%" delete %debugLog%
if exist "%puttyLog%" delete %puttyLog%
set debug %debugLog%
