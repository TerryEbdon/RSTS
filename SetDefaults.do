;;; @author     Terry Ebdon
;;; @date       09-MAY-19
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Set defaults, no JOB MAX or SWAP MAX changes
;;; @arg %1 optional default RTS

set env defaultRts="\n"
if "%1" != "" set env defaultRts="%1\r"

send "DEFAULT\r"
expect "JOB MAX or SWAP MAX changes?" send "\n";         go
expect "Run Time System"              send %defaultRts%; go
expect "Error message file"           send "ERR.ERR\r";  go
expect "Installation name"            send "RSTS V8, %USERNAME%\r"; go
expect "Table suboption?"             send "\n";    go
expect "Crash dump?"                  send "YES\r"; go
expect "Magtape labelling default"    send "DOS\r"; go
expect "Preferred clock <L>?"         send "\n";    go
expect "Date format"                  send "ALP\r"; go
expect "Time format"                  send "24\r";  go
expect "Power fail delay"             send "1\r";   go

expect "Option: " echo
go
