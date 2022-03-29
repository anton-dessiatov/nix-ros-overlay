
# Copyright 2022 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, catkin, cob-msgs, cob-srvs, diagnostic-msgs, diagnostic-updater, python3Packages, roscpp, rospy, socketcan-interface, std-msgs }:
buildRosPackage {
  pname = "ros-noetic-cob-bms-driver";
  version = "0.7.12-r1";

  src = fetchurl {
    url = "https://github.com/ipa320/cob_driver-release/archive/release/noetic/cob_bms_driver/0.7.12-1.tar.gz";
    name = "0.7.12-1.tar.gz";
    sha256 = "3a320f76d580a236ce06577a1df7b20ef79fa0f19b1c0911119aa8efd6dc691e";
  };

  buildType = "catkin";
  propagatedBuildInputs = [ cob-msgs cob-srvs diagnostic-msgs diagnostic-updater python3Packages.numpy roscpp rospy socketcan-interface std-msgs ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''Driver package for interfacing the battery management system (BMS) on Care-O-bot.'';
    license = with lib.licenses; [ asl20 ];
  };
}
