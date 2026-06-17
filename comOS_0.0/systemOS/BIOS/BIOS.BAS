CLS
COLOR 7, 1
DO
    PRINT "+==============================BIOS==============================+"
    PRINT "|help - to open this menu                                        |"
    PRINT "|echo - to print text                                            |"
    PRINT "|exit - to exit this system                                      |"
    PRINT "+================================================================+"
    INPUT "BIOS\comos~$", a$
    IF a$ = "exit" THEN
        EXIT DO
    END IF
LOOP

