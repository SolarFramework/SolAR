#!/bin/bash

QTVERSION=5.15.2
SOLARFRAMEWORKROOT=../core/SolARFramework

display_usage() { 
	echo "This script builds the SolAR framework in shared mode."
    echo "It can receive two optional arguments." 
	echo -e "\nUsage: \$0 [Qt kit version to use | default='${QTVERSION} [path to SolAR Framework project root | default='${SOLARFRAMEWORKROOT}']'] \n" 
} 

# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $1 == "--help") ||  $1 == "-h" ]] 
then 
    display_usage
    exit 0
fi 

if [ $# -ge 1 ]; then
	QTVERSION=$1
fi

if [ $# -eq 2 ]; then
	SOLARFRAMEWORKROOT=$2
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

if [ -d build-SolARFramework/shared ]; then
	rm -rf build-SolARFramework/shared
fi

mkdir -p build-SolARFramework/shared/debug
mkdir -p build-SolARFramework/shared/release

echo "===========> run remaken from ${SOLARROOTFOLDER}/packagedependencies.txt <==========="
remaken install ${SOLARFRAMEWORKROOT}/packagedependencies.txt
remaken install ${SOLARFRAMEWORKROOT}/packagedependencies.txt -c debug

echo "===========> building SolAR Framework shared <==========="
pushd build-SolARFramework/shared/debug
`${QMAKE_PATH}/qmake ../../../${SOLARFRAMEWORKROOT}/SolARFramework.pro -spec ${QMAKE_SPEC} CONFIG+=debug CONFIG+=x86_64 CONFIG+=qml_debug && /usr/bin/make qmake_all`
make
make install
popd
pushd build-SolARFramework/shared/release
`${QMAKE_PATH}/qmake ../../../${SOLARFRAMEWORKROOT}/SolARFramework.pro -spec ${QMAKE_SPEC} CONFIG+=x86_64 CONFIG+=qml_debug && /usr/bin/make qmake_all`
make
make install
popd

