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
    samples/Sample-FiducialMarker/SolARSample_FiducialMarker_Mono/SolARSample_FiducialMarker_Mono.pro \
    samples/Sample-NaturalImageMarker/SolARSample_NaturalImageMarker_Mono/SolARSample_NaturalImageMarker_Mono.pro \
    samples/Sample-NaturalImageMarker/SolARSample_NaturalImageMarker_Multi/SolARSample_NaturalImageMarker_Multi.pro \
    samples/Sample-Mapping/MapExtension/SolARSample_Mapping_MapExtension_Mono/SolARSample_Mapping_MapExtension_Mono.pro \
    samples/Sample-Mapping/MapFusion/SolARSample_Mapping_FloatingMapFusion_Mono/SolARSample_Mapping_FloatingMapFusion_Mono.pro \
    samples/Sample-Mapping/MapFusion/SolARSample_Mapping_LocalMapFusion_Mono/SolARSample_Mapping_LocalMapFusion_Mono.pro \
    samples/Sample-Mapping/Mapping/SolARSample_Mapping_Mono/SolARSample_Mapping_Mono.pro \
    samples/Sample-Mapping/Mapping/SolARSample_Mapping_Multi/SolARSample_Mapping_Multi.pro \
    samples/Sample-Mapping/MapViz/SolARSample_Mapping_MapVisualizer/SolARSample_Mapping_MapVisualizer.pro \
    samples/Sample-Slam/SolARSample_SLAM_Mono/SolARSample_SLAM_Mono.pro \
    samples/Sample-Slam/SolARSample_SLAM_Multi/SolARSample_SLAM_Multi.pro \
    samples/Sample-Relocalization/SolARSample_Relocalization_Mono/SolARSample_Relocalization_Mono.pro \
    samples/Sample-Relocalization/SolARSample_Relocalization_Multi/SolARSample_Relocalization_Multi.pro \
    samples/Sample-Triangulation/SolARSample_Triangulation_Mono/SolARSample_Triangulation_Mono.pro

win32 {
	SUBDIRS += samples/Sample-DepthCamera/SolARSample_DepthCamera_Mono/SolARSample_DepthCamera_Mono.pro
}

# Add install_deps target that recursively calls install_deps
# on submodules
install_deps.CONFIG += recursive
install_deps.recurse_target = install_deps
QMAKE_EXTRA_TARGETS += install_deps





