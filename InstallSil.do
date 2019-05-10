;;; @author Terry Ebdon
;;; @date   09-MAY-19
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Install a SIL
;;; @arg %1 SIL file name to install

if "%1" == "" set env msg=echo ?No SIL in argument 1
if ( "%msg" != "" ) %msg; return

send "Install\r"
expect -r "Sil(\?)|( <.+>\?)" send "%1\r"; go
expect "Option: " echo
go
