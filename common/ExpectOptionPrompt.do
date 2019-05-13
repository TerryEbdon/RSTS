;;; @file
;;; @author     Terry Ebdon
;;; @date       13-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Expect the "Option" prompt, or it's equivalent
;;; @arg %1 set to *noflush* to prevent this script from
;;; issuing a "go" and flushing it's own unused
;;; expectations

; Pre-v9 and, sometimes, V9
expect "Option: " echo

; V9
expect "Start timesharing?" echo

; Only one of these expectations will have been fulfilled.
; Can't flush until we 'go', but that doesn't work
; if the caller's about to execute a 'boot'
;
if "%1" == "noflush" return
go
do FlushExpectOptions.do
