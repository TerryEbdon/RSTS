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
