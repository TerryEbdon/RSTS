;;; @file
;;; @author     Terry Ebdon
;;; @date       13-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Remove redundant expectations set by ExpectOptionPrompt.do

; Only one of these expectations will have been fulfilled.
; Flush the redundant one.
noexpect "Option: "
noexpect "Start timesharing?"
