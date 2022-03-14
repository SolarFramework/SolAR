@echo off

echo **** Remaken version
remaken version
echo .
echo ****cmake version
cmake -version
echo .
echo **** pkg-config version
pkg-config --version
echo .
echo **** conan version
conan -v
echo .
echo **** visual compiler version
cl.exe
echo .
echo **** REMAKEN_PKG_ROOT
echo %REMAKEN_PKG_ROOT%
echo .
echo **** remaken profile
remaken profile display
echo .
echo **** conan profile
conan profile show default

