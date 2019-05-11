;;; @file
;;; @author     Terry Ebdon
;;; @date       11-MAY-19
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief BASIC-PLUS section of the sysgen Q&A

expect "BASIC-PLUS RTS name ?" send "BASIC\r"; go

;;; @todo this section is re-usable for V8.0
;;;
expect "FPP ?"                 send "Y\r";    go
expect "Math precision ?"      send "2\r";    go
expect "Log functions ?"       send "Y\r";    go
expect "Trig functions ?"      send "Y\r";    go
expect "Print using ?"         send "Y\r";    go
expect "Matrices ?"            send "YES\r"; go
expect "String arithmetic ?"   send "NO\r";    go
expect "Installing SORT/MERGE package" echo
