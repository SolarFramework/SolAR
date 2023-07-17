@echo off
setlocal

set PROJECT=SolARFrameworkGRPCRemote

REM default parameter value
set QTVERSION=5.14.2
set VISUALVERSION=2017
set SOLARFRAMEWORKGRPCROOT=..\core\SolARFrameworkGRPCRemote

REM check whether user had supplied -h or --help . If yes display usage 
for %%A in ("--help" "-h") do if "%1"==%%A (call:display_usage %1 & exit /b 0)

REM replace default QTVERSION
if NOT [%1]==[] set QTVERSION=%1
if NOT [%2]==[] set VISUALVERSION=%2
if NOT [%3]==[] set SOLARFRAMEWORKGRPCROOT=%3

set JOM_PATH=c:\Qt\Tools\QtCreator\bin
if not exist %JOM_PATH%\jom.exe set JOM_PATH=c:\Qt\Tools\QtCreator\bin\jom

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

if exist %SOLARFRAMEWORKGRPCROOT%/installpackages.txt (
    remaken install %SOLARFRAMEWORKGRPCROOT%/installpackages.txt
    remaken install %SOLARFRAMEWORKGRPCROOT%/installpackages.txt -c debug )

remaken install %SOLARFRAMEWORKGRPCROOT%/packagedependencies.txt
remaken install %SOLARFRAMEWORKGRPCROOT%/packagedependencies.txt -c debug

if exist build\core\%PROJECT%\shared rmdir /S /Q build\core\%PROJECT%\shared
if not exist build\core\%PROJECT%\shared\debug mkdir build\core\%PROJECT%\shared\debug
if not exist build\core\%PROJECT%\shared\release mkdir build\core\%PROJECT%\shared\release

echo "===========> building %PROJECT% shared <==========="
cd %~dp0\build\core\%PROJECT%\shared\debug

%QMAKE_PATH%\qmake.exe ../../../../../%SOLARFRAMEWORKGRPCROOT%/%PROJECT%.pro -spec win32-msvc CONFIG+=debug CONFIG+=qml_debug && %JOM_PATH%\jom.exe qmake_all
%JOM_PATH%\jom.exe
::%JOM_PATH%\jom.exe install

cd %~dp0\build\core\%PROJECT%\shared\release
%QMAKE_PATH%\qmake.exe ../../../../../%SOLARFRAMEWORKGRPCROOT%/%PROJECT%.pro -spec win32-msvc CONFIG+=qml_debug && %JOM_PATH%\jom.exe qmake_all
%JOM_PATH%\jom.exe
::%JOM_PATH%\jom.exe install

cd "%~dp0"

endlocal
goto:eof


::--------------------------------------------------------
::-- Function display_usage starts below here
::--------------------------------------------------------

:display_usage

echo This script builds %PROJECT% in shared mode.
echo It can receive two optional arguments. 
echo.
echo Usage: params [Qt kit version to use - default='%QTVERSION%'] [Visual version to use - default='%VISUALVERSION%'] [path to SolAR Framework Grpc Remote project root - default='%SOLARFRAMEWORKGRPCROOT%'] 

exit /b 0

:end

