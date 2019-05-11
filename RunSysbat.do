;;; @file
;;; @author     Terry Ebdon
;;; @date       09-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Run $SYSBAT to build the system configured in the Q&A.
;;; @arg %1 Unit number to mount media on. Defaults to 0.

set env unitNo=0
if "%1" != "" set env unitNo=%1

send "RUN $SYSBAT\r"
expect "Unit ? " send "%unitNo%\r"; go
expect "Unit ? " send "%unitNo%\r"; go
expect "Unit ? " send "%unitNo%\r"; go
