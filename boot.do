;;; @file
;;; @author     Terry Ebdon
;;; @date       06-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Configure an 11/84 with 4M of memory & boot RSTS/E V8.

set noverify
set noverbose
set message
set quiet

do Configure1184.do
do AttachSysgenMediaV8.do
do EnableCardReader.do
do SetupSerialPorts.do
do BootSysgenDisk.do
