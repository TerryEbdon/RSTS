;;; @file
;;; @author Terry Ebdon
;;; @date   09-MAY-2019
;;; Run $SYSBAT to build the system configured in the Q&A.

send "RUN $SYSBAT\r"
expect "Unit ? " send "0\r"; go
expect "Unit ? " send "0\r"; go
expect "Unit ? " send "0\r"; go
