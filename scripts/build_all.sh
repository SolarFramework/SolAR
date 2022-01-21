#!/bin/bash


QTVERSION=5.15.2
NBPROCESSORS=6
SOLARROOT=../

display_usage() { 
	echo "This script builds all SolAR projects in shared mode."
    echo "It can receive two optional arguments." 
	echo -e "\nUsage: \$0 [Qt kit version to use | default='${QTVERSION}'] [path to SolAR root folder | default='${SOLARROOT}'] \n" 
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
	SOLARROOT=$3
fi

if [ ! -d ${SOLARROOT} ]; then
	echo "SOLAR project root path '${SOLARROOT}' doesn't exist"
	exit 2
fi

./build_framework.sh ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}/core/SolARFramework
./build_allModules.sh ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}/modules
./build_allModuleTests.sh ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}
./build_allSamples.sh ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}
./build_allPipelines.sh ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}
./build_allPipelineTests.sh ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}
./build_allServices.sh ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}
./build_allServiceTests.sh ${NBPROCESSORS} ${QTVERSION} ${SOLARROOT}
