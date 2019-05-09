;;; @author Terry Ebdon
;;; @date   09-MAY-19
;;; Set defaults, no JOB MAX or SWAP MAX changes

send "DEFAULT\r"
expect "JOB MAX or SWAP MAX changes?" send "\n";    go
expect "Run Time System"              send "\n";    go
expect "Error message file"           send "\n";    go
expect "Installation name"            send "RSTS V8, %USERNAME%\r"; go
expect "Table suboption?"             send "\n";    go
expect "Crash dump?"                  send "YES\r"; go
expect "Crash dump?"                  send "YES\r"; go
expect "Magtape labelling default"    send "DOS\r"; go
expect "Preferred clock <L>?"         send "\n";    go
expect "Date format <ALPHABETIC>?"    send "\n";    go
expect "Time format <AM/PM>?"         send "24\r";  go
expect "Power fail delay <5>?"        send "1\r";   go

expect "Option: " echo
go
