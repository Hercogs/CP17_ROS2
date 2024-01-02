#! /bin/bash

sudo apt-get update
sudo apt-get install -y docker.io docker-compose
sudo service docker start

sudo usermod -aG docker $USER
newgrp docker

git config --global user.name "Hercogs"
git config --global user.email "jecuks96@gmail.com"

cd ~/catkin_ws/src/ros1_ci


