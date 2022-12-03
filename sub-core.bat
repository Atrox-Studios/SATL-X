@echo off
color 0f
title SATL-X - Luancher
mode con cols=48 lines=35
setlocal enabledelayedexpansion

if not exist Satlx_data\lib\boot.config (
(
echo [MAIN_CONFIG]
echo [SAVE_FILE_LOCATION] : 
echo C:\Satlx_data
echo.
echo [PACKAGES_FOLDER_LOCATION] : 
echo Satlx_data\bin\packages
echo.
echo [CORE_PROGRAM_LOCATION] :
echo Satlx_data\bin\core.bat
) > Satlx_data\lib\boot.config
goto hth
)

< Satlx_data\lib\boot.config (
set /p null=
set /p null=
set /p dir_path=
set /p null=
set /p null=
set /p pak_path=
set /p null=
set /p null=
set /p crf_path=
)


< Satlx_data\bin\defaults.config (
set /p null=
set /p null=
set /p autosave_default=
set /p null=
set /p null=
set /p licence_default=
)
< %pak_path%\redr_window-client.pak (
set /p linevar=
set /p linevar2=
set /p linevar3=
)
< %dir_path%\packages\achv_window-save.pak (
set /p unitcount=
set /p unit1=
set /p unit2=
set /p unit3=
set /p unit4=
set /p unit5=
set /p unit6=
)
< %dir_path%\packages\arvc_window-client.pak (
set /p code1=
set /p code2=
set /p code3=
set /p code4=
set /p code5=
)
set select=1
set version=[90mPrototype[97m
net use Y: /delete
set msplash=y
set nsplash=y

FOR /F "usebackq tokens=3*" %%A IN (`REG QUERY "HKCU\Console" /v QuickEdit`) DO (
  set quickEditSetting=%%A %%B
)
if %quickEditSetting%==0x1 (
  :: Disable QuickEdit Mode
  reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 0 /f

  :: Open script in a new Command Prompt window
  start "" "%~dpnx0" %* && exit
)

:launcher
color 0f
cls
mode con cols=48 lines=35
if %select% gtr 4 set select=1
if %select% lss 1 set select=4
set s1=-
set s2=-
set s3=-
set s4=+
set s%select%=[90m#[0m[97m
echo %linevar2%
echo [37mWelcome to [97mSATL[37m-X[0m  ^|  %version%
echo %linevar2%
echo [0m
echo [%s1%] Startup[0m
echo [%s2%] Changelog[0m
echo [%s3%] Credits[0m
echo.
echo [%s4%] Quit[0m
echo.
echo %linevar%
if "%msplash%"=="y" echo.
if "%msplash%"=="y" echo Use W,S To Navigate, D To Select
choice /c:wsd /n /m ""
set msplash=n
if "%errorlevel%"=="1" set /a select-=1
if "%errorlevel%"=="2" set /a select+=1
if "%errorlevel%"=="3" (
if "%select%"=="1" set select=1&goto startup
if "%select%"=="2" set select=1&goto changelog
if "%select%"=="3" set select=1&goto credits
)
goto launcher

:startup
CALL %crf_path%
goto startgame