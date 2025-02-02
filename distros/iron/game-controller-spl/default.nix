
# Copyright 2024 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-copyright, ament-flake8, ament-pep257, game-controller-spl-interfaces, python3Packages, pythonPackages, rclpy }:
buildRosPackage {
  pname = "ros-iron-game-controller-spl";
  version = "3.1.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/gc_spl-release/archive/release/iron/game_controller_spl/3.1.0-1.tar.gz";
    name = "3.1.0-1.tar.gz";
    sha256 = "d7d20b1557e47f576eef994dcd4a37a38d52b7b21526d87c8672e31e59b6c9c8";
  };

  buildType = "ament_python";
  checkInputs = [ ament-copyright ament-flake8 ament-pep257 pythonPackages.pytest ];
  propagatedBuildInputs = [ game-controller-spl-interfaces python3Packages.construct rclpy ];

  meta = {
    description = ''GameController-Robot communication in RoboCup SPL'';
    license = with lib.licenses; [ asl20 ];
  };
}
