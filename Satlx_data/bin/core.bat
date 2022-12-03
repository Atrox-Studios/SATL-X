@echo off
color 0f
title StormTides Byte - Luancher
mode con cols=48 lines=35
setlocal enabledelayedexpansion
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

:startgame
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
echo [%s1%] Load Network[0m
echo [%s2%] Controls[0m
echo [%s3%] -[0m
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
if "%select%"=="1" set select=1&goto login2
if "%select%"=="2" set select=1&goto changelog
if "%select%"=="3" set select=1&goto credits
)
goto startgame

:new
set sv=0
goto findnew
:findnew
if "%sv%"=="5" goto error3
set /a sv+=1
if not exist "%dir_path%\save%sv%\save%sv%.sav" goto createuser
goto findnew
:createuser
cls
mode con cols=48 lines=35
echo %linevar%
echo What would you like to name your Network?
echo %linevar%
echo.
set /p username1=^> 
if not defined username1 (
goto createuser
)
if %username1% EQU exit goto startgame
:checkforspaces
set x=!v1f!
set Letter%v1f%=!username1:~%x%,1!
if "!Letter%v1f%!" EQU " " (
echo.
echo.
echo Sorry you cant use spaces in your Network.
echo.
pause>nul
goto createuser
)
if NOT "!Letter%v1f%!" EQU "" (
set /a v1f=%v1f%+1
goto checkforspaces
)
:loginSUCCESS2
cls
mode con cols=48 lines=35
if %select% gtr 1 set select=1
if %select% lss 1 set select=1
set s1=-
set s%select%=[90m#[0m[97m
echo %linevar%
echo SUCCESSFULLY CREATED SAVE FILE
echo %linevar%
echo We hope you have fun playing
echo [97mSATL[37m-X[0m!
echo.
echo %linevar%
echo [%s1%] Okay
if "%msplash%"=="y" echo.
choice /c:d /n /m ""
set msplash=n
if "%errorlevel%"=="1" (
if "%select%"=="1" set select=1&goto DATA_VALUES
)
goto loginSUCCESS2

:login2
cls
mode con cols=48 lines=35
if %select% gtr 6 set select=1
if %select% lss 1 set select=6
set s1=-
set s2=-
set s3=-
set s4=-
set s5=-
set s6=-
set s%select%=[90m@[97m
echo Load Netowk[0m
echo %linevar%
if exist "%dir_path%\save1\save1.sav" < %dir_path%\save1\save1.sav (
set /p username1=
set /p level=
set /p title=
set /p swarm_count=
)
if exist "%dir_path%\save1\save1.sav" echo [%s1%] 1  %username1%: Swarm Count [90m%swarm_count%[0m
if not exist "%dir_path%\save1\save1.sav" echo [%s1%] 1  [90mNew Network[0m[0m

if exist "%dir_path%\save2\save2.sav" < %dir_path%\save2\save2.sav (
set /p username1=
set /p password1=
set /p levell=
)
if exist "%dir_path%\save2\save2.sav" echo [%s2%] 2  %username1%: Swarm Count [90m%swarm_count%[0m
if not exist "%dir_path%\save2\save2.sav" echo [%s2%] 2  [90mNew Network[0m[0m

if exist "%dir_path%\save3\save3.sav" < %dir_path%\save3\save3.sav (
set /p username1=
set /p password1=
set /p levell=
)
if exist "%dir_path%\save3\save3.sav" echo [%s3%] 3  %username1%: Swarm Count [90m%swarm_count%[0m
if not exist "%dir_path%\save3\save3.sav" echo [%s3%] 3  [90mNew Network[0m[0m

if exist "%dir_path%\save4\save4.sav" < %dir_path%\save4\save4.sav (
set /p username1=
set /p password1=
set /p levell=
)
if exist "%dir_path%\save4\save4.sav" echo [%s4%] 4  %username1%: Swarm Count [90m%swarm_count%[0m
if not exist "%dir_path%\save4\save4.sav" echo [%s4%] 4  [90mNew Network[0m[0m

if exist "%dir_path%\save5\save5.sav" < %dir_path%\save5\save5.sav (
set /p username1=
set /p password1=
set /p levell=
)
if exist "%dir_path%\save5\save5.sav" echo [%s5%] 5  %username1%: Swarm Count [90m%swarm_count%[0m
if not exist "%dir_path%\save5\save5.sav" echo [%s5%] 5  [90mNew Network[0m[0m
set sv=%select%
echo %linevar%
echo [%s6%] Back[0m
if "%msplash%"=="y" echo.
choice /c:wsd /n /m ""
set msplash=n
if "%errorlevel%"=="1" set /a select-=1
if "%errorlevel%"=="2" set /a select+=1
if "%errorlevel%"=="3" (
if "%select%"=="1" set select=1&goto loadsv
if "%select%"=="2" set select=2&goto loadsv
if "%select%"=="3" set select=3&goto loadsv
if "%select%"=="4" set select=4&goto loadsv
if "%select%"=="5" set select=5&goto loadsv
if "%select%"=="6" set select=1&goto startgame
)
goto login2

:loadsv
set sv=%select%
if exist "%dir_path%\save%sv%\save%sv%.sav" goto loginSUCCESS
if not exist "%dir_path%\save%sv%\save%sv%.sav" goto no_save_content

:no_save_content
goto new

:loginSUCCESS
cls
mode con cols=48 lines=35
if %select% gtr 1 set select=1
if %select% lss 1 set select=1
set s1=-
set s%select%=[90m#[0m[97m
echo %linevar%
echo SUCCESSFULLY LOADED SAVE FILE
echo %linevar%
echo We hope you have fun playing
echo [97mSATL[37m-X[0m!
echo.
echo %linevar%
echo [%s1%] Okay
choice /c:d /n /m ""
set msplash=n
if "%errorlevel%"=="1" (
if "%select%"=="1" set select=1&< %dir_path%\save%sv%\save%sv%.sav (
set /p username1=
set /p level=1
set /p title=Novice
set /p swarm_count=0
set /p network_status=Offline
set /p net_integrity=100
set /p xyz=50
set /p sat_1=0
set /p sat_2=0
set /p sat_3=0
set /p sat_4=0
set /p sat_5=0
set /p node_1=0
set /p node_2=0
set /p node_3=0
set /p node_4=0
set /p node_5=0
set /p rocket_1=0
set /p rocket_2=0
set /p rocket_3=0
set /p rocket_4=0
set /p rocket_5=0
set /p pad1_rocket=None
set /p pad1_payload=None
)
< %dir_path%\save%sv%\settings.ini (
set /p as=Online
set /p color=0f
)
cls
)
mode con cols=48 lines=35
goto SAVE_GAME_FILES2
)
goto loginSUCCESS

:DATA_VALUES
set level=1
set title=Novice
set swarm_count=0
set network_status=Offline
set net_integrity=100
set xyz=50
set sat_1=0
set sat_2=0
set sat_3=0
set sat_4=0
set sat_5=0
set node_1=0
set node_2=0
set node_3=0
set node_4=0
set node_5=0
set rocket_1=0
set rocket_2=0
set rocket_3=0
set rocket_4=0
set rocket_5=0
set pad1_rocket=None
set pad1_payload=None

set as=Online
goto SAVE_GAME_FILES2


:SAVE_GAME_FILES2
cls
mode con cols=48 lines=35
md %dir_path%
md %dir_path%\save%sv%
(
echo %username1%
echo %level%
echo %title%
echo %swarm_count%
echo %network_status%
echo %net_integrity%
echo %xyz%
echo %sat_1%
echo %sat_2%
echo %sat_3%
echo %sat_4%
echo %sat_5%
echo %node_1%
echo %node_2%
echo %node_3%
echo %node_5%
echo %rocket_1%
echo %rocket_2%
echo %rocket_3%
echo %rocket_4%
echo %rocket_5%
echo %pad1_rocket%
echo %pad1_payload%
) > %dir_path%\save%sv%\save%sv%.sav
(
echo %as%
echo %color%
) > %dir_path%\save%sv%\settings.ini
cls
mode con cols=48 lines=35
goto STATION

:SAVE_GAME_FILES
cls
mode con cols=48 lines=35
md %dir_path%
md %dir_path%\save%sv%
(
echo %username1%
echo %level%
echo %title%
echo %swarm_count%
echo %network_status%
echo %net_integrity%
echo %xyz%
echo %sat_1%
echo %sat_2%
echo %sat_3%
echo %sat_4%
echo %sat_5%
echo %node_1%
echo %node_2%
echo %node_3%
echo %node_5%
echo %rocket_1%
echo %rocket_2%
echo %rocket_3%
echo %rocket_4%
echo %rocket_5%
echo %pad1_rocket%
echo %pad1_payload%
) > %dir_path%\save%sv%\save%sv%.sav
(
echo %as%
echo %color%
) > %dir_path%\save%sv%\settings.ini
cls
mode con cols=48 lines=35
goto %destination%




// MARK: Station
:STATION
title SATL-X - Station
cls
set destination=STATION-2
if %as% equ Online goto SAVE_GAME_FILES
:STATION-2
set xpmul=5
cls
mode con cols=48 lines=35
if %select% gtr 6 set select=1
if %select% lss 1 set select=6
set s1=-
set s2=-
set s3=-
set s4=-
set s5=-
set s6=-
set s%select%=[90m#[0m[97m
echo %linevar%
echo [37m Network %username1%[0m
echo %linevar%
echo [0m
set s%select%=[90m#[0m[97m
echo [%s1%] SLX Terminal[0m
echo [%s2%] Satellite Market[0m
echo [%s3%] Node Market[0m
echo [%s4%] Launch Pads[0m
echo [%s5%] Station Storage[0m
echo [%s6%] [0m
echo.
echo %linevar%
echo  Curently On Network: [37m%Username1%[0m
echo %linevar%
if "%msplash%"=="y" echo.
choice /c:wsmid /n /m ""
set msplash=n
if "%errorlevel%"=="1" set /a select-=1
if "%errorlevel%"=="2" set /a select+=1
if "%errorlevel%"=="3" goto mainmenu
if "%errorlevel%"=="4" goto checkitemsINV
if "%errorlevel%"=="5" (
if "%select%"=="1" set select=1&goto slx
if "%select%"=="2" set select=1&goto satmarket1
if "%select%"=="3" set select=1&goto armorstore1
if "%select%"=="4" set select=1&goto launchpad-select
if "%select%"=="5" set select=1&goto selectbag
if "%select%"=="6" goto workshop
)
goto STATION-2

// MARK: SLX Terminal
:slx
title SATL-X - Station
set destination=map1
set backdest=MENU
cls
mode con cols=48 lines=35
if %select% gtr 6 set select=1
if %select% lss 1 set select=6
set s1=-
set s2=-
set s3=-
set s4=-
set s5=-
set s6=-
set s%select%=[90m#[0m[97m
echo %linevar%
echo SLX Terminal
echo %linevar%
echo Please choose an option on the terminal
echo Swarm Count: %swarm_count%
echo Network Integrity: %net_integrity% Percent
echo 
echo [0m
echo Satellite Actions
echo [%s1%] Network Status: %network_status%[0m
echo [%s2%] Clusterfy Network[0m
echo [%s3%] Temp[31m[Coming Soon][0m
echo.
echo Network Management
echo [%s4%] Towns[0m
echo [%s5%] Special Locations[0m
echo %linevar%
echo [%s6%] Back[0m
if "%msplash%"=="y" echo.
choice /c:wsmiad /n /m ""
set msplash=n
if "%errorlevel%"=="1" set /a select-=1
if "%errorlevel%"=="2" set /a select+=1
if "%errorlevel%"=="3" goto mainmenu
if "%errorlevel%"=="4" goto checkitemsINV
if "%errorlevel%"=="5" set select=1&goto %backdest%
if "%errorlevel%"=="6" (
if "%select%"=="1" set select=1&goto netst
if "%select%"=="2" set select=1&goto dungeons
if "%select%"=="3" goto map1
if "%select%"=="4" set select=1&goto towns
if "%select%"=="6" set select=1&goto STATION-2
)
goto slx

:netst
if %network_status% EQU Offline set network_status=Online&goto slx
if %network_status% EQU Online set network_status=Offline&goto slx
goto settings






// MARK: Satellite Market
:satmarket1
title SATL-X - Satellite Market
set destination=satmarket1
set backdest=STATION
cls
mode con cols=48 lines=35
if %select% gtr 2 set select=1
if %select% lss 1 set select=2
set s1=-
set s2=-
set s%select%=[90m#[0m[97m
echo %linevar%
echo You Curently Have %xyz% XYZ.
echo %linevar%
echo [0m
set s%select%=[90m#[0m[97m
echo [%s1%] Basic Low Orbit Satellite - 50 XYZ[0m
echo.
echo Weapon Store Pg.1
echo %linevar%
echo [%s2%] Back[0m
if "%msplash%"=="y" echo.
choice /c:wsmiad /n /m ""
set msplash=n
if "%errorlevel%"=="1" set /a select-=1
if "%errorlevel%"=="2" set /a select+=1
if "%errorlevel%"=="3" goto mainmenu
if "%errorlevel%"=="4" goto checkitemsINV
if "%errorlevel%"=="5" set select=1&goto %backdest%
if "%errorlevel%"=="6" (
if "%select%"=="2" set select=1&goto STATION
if "%select%"=="1" set select=1&goto buy1
)
goto satmarket1

:buy1
set destination=buyw1
if %xyz% LSS 50 goto noxyz
set /a xyz=%xyz%-50
set /a sat_1=%sat_1%+1
cls
mode con cols=48 lines=35
if %select% gtr 1 set select=1
if %select% lss 1 set select=1
set s1=-
set s%select%=[90m#[0m[97m
echo %linevar%
echo Basic Low Orbit Satellite purchased.
echo %linevar%
echo.
echo [%s1%] Okay
echo.
echo %linevar%
if "%msplash%"=="y" echo.
choice /c:d /n /m ""
set msplash=n
if "%errorlevel%"=="1" (
if "%select%"=="1" set select=1&goto satmarket1
)
goto buy1



:noxyz
set destination=noxyz
cls
mode con cols=48 lines=35
if %select% gtr 1 set select=1
if %select% lss 1 set select=1
set s1=-
set s%select%=[90m#[0m[97m
echo %linevar%
echo You don't have enough XYZ to buy this.
echo %linevar%
echo You should come back when you are not poor.
echo.
echo [%s1%] Okay
echo.
echo %linevar%
if "%msplash%"=="y" echo.
choice /c:d /n /m ""
set msplash=n
if "%errorlevel%"=="1" (
if "%select%"=="1" set select=1&goto satmarket1
)
goto noxyz



// MARK: Node Market
:nodemarket1
title SATL-X - Node Market
set destination=satmarket1
set backdest=STATION
cls
mode con cols=48 lines=35
if %select% gtr 2 set select=1
if %select% lss 1 set select=2
set s1=-
set s2=-
set s%select%=[90m#[0m[97m
echo %linevar%
echo You Curently Have %xyz% XYZ.
echo %linevar%
echo [0m
set s%select%=[90m#[0m[97m
echo [%s1%] Basic shield node - 150 XYZ[0m
echo.
echo Weapon Store Pg.1
echo %linevar%
echo [%s2%] Back[0m
if "%msplash%"=="y" echo.
choice /c:wsmiad /n /m ""
set msplash=n
if "%errorlevel%"=="1" set /a select-=1
if "%errorlevel%"=="2" set /a select+=1
if "%errorlevel%"=="3" goto mainmenu
if "%errorlevel%"=="4" goto checkitemsINV
if "%errorlevel%"=="5" set select=1&goto %backdest%
if "%errorlevel%"=="6" (
if "%select%"=="2" set select=1&goto STATION
if "%select%"=="1" set select=1&goto buyn1
)
goto nodemarket1

:buyn1
set destination=buyw1
if %xyz% LSS 150 goto noxyz
set /a xyz=%xyz%-150
set /a node_1=%sat_1%+1
cls
mode con cols=48 lines=35
if %select% gtr 1 set select=1
if %select% lss 1 set select=1
set s1=-
set s%select%=[90m#[0m[97m
echo %linevar%
echo Basic Shield Node purchased.
echo %linevar%
echo.
echo [%s1%] Okay
echo.
echo %linevar%
if "%msplash%"=="y" echo.
choice /c:d /n /m ""
set msplash=n
if "%errorlevel%"=="1" (
if "%select%"=="1" set select=1&goto satmarket1
)
goto buy1



:noxyz
set destination=noxyz
cls
mode con cols=48 lines=35
if %select% gtr 1 set select=1
if %select% lss 1 set select=1
set s1=-
set s%select%=[90m#[0m[97m
echo %linevar%
echo You don't have enough XYZ to buy this.
echo %linevar%
echo You should come back when you are not poor.
echo.
echo [%s1%] Okay
echo.
echo %linevar%
if "%msplash%"=="y" echo.
choice /c:d /n /m ""
set msplash=n
if "%errorlevel%"=="1" (
if "%select%"=="1" set select=1&goto satmarket1
)
goto noxyz


// MARK: Launchpads
:launchpad-select
title SATL-X - Launchpads
set destination=launchpad-select
set backdest=STATION
cls
mode con cols=48 lines=35
if %select% gtr 4 set select=1
if %select% lss 1 set select=4
set s1=-
set s2=-
set s3=-
set s4=-
set s%select%=[90m#[0m[97m
echo %linevar%
echo Station Launchpads
echo %linevar%
echo Please choose a launchpad.
echo.
echo [0m
echo [%s1%] Launchpad #1[0m
echo [%s2%] Launchpad #2[0m
echo [%s3%] Launchpad #3[0m
echo.
echo %linevar%
echo [%s4%] Back[0m
if "%msplash%"=="y" echo.
choice /c:wsmiad /n /m ""
set msplash=n
if "%errorlevel%"=="1" set /a select-=1
if "%errorlevel%"=="2" set /a select+=1
if "%errorlevel%"=="3" goto mainmenu
if "%errorlevel%"=="4" goto checkitemsINV
if "%errorlevel%"=="5" set select=1&goto %backdest%
if "%errorlevel%"=="6" (
if "%select%"=="1" set select=1&goto pad1
if "%select%"=="2" set select=1&goto pad2
if "%select%"=="3" set select=1&goto pad3
if "%select%"=="4" set select=1&goto STATION
)
goto launchpad-select


:pad1
set destination=pad1
set backdest=STATION
cls
mode con cols=48 lines=35
if %select% gtr 4 set select=1
if %select% lss 1 set select=4
set s1=-
set s2=-
set s3=-
set s4=-
set s%select%=[90m#[0m[97m
echo %linevar%
echo Launchpad #1
echo %linevar%
echo Please choose an option on the launch terminal
echo Rocket: %pad1_rocket%
echo Payload: %pad1_payload%
echo.
echo [0m
echo [%s1%] Select Rocket[0m
echo [%s2%] Rocket Playload[0m
echo.
echo [%s3%] Launch Rocket[0m
echo.
echo %linevar%
echo [%s4%] Back[0m
if "%msplash%"=="y" echo.
choice /c:wsmiad /n /m ""
set msplash=n
if "%errorlevel%"=="1" set /a select-=1
if "%errorlevel%"=="2" set /a select+=1
if "%errorlevel%"=="3" goto mainmenu
if "%errorlevel%"=="4" goto checkitemsINV
if "%errorlevel%"=="5" set select=1&goto %backdest%
if "%errorlevel%"=="6" (
if "%select%"=="1" set select=1&goto netst
if "%select%"=="2" set select=1&goto dungeons
if "%select%"=="3" goto map1
if "%select%"=="4" set select=1&goto towns
if "%select%"=="6" set select=1&goto STATION-2
)
goto pad1
