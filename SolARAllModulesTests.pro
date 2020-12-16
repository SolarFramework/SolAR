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
    modules/SolARModuleCeres/tests/Bundler/SolARTestModuleCeresBundler.pro \
    modules/SolARModuleCeres/tests/SolARTestCeresGlobalBundleAdjustment/SolARTestCeresGlobalBundleAdjustment.pro \
    modules/SolARModuleFBOW/tests/ClosestKeyframeRetrieval/SolARTestModuleFBOWClosestKeyframeRetrieval.pro \
    modules/SolARModuleFBOW/tests/SolARFeatureMatchingUsingFBOW/SolARFeatureMatchingUsingFBOW.pro \
    modules/SolARModuleG2O/tests/SolARTestModuleG2OBundler/SolARTestModuleG2OBundler.pro \
    modules/SolARModuleG2O/tests/SolARTestModuleG2OGlobalBundleAdjustment/SolARTestModuleG2OGlobalBundleAdjustment.pro \
    modules/SolARModuleNonFreeOpenCV/tests/SolARDescriptorExtractor/SolARDescriptorExtractorOpenCVNonFreeTest.pro \
    modules/SolARModuleOpenCV/tests/SolARCameraCalibration/SolARCameraCalibration.pro \
    modules/SolARModuleOpenCV/tests/SolARDescriptorMatcher/SolARDescriptorMatcherOpenCVTest.pro \
    modules/SolARModuleOpenCV/tests/SolARDeviceDataLoader/SolARDeviceDataLoaderTest.pro \
    modules/SolARModuleOpenCV/tests/SolARDeviceDualMarkerCalibration/SolARDeviceDualMarkerCalibrationTest.pro \
    modules/SolARModuleOpenCV/tests/SolARDevicePoseCorrection/SolARDevicePoseCorrectionTest.pro \
    modules/SolARModuleOpenCV/tests/SolARFiducialMarker/SolARMarker2DFiducialOpenCVTest.pro \
    modules/SolARModuleOpenCV/tests/SolARFundamentalMatrixDecomposer/SolARFundamentalMatrixDecomposerOpenCVTest.pro \
    modules/SolARModuleOpenCV/tests/SolARFundamentalMatrixEstimation/SolARFundamentalMatrixEstimationOpenCVTest.pro \
    modules/SolARModuleOpenCV/tests/SolARImageConvertor/SolARImageConvertorOpenCVTest.pro \
    modules/SolARModuleOpenCV/tests/SolARImageLoader/SolARImageLoaderOpenCVTest.pro \
    modules/SolARModuleOpenCV/tests/SolARMatchesFilter/SolARMatchesFilterTest.pro \
    modules/SolARModuleOpenCV/tests/SolAROpticalFlow/SolAROpticalFlowOpenCVTest.pro \
    modules/SolARModuleOpenGL/tests/PointsCloudDisplay/SolARTestModuleOpenGLPointCloudDisplay.pro \
    modules/SolARModuleOpenGV/tests/SolARTestModuleOpenGVPnP/SolARTestModuleOpenGVPnP.pro \
    modules/SolARModuleOpenGV/tests/SolARTestModuleOpenGVTriangulation/SolARTestModuleOpenGVTriangulation.pro \
    modules/SolARModulePCL/tests/SolARTestPCLPointCloudLoader/SolARTestPCLPointCloudLoader.pro \
    modules/SolARModuleRealSense/tests/SolARTestRealSenseRGBDCamera/SolARTestRealSenseRGBDCamera.pro \















