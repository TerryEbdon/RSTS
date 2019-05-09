;;; @author Terry Ebdon
;;; @date   09-MAY-19
;;; Install a SIL
;;; @arg %1 SIL file name to install

if "%1" == "" set env msg=echo ?No SIL in argument 1
if ( "%msg" != "" ) %msg; return

send "Install\r"
expect "Sil?" send "%1\r"; go
expect "Option: " echo
go
