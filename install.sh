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

sudo rm -rf ./nginx/persistence/
sudo chmod -R 777 ./nginx
mkdir -p ./nginx/persistence/
cp -R ./nginx/config/* ./nginx/persistence/
sed -i "s/localhost/$jenkins/g" ./nginx/persistence/sites-enabled/jenkins.conf

sudo rm -rf ./jenkins/persistence
sudo chmod -R 777 ./jenkins
mkdir -p ./jenkins/persistence/plugins
cp -R jenkins/backup/* jenkins/persistence/
#É DE EXTREMA IMPORTANCIA O DOWNLOAD DOS PLUGINS ANTES DE INICIAR O CONTAINER
./jenkins/install-plugins.sh $(echo $(cat ./jenkins/plugins.txt))
docker-compose up -d
