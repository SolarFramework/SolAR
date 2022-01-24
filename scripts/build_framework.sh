#!/bin/bash

QTVERSION=5.15.2
NBPROCESSORS=6
SOLARFRAMEWORKROOT=../core/SolARFramework

display_usage() { 
	echo "This script builds the SolAR framework in shared mode."
    echo "It can receive two optional arguments." 
	echo -e "\nUsage: \$0 [Nb processors used for building | default='${NBPROCESSORS}'] [Qt kit version to use | default='${QTVERSION}'] [path to SolAR Framework project root | default='${SOLARFRAMEWORKROOT}'] \n" 
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
	SOLARFRAMEWORKROOT=$3
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

if [ ! -d ${SOLARFRAMEWORKROOT} ]; then
	echo "SOLAR project root path '${SOLARFRAMEWORKROOT}' doesn't exist"
	exit 2
fi
echo "SOLAR project root path used is : ${SOLARFRAMEWORKROOT}"

if [ -d build/core/SolARFramework/shared ]; then
	rm -rf build/core/SolARFramework/shared
fi

mkdir -p build/core/SolARFramework/shared/debug
mkdir -p build/core/SolARFramework/shared/release

echo "===========> run remaken from ${SOLARROOTFOLDER}/packagedependencies.txt <==========="
if [ -f ${SOLARFRAMEWORKROOT}/installpackages.txt ]; then
	remaken install ${SOLARFRAMEWORKROOT}/installpackages.txt
	remaken install ${SOLARFRAMEWORKROOT}/installpackages.txt -c debug
fi
remaken install ${SOLARFRAMEWORKROOT}/packagedependencies.txt
remaken install ${SOLARFRAMEWORKROOT}/packagedependencies.txt -c debug

echo "===========> building SolAR Framework shared <==========="
pushd build/core/SolARFramework/shared/debug
${QMAKE_PATH}/qmake ../../../../../${SOLARFRAMEWORKROOT}/SolARFramework.pro -spec ${QMAKE_SPEC} CONFIG+=debug CONFIG+=x86_64 CONFIG+=qml_debug && /usr/bin/make qmake_all
make -j${NBPROCESSORS}
popd
pushd build/core/SolARFramework/shared/release
${QMAKE_PATH}/qmake ../../../../../${SOLARFRAMEWORKROOT}/SolARFramework.pro -spec ${QMAKE_SPEC} CONFIG+=x86_64 CONFIG+=qml_debug && /usr/bin/make qmake_all
make -j${NBPROCESSORS}
popd

