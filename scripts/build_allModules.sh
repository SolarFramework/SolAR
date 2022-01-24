#!/bin/bash

QTVERSION=5.15.2
SOLARMODULESROOT=../modules
NBPROCESSORS=6
modules=("SolARModuleCeres" "SolARModuleFBOW" "SolARModuleG2O" "SolARModuleNonFreeOpenCV" "SolARModuleOpenCV" "SolARModuleOpenGL" "SolARModuleOpenGV" "SolARModulePCL" "SolARModulePopSift" "SolARModuleTools")

display_usage() { 
	echo "This script builds the SolAR modules in shared mode."
    echo "It can receive three optional arguments." 
	echo -e "\nUsage: \$0 [Nb processors used for building | default='${NBPROCESSORS}'] [Qt kit version to use | default='${QTVERSION}'] [path to SolAR modules root folder | default='${SOLARMODULESROOT}'] \n" 
}


# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $1 == "--help") ||  $1 == "-h" ]] 
then 
    display_usage
    exit 0
fi 

if [ $# -ge 1 ]; then
	NBPROCESSORS=$1
	echo "Build using ${NBPROCESSORS} processors"
fi

if [ $# -ge 2 ]; then
	QTVERSION=$2
fi

if [ $# -eq 3 ]; then
	SOLARMODULESROOT=$3
fi

# default linux values

QMAKE_PATH=$HOME/Qt/${QTVERSION}/gcc_64/bin
QMAKE_SPEC=linux-g++

if [[ "$OSTYPE" == "darwin"* ]]; then
# overload for mac values
	QMAKE_PATH=~/Applications/Qt/${QTVERSION}/clang_64/bin
	QMAKE_SPEC=macx-clang
fi

if [ ! -d ${QMAKE_PATH} ]; then
	echo "Qt path '${QMAKE_PATH}' doesn't exist : check your Qt installation and kits"
	exit 2
fi

if [ ! -d ${SOLARMODULESROOT} ]; then
	echo "SOLAR module root path '${SOLARMODULESROOT}' doesn't exist"
	exit 2
fi
echo "SOLAR module folder root path used is : ${SOLARMODULESROOT}"

buildAndInstall() {

if [ -d build/modules/${1}/shared ]; then
	rm -rf build/modules/${1}/shared
fi
mkdir -p build/modules/${1}/shared/debug
mkdir -p build/modules/${1}/shared/release

echo "===========> run remaken for ${1} <==========="
if [ -f ${SOLARMODULESROOT}/${1}/installpackages.txt ]; then
	remaken install ${SOLARMODULESROOT}/${1}/installpackages.txt
	remaken install ${SOLARMODULESROOT}/${1}/installpackages.txt -c debug
fi
remaken install ${SOLARMODULESROOT}/${1}/packagedependencies.txt
remaken install ${SOLARMODULESROOT}/${1}/packagedependencies.txt -c debug

echo "===========> building ${1} shared <==========="
pushd build/modules/${1}/shared/debug
${QMAKE_PATH}/qmake ../../../../../${SOLARMODULESROOT}/${1}/${1}.pro -spec ${QMAKE_SPEC} CONFIG+=debug CONFIG+=x86_64 CONFIG+=qml_debug && /usr/bin/make qmake_all
make -j${2}
popd

pushd build/modules/${1}/shared/release
${QMAKE_PATH}/qmake ../../../../../${SOLARMODULESROOT}/${1}/${1}.pro -spec ${QMAKE_SPEC} CONFIG+=x86_64 CONFIG+=qml_debug && /usr/bin/make qmake_all
make -j${2}
popd
}

for module in ${modules[*]}
  do
    buildAndInstall $module ${NBPROCESSORS}
  done




