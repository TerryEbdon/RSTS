echo 
echo ### attach RSTS/E V8 sysgen tape image to MT0: **
echo 

attach -r TM0 V8SYSGNK.TAP
echo 
show TM0

echo 
echo ### attach RSTS/E V8 sysgen RM03 image **
echo 

attach RP0 RSTSV8_System.dsk
show RP0
