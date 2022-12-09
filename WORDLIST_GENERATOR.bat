@echo off
color 2
title WORDLIST GENERATOR

setlocal enableDelayedExpansion

echo --------------------------------------
echo         WORDLIST GENERATOR
echo --------------------------------------
echo.
set /p input="Amount of digits: "
set /a depth=%input%-1
set /p possibleChars="Possible Characters (With Space): "
set /p filename=Enter the txt file name with extension:
echo:

for /l %%y in (0, 1, %depth%) do (
    set chars[%%y]=0
)

call :next 0
echo:
pause
exit

:next
    setLocal
    set /a d=%1

    for %%x in (%possibleChars%) do (

        set chars[%d%]=%%x

        if %d% lss %depth% (
            call :next !d!+1
        ) else (

            set password=

            for /l %%c in (0, 1, %depth%) do (
                set password=!!password!!chars[%%c]!!
            )
            echo !password!>>%filename%
            echo !password!
            
        )
    )