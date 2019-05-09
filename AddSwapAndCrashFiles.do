;;; @file
;;; @author Terry Ebdon
;;; @date   09-MAY-19
;;; Boot Add swap file 2 and a crash dump file
;;; @arg %1 Size of swap file
;;; @arg %2 Size of crash dump file

if "%1" == "" set env msg=echo ?arg 1 must be a valid size for a swap file
if "%2" == "" set env msg=echo ?arg 2 must be a valid size for a crash dump file
if ( "%msg" != "" ) %msg; return

do AddSystemfile.do SWAP.SYS  %1
noexpect

if ( "%msg" != "" ) %msg; return

do AddSystemfile.do CRASH.SYS %2
noexpect
