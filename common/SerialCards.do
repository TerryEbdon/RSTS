;;; @file
;;; @author     Terry Ebdon
;;; @date       MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Sysgen serial card configuration responses, for V8 & V9.

expect "DL11A compatible lines ?"     send "1\r";  go
expect "DL11C, DL11D's ?"             send "0\r";  go
expect "DL11E,DLV11E's ?"             send "0\r";  go
expect "DJ11's ?"                     send "0\r";  go
expect "DH11's ?"                     send "0\r";  go
expect "DZ11 unit 00 lines enabled ?" send "8\r";  go
expect "DZ11 unit 01 lines enabled ?" send "8\r";  go
expect "Dataset support for DZ11's ?" send "NO\r"; go
