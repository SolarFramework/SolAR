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
    samples/Sample-FiducialMarker/SolARPipeline_FiducialMarker/SolARPipeline_FiducialMarker.pro \
    samples/Sample-NaturalImageMarker/SolARPipeline_NaturalImageMarker/SolARPipeline_NaturalImageMarker.pro \
    samples/Sample-Mapping/Mapping/SolARPipeline_Mapping_Multi/SolARPipeline_Mapping_Multi.pro \
    samples/Sample-Slam/SolARPipeline_SLAM/SolARPipeline_SLAM.pro \
    samples/Sample-Relocalization/SolARPipeline_Relocalization/SolARPipeline_Relocalization.pro \
    samples/Sample-Relocalization/SolARPipeline_RelocalizationMarker/SolARPipeline_RelocalizationMarker.pro \
    samples/Sample-Relocalization/SolARPipeline_MappingAndRelocalizationFrontend/SolARPipeline_MappingAndRelocalizationFrontend.pro \
    samples/Sample-MapUpdate/SolARPipeline_MapUpdate/SolARPipeline_MapUpdate.pro \


