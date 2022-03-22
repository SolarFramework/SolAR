@echo off
setlocal enabledelayedexpansion

REM default parameter value
set QTVERSION=5.14.2
set VISUALVERSION=2017
set SOLARROOTFOLDER=..

REM check whether user had supplied -h or --help . If yes display usage 
for %%A in ("--help" "-h") do if "%1"==%%A (call:display_usage %1 & exit /b 0)

REM replace default QTVERSION
if NOT [%1]==[] set QTVERSION=%1
if NOT [%2]==[] set VISUALVERSION=%2
if NOT [%3]==[] set SOLARROOTFOLDER=%3

set JOM_PATH=c:\Qt\Tools\QtCreator\bin
<<<<<<< HEAD
=======
if not exist %JOM_PATH%\jom.exe set JOM_PATH=c:\Qt\Tools\QtCreator\bin\jom
>>>>>>> develop
set QMAKE_PATH=C:\Qt\%QTVERSION%\msvc%VISUALVERSION%_64\bin

if not exist %QMAKE_PATH% (echo "Qt path '%QMAKE_PATH%' doesn't exist : check your Qt installation and kits" & exit /b 2)

if "%VISUALVERSION%" == "2015" (
    set min=14.0 
....set max=15.0 
) else if "%VISUALVERSION%" == "2017" (
    set min=15.0
    set max=16.0 
) else if "%VISUALVERSION%" == "2019" (
    set min=16.0
    set max=17.0
) else if "%VISUALVERSION%" == "2022" (
    set min=17.0
    set max=18.0
) else (echo "VISUAL version argument should be either 2015, 2017, 2019 or 2022" & exit /b 2)

FOR /F "tokens=* USEBACKQ" %%a in (`vswhere -version "[%min%,%max%]" -property installationPath`) do (
    if [%%a]==[] (echo "Path for Visual Studio %VISUALVERSION% has not been found" & exit /b 2)

	echo " Visual Studio %VISUALVERSION% has been found in %%a"
	call "%%a\VC\Auxiliary\Build\vcvars64.bat"
)

if not exist %SOLARROOTFOLDER%\SolARAllPipelines.pro (
    echo "QT project SolARAllPipelines.pro doesn't exist in folder %SOLARROOTFOLDER%"
    goto:eof
)

echo "SOLAR all pipeline QT project used is : %SOLARROOTFOLDER%\SolARAllPipelines.pro"

for /f "delims=" %%A in ('powershell -Command "& {Select-String -Path "%SOLARROOTFOLDER%\SolARAllPipelines.pro" -Pattern 'samples.*pro' | Select-Object -ExpandProperty Matches | Select-Object -ExpandProperty Value}"') do (call:process_pipeline_path %%A)
endlocal
goto:eof

:process_pipeline_path
set "pipelinePath=%~1"
    
set "_slash_pos="
set "noslash=%pipelinePath:/=%"
if "%noslash%"=="%pipelinePath%" goto :jjloopEnd
set /a jj=1
:jjloop
call set "_auxiliary=%%pipelinePath:~-%jj%%%"
set "_aux_1char=%_auxiliary:~0,1%"
if "%_aux_1char%"=="/" (
    set /A _slash_pos=jj
    set /A _slash_pre=jj - 1
    goto :jjloopEnd
)
set /a jj+=1
goto :jjloop
:jjloopEnd
if not defined _slash_pos (
    rem string does not contain any dot character at all
    set "vara=%pipelinePath%"
    set "varb="
    goto :launchBuild
)
call set "vara=%%pipelinePath:~0,-%_slash_pos%%%"
if %_slash_pos% EQU 1 (
    set "varb="
) else (
    call set "varb=%%pipelinePath:~-%_slash_pre%%%"
)
:launchBuild
rem debugging output 
set varc=%varb:.pro=%
call:buildAndInstall %SOLARROOTFOLDER% %vara:/=\% %varc%
goto :eof

::--------------------------------------------------------
::-- Function to build and Install
::--------------------------------------------------------

:buildAndInstall
echo "Build pipeline %~3 found in %~1\%~2"
if exist %~1\%~2\installpackages.txt (
    remaken install %~1\%~2\installpackages.txt
    remaken install %~1\%~2\installpackages.txt -c debug )

remaken install %~1\%~2\packagedependencies.txt
remaken install %~1\%~2\packagedependencies.txt -c debug

if exist build\pipelines\%~3\shared rmdir /S /Q build\pipelines\%~3\shared
if not exist build\pipelines\%~3\shared\debug mkdir build\pipelines\%~3\shared\debug
if not exist build\pipelines\%~3\shared\release mkdir build\pipelines\%~3\shared\release

cd %~dp0\build\pipelines\%~3\shared\release
%QMAKE_PATH%\qmake.exe ..\..\..\..\..\%~1\%~2\%~3.pro -spec win32-msvc CONFIG+=qml_debug && %JOM_PATH%\jom.exe qmake_all
%JOM_PATH%\jom.exe

cd %~dp0\build\pipelines\%~3\shared\debug
%QMAKE_PATH%\qmake.exe ..\..\..\..\..\%~1\%~2\%~3.pro -spec win32-msvc CONFIG+=debug CONFIG+=qml_debug && %JOM_PATH%\jom.exe qmake_all
%JOM_PATH%\jom.exe

cd "%~dp0"

EXIT /b 0


::--------------------------------------------------------
::-- Function display_usage starts below here
::--------------------------------------------------------

:display_usage

echo This script builds pipelines.
echo It can receive three optional arguments. 
echo.
echo Usage: params [Qt kit version to use - default='%QTVERSION%'] [Visual version to use - default='%VISUALVERSION%'] [path to SolAR root folder - default='%SOLARROOTFOLDER%'] 

exit /b 0

:end

