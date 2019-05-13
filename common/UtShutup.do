;;; @file
;;; @author     Terry Ebdon
;;; @date       13-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Shut down RSTS from the RT11 '.' prompt.
;;; @pre RT11 must be the default run time system.

send "RUN UTILTY\r"
expect "\r\n*" send "NO LOGINS\r";  go
expect "\r\n*" send "SHUTUP\r";     go

do %~p0/ExpectOptionPrompt.do
