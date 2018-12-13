#!/bin/bash

DARKGRAY='\033[1;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

printf "\n\n * * * NGINX * * * \n"
printf "JENKINS HOST(default = ${YELLOW}localhost${NC}): "
read host
if [ -z $host ]; then
    host='localhost'
fi
sed -i "s/localhost/$host/g" ./nginx/default.conf

sudo docker-compose down
sudo rm -rf jenkins/home/*
sudo cp -R jenkins/backup/* jenkins/home/
sudo docker-compose up -d
sudo docker exec -it jenkins /bin/bash ./entrypoint.sh
sudo docker restart jenkins
