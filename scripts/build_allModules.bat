@echo off
setlocal

REM default parameter value
set QTVERSION=5.14.2
set VISUALVERSION=2017
set SOLARMODULESROOT=..\modules
set modules= SolARModuleCeres SolARModuleFBOW SolARModuleG2O SolARModuleNonFreeOpenCV SolARModuleOpenCV SolARModuleOpenGL SolARModuleOpenGV SolARModulePCL SolARModuleRealSense SolARModulePopSift SolARModuleTools
REM check whether user had supplied -h or --help . If yes display usage 
for %%A in ("--help" "-h") do if "%1"==%%A (call:display_usage %1 & exit /b 0)

REM replace default QTVERSION
if NOT [%1]==[] set QTVERSION=%1
if NOT [%2]==[] set VISUALVERSION=%2
if NOT [%3]==[] set SOLARMODULESROOT=%3

set JOM_PATH=c:\Qt\Tools\QtCreator\bin
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

(for %%a in (%modules%) do (
    call:buildAndInstall %SOLARMODULESROOT% %%a
))
endlocal
goto:eof

::--------------------------------------------------------
::-- Function to build and Install
::--------------------------------------------------------

:buildAndInstall
echo "Build module %~2 found in %~1\%~2"
if exist %~1\%~2\installpackages.txt (
    remaken install %~1\%~2\installpackages.txt
    remaken install %~1\%~2\installpackages.txt -c debug )

remaken install %~1\%~2\packagedependencies.txt
remaken install %~1\%~2\packagedependencies.txt -c debug

if exist build\modules\%~2\shared rmdir /S /Q build\modules\%~2\shared
if not exist build\modules\%~2\shared\debug mkdir build\modules\%~2\shared\debug
if not exist build\modules\%~2\shared\release mkdir build\modules\%~2\shared\release

cd %~dp0\build\modules\%~2\shared\release
%QMAKE_PATH%\qmake.exe ..\..\..\..\..\%~1\%~2\%~2.pro -spec win32-msvc CONFIG+=qml_debug && %JOM_PATH%\jom.exe qmake_all
%JOM_PATH%\jom.exe

cd %~dp0\build\modules\%~2\shared\debug
%QMAKE_PATH%\qmake.exe ..\..\..\..\..\%~1\%~2\%~2.pro -spec win32-msvc CONFIG+=debug CONFIG+=qml_debug && %JOM_PATH%\jom.exe qmake_all
%JOM_PATH%\jom.exe

cd "%~dp0"

EXIT /b 0


::--------------------------------------------------------
::-- Function display_usage starts below here
::--------------------------------------------------------

:display_usage

echo This script builds modules in shared mode.
echo It can receive two optional arguments. 
echo.
echo Usage: params [Qt kit version to use - default='%QTVERSION%'] [Visual version to use - default='%VISUALVERSION%'] [path to SolAR modules folder - default='%SOLARMODULESROOT%'] 

exit /b 0

:end

