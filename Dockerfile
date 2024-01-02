FROM osrf/ros:galactic-desktop

# Tell the container to use the C.UTF-8 locale for its language settings
ENV LANG C.UTF-8

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections


# Install required packages
RUN set -x \
    && apt-get update \
    && apt-get --with-new-pkgs upgrade -y \
    && apt-get install -y git \
    && apt-get install -y ros-galactic-joint-state-publisher ros-galactic-robot-state-publisher ros-galactic-cartographer ros-galactic-cartographer-ros ros-galactic-gazebo-plugins ros-galactic-teleop-twist-keyboard  ros-galactic-teleop-twist-joy ros-galactic-xacro ros-galactic-nav2* ros-galactic-urdf ros-galactic-v4l2-camera \
    && rm -rf /var/lib/apt/lists/*

# Link python3 to python otherwise ROS scripts fail when using the OSRF contianer
# RUN ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /ros2_ws
RUN /bin/bash -c "source /opt/ros/galactic/setup.bash && colcon build"

# Set up the catkin workspace
WORKDIR /
RUN mkdir -p /ros2_ws/src
WORKDIR /ros2_ws/src

# # Clone tortoise packages
RUN git clone -b ros2-galactic --recursive https://github.com/rigbetellabs/tortoisebot.git
RUN git clone https://github.com/Hercogs/CP16_ROS2_interfaces.git
RUN git clone https://github.com/Hercogs/CP16_ROS2.git

# COPY ./ /catkin_ws/src/move_and_turn

# build
WORKDIR /ros2_ws
RUN /bin/bash -c "source /opt/ros/galactic/setup.bash && colcon build --packages-skip tortoisebot_control"

# replace setup.bash in ros_entrypoint.sh
RUN sed -i 's|source "/opt/ros/\$ROS_DISTRO/setup.bash"|source "/ros2_ws/install/setup.bash"|g' /ros_entrypoint.sh

# Cleanup
RUN rm -rf /root/.cache

# Start a bash shell when the container starts
CMD ["bash"]