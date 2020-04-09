
@echo off
set /A discord_set=0
set /A ts_set=0
:LOOP
tasklist | find /i "discord.exe" >nul 2>&1
IF ERRORLEVEL 1 (
 ECHO Discord is not running wait for it... 
 Timeout /T 5 /Nobreak
) ELSE (
  ECHO Wait 10 seconds until discord and all subprocs are started   
  Timeout /T 10 /Nobreak
  wmic process where name="discord.exe" CALL setpriority "128"
  ECHO Discord prio set.
  set /A discord_set=1
)
tasklist | find /i "ts3client_win64.exe" >nul 2>&1
IF ERRORLEVEL 1 (
  ECHO TS is not running wait for it... 
  Timeout /T 5 /Nobreak
) ELSE (
  ECHO Wait 10 seconds until ts and all subprocs are started  
  Timeout /T 10 /Nobreak  
  wmic process where name="ts3client_win64.exe" CALL setpriority "128"
  ECHO TS prio set.
  set /A ts_set=1
)
IF %discord_set% EQU 0 (
    GOTO:LOOP
)
IF %ts_set% EQU 0 (
    GOTO:LOOP
)
pause