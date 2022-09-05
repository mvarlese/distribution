#!/bin/sh

File='Dockerfile.bci'
Version='1.18'
Port='5001'
Green='\033[1;32m'
GreenBG='\033[42m'
Nc='\033[0m' # No Color

echo ""
echo -e "${Green}Removing any cached image${Nc}"
echo -e "${GreenBG}docker system prune -a${Nc}"
#docker system prune -a -f
echo ""

echo -e "${Green}Building the distribution project..."
echo -e "${GreenBG}DOCKER_BUILDKIT=1 docker build -t distribution-${Version} -f ${File} .${Nc}"
DOCKER_BUILDKIT=1 docker build -t distribution-${Version} -f ${File}.${Version} .
echo ""

echo -e "${Green}Running the registry...${Nc}"
echo -e "${GreenBG}docker run -p ${Port}:5000 distribution-${Version}${Nc}"
docker run -p ${Port}:5000 distribution-${Version}

