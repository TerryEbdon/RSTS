;;; @file
;;; @author     Terry Ebdon
;;; @date       MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Sysgen mag tape configuration responses, for V8 & V9.

expect "TU16/TE16/TU45/TU77's ?"   send "0\r";    go
expect "TU10/TE10/TS03's ?"        send "8\r";    go
;
; V9.5 supports TK25, V8 doesn't.
;
expect -r "TS11/(TK25/){0,1}TSV05/TU80's ?" send "0\r";    go
expect "DECtapes ?"                         send "0\r";    go
