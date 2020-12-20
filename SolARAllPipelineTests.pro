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
    samples/FiducialMarker/Plugin/tests/TestFiducialMarkerPipeline/TestFiducialMarkerPlugin.pro \
    samples/NaturalImageMarker/Plugin/tests/TestNaturalImageMarkerPipeline/TestNaturalImageMarkerPlugin.pro \
    samples/Sample-Mapping/Mapping/SolARPipeline_Mapping_Mono/tests/SolARPipelineTest_Mapping_Mono.pro \
    samples/Sample-Mapping/Mapping/SolARPipeline_Mapping_Multi/tests/SolARPipelineTest_Mapping_Multi.pro \
    samples/Sample-Slam/Plugin/tests/TestSlamPipeline/TestSlamPlugin.pro \



