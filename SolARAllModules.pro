##
## @copyright Copyright (c) 2020 B-com http://www.b-com.com/
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##

CONFIG -= flat

TEMPLATE = subdirs

SUBDIRS = \
    modules/SolARModuleCeres \
    modules/SolARModuleFBOW \
    modules/SolARModuleG2O \
    modules/SolARModuleNonFreeOpenCV \
    modules/SolARModuleOpenCV \
    modules/SolARModuleTools

win32 {
    SUBDIRS += \
        modules/SolARModulePCL \
        modules/SolARModuleRealSense \
        modules/SolARModuleOpenGV \
        modules/SolARModuleOpenGL
    }

unix:!android {
    SUBDIRS += \
        modules/SolARModuleOpenGV \
        modules/SolARModuleOpenGL
    }


# Add install_deps target that recursively calls install_deps
# on submodules
install_deps.CONFIG += recursive
install_deps.recurse_target = install_deps
QMAKE_EXTRA_TARGETS += install_deps




