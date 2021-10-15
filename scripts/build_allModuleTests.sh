#!/bin/bash

QTVERSION=5.15.2
SOLARROOTFOLDER=../

display_usage() { 
	echo "This script builds the SolAR samples in shared mode."
    echo "It can receive two optional arguments." 
	echo -e "\nUsage: \$0 [Qt kit version to use | default='${QTVERSION} [path to the folder containing the QT project SolARAllModulesTests.pro | default='${SOLARROOTFOLDER}']'] \n" 
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
	SOLARROOTFOLDER=$2
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

if [ ! -f ${SOLARROOTFOLDER}SolARAllModulesTests.pro ]; then
	echo "QT project SolARAllModulesTests.pro doesn't exist in folder '${SOLARROOTFOLDERPROJECT}'"
	exit 2
fi

echo "SOLAR all pipelines QT project used is : ${SOLARROOTFOLDER}SolARAllModulesTests.pro"

buildAndInstall() {
if [ -d build-${1}/shared ]; then
	rm -rf build-${1}/shared
fi
mkdir -p build-${1}/shared/debug
mkdir -p build-${1}/shared/release

moduleTestProjectPath=${2%/*}
echo "===========> run remaken from ${SOLARROOTFOLDER}/${moduleTestProjectPath}/packagedependencies.txt <==========="
remaken install ${SOLARROOTFOLDER}/${moduleTestProjectPath}/packagedependencies.txt
remaken install ${SOLARROOTFOLDER}/${moduleTestProjectPath}/packagedependencies.txt -c debug


echo "===========> building ${1} shared <==========="
pushd build-${1}/shared/debug
`${QMAKE_PATH}/qmake ../../../${SOLARROOTFOLDER}/${2} -spec ${QMAKE_SPEC} CONFIG+=debug CONFIG+=x86_64 CONFIG+=qml_debug && /usr/bin/make qmake_all`
make
make install
make install_deps
popd
pushd build-${1}/shared/release
`${QMAKE_PATH}/qmake ../../../${SOLARROOTFOLDER}/${2} -spec ${QMAKE_SPEC} CONFIG+=x86_64 CONFIG+=qml_debug && /usr/bin/make qmake_all`
make
make install
make install_deps
popd
}

for moduleTestProjectPath in $(grep ".pro" ${SOLARROOTFOLDER}SolARAllModulesTests.pro | grep -v "SUBDIRS +=" | tr -d '\\')
  do
     moduleTestProject="${moduleTestProjectPath##*/}"
     moduleTestName="${moduleTestProject%%.pro}"
     echo "${moduleTestName} ${moduleTestProjectPath}"
     buildAndInstall ${moduleTestName} ${moduleTestProjectPath}
  done







