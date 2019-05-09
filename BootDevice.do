;;; @file
;;; @author Terry Ebdon
;;; @date   08-MAY-19
;;; Boot RSTS/E from a simulated device
;;; @arg %1 simulated device ID to boot

if "%1" == "" set env msg=echo ?No device ID in argument 1
if ( "%msg" != "" ) %msg; return

echo ### Booting RSTS/E from device %1

expect "Option: " echo
boot %1
