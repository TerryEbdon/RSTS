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
set env silToInstall=%1

echo ### Installing SIL %silToInstall%

send "Install\r"
expect -r "Sil(\?)|( <.+>\?)" send "%silToInstall%\r"; go
expect "File not found\r\n" set env msg=echof '\n?InstallSil.do: SIL %silToInstall% not found!'

do common/ExpectOptionPrompt.do

if "%msg%" != "" ignore; %msg%; exit
