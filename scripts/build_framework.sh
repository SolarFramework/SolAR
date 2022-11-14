#!/bin/bash

CROSSBUILD=NO
QTVERSION=5.15.2
NBPROCESSORS=6
SOLARFRAMEWORKROOT=../core/SolARFramework

PLATEFORMFOLDER="linux/"
ANDROIDREMAKENOPTIONS=""
QMAKEOPTIONS="CONFIG+=x86_64"
MAKE_PATH="/usr/bin/"

display_usage() { 
	echo "This script builds the SolAR framework in shared mode."
	echo "It can receive four optional arguments." 
	echo -e "\nUsage: \$0 [ Cross build ? | default='${CROSSBUILD}' | possible values=[NO, ANDROID]] [Nb processors used for building | default='${NBPROCESSORS}'] [Qt kit version to use | default='${QTVERSION}'] [path to SolAR Framework project root | default='${SOLARFRAMEWORKROOT}'] \n" 
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

if [ $# -eq 3 ]; then
	SOLARFRAMEWORKROOT=$3
fi

# default linux values

QMAKE_PATH=$HOME/Qt/${QTVERSION}/gcc_64/bin/
QMAKE_SPEC=linux-g++

if [[ "$OSTYPE" == "darwin"* ]]; then
# overload for mac values
	QMAKE_PATH=~/Applications/Qt/${QTVERSION}/clang_64/bin/
	QMAKE_SPEC=macx-clang
	PLATEFORMFOLDER="mac/"
else
	if [ "$CROSSBUILD" == "ANDROID" ]; then	
		QMAKE_PATH=$HOME/Qt/${QTVERSION}/android/bin/
	fi
fi

if [ ! -d ${QMAKE_PATH} ]; then
	echo "Warning ! '${QMAKE_PATH}' does not exists. Try to find qmake and make in your PATH."
	QMAKE_PATH=""
fi

if [ ! -d ${SOLARFRAMEWORKROOT} ]; then
	echo "SOLAR project root path '${SOLARFRAMEWORKROOT}' doesn't exist"
	exit 2
fi
echo "SOLAR project root path used is : ${SOLARFRAMEWORKROOT}"

if [ "$CROSSBUILD" == "ANDROID" ]; then		
	if [ ! -n "$ANDROID_NDK_ROOT" ]; then
		echo "The ANDROID_NDK_ROOT environnement variable must be defined for cross-building (e.g. /home/user/Android/Sdk/ndk/21.3.6528147)."
		exit 2
	else
		if [ -f $ANDROID_NDK_ROOT/prebuilt/linux-x86_64/bin/make ]; then
			echo "Cross-build make found in $ANDROID_NDK_ROOT/prebuilt/linux-x86_64/bin/make"
		else
			echo "$ANDROID_NDK_ROOT/prebuilt/linux-x86_64/bin/make doesn't exist for Android cross-build"
			exit 2
		fi	
	fi	
	ANDROIDFOLDER="android/"
	ANDROIDREMAKENOPTIONS="--cpp-std 17 -b clang -o android -a arm64-v8a"
	echo "androidRemakenOptions: ${ANDROIDREMAKENOPTIONS}"
	if conan profile list | grep -w 'android-clang-arm64-v8a'; then
		echo "conan profile android-clang-arm64-v8a already exists:"
	else
		conan profile new --force --detect android-clang-arm64-v8a 
		conan profile update settings.os=Android android-clang-arm64-v8a 
		conan profile update settings.arch=armv8 android-clang-arm64-v8a 
		conan profile update settings.compiler=clang android-clang-arm64-v8a 
		conan profile update settings.compiler.version=8 android-clang-arm64-v8a 
		conan profile update settings.compiler.libcxx=libc++ android-clang-arm64-v8a 
		conan profile update settings.os.api_level=21 android-clang-arm64-v8a 
		conan profile update settings.compiler.cppstd=17 android-clang-arm64-v8a
		echo "Create new conan profile called android-clang-arm64-v8a :"
	fi
	conan profile show android-clang-arm64-v8a
	QMAKEOPTIONS="ANDROID_ABIS=\"armeabi-v8a\" "
	QMAKE_SPEC="android-clang"
	PLATEFORMFOLDER="android/"
	MAKE_PATH=${QMAKE_PATH}  /
fi

BUILDREPORT=""
if [ -f build/${PLATEFORMFOLDER}core/SolARFramework/report.txt ]; then
	rm -f build/${PLATEFORMFOLDER}core/SolARFramework/report.txt
fi


if [ -d build/${PLATEFORMFOLDER}core/SolARFramework/shared ]; then
	rm -rf build/${PLATEFORMFOLDER}core/SolARFramework/shared
fi

mkdir -p build/${PLATEFORMFOLDER}core/SolARFramework/shared/debug
mkdir -p build/${PLATEFORMFOLDER}core/SolARFramework/shared/release

echo "===========> run remaken from ${SOLARROOTFOLDER}/packagedependencies.txt <==========="
remaken install ${ANDROIDREMAKENOPTIONS} ${SOLARFRAMEWORKROOT}/packagedependencies.txt
remaken install ${ANDROIDREMAKENOPTIONS} ${SOLARFRAMEWORKROOT}/packagedependencies.txt -c debug

echo "===========> building SolAR Framework shared <==========="
pushd build/${PLATEFORMFOLDER}core/SolARFramework/shared/debug
echo "${QMAKE_PATH}qmake ../../../../../../${SOLARFRAMEWORKROOT}/SolARFramework.pro -spec ${QMAKE_SPEC} CONFIG+=debug CONFIG+=qml_debug ${QMAKEOPTIONS} && ${MAKE_PATH}make qmake_all"
${QMAKE_PATH}qmake ../../../../../../${SOLARFRAMEWORKROOT}/SolARFramework.pro -spec ${QMAKE_SPEC} CONFIG+=debug CONFIG+=qml_debug ${QMAKEOPTIONS} && ${MAKE_PATH}make qmake_all
make -j${NBPROCESSORS}
if [ $? -eq 0 ]; then 
	BUILDREPORT="${BUILDREPORT}\n$(tput setab 2)success - Framework - Debug$(tput sgr 0)"
else
	BUILDREPORT="${BUILDREPORT}\n$(tput setab 1)failed - Framework - Debug$(tput sgr 0)"
fi  
popd
pushd build/${PLATEFORMFOLDER}core/SolARFramework/shared/release
echo "${QMAKE_PATH}qmake ../../../../../../${SOLARFRAMEWORKROOT}/SolARFramework.pro -spec ${QMAKE_SPEC} CONFIG+=qml_debug ${QMAKEOPTIONS} && ${MAKE_PATH}make qmake_all"
${QMAKE_PATH}qmake ../../../../../../${SOLARFRAMEWORKROOT}/SolARFramework.pro -spec ${QMAKE_SPEC} CONFIG+=qml_debug ${QMAKEOPTIONS} && ${MAKE_PATH}make qmake_all
make -j${NBPROCESSORS}
if [ $? -eq 0 ]; then 
	BUILDREPORT="${BUILDREPORT}\n$(tput setab 2)success - Framework - Release$(tput sgr 0)"
else
	BUILDREPORT="${BUILDREPORT}\n$(tput setab 1)failed - Framework - Release$(tput sgr 0)"
fi
popd

echo -e ${BUILDREPORT}
echo -e ${BUILDREPORT} >> build/${PLATEFORMFOLDER}core/SolARFramework/report.txt
