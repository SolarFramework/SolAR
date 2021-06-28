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
    samples/Sample-FiducialMarker/SolARPipeline_FiducialMarker/tests/SolARPipelineTest_FiducialMarker/SolARPipelineTest_FiducialMarker.pro \
    samples/Sample-NaturalImageMarker/SolARPipeline_NaturalImageMarker/tests/SolARPipelineTest_NaturalImageMarker/SolARPipelineTest_NaturalImageMarker.pro \
    samples/Sample-Mapping/Mapping/SolARPipeline_Mapping_Mono/tests/SolARPipelineTest_Mapping_Mono/SolARPipelineTest_Mapping_Mono.pro \
    samples/Sample-Mapping/Mapping/SolARPipeline_Mapping_Multi/tests/SolARPipelineTest_Mapping_Multi/SolARPipelineTest_Mapping_Multi.pro \
    samples/Sample-Slam/SolARPipeline_SLAM/tests/SolARPipelineTest_SLAM/SolARPipelineTest_SLAM.pro \
    samples/Sample-Relocalization/SolARPipeline_Relocalization/tests/SolARPipelineTest_Relocalization/SolARPipelineTest_Relocalization.pro \
    samples/Sample-MapUpdate/SolARPipeline_MapUpdate/tests/SolARPipelineTest_MapUpdate/SolARPipelineTest_MapUpdate.pro \
	
# Add install_deps target that recursively calls install_deps
# on submodules
install_deps.CONFIG += recursive
install_deps.recurse_target = install_deps
QMAKE_EXTRA_TARGETS += install_deps

