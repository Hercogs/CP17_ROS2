# CP17_ROS2

0. Start docker: (skip, if already is running from Task1)
    - execute: `. ~/ros2_ws/src/ros2_ci/docker.bash`

1. Start Jenkins: (skip, if already is running from Task1)
    - execute: `. ~/webpage_ws/start_jenkins.sh`
    - In `~/jenkins__pid__url.txt` copy Jenkins URL and open in browser
    - log in using username `admin` and password `admin`

2. Modify `ros2_ci` repo:
    - execute `. ~/ros2_ws/src/ros2_ci/push_changes.bash` command
    - when asked for git credentials, copy them from "~/catkin_ws/src/git.txt"
    - Wait up to 1 minutes

3. Monitor Jenkins:
    - In Jenkin open task **CP17_ROS2** and verify results.
