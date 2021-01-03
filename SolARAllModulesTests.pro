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
    modules/SolARModuleCeres/tests/SolARTest_ModuleCeres_Bundler/SolARTest_ModuleCeres_Bundler.pro \
    modules/SolARModuleFBOW/tests/SolARTest_ModuleFBOW_ClosestKeyframeRetrieval/SolARTest_ModuleFBOW_ClosestKeyframeRetrieval.pro \
    modules/SolARModuleFBOW/tests/SolARTest_ModuleFBOW_FeatureMatching/SolARTest_ModuleFBOW_FeatureMatching.pro \
    modules/SolARModuleG2O/tests/SolARTest_ModuleG2O_Bundler/SolARTest_ModuleG2O_Bundler.pro \
    modules/SolARModuleNonFreeOpenCV/tests/SolARTest_ModuleNonFreeOpenCV_DescriptorExtractor/SolARTest_ModuleNonFreeOpenCV_DescriptorExtractor.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_CameraCalibration/SolARTest_ModuleOpenCV_CameraCalibration.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_DescriptorMatcher/SolARTest_ModuleOpenCV_DescriptorMatcher.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_DeviceDataLoader/SolARTest_ModuleOpenCV_DeviceDataLoader.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_DeviceDualMarkerCalibration/SolARTest_ModuleOpenCV_DeviceDualMarkerCalibration.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_DevicePoseCorrection/SolARTest_ModuleOpenCV_DevicePoseCorrection.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_FiducialMarker/SolARTest_ModuleOpenCV_FiducialMarker.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_FundamentalMatrixDecomposer/SolARTest_ModuleOpenCV_FundamentalMatrixDecomposer.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_FundamentalMatrixEstimation/SolARTest_ModuleOpenCV_FundamentalMatrixEstimation.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_ImageConvertor/SolARTest_ModuleOpenCV_ImageConvertor.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_ImageLoader/SolARTest_ModuleOpenCV_ImageLoader.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_MatchesFilter/SolARTest_ModuleOpenCV_MatchesFilter.pro \
    modules/SolARModuleOpenCV/tests/SolARTest_ModuleOpenCV_OpticalFlow/SolARTest_ModuleOpenCV_OpticalFlow.pro \
    modules/SolARModuleOpenGL/tests/SolARTest_ModuleOpenGL_PointsCloudDisplay/SolARTest_ModuleOpenGL_PointsCloudDisplay.pro \
    modules/SolARModuleOpenGV/tests/SolARTest_ModuleOpenGV_PnP/SolARTest_ModuleOpenGV_PnP.pro \
    modules/SolARModuleOpenGV/tests/SolARTest_ModuleOpenGV_Triangulation/SolARTest_ModuleOpenGV_Triangulation.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_3DTransformEstimationSACFrom3D3D/SolARTest_ModuleTools_3DTransformEstimationSACFrom3D3D.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_BoostCovisibilityGraph/SolARTest_ModuleTools_BoostCovisibilityGraph.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_CovisibilityGraph/SolARTest_ModuleTools_CovisibilityGraph.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_DualMapperSingleton/SolARTest_ModuleTools_DualMapperSingleton.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_LoopClosureDetection/SolARTest_ModuleTools_LoopClosureDetection.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_LoopCorrection/SolARTest_ModuleTools_LoopCorrection.pro \
    modules/SolARModuleTools/tests/SolARTest_ModuleTools_PointCloudManager/SolARTest_ModuleTools_PointCloudManager.pro
	
win32 {
	SUBDIRS += \
		modules/SolARModulePCL/tests/SolARTest_ModulePCL_PointCloudLoader/SolARTest_ModulePCL_PointCloudLoader.pro \
		modules/SolARModuleRealSense/tests/SolARTest_ModuleRealSense_RGBDCamera/SolARTest_ModuleRealSense_RGBDCamera.pro
}















