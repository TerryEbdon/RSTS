;;; @file
;;; @author     Terry Ebdon
;;; @date       MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Sysgen micro-controllers configuration responses, for V8 & V9.

expect "DMC11's/DMR11's ?"           send "0\r";    go
expect "KMC11's ?"                   send "0\r";    go
