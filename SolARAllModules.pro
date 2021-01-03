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
    SolARModulePCL \
    SolARModuleRealSense \
    SolARModuleTools

# where to find the sub projects - give the folders
    SolARFramework.subdir = core/SolARFramework
    SolARPipelineManager.subdir = core/SolARPipelineManager
    SolARModuleCeres.subdir = modules/SolARModuleCeres
    SolARModuleFBOW.subdir = modules/SolARModuleFBOW
    SolARModuleG2O.subdir = modules/SolARModuleG2O
    SolARModuleNonFreeOpenCV.subdir = modules/SolARModuleNonFreeOpenCV
    SolARModuleOpenCV.subdir = modules/SolARModuleOpenCV
    SolARModuleOpenGL.subdir = modules/SolARModuleOpenGL
    SolARModuleOpenGV.subdir = modules/SolARModuleOpenGV
    SolARModulePCL.subdir = modules/SolARModulePCL
    SolARModuleRealSense.subdir = modules/SolARModuleRealSense
    SolARModuleTools.subdir = modules/SolARModuleTools

 
  # what subproject depends on others
  SolARPipelineManager.depends = SolARFramework
  SolARModuleCeres.depends = SolARFramework
  SolARModuleFBOW.depends = SolARFramework
  SolARModuleG2O.depends = SolARFramework
  SolARModuleNonFreeOpenCV.depends = SolARFramework SolARModuleOpenCV
  SolARModuleOpenCV.depends = SolARFramework
  SolARModuleOpenGL.depends = SolARFramework
  SolARModuleOpenGV.depends = SolARFramework
  SolARModulePCL.depends = SolARFramework
  SolARModuleRealSense.depends = SolARFramework
  SolARModuleTools.depends = SolARFramework





