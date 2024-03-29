#!/bin/bash

QTVERSION=5.15.2
NBPROCESSORS=6
SOLARROOTFOLDER=..
PLATEFORMFOLDER="linux/"

display_usage() { 
	echo "This script builds the SolAR samples in shared mode."
    echo "It can receive two optional arguments." 
	echo -e "\nUsage: \$0 [Nb processors used for building | default='${NBPROCESSORS}'] [Qt kit version to use | default='${QTVERSION}'] [path to the folder containing the QT project SolARAllmodules.pro | default='${SOLARROOTFOLDER}'] \n" 
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
	SOLARROOTFOLDER=$3
fi

# default linux values

QMAKE_PATH=$HOME/Qt/${QTVERSION}/gcc_64/bin/
QMAKE_SPEC=linux-g++

if [[ "$OSTYPE" == "darwin"* ]]; then
# overload for mac values
	QMAKE_PATH=~/Applications/Qt/${QTVERSION}/clang_64/bin/
	QMAKE_SPEC=macx-clang
	PLATEFORMFOLDER="mac/"
fi

if [ ! -d ${QMAKE_PATH} ]; then
	echo "Warning ! '${QMAKE_PATH}' does not exists. Try to find qmake and make in your PATH."
	QMAKE_PATH=""
fi

if [ ! -f ${SOLARROOTFOLDER}/SolARAllSamples.pro ]; then
	echo "QT project SolARAllSamples.pro doesn't exist in folder '${SOLARROOTFOLDERPROJECT}'"
	exit 2
fi

echo "SolAR all samples QT project used is : ${SOLARROOTFOLDER}/SolARAllSamples.pro"

BUILDREPORT=""
if [ -f build/${PLATEFORMFOLDER}samples/report.txt ]; then
	rm -f build/${PLATEFORMFOLDER}samples/report.txt
fi

buildAndInstall() {
if [ -d build/${PLATEFORMFOLDER}samples/${1}/shared ]; then
	rm -rf build/${PLATEFORMFOLDER}samples/${1}/shared
fi
mkdir -p build/${PLATEFORMFOLDER}samples/${1}/shared/debug
mkdir -p build/${PLATEFORMFOLDER}samples/${1}/shared/release

sampleProjectPath=${2%/*}
echo "===========> run remaken from ${SOLARROOTFOLDER}/${sampleProjectPath}/packagedependencies.txt <==========="
remaken install ${SOLARROOTFOLDER}/${sampleProjectPath}/packagedependencies.txt
remaken install ${SOLARROOTFOLDER}/${sampleProjectPath}/packagedependencies.txt -c debug


echo "===========> building ${1} shared <==========="
pushd build/${PLATEFORMFOLDER}samples/${1}/shared/debug
${QMAKE_PATH}qmake ../../../../../../${SOLARROOTFOLDER}/${2} -spec ${QMAKE_SPEC} CONFIG+=debug CONFIG+=x86_64 CONFIG+=qml_debug && /usr/bin/make qmake_all
make -j${NBPROCESSORS}
if [ $? -eq 0 ]; then 
	BUILDREPORT="${BUILDREPORT}\n$(tput setab 2)success - ${1} - Debug$(tput sgr 0)"
else
	BUILDREPORT="${BUILDREPORT}\n$(tput setab 1)failed - ${1} - Debug$(tput sgr 0)"
fi
popd
pushd build/${PLATEFORMFOLDER}samples/${1}/shared/release
${QMAKE_PATH}qmake ../../../../../../${SOLARROOTFOLDER}/${2} -spec ${QMAKE_SPEC} CONFIG+=x86_64 CONFIG+=qml_debug && /usr/bin/make qmake_all
make -j${NBPROCESSORS}
if [ $? -eq 0 ]; then 
	BUILDREPORT="${BUILDREPORT}\n$(tput setab 2)success - ${1} - Release$(tput sgr 0)"
else
	BUILDREPORT="${BUILDREPORT}\n$(tput setab 1)failed - ${1} - Release$(tput sgr 0)"
fi
popd
}

for sampleProjectPath in $(grep ".pro" ${SOLARROOTFOLDER}/SolARAllSamples.pro | grep -v "SUBDIRS +=" | tr -d '\\')
  do
     sampleProject="${sampleProjectPath##*/}"
     sampleName="${sampleProject%%.pro}"
     echo "${sampleName} ${sampleProjectPath}"
     buildAndInstall ${sampleName} ${sampleProjectPath} 
  done

echo -e ${BUILDREPORT}
echo -e ${BUILDREPORT} >> build/${PLATEFORMFOLDER}samples/report.txt





