
# Copyright 2024 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-lint-cmake, ament-cmake-xmllint, ament-lint-auto, camera-calibration, depth-image-proc, image-proc, image-publisher, image-rotate, image-view, stereo-image-proc }:
buildRosPackage {
  pname = "ros-humble-image-pipeline";
  version = "3.0.3-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/image_pipeline-release/archive/release/humble/image_pipeline/3.0.3-1.tar.gz";
    name = "3.0.3-1.tar.gz";
    sha256 = "9a2d6edef5a33f647b14925ee119abdb274880dd75ac5a13336597861b9badb6";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ];
  checkInputs = [ ament-cmake-lint-cmake ament-cmake-xmllint ament-lint-auto ];
  propagatedBuildInputs = [ camera-calibration depth-image-proc image-proc image-publisher image-rotate image-view stereo-image-proc ];
  nativeBuildInputs = [ ament-cmake ];

  meta = {
    description = ''image_pipeline fills the gap between getting raw images from a camera driver and higher-level vision processing.'';
    license = with lib.licenses; [ bsdOriginal ];
  };
}
