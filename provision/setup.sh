#!/bin/bash

echo "#Update ubuntu"
echo "sudo do-release-upgrade -f DistUpgradeViewNonInteractive"

echo "#Install curl"
sudo apt-get install -y curl 

sudo apt-get install gcc make build-essential -y

echo "#Install nodejs v.0.12"
curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -
sudo apt-get install -y nodejs

sudo npm install -g bower
sudo npm install -g grunt-cli
sudo npm install -g gulp

echo "Install mongodb..."
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen
sudo apt-get update
sudo apt-get install mongodb-org -y
sudo npm install mongoose

echo "sudo apt-get upgrade -y"