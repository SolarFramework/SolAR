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
    core/SolARFramework/SolARFramework.pro \
    core/SolARPipelineManager/SolARPipelineManager.pro \
    modules/SolARModuleCeres/SolARModuleCeres.pro \
    modules/SolARModuleFBOW/SolARModuleFBOW.pro \
    modules/SolARModuleG2O/SolARModuleG2O.pro \
    modules/SolARModuleNonFreeOpenCV/SolARModuleNonFreeOpenCV.pro \
    modules/SolARModuleOpenCV/SolARModuleOpenCV.pro \
    modules/SolARModuleOpenGL/SolARModuleOpenGL.pro \
    modules/SolARModuleOpenGV/SolARModuleOpenGV.pro \
    modules/SolARModulePCL/SolARModulePCL.pro \
    modules/SolARModuleRealSense/SolARModuleRealSense.pro \
    modules/SolARModuleTools/SolARModuleTools.pro \







