# Release Notes

## v0.10.0

* Camera stereo components (e.g. calibration, rectification, depth estimation, reprojection to 3D)
* Map update pipeline
* SLAM and mapping optimizations

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
