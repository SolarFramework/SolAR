@echo off

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

call build_framework.bat %QTVERSION% %VISUALVERSION% %SOLARROOTFOLDER%/core/SolARFramework
call build_allModules.bat %QTVERSION% %VISUALVERSION% %SOLARROOTFOLDER%/modules
call build_allModuleTests.bat %QTVERSION% %VISUALVERSION% %SOLARROOTFOLDER%
call build_allSamples.bat %QTVERSION% %VISUALVERSION% %SOLARROOTFOLDER%
call build_allPipelines.bat %QTVERSION% %VISUALVERSION% %SOLARROOTFOLDER%
call build_allPipelineTests.bat %QTVERSION% %VISUALVERSION% %SOLARROOTFOLDER%
call build_allServices.bat %QTVERSION% %VISUALVERSION% %SOLARROOTFOLDER%
call build_allServiceTests.bat %QTVERSION% %VISUALVERSION% %SOLARROOTFOLDER%
endlocal
goto:eof

:display_usage

echo This script builds all SolAR projects.
echo It can receive three optional arguments. 
echo.
echo Usage: params [Qt kit version to use - default='%QTVERSION%'] [Visual version to use - default='%VISUALVERSION%'] [path to SolAR root folder - default='%SOLARROOTFOLDER%'] 

exit /b 0

:end