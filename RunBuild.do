;;; @file
;;; @author     Terry Ebdon
;;; @date       13-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;;
;;; @brief Build the system configured by the Q&A.
;;; @arg %1 source device
;;; @arg %2 control file
;;; @arg %3 Location for package. Defaults to SY:[1,2]. May not be prompted for.
;;; @pre The primary run-time system is BASIC-PLUS.

if "%1"=="" set env msg=echo ?source device is mandatory
if "%2"=="" set env msg=echo ?Control file is mandatory

if "%msg%" != "" ignore; %msg%; return
do common/SetVars.do

set env distDev=%1
set env ctlFile=%2
set env packageLocation=SY:[1,1]

if "%3" != "" set env packageLocation=%3

set env systemBuild=YES
if "%ctlFile%" != "" set env systemBuild=NO
if exist "Build_%ctlFile%.do" do Build_%ctlFile%.do
expect "?Program lost-Sorry" noexpect; set env msg=echo ?Couldn't run BUILD
expect "?Command file aborted" noexpect; set env msg=echof '\r\n%n0 Error running $BUILD'

send "RUN %distDev%$BUILD\r"
expect "System Build <No> ?"                  send "%systemBuild%\r"; go

; Prompts for system build
expect "Source Input Device"                  send "%distDev%\r";  go
expect "Library Output Device <SY:> ?"        send "\n";    go
expect "Target System Device <SY0:> ?"        send "\n";    go
expect "Library Account <[1,2]> ?"            send "\n";    go

if "%systemBuild%"=="NO" expect "Control File is ?" send "%ctlFile%\r";  go

expect "Locate logical 'LB:' on"              send "SY:[1,1]\r";   go
expect "Create account SY:[1,1]"              send "YES\r"; go
expect "Function (Build/Patch, Patch, Build)" send "\n";    go
expect "Patch file input location"            send "SY:[200,200]\r"; go
expect "Save patched sources"                 send "YES\r"; go
expect "Write patched sources to"             send "SY:[200,200]\r"; go
expect "Run-Time System "                     send "BASIC\r"; go

set env msgNoCtlFile=set env msg=echo ?Control file not there
if "%systemBuild%"=="NO" expect "Control File is ?" send "%CTRL-Z%"; %msgNoCtlFile%; go

if "%systemBuild%" == "YES" expect "Locate ERROR Package on" send "SY:[2,3]\r"; go
if "%systemBuild%" == "YES" expect "Create account SY:[2,3] <No>?" send "YES\r"; go

if "%systemBuild%" == "NO" expect -r "Locate [A-Z]+ Package on" send "%packageLocation%\r"; go
if "%systemBuild%" == "NO" expect "Create account %packageLocation% <No>?" send "YES\r"; go

expect "Additional Control File is"           send "\n"; go
expect "!*** BUILD Complete ***" %expectReady%; go

go
if "%msg%" != "" ignore; %msg%; %expectReady%; go

noexpect
set env distDev
set env ctlFile
set env systemBuild
set env packagelocation
set env msgnoctlfile
