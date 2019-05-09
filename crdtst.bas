1      !!! @file
2      !!! @author Terry Ebdon
3      !!! @date   06-MAY-2019
4      !!! Test reading card decks

1010    OPEN "CR0:" FOR INPUT AS FILE 1
1020    ON ERROR GOTO 90
1040    WHILE -1%
1050    INPUT #1, A$
1060	   PRINT A$
1070    NEXT
1090    PRINT CHR$(10); CHR$(11); "ERROR"; ERR; "AT";ERL
32767   END
