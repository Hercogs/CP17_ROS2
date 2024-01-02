#! /bin/bash

cd /home/user/ros2_ws/src/ros2_ci

echo "Test" >> /home/user/ros2_ws/src/ros2_ci/push_changes.txt

git add .
git commit -m "test: $((1 + $RANDOM % 10))"
git push origin main