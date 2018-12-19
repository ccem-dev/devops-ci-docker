#!/bin/bash

DARKGRAY='\033[1;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

printf "\n\n * * * NGINX * * * \n"
printf "JENKINS HOST(default = ${YELLOW}localhost${NC}): "
read jenkins
if [ -z $jenkins ]; then
    jenkins='localhost'
fi

sudo mkdir ./nginx/persistence/
sudo cp -R ./nginx/config/ ./nginx/persistence/
sed -i "s/localhost/$jenkins/g" ./nginx/persistence/sites-enabled/jenkins.conf

sudo mkdir ./jenkins/persistence/
sudo cp -R jenkins/backup/* jenkins/persistence/
sudo docker-compose up -d
sudo docker exec -it jenkins /bin/bash ./entrypoint.sh
