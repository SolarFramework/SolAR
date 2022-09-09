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
CONFIG += ordered

TEMPLATE = subdirs
 
SUBDIRS = \
    services/Service-Mapping/SolARService_Mapping_Multi/tests/SolARServiceTest_Mapping_Multi_Producer/SolARServiceTest_Mapping_Multi_Producer.pro \
    services/Service-Mapping/SolARService_Mapping_Multi/tests/SolARServiceTest_Mapping_Multi_Viewer/SolARServiceTest_Mapping_Multi_Viewer.pro \
    services/Service-Mapping/SolARService_Mapping_Multi/tests/SolARServiceTest_Mapping_Multi_Relocalization/SolARServiceTest_Mapping_Multi_Relocalization.pro \
    services/Service-MapUpdate/SolARService_MapUpdate/tests/SolARServiceTest_MapUpdate/SolARServiceTest_MapUpdate.pro \
    services/Service-MapUpdate/SolARService_MapUpdate/tests/SolARServiceTest_MapUpdate_DisplayMap/SolARServiceTest_MapUpdate_DisplayMap.pro \
    services/Service-Relocalization/SolARService_Relocalization/tests/SolARServiceTest_Relocalization/SolARServiceTest_Relocalization.pro \
    services/Service-Relocalization/SolARService_RelocalizationMarkers/tests/SolARServiceTest_RelocalizationMarkers/SolARServiceTest_RelocalizationMarkers.pro \
    services/Service-Relocalization/SolARService_MappingAndRelocalizationFrontend/tests/SolARServiceTest_MappingAndRelocalizationFrontend/SolARServiceTest_MappingAndRelocalizationFrontend.pro \
    services/Service-Relocalization/SolARService_MappingAndRelocalizationFrontend/tests/SolARServiceTest_MappingAndRelocalizationFrontend_RelocViewer/SolARServiceTest_MappingAndRelocalizationFrontend_RelocViewer.pro \

# Add install_deps target that recursively calls install_deps
# on submodules
#install_deps.CONFIG += recursive
#install_deps.recurse_target = install_deps
#QMAKE_EXTRA_TARGETS += install_deps

