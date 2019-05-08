# Disable XQ as the bus type will change. Simh will automatically disable
# the device on a bus change, and display a warning. Explicitly disabling
# the device suppresses the warning.
echo ### Configureing as a PDP-11/84 **
set XQ disabled

# When idle is disabled the simulator hogs the host CPU.
set cpu 11/84 4m idle
