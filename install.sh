#!/bin/bash
sudo cp -R jenkins/backup/ jenkins/home/
sudo docker-compose up -d
sudo docker exec -it jenkins ./install_jenkins_plugins.sh $(echo $(cat plugins.txt))
