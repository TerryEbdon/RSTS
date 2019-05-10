;;; @file
;;; @author Terry Ebdon
;;; @date   MAY-19
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Answer Init's Date and time prompts.
;;; @note This assumes that RSTS has *not* been patched for Y2K.

expect "?" send "%DATE_DD%-%DATE_MMM%-99\r"; go
expect "?" send "%TIME_HH%:%TIME_MM%\r";     go
