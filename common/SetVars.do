;;; @file
;;; @author     Terry Ebdon
;;; @date       14-MAY-2019
;;; @copyright  Terry Ebdon, 2019
;;; Licensed under the Apache License, Version 2.0
;;; See the README.md and LICENSE files for details.
;;; @brief Set commonly used environment variables.

if "%varsSet%" == "VARS_ARE_SET" return
set env CTRL-C=\003
set env CTRL-Z=\032
set env abort=send "%CTRL-C%%CTRL-C%%CTRL-C%"
set env expectReady=expect "\r\nReady\r\n"
set env varsSet=VARS_ARE_SET
