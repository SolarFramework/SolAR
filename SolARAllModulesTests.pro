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
    modules/SolARModuleFBOW/tests/SolARTest_ModuleFBOW_ClosestKeyframeRetrieval/SolARTest_ModuleFBOW_ClosestKeyframeRetrieval.pro \
    modules/SolARModuleFBOW/tests/SolARTest_ModuleFBOW_FeatureMatching/SolARTest_ModuleFBOW_FeatureMatching.pro \
    modules/SolARModuleG2O/tests/SolARTest_ModuleG2O_Bundler/SolARTest_ModuleG2O_Bundler.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_CameraCalibration/SolARTest_ModuleOpenCV_CameraCalibration.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_GenericSemanticSegmentation/SolARTest_ModuleOpenCV_GenericSemanticSegmentation.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_DescriptorMatcher/SolARTest_ModuleOpenCV_DescriptorMatcher.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_DeviceDataLoader/SolARTest_ModuleOpenCV_DeviceDataLoader.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_DeviceDualMarkerCalibration/SolARTest_ModuleOpenCV_DeviceDualMarkerCalibration.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_DevicePoseCorrection/SolARTest_ModuleOpenCV_DevicePoseCorrection.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_FCNSegmentation/SolARTest_ModuleOpenCV_FCNSegmentation.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_FeatureMatchingStabilization/SolARTest_ModuleOpenCV_FeatureMatchingStabilization.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_FiducialMarker/SolARTest_ModuleOpenCV_FiducialMarker.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_FundamentalMatrixDecomposer/SolARTest_ModuleOpenCV_FundamentalMatrixDecomposer.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_FundamentalMatrixEstimation/SolARTest_ModuleOpenCV_FundamentalMatrixEstimation.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_ImageConvertor/SolARTest_ModuleOpenCV_ImageConvertor.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_ImageCompression/SolARTest_ModuleOpenCV_ImageCompression.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_ImageFilter/SolARTest_ModuleOpenCV_ImageFilter.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_ImageLoader/SolARTest_ModuleOpenCV_ImageLoader.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_MatchesFilter/SolARTest_ModuleOpenCV_MatchesFilter.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_MultiQRCodesPoseEstimation/SolARTest_ModuleOpenCV_MultiQRCodesPoseEstimation.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_OpticalFlow/SolARTest_ModuleOpenCV_OpticalFlow.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_QRCodePoseEstimation/SolARTest_ModuleOpenCV_QRCodePoseEstimation.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_QRCodesDetection/SolARTest_ModuleOpenCV_QRCodesDetection.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_YolactSegmentation/SolARTest_ModuleOpenCV_YolactSegmentation.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_PnP/SolARTest_ModuleOpenCV_PnP.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_StereoCameraCalibration/SolARTest_ModuleOpenCV_StereoCameraCalibration.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_StereoFeatureMatching/SolARTest_ModuleOpenCV_StereoFeatureMatching.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_StereoImageRectification/SolARTest_ModuleOpenCV_StereoImageRectification.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_StereoKeypointRectification/SolARTest_ModuleOpenCV_StereoKeypointRectification.pro \
    modules/SolARModuleOpenGL/tests/SolARTest_ModuleOpenGL_PointsCloudDisplay/SolARTest_ModuleOpenGL_PointsCloudDisplay.pro \
    modules/SolARModulePopSift/tests/SolARTest_ModulePopSift_DescriptorMatcher/SolARTest_ModulePopSift_DescriptorMatcher.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_3DTransformEstimationSACFrom3D3D/SolARTest_ModuleTools_3DTransformEstimationSACFrom3D3D.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_BoostCovisibilityGraph/SolARTest_ModuleTools_BoostCovisibilityGraph.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_CameraParametersManager/SolARTest_ModuleTools_CameraParametersManager.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_CovisibilityGraph/SolARTest_ModuleTools_CovisibilityGraph.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_DualMapperSingleton/SolARTest_ModuleTools_DualMapperSingleton.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_ExtractSubmap/SolARTest_ModuleTools_ExtractSubmap.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_FiducialMarkersDetection/SolARTest_ModuleTools_FiducialMarkersDetection.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_LoopClosureDetection/SolARTest_ModuleTools_LoopClosureDetection.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_LoopCorrection/SolARTest_ModuleTools_LoopCorrection.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_MultiFiducialMarkersPoseEstimator/SolARTest_ModuleTools_MultiFiducialMarkersPoseEstimator.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_PointCloudManager/SolARTest_ModuleTools_PointCloudManager.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_StereoDepthEstimation/SolARTest_ModuleTools_StereoDepthEstimation.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_WorldGraphLoader/SolARTest_ModuleTools_WorldGraphLoader.pro \
    modules/SolARModuleHapPLY/tests/SolARTest_ModuleHapPLY_PointCloudFileToPly/SolARTest_ModuleHapPLY_PointCloudFileToPly.pro \
    modules/SolARModuleHapPLY/tests/SolARTest_ModuleHapPLY_MeshIO/SolARTest_ModuleHapPLY_MeshIO.pro \















