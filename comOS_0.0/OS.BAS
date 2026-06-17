CLS
COLOR 1
PRINT "@"
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "@"
SLEEP 1
CLS
PRINT "@@"
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "@@"
SLEEP 1
CLS
PRINT "@@@"
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "@@@"
SLEEP 1
CLS
PRINT "@@@@"
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "@@@@"
SLEEP 1
CLS
PRINT "@@@@@"
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "@@@@@"
SLEEP 1
CLS
PRINT " @@@@@"
PRINT "@"
PRINT "@"
PRINT "@"
PRINT "@"
PRINT "@"
PRINT " @@@@@"
SLEEP 1
CLS
PRINT " @@@@@"
PRINT "@"
PRINT "@"
PRINT "@"
PRINT "@"
PRINT "@"
PRINT " @@@@@"
PRINT "c"
SLEEP 1
CLS
PRINT " @@@@@"
PRINT "@"
PRINT "@"
PRINT "@"
PRINT "@"
PRINT "@"
PRINT " @@@@@"
PRINT "co"
SLEEP 1
CLS
PRINT " @@@@@"
PRINT "@"
PRINT "@"
PRINT "@"
PRINT "@"
PRINT "@"
PRINT " @@@@@"
PRINT "com"
SLEEP 1
CLS
PRINT " @@@@@"
PRINT "@"
PRINT "@"
PRINT "@"
PRINT "@"
PRINT "@"
PRINT " @@@@@"
PRINT "comOS"
SLEEP 1
CLS
COLOR 7
PRINT "enter your name"
PRINT "========================================================"
INPUT "", name$
PRINT "hello", name$, "!"
SLEEP 5
CLS
PRINT "enter your password"
PRINT "========================================================"
INPUT "", pw$
PRINT "your password", pw$
DO
    SLEEP 5
    CLS
    PRINT "", name$
    INPUT "", pwv$
    IF pwv$ = pw$ THEN
        PRINT "hello"
        SLEEP 3
        CLS
        PRINT "(#)"
        PRINT "(B)"
        PRINT "(n)"
        PRINT "(T)"
        PRINT "(G)"
        PRINT "[B]"
        PRINT "(E)"
        PRINT "(c)"
        DO: q$ = INKEY$: LOOP WHILE q$ = ""
        IF q$ = "n" THEN
            CLS
            PRINT "notes                                                [x]"
            PRINT "========================================================"
            INPUT "", note$
        END IF
        IF q$ = "e" THEN
            CLS
            PRINT "explorer                                             [x]"
            PRINT "========================================================"
            FILES
            INPUT "", explorer$
            IF explorer$ = "cd" THEN
                INPUT "", nd$
                CHDIR "C:\" + nd$
            END IF
            IF explorer$ = "open" THEN
                INPUT "", nf$
                RUN nf$
            END IF
        END IF
        IF q$ = "B" THEN
            CLS
            PRINT "BANK                                                 [x]"
            PRINT "========================================================"
            PRINT "enter number your card on megaBANK"
            INPUT "", mb$
            PRINT "your card number is:", mb$
            SLEEP 2
            CLS
            INPUT "to dalee enter 0:", balance$
            DO
                CLS
                PRINT "BANK                                                 [x]"
                PRINT "========================================================"
                PRINT "hello!"
                PRINT "your balance is:"; balance$
                INPUT "chto hotity sdelat:", destvie$
                IF destvie$ = "exit" THEN
                    EXIT DO
                END IF
                IF destvie$ = "eto" THEN
                    END
                END IF
                IF destvie$ = "help" THEN
                    PRINT "exit - to exit this programm"
                    PRINT "eto - to exit this os"
                    SLEEP 5
                END IF
            LOOP
        END IF
            IF mb$ = "0000x0000xADMIN" THEN
                DO
                    CLS
                    PRINT "hello! emil"
                    PRINT "BANK                                                 [x]"
                    PRINT "========================================================"
                    PRINT "hello!"
                    PRINT "your balance is:infinity"
                    INPUT "chto hotity sdelat:", destvieAdmina$
                    IF destvieAdmina$ = "exit" THEN
                        EXIT DO
                    END IF
                LOOP
            END IF
        IF q$ = "g" THEN
            DO
                CLS
                PRINT "(#)     _________________"
                PRINT "(B)    |games         [x]|"
                PRINT "(n)    |==========|======|"
                PRINT "(T)    |<()>      |#     |"
                PRINT "(G)    |minesweper|Bambuk|"
                PRINT "[B]    |__________|______|"
                PRINT "(E)"
                PRINT "(c)"
                DO: w$ = INKEY$: LOOP WHILE w$ = ""
                IF w$ = "m" THEN
                    DO
                        CLS
                        PRINT " _________"
                        PRINT "|error 404|"
                        PRINT "|[ok]     |"
                        PRINT "|_________|"
                        SLEEP 5
                        EXIT DO
                    LOOP
                END IF
                IF w$ = "#" THEN
                    DO
                        CLS
                        PRINT "bambuk game                                          [x]"
                        PRINT "========================================================"
                        PRINT "hello to game bambuk!"
                        PRINT "help to help"
                        PRINT "5|#"
                        PRINT "4|#"
                        PRINT "3|#  ()"
                        PRINT "2|#  /|\"
                        PRINT "1|#  /\"
                        INPUT "", bambuk$
                        IF bambuk$ = "1" THEN
                            CLS
                            PRINT ";( no error"
                            PRINT "prichina:game_over"
                            SLEEP 5
                            EXIT DO
                        END IF
                        IF bambuk$ = "2" THEN
                            CLS
                            PRINT ";( no error"
                            PRINT "prichina:game_over"
                            SLEEP 5
                            EXIT DO
                        END IF
                        IF bambuk$ = "3" THEN
                            CLS
                            PRINT ";( no error"
                            PRINT "prichina:game_over"
                            SLEEP 5
                            EXIT DO
                        END IF
                        IF bambuk$ = "4" THEN
                            CLS
                            PRINT ";( no error"
                            PRINT "prichina:game_over"
                            SLEEP 5
                            EXIT DO
                        END IF
                        IF bambuk$ = "5" THEN
                            CLS
                            PRINT ";) no error"
                            PRINT "prichina:you_won"
                            SLEEP 5
                            EXIT DO
                        END IF
                        IF bambuk$ = "exit" THEN
                            CLS
                            PRINT ":) no error"
                            PRINT "prichina:poka poka"
                            SLEEP 5
                            EXIT DO
                        END IF
                        
                    LOOP
                END IF
                IF w$ = "x" THEN
                    PRINT "wait 3 sec"
                    EXIT DO
                END IF
            LOOP
        END IF
        IF q$ = "t" THEN
            CLS
            PRINT "terminal                                             [x]"
            PRINT "========================================================"
            DO
                INPUT "user~$comos$", t$
                IF t$ = "help" THEN
                    PRINT "help - to open this menu"
                    PRINT "exit - to exit this programm"
                    PRINT "echo - to vivoda poslednego text"
                    PRINT "eto(exit this os) - to exit this OS"
                    PRINT "cls - to clear screen terminal"
                END IF
                IF t$ = "exit" THEN
                    EXIT DO
                    CLS
                    PRINT "wait 3 sec"
                END IF
                IF t$ = "echo" THEN
                     PRINT t$
                END IF
                IF t$ = "eto" THEN
                    END
                END IF
                IF t$ = "cls" THEN
                    CLS
                END IF
            LOOP
        END IF
        IF q$ = "#" THEN
            DO
                CLS
                PRINT " ___________"
                PRINT "|svoistvo   |"
                PRINT "============="
                PRINT "|os:comOS   |"
                PRINT "|version:0.0|"
                PRINT "|(ok)       |"
                PRINT "| @@@@@     |"
                PRINT "|@          |"
                PRINT "|@          |"
                PRINT "|@          |"
                PRINT "|@          |"
                PRINT "|@          |"
                PRINT "| @@@@@     |"
                PRINT "|comOS      |"
                PRINT "|___________|"
                DO: w$ = INKEY$: LOOP WHILE w$ = ""
                IF w$ = "o" THEN
                    CLS
                    PRINT "wait 5 sec"
                    EXIT DO
                END IF
            LOOP
        END IF
        IF q$ = "b" THEN
            DO
                CLS
                PRINT "browser                                              [x]"
                PRINT "========================================================"
                INPUT "|", search$
                IF search$ = "chto takoe browser" THEN
                    CLS
                    PRINT "browser                                              [x]"
                    PRINT "========================================================"
                    PRINT "ai"
                    PRINT "================================================="
                    PRINT "privet browser eto programma dla poiska v browser"
                    PRINT ""
                    PRINT "saitov ne naideno"
                    SLEEP 67694252
                    EXIT DO
                END IF
            LOOP
        END IF
    END IF
    IF pwv$ > pw$ THEN
        PRINT "no done"
    END IF
    IF pwv$ = "start BIOS" THEN
        CHDIR "c:\comOS_0.0\systemOS\bios"
        RUN "bios.bas"
    END IF
    IF pwv$ < pw$ THEN
        PRINT "no done"
    END IF
    IF pwv$ = "eto" THEN
        CLS
        PRINT ":) no error:3"
        PRINT "prichina:poka poka"
        END
    END IF
LOOP

