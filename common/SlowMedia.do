;;; @file
;;; @author     Terry Ebdon
;;; @date       MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief slow media configuration responses, for V8 & V9.

expect "Printers ?"                send "1\r";    go
expect "RX01/RX02's ?"             send "8\r";    go
expect "CR11/CM11 card reader ?"   send "YES\r";  go
expect "CD11 card reader ?"        send "NO\r";   go
expect "Card decode ?"             send "ANSI\r"; go
expect "P.T. reader / punch ?"     send "YES\r";  go
expect "Extended buffering for LP ?" send "YES\r";  go
