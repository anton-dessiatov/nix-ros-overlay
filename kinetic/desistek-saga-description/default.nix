
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, gazebo-ros, uuv-gazebo-ros-plugins, uuv-sensor-ros-plugins, uuv-assistants, xacro, uuv-descriptions, catkin, rostest, robot-state-publisher, rosunit }:
buildRosPackage {
  pname = "ros-kinetic-desistek-saga-description";
  version = "0.3.2";

  src = fetchurl {
    url = https://github.com/uuvsimulator/desistek_saga-release/archive/release/kinetic/desistek_saga_description/0.3.2-0.tar.gz;
    sha256 = "48887175109459a43f0c85ff4f74dc43cfc2824f8ef6ddf9f396458360453805";
  };

  checkInputs = [ rostest xacro rosunit ];
  propagatedBuildInputs = [ gazebo-ros uuv-assistants uuv-gazebo-ros-plugins uuv-sensor-ros-plugins robot-state-publisher uuv-descriptions ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''The robot description files for the Desistek SAGA ROV underwater vehicle'';
    #license = lib.licenses.Apache-2.0;
  };
}