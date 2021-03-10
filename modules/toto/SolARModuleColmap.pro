QT       -= core gui
CONFIG -= app_bundle qt

TARGET = SolARModuleColmap
FRAMEWORK = $${TARGET}
VERSION=0.9.5
DEFINES +=  $${TARGET}VERSION=\"$${VERSION}\"

CONFIG += c++1z

include(findremakenrules.pri)

CONFIG += shared

DEPENDENCIESCONFIG = sharedlib
DEPENDENCIESCONFIG += install_recurse

## Configuration for Visual Studio to install binaries and dependencies. Work also for QT Creator by replacing QMAKE_INSTALL
PROJECTCONFIG = QTVS

#NOTE : CONFIG as staticlib or sharedlib, DEPENDENCIESCONFIG as staticlib or sharedlib and PROJECTDEPLOYDIR MUST BE DEFINED BEFORE templatelibbundle.pri inclusion
include ($${QMAKE_REMAKEN_RULES_ROOT}/templatelibconfig.pri)


DEFINES += BOOST_ALL_NO_LIB
DEFINES += BOOST_ALL_DYN_LINK

SOURCES +=     SolARModuleColmap_main.cpp \
    StructureFromMotion.cpp

HEADERS +=     SolARModuleColmapAPI.h \
    StructureFromMotion.h
unix {
}

macx {
    DEFINES += _MACOS_TARGET_
    QMAKE_MAC_SDK= macosx
    QMAKE_CFLAGS += -mmacosx-version-min=10.7 #-x objective-c++
    QMAKE_CXXFLAGS += -mmacosx-version-min=10.7 -std=c++17 -fPIC#-x objective-c++
    QMAKE_LFLAGS += -mmacosx-version-min=10.7 -v -lstdc++
    LIBS += -lstdc++ -lc -lpthread
}

win32 {
    DEFINES += _X86_VC12_TARGET_
    DEFINES += MBCS _MBCS
 }

INCLUDEPATH += $${PWD}

header_files.path = $${PROJECTDEPLOYDIR}/interfaces/
header_files.files = $$files($${PWD}/I*.h)

INSTALLS += header_files
DISTFILES +=     Makefile

OTHER_FILES += \
    packagedependencies.txt \
    packagedependencies-win.txt

#NOTE : Must be placed at the end of the .pro
include ($${REMAKEN_RULES_ROOT}/remaken_install_target.pri)
