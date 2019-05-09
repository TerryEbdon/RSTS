;;; @file
;;; @author Terry Ebdon
;;; @date   09-MAY-2019
;;; Configure DZ11 serial ports

echo ### Configuring serial ports

; KB0: Console
; KB1: to  KB4: are PK0 to PK3
; KB5: to KB20: are line 0 to 15 on DZ0

; KB5: listening on port 8000
attach DZ0 line=0,8000
