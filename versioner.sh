#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage:"
  echo "$0 [path to versions.txt file]"
  exit -1
fi

VERSIONSFILE=$1        # input file : versions.txt
WITHWARNING=1        # 1 to print warnings
DONOTHING=0            # 1 to display current versions only
VERBOSE=0            # 1 to enable verbose logs

# $1: message string
function log_verbose()
{
    if [ $VERBOSE -ne 0 ]; then echo "$1"; fi
}

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

# read required versions and store them in associative array
declare -A ARRAYVER
echo "Loading version file"
while read line; do
    if [[ $line == *\|* ]]; then
        componentName=`echo $line | cut -d "|" -f1`
        componentVersion=`echo $line | cut -d "|" -f2`
        ARRAYVER[$componentName]=$componentVersion
        log_verbose "  $componentName: $componentVersion"
    fi
done < $VERSIONSFILE
log_verbose

echo "Updating .pro and .pc.in files"
rm -f version-gen.txt
for qt_project_file in `find . -path "**/deploy" -prune -o -type f -name "*.pro" -print`
do
    target=`grep "^TARGET" $qt_project_file | cut -d '=' -f2 | tr -d ' '`
    version=`grep "^VERSION" $qt_project_file | cut -d '=' -f2 | tr -d ' '`

    if [[ $target == "" ]]; then continue; fi

    log_verbose
    log_verbose "Updating $qt_project_file"

    if [[ $version == "" ]]; then
        if [ $WITHWARNING -eq 1 ]; then
            echo "(WARN) $file does not contain version number in $file"
        fi
    else
        if [[ ${ARRAYVER[$target]} == "" ]]; then
            echo "Enter new version for $target:"
            read newversion
            ARRAYVER[$target]=$newversion
            echo "$target|$newversion" >> version-gen.txt
        else
            newversion=${ARRAYVER[$target]}
        fi

        log_verbose "  $target: $version -> $newversion"

        if [ $DONOTHING -ne 0 ]; then continue; fi

        sed -i -e "s/VERSION\s\?=\s\?[0-9]\+\.[0-9]\+\.[0-9]\+/VERSION=$newversion/g" $qt_project_file > /dev/null

        pushd $(dirname "$qt_project_file")
        # change in .pc.in if exists
        for pcin in `find . -name "*.pc.in"`; do
            log_verbose "  Updating $pcin" && sed -i -e "s/Version: [0-9]\+\.[0-9]\+\.[0-9]\+/Version: $newversion/g" $pcin
        done
        popd
    fi
done

log_verbose
log_verbose "Newly defined versions can be found in 'version-gen.txt' to update version file with missing entries"
log_verbose

if [ $DONOTHING -ne 0 ]; then exit 0; fi

# Cannot deduce version from particular .pro file -> take framework version as it is what we usually do (c.f. samples/Sample-Mapping)
echo "Updating bundleSamples* files"
for bundleSamples in `find . -name "*bundleSamples.*"`
do
    # /!\ .bat have "version", .sh have "Version"
    log_verbose "  Updating $bundleSamples"
    sed -i -e "s/ersion\s\?=\s\?[0-9]\+\.[0-9]\+\.[0-9]\+/ersion=${ARRAYVER["SolARFramework"]}/g" $bundleSamples
done
log_verbose

# Uncomment to have completely updated version file
# echo "Generating updated version file to 'version-gen.txt'"
# rm -f version-gen.txt
# for key in ${!ARRAYVER[@]}; do
#     echo "$key|${ARRAYVER[$key]}" >> version-gen.txt
# done

echo "Updating *.xml files"
for xmlfile in `find . -path **/deploy -prune -o -name "*.xml" -print`
do
    log_verbose "  Updating $xmlfile"
    for key in ${!ARRAYVER[@]}; do
        sed -i -e "s/$key\/[0-9]\+\.[0-9]\+\.[0-9]\+/$key\/${ARRAYVER[$key]}/g" $xmlfile
    done
done
log_verbose

echo "Updating packagedependencies files"
for packagedepfile in `find . -path **/deploy -prune -o -path **/.build-rules -prune -o -name "packagedependencies*.txt" -print`
do
    log_verbose "  Updating $packagedepfile"
    for key in ${!ARRAYVER[@]}; do
        sed -i -e "s/$key|[0-9]\+\.[0-9]\+\.[0-9]\+/$key|${ARRAYVER[$key]}/g" $packagedepfile
    done
done
log_verbose

echo "Updating SolARWrapper *_build* scripts"
for script in `find core/SolARFramework/SolARWrapper -path **/deploy -prune -o -name "_build*" -print`
do
    log_verbose "  Updating $script"
    sed -i -e "s/SOLAR_WRAPPER_VERSION\s\?=\s\?[0-9]\+\.[0-9]\+\.[0-9]\+/SOLAR_WRAPPER_VERSION=${ARRAYVER["SolARWrapper"]}/g" $script
    sed -i -e "s/SOLAR_VERSION\s\?=\s\?[0-9]\+\.[0-9]\+\.[0-9]\+/SOLAR_VERSION=${ARRAYVER["SolARFramework"]}/g" $script
    sed -i -e "s/XPCF_VERSION\s\?=\s\?[0-9]\+\.[0-9]\+\.[0-9]\+/XPCF_VERSION=${ARRAYVER["xpcf"]}/g" $script
done
log_verbose

echo "Updating SolARPipelineManager BuildCSharp* scripts"
for script in `find core/SolARPipelineManager -path **/deploy -prune -o -name "BuildCSharp*" -print`
do
    log_verbose "  Updating $script"
    sed -i -e "s/SOLAR_VERSION\s\?=\s\?[0-9]\+\.[0-9]\+\.[0-9]\+/SOLAR_VERSION=${ARRAYVER["SolARFramework"]}/g" $script
    sed -i -e "s/XPCF_VERSION\s\?=\s\?[0-9]\+\.[0-9]\+\.[0-9]\+/XPCF_VERSION=${ARRAYVER["xpcf"]}/g" $script
done
log_verbose

echo "Updating $plugin/unity/SolARUnityPlugin/Bundle.bat"
sed -i -e "s/SOLAR_PIPELINE_MANAGER_VERSION\s\?=\s\?[0-9]\+\.[0-9]\+\.[0-9]\+/SOLAR_PIPELINE_MANAGER_VERSION=${ARRAYVER["SolARPipelineManager"]}/g" plugin/unity/SolARUnityPlugin/Bundle.bat
sed -i -e "s/SOLAR_WRAPPER_VERSION\s\?=\s\?[0-9]\+\.[0-9]\+\.[0-9]\+/SOLAR_WRAPPER_VERSION=${ARRAYVER["SolARWrapper"]}/g" plugin/unity/SolARUnityPlugin/Bundle.bat

