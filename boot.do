### @file
### @author Terry Ebdon
### @date   06-MAY-2019
### Configure an 11/84 with 4M of memory & boot RSTS/E V8.

# Disable XQ as the bus type will change. Simh will automatically disable
# the device on a bus change, and display a warning. Explicitly disabling
# the device suppresses the warning.
set XQ disabled

# When idle is disabled the simulator hogs the host CPU.
set cpu 11/84
set cpu 4m
set cpu idle

echo 
echo ### attach RSTS/E V8 sysgen tape image to MT0:
echo 

att -r tm0 V8SYSGNK.TAP
echo 
sh tm0

echo 
echo ### attach RSTS/E V8 sysgen RM03 image
echo 

att rp0 RSTSV8_System.dsk
sh rp0

echo 
echo ### Enable CR11 card reader
echo 

set cr ena
sh cr

echo 
echo ### Booting the RSTS/E sysgen disk.
echo ### This will take while, please be patient.
echo ### Ignore the "Breakpoint, PC: <blah>", and wait for me to boot.
nosend
noexpect
set break 12106
b rp0
echo
echo Please ignore the breakpoint... I'm still booting!
set nobreak
send "ID\r"
go
;expect -r ".*Option: "  send "HA LI\r"; go
