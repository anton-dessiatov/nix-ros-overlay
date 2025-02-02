
# Copyright 2024 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-cmake-xmllint, ament-lint-auto, ament-lint-common, cmake, ros-environment }:
buildRosPackage {
  pname = "ros-humble-mola-test-datasets";
  version = "0.3.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/mola_test_datasets-release/archive/release/humble/mola_test_datasets/0.3.0-1.tar.gz";
    name = "0.3.0-1.tar.gz";
    sha256 = "19e8c3330ea5a8d9d810332afeb8f5db23aaa4a4f1ca42fcde697ba54b7776ac";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-cmake-gtest ament-cmake-xmllint cmake ros-environment ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ament-cmake-gtest cmake ];

  meta = {
    description = ''Small SLAM dataset extracts used for demos or unit tests in the rest of MOLA packages'';
    license = with lib.licenses; [ bsdOriginal bsdOriginal "CC-BY-NC-SA-3.0" "CC-BY-3.0" "CC-BY-3.0" ];
  };
}
