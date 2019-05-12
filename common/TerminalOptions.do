;;; @file
;;; @author     Terry Ebdon
;;; @date       MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Sysgen terminal configuration responses, for V8 & V9.

expect "Pseudo keyboards ?"             send "4\r";   go
expect "Multi-terminal service ?"       send "YES\r"; go
expect "Echo control ?"                 send "YES\r"; go
expect "One-line status report ?"       send "YES\r"; go
expect "FMS-11 support ?"               send "NO\r";  go
expect "Multiple private delimiters ?"  send "YES\r"; go
