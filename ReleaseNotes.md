# Release Notes

## v1.0.0
* Dependencies:
  * Update XPCF to 2.6.2

## v0.11.0 (2022/11/15)

* Support of QR Code for relocalization
* Support of PNG and JPEG decoding
* New Front End service (for cloud deployment)
* New Relocalization Markers pipeline and service
* Optimization of Map Update, Mapping and Relocalization pipelines
* CUDA versions of Map Update, Mapping and Relocalization services
* Bug fixes, optimizations
* Dependencies
  * Update XPCF to 2.5.3
  * Update OpenCV to 4.5.5
  * Update spdlog to 1.9.2
  * Introduce OpenImageIO 2.3.13.0
  * Remove flann 1.9.1

## v0.10.0 (2021/12/30)

* Stereo camera components (e.g. calibration, rectification, depth estimation, reprojection to 3D)
* Map update pipeline
* SLAM and mapping optimizations
* gRPC module: stubs for client and server sides, for all SolAR interfaces, to create remote services
* Map Update, Relocalization and Mapping services (for cloud deployment) and client test applications
* Add module PopSift for CUDA optimized SIFT feature detection and extraction.

## v0.9.1 (2021/08/30)

* Bug fix and optimizations

## v0.9.0 (2021/01/07)

* Map overlap detection and merging
* Move to XPCF 2.5.0 to use remoting feature for creating communication layer of cloud services

## v0.8.0 (2020/10/05)

* Android is now supported
* The SLAM pipeline integrates a global bundle adjustment and a loop closure
* The map can be saved and reloaded for persistent AR experiences
* Storage components are now available to share data between processing components (point clouds, keyframes, covisibility, etc.)
* Component injection to create high-level component implementations (e.g. SLAM bootstraper, tracking, and mapping) with the low-level components of your choice (e.g. keypoint detector, descriptor, matcher, or PnP)
* Binded or injected components are now configurable with specific properties (XPCF 2.4.0)
* Use of conan-center-index remote and of a new solar conan remote for installing third parties

## v0.7.0 (2020/02/07)

* A SLAM pipeline is now available on SolAR Framework
New build pipeline, based on qmake


## Contact 
Website https://solarframework.github.io/

Contact framework.solar@b-com.com
