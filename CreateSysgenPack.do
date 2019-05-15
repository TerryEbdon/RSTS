;;; @file
;;; @author     Terry Ebdon
;;; @date       MAY-19
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Create empty sysgen pack in the specified VHD file
;;; @arg %1 is the image file name
;;; @warning If the file exists it will be deleted.

echo ### Creating empty sysgen pack in %1

if exist "%1" echo --- Deleting old disk image in %1
if exist "%1" delete %1

echo --- Creating new disk image in %1 -- This is slow, please be patient.
attach -n RP0 %1
echo ... Adding factory error information.
set -Y RP0 BADBLOCK
