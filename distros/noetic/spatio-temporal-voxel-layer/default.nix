
# Copyright 2021 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, catkin, costmap-2d, dynamic-reconfigure, geometry-msgs, laser-geometry, message-filters, message-generation, openexr, openvdb, pcl-conversions, pcl-ros, pluginlib, roscpp, sensor-msgs, std-msgs, tbb, tf2-geometry-msgs, tf2-ros, visualization-msgs }:
buildRosPackage {
  pname = "ros-noetic-spatio-temporal-voxel-layer";
  version = "1.4.5-r1";

  src = fetchurl {
    url = "https://github.com/SteveMacenski/spatio_temporal_voxel_layer-release/archive/release/noetic/spatio_temporal_voxel_layer/1.4.5-1.tar.gz";
    name = "1.4.5-1.tar.gz";
    sha256 = "5f3f5d2b3ccc4907ad9166531fc8a6acbe53ee3396b0cb3c1738ba13273091c5";
  };

  buildType = "catkin";
  buildInputs = [ message-generation ];
  propagatedBuildInputs = [ costmap-2d dynamic-reconfigure geometry-msgs laser-geometry message-filters openexr openvdb pcl-conversions pcl-ros pluginlib roscpp sensor-msgs std-msgs tbb tf2-geometry-msgs tf2-ros visualization-msgs ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''The spatio-temporal 3D obstacle costmap package'';
    license = with lib.licenses; [ lgpl21 ];
  };
}