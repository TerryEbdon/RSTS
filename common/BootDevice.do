;;; @file
;;; @author     Terry Ebdon
;;; @date       08-MAY-19
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Boot RSTS/E from a simulated device
;;; @arg %1 simulated device ID to boot

if "%1" == "" set env msg=echo ?No device ID in argument 1
if ( "%msg" != "" ) %msg; return
set env bootDev=%1

echo ### Booting RSTS/E from device %1
expect "?PLEASE BOOT FROM THE SYSTEM DISK." echof "%0 ?Can't boot from %bootDev%"; exit
do common/ExpectOptionPrompt.do noflush
boot %bootDev%
do common/FlushExpectOptions.do

set env bootDev
noexpect "?PLEASE BOOT FROM THE SYSTEM DISK."
