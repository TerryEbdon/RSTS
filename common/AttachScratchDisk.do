;;; @file
;;; @author     Terry Ebdon
;;; @date       14-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Create unformatted, 28 MB, [RK07](https://obsoletemedia.org/dec-rk07/)
;;; scratch disk and attach to a device.
;;; @arg %1 Device to attach to, e.g HK7.
;;; @arg %2 Name of VHD file to use.
;;; @Warning the VHD will be deleted if it already exists

if "%1" == "" set env msg=echo Device arg must be provided.
if "%2" == "" set env msg=echo VHD file name must be provided.
if "%msg%" != "" ignore; %msg%; return

set env acd_scratchDev=%1
set env acd_scratchVhd=%2

echo --- Creating scratch RK07 in VHD %acd_scratchVhd% & attaching to %acd_scratchDev%
if exist "%acd_scratchVhd%" delete %acd_scratchVhd%; echo ... Deleted old scratch VHD
set %acd_scratchDev% RK07
attach -n %acd_scratchDev% %acd_scratchVhd%
echo ... New VHD attached.
set -Y %acd_scratchDev% BADBLOCK
echo ... Bad block data written to VHD.
set env acd_scratchVhd
set env acd_scratchDev
