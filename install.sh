#!/bin/bash
sudo docker-compose down
sudo rm -rf jenkins/home/*
sudo cp -R jenkins/backup/* jenkins/home/
sudo docker-compose up -d
sudo docker exec -it jenkins /bin/bash ./entrypoint.sh
sudo docker restart jenkins
