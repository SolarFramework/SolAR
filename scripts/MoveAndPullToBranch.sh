#!/bin/bash

BRANCH="master"
FORCE=""
SOLARROOT=../

display_usage() { 
	echo "This script builds all SolAR projects in shared mode."
    echo "It can receive three optional arguments." 
	echo -e "\nUsage: \$0 [branch to checkout and pull | default=master] [Force checkout if first argument equals force | default=empty] [path to SolAR root folder | default='${SOLARROOT}']  \n" 
} 


# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $1 == "--help") ||  $1 == "-h" ]] 
then 
    display_usage
    exit 0
fi

if [ $# -eq 1 ]; then
	BRANCH=$1
fi 

if [ $# -eq 2 ]; then
	FORCE=$2
fi 

if [ $# -eq 3 ]; then
	SOLARROOT=$3
fi 

if [ ! -d ${SOLARROOT} ]; then
	echo "SOLAR project root path '${SOLARROOT}' doesn't exist"
	exit 2
fi

pushd ${SOLARROOT}
if (FORCE="force"); then
   echo "Force checkout"
   git checkout -f ${BRANCH}
   git pull
   git submodule foreach --recursive git checkout -f ${BRANCH}
   git submodule foreach --recursive git pull
else 
   git checkout ${BRANCH}
   git pull
   git submodule foreach --recursive git checkout ${BRANCH}
   git submodule foreach --recursive git pull
fi
popd
