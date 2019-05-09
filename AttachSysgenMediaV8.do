echo ### Attach RSTS/E V8 sysgen tape image to MT0:

attach -r TM0 V8SYSGNK.TAP
;show TM0

echo ### Attach RSTS/E V8 sysgen RM03 image

attach RP0 RSTSV8_System.dsk
;show RP0
