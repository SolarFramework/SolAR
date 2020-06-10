#!/bin/bash


if [ $# -lt 1 ]; then
  echo "Usage:"
  echo "$0 [path to versions.txt file]"
  exit -1
fi

VERSIONSFILE=$1		# input file : versions.txt
WITHWARNING=0		# 1 to print warnings
DONOTHING=0			# 1 to display current versions only

SOURCEDIR=`pwd`
echo "SOURCEDIR: $SOURCEDIR"
export PATH=$SOURCEDIR/build-scripts/:$PATH


# read required versions and store them in associative array
declare -A ARRAYVER

while read line; do
	if [[ $line == *\|*.*.* ]]; then
        componentName=`echo $line | cut -d "|" -f1`
		componentVersion=`echo $line | cut -d "|" -f2`
		ARRAYVER[$componentName]=$componentVersion
		#echo ">>>>> ARRAYVER[$componentName]=$componentVersion"
		echo "$componentName will be set to version $componentVersion"
    fi	
done < $VERSIONSFILE



# update all sources repositories
# update function
function updateVersion()
{
	repo_fullname=`git rev-parse --show-toplevel`
	repo_name=`basename $repo_fullname`

	# find directories containing a CMakeLists.txt file
	directories=`find . -name "*.pro" -printf '%h\n'`
	processedDir=`pwd`
	for directory in $directories
	do
		#echo "##### PROCESSING $directory"
		cd $directory
		current=`pwd`
		# get current version
		for file in *.pro ; do
			target=`grep "^TARGET" $file | cut -d '=' -f2 | tr -d ' '`
			version=`grep "^VERSION" $file | cut -d '=' -f2 | tr -d ' '`

			if [[ $version == "" ]]; then
				if [[ $WITHWARNING == "1" ]]; then
					echo "(WARN) $file does not contain version number in $file"
				fi
			else
				echo ""
				echo "$target is in version $version"

				# CHANGE VERSION NUMBER HERE - interactive mode if versions.txt does not contain version number for component
				if [[ $DONOTHING == "0" ]]; then


					if [[ ${ARRAYVER[$target]} == "" ]]; then
						echo "enter new version:"
						read newversion
						ARRAYVER[$target]=$newversion
					else
						newversion=${ARRAYVER[$target]}		
						echo ">>>> Changing $target version number to $newversion"
					fi

					# change in .pc.in if exists
					for pcin in ./*.pc.in; do
						[ -e "$pcin" ] && sed -i -e "s/Version: [0-]\.[0-9]\.[0-9]/Version: $newversion/g" $pcin
					done
					
					# change in .pro
					sed -i -e "s/VERSION\s\?=\s\?[0-9]\.[0-9]\.[0-9]/VERSION=$newversion/g" *.pro > /dev/null

					# change in all .xml
					xmlfiles=`find $SOURCEDIR -name "*.xml"`
					for xmlfile in $xmlfiles
					do
						sed -i -e "s/$target\/[0-9]\.[0-9]\.[0-9]/$target\/$newversion/g" $xmlfile
					done

					# change packagedependencies.txt in other repositories
					packagedepfiles=`find $SOURCEDIR -name "packagedependencies*.txt"`
					for packagedepfile in $packagedepfiles
					do
						sed -i -e "s/$target|[0-9]\.[0-9]\.[0-9]/$target|$newversion/g" $packagedepfile
					done
					
					# change in _build.bat and _build.sh for SolARWrapper
					if [[ $target == "SolARWrapper" ]]; then
						batfiles=`find $SOURCEDIR -name "_build.*"`
						for batfile in $batfiles
						do
							sed -i -e "s/SOLAR_WRAPPER_VERSION\s\?=\s\?[0-9]\.[0-9]\.[0-9]/SOLAR_WRAPPER_VERSION=${ARRAYVER["SolARWrapper"]}/g" $batfile
							sed -i -e "s/SOLAR_VERSION\s\?=\s\?[0-9]\.[0-9]\.[0-9]/SOLAR_VERSION=${ARRAYVER["SolARFramework"]}/g" $batfile
							sed -i -e "s/XPCF_VERSION\s\?=\s\?[0-9]\.[0-9]\.[0-9]/XPCF_VERSION=${ARRAYVER["xpcf"]}/g" $batfile
						done
					fi
					
					# change in _build.bat and _build.sh for SolARPipelineManager
					if [[ $target == "SolARPipelineManager" ]]; then
						batfiles=`find $SOURCEDIR -name "BuildCSharp.*"`
						for batfile in $batfiles
						do
							sed -i -e "s/SOLAR_VERSION\s\?=\s\?[0-9]\.[0-9]\.[0-9]/SOLAR_VERSION=${ARRAYVER["SolARFramework"]}/g" $batfile
							sed -i -e "s/XPCF_VERSION\s\?=\s\?[0-9]\.[0-9]\.[0-9]/XPCF_VERSION=${ARRAYVER["xpcf"]}/g" $batfile
						done
					fi
				fi		
				# 
				####

			fi
		done
		# fi
		cd $processedDir
	done
}

# SolARFramework
echo "------------ Process Framework"
cd core/SolARFramework
updateVersion
cd $SOURCEDIR

# SolARPipelineManager
echo "------------ Process Pipeline Manager"
cd core/SolARPipelineManager
updateVersion
cd $SOURCEDIR


# Modules
echo "------------ Process Modules"
cd modules
MODULEDIR=`pwd`
for module in ./SolAR* #$modules
do
	cd $module
	if [ -f .git ] || [ -d *.git ]; then
		updateVersion
		echo ""
	fi
	cd $MODULEDIR	
done
cd $SOURCEDIR

# Samples
echo "----------- Process samples"
samples=`find samples/ -mindepth 1 -maxdepth 1 -type d`
cd samples
SAMPLEDIR=`pwd`
for sample in */
do
	cd $sample
	if [ -f .git ] || [ -d *.git ]; then
		updateVersion
		echo ""
	fi
	cd $SAMPLEDIR
done
cd $SOURCEDIR

# ultimate change of all packagedependencies.txt
echo "----------- Process all packagedependencies.txt"
if [[ $DONOTHING == "0" ]]; then

	for comp in "${!ARRAYVER[@]}"
	do
		vers=${ARRAYVER[$comp]}
		packagedepfiles=`find $SOURCEDIR -name "packagedependencies*.txt"`
		for packagedepfile in $packagedepfiles
		do
			sed -i -e "s/$comp|[0-9]\.[0-9]\.[0-9]/$comp|$vers/g" $packagedepfile
			sed -i -e "s/$comp|[0-9]\.[0-9][0-9]\.[0-9]/$comp|$vers/g" $packagedepfile
		done				
	done
fi
cd $SOURCEDIR

# Update of Install.bat for the Unity Plugin
echo "----------- Process unity plugin batch files"
cd plugin
if [[ $DONOTHING == "0" ]]; then
	unityplugin=`find -name "SolARUnityPlugin" -type d ! -path "*.vs*"` 
	cd $unityplugin
	sed -i -e "s/SOLAR_PIPELINE_MANAGER_VERSION\s\?=\s\?[0-9]\.[0-9]\.[0-9]/SOLAR_PIPELINE_MANAGER_VERSION=${ARRAYVER["SolARPipelineManager"]}/g" Install.bat
	sed -i -e "s/SOLAR_WRAPPER_VERSION\s\?=\s\?[0-9]\.[0-9]\.[0-9]/SOLAR_WRAPPER_VERSION=${ARRAYVER["SolARWrapper"]}/g" Install.bat
fi
cd $SOURCEDIR