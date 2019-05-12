;;; @file
;;; @author     Terry Ebdon
;;; @date       MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Sysgen disk configuration responses, for V8 & V9.

expect "RK05's ?"            send "08\r";  go
expect "Overlapped seek ?"   send "YES\r"; go
expect "RL01/RL02's ?"       send "4\r";   go
expect "Overlapped seek ?"   send "YES\r"; go
expect "RK06/RK07's ?"       send "8\r";   go
expect "Overlapped seek ?"   send "YES\r"; go
expect "RP02/RP03's ?"       send "0\r";   go
