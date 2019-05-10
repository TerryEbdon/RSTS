;;; @file
;;; @author     Terry Ebdon
;;; @date       MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Configuring a PDP-11/84 with 4m of memory & idle enabled.
;;; Disable XQ as the bus type will change. Simh will automatically disable
;;; the device on a bus change, and display a warning. Explicitly disabling
;;; the device suppresses the warning.

echo ### Configuring as a PDP-11/84
set XQ disabled

# When idle is disabled the simulator hogs the host CPU.
set cpu 11/84 4m idle
