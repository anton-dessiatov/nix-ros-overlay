
# Copyright 2024 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-cmake-ros, ament-lint-auto, ament-lint-common, fastcdr, fastrtps, fastrtps-cmake-module, osrf-testing-tools-cpp, rcpputils, rcutils, rmw, rmw-dds-common, rmw-fastrtps-shared-cpp, rosidl-dynamic-typesupport, rosidl-dynamic-typesupport-fastrtps, rosidl-runtime-c, rosidl-runtime-cpp, rosidl-typesupport-fastrtps-c, rosidl-typesupport-fastrtps-cpp, test-msgs, tracetools }:
buildRosPackage {
  pname = "ros-rolling-rmw-fastrtps-cpp";
  version = "8.2.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rmw_fastrtps-release/archive/release/rolling/rmw_fastrtps_cpp/8.2.0-1.tar.gz";
    name = "8.2.0-1.tar.gz";
    sha256 = "1f214487f82ac8faf8a762c2ed745de26c7895cb50cbe1b1d0f9c9b026a7198a";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-ros ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto ament-lint-common osrf-testing-tools-cpp test-msgs ];
  propagatedBuildInputs = [ ament-cmake fastcdr fastrtps fastrtps-cmake-module rcpputils rcutils rmw rmw-dds-common rmw-fastrtps-shared-cpp rosidl-dynamic-typesupport rosidl-dynamic-typesupport-fastrtps rosidl-runtime-c rosidl-runtime-cpp rosidl-typesupport-fastrtps-c rosidl-typesupport-fastrtps-cpp tracetools ];
  nativeBuildInputs = [ ament-cmake ament-cmake-ros fastrtps-cmake-module ];

  meta = {
    description = ''Implement the ROS middleware interface using eProsima FastRTPS static code generation in C++.'';
    license = with lib.licenses; [ asl20 ];
  };
}
