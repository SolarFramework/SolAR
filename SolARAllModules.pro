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
    SolARModuleCeres \
    SolARModuleFBOW \
    SolARModuleG2O \
    SolARModuleNonFreeOpenCV \
    SolARModuleOpenCV \
    SolARModuleOpenGL \
    SolARModuleOpenGV \
    SolARModuleTools

win32 {
    SUBDIRS += \
        SolARModulePCL \
        SolARModuleRealSense
}

# where to find the sub projects - give the folders
    SolARModuleCeres.subdir = modules/SolARModuleCeres
    SolARModuleFBOW.subdir = modules/SolARModuleFBOW
    SolARModuleG2O.subdir = modules/SolARModuleG2O
    SolARModuleNonFreeOpenCV.subdir = modules/SolARModuleNonFreeOpenCV
    SolARModuleOpenCV.subdir = modules/SolARModuleOpenCV
    SolARModuleOpenGL.subdir = modules/SolARModuleOpenGL
    SolARModuleOpenGV.subdir = modules/SolARModuleOpenGV
    SolARModuleTools.subdir = modules/SolARModuleTools
    SolARModulePCL.subdir = modules/SolARModulePCL

win32 {

    SolARModuleRealSense.subdir = modules/SolARModuleRealSense
}



  # what subproject depends on others
  SolARModuleNonFreeOpenCV.depends = SolARModuleOpenCV

# Add install_deps target that recursively calls install_deps
# on submodules
install_deps.CONFIG += recursive
install_deps.recurse_target = install_deps
QMAKE_EXTRA_TARGETS += install_deps




