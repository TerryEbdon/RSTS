;;; @file
;;; @author     Terry Ebdon
;;; @date       09-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Run $SYSBAT to build the system configured in the Q&A.

send "RUN $SYSBAT\r"
expect "Unit ? " send "0\r"; go
expect "Unit ? " send "0\r"; go
expect "Unit ? " send "0\r"; go
