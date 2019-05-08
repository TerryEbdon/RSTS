### @file
### @author Terry Ebdon
### @date   06-MAY-2019
### Configure an 11/84 with 4M of memory & boot RSTS/E V8.

# Disable XQ as the bus type will change. Simh will automatically disable
# the device on a bus change, and display a warning. Explicitly disabling
# the device suppresses the warning.
set XQ disabled

# When idle is disabled the simulator hogs the host CPU.
set cpu 11/84 4m idle

echo 
echo ### attach RSTS/E V8 sysgen tape image to MT0:
echo 

attach -r TM0 V8SYSGNK.TAP
echo 
show TM0

echo 
echo ### attach RSTS/E V8 sysgen RM03 image
echo 

attach RP0 RSTSV8_System.dsk
show RP0

echo 
echo ### Enable CR11 card reader
echo 

set CR enabled
show CR

expect "Option: " send "ID\r"; go

echo 
echo ### Booting the RSTS/E sysgen disk.
boot RP0

