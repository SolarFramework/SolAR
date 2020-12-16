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
    samples\FiducialMarker\StandAlone\SolARFiducialMarkerSampleStandAlone.pro \
    samples\FiducialMarker\Plugin\PipelineFiducialMarker.pro \
    samples\NaturalImageMarker\Multithread\SolARNaturalImageMarkerMT.pro \
    samples\NaturalImageMarker\Plugin\PipelineNaturalImageMarker.pro \
    samples\NaturalImageMarker\StandAlone\SolARNaturalImageMarkerStandAlone.pro \
    samples\Sample-DepthCamera\StandAlone\SolARDepthCameraSampleStandAlone.pro \
    samples\Sample-Mapping\MapExtension\StandAlone\SolARMapExtensionStandAlone.pro \
    samples\Sample-Mapping\MapFusion\floatingMapFusionStandAlone\SolARfloatingMapFusionStandAlone.pro \
    samples\Sample-Mapping\MapFusion\localMapFusionStandAlone\SolARLocalMapFusionStandAlone.pro \
    samples\Sample-Mapping\Mapping\Multi\SolARMappingMulti.pro \
    samples\Sample-Mapping\Mapping\SolARMappingPipeline\SolARMappingPipeline.pro \
    samples\Sample-Mapping\Mapping\SolARMappingPipelineMulti\SolARMappingPipelineMulti.pro \
    samples\Sample-Mapping\Mapping\StandAlone\SolARMappingStandAlone.pro \
    samples\Sample-Mapping\MapViz\SolARMapViz.pro \
    samples\Sample-Slam\Mono\SolARSlamSampleMono.pro \
    samples\Sample-Slam\Multi\SolARSlamSampleMulti.pro \
    samples\Sample-Slam\Plugin\PipelineSlam.pro \
    samples\Sample-Triangulation\StandAlone\SolARTriangulationSample.pro \







