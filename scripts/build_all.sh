#!/bin/bash

CROSSBUILD=NO
QTVERSION=5.15.2
NBPROCESSORS=6
SOLARROOT=../

PLATEFORMFOLDER="linux/"

display_usage() { 
	echo "This script builds all SolAR projects in shared mode."
    echo "It can receive two optional arguments." 
	echo -e "\nUsage: \$0 [ Cross build ? | default='${CROSSBUILD}' | possible values=[NO, ANDROID]] [Qt kit version to use | default='${QTVERSION}'] [path to SolAR root folder | default='${SOLARROOT}'] \n" 
} 


# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $1 == "--help") ||  $1 == "-h" ]] 
then 
    display_usage
    exit 0
fi

if [ $# -ge 1 ]; then
	CROSSBUILD=$1
	if [[ "CROSSBUILD" == "ANDROID" ]]; then
		echo "Cross-build for Android requested."	
	fi
fi

if [ $# -ge 2 ]; then
	NBPROCESSORS=$2
	echo "Build using ${NBPROCESSORS} processors"
fi

if [ $# -ge 3 ]; then
	QTVERSION=$3
fi 

if [ $# -eq 4 ]; then
	SOLARROOT=$4
fi

if [ ! -d ${SOLARROOT} ]; then
	echo "SOLAR project root path '${SOLARROOT}' doesn't exist"
	exit 2
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
	PLATEFORMFOLDER="mac/"
fi

if [[ "$CROSSBUILD" == "ANDROID" ]]; then
	PLATEFORMFOLDER="android/"
fi		
	
./build_framework.sh ${CROSSBUILD} ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}/core/SolARFramework
./build_allModules.sh ${CROSSBUILD} ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}/modules

./build_allPipelines.sh ${CROSSBUILD} ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}
echo "Build report for all pipelines"
cat build/${PLATEFORMFOLDER}pipelines/report.txt

if [ ! "$CROSSBUILD" == "ANDROID" ]; then
	./build_allSamples.sh ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}
	./build_allModuleTests.sh ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}
	./build_allPipelineTests.sh ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}
	./build_allServices.sh ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}
	./build_allServiceTests.sh ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}
fi

# display build reports
echo "Build report for SolAR framework"
cat build/${PLATEFORMFOLDER}core/SolARFramework/report.txt
echo "Build report for all modules"
cat build/${PLATEFORMFOLDER}modules/report.txt
echo "Build report for all pipelines"
cat build/${PLATEFORMFOLDER}pipelines/report.txt

if [ ! "$CROSSBUILD" == "ANDROID" ]; then
	echo "Build report for all samples"
	cat build/${PLATEFORMFOLDER}samples/report.txt
	echo "Build report for all module tests"
	cat build/${PLATEFORMFOLDER}moduleTests/report.txt
	echo "Build report for all pipeline tests"
	cat build/${PLATEFORMFOLDER}pipelineTests/report.txt
	echo "Build report for all services"
	cat build/${PLATEFORMFOLDER}services/report.txt
	echo "Build report for all service tests"
	cat build/${PLATEFORMFOLDER}serviceTests/report.txt
fi
