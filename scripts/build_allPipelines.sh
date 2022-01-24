#!/bin/bash

QTVERSION=5.15.2
NBPROCESSORS=6
SOLARROOTFOLDER=..

display_usage() { 
	echo "This script builds the SolAR samples in shared mode."
    echo "It can receive three optional arguments." 
	echo -e "\nUsage: \$0 [Nb processors used for building | default='${NBPROCESSORS}'] [Qt kit version to use | default='${QTVERSION}'] [path to the folder containing the QT project SolARAllPipelines.pro | default='${SOLARROOTFOLDER}'] \n" 
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

if [ ! -f ${SOLARROOTFOLDER}/SolARAllPipelines.pro ]; then
	echo "QT project SolARAllPipelines.pro doesn't exist in folder '${SOLARROOTFOLDERPROJECT}'"
	exit 2
fi

echo "SOLAR all pipelines QT project used is : ${SOLARROOTFOLDER}/SolARAllPipelines.pro"

buildAndInstall() {
if [ -d build/pipelines/${1}/shared ]; then
	rm -rf build/pipelines/${1}/shared
fi
mkdir -p build/pipelines/${1}/shared/debug
mkdir -p build/pipelines/${1}/shared/release

pipelineProjectPath=${2%/*}
echo "===========> run remaken from ${SOLARROOTFOLDER}/${pipelineProjectPath}/packagedependencies.txt <==========="
remaken install ${SOLARROOTFOLDER}/${pipelineProjectPath}/packagedependencies.txt
remaken install ${SOLARROOTFOLDER}/${pipelineProjectPath}/packagedependencies.txt -c debug


echo "===========> building ${1} shared <==========="
pushd build/pipelines/${1}/shared/debug
${QMAKE_PATH}/qmake ../../../../../${SOLARROOTFOLDER}/${2} -spec ${QMAKE_SPEC} CONFIG+=debug CONFIG+=x86_64 CONFIG+=qml_debug && /usr/bin/make qmake_all
make -j${3}
popd
pushd build/pipelines/${1}/shared/release
${QMAKE_PATH}/qmake ../../../../../${SOLARROOTFOLDER}/${2} -spec ${QMAKE_SPEC} CONFIG+=x86_64 CONFIG+=qml_debug && /usr/bin/make qmake_all
make -j${3}
popd
}

for pipelineProjectPath in $(grep ".pro" ${SOLARROOTFOLDER}/SolARAllPipelines.pro | grep -v "SUBDIRS +=" | tr -d '\\')
  do
     pipelineProject="${pipelineProjectPath##*/}"
     pipelineName="${pipelineProject%%.pro}"
     echo "${pipelineName} ${pipelineProjectPath}"
     buildAndInstall ${pipelineName} ${pipelineProjectPath} ${NBPROCESSORS}
  done








