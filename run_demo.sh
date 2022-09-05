#!/bin/sh

Port_Server_1='5000'
Port_Server_2='5001'
Green='\033[1;32m'
GreenBG='\033[42m'
Nc='\033[0m' # No Color

wait_for_key_press() {
        echo "Press any key to continue"
        while [ true ] ; do
        read -t 3 -n 1
        if [ $? = 0 ] ; then
        return ;
        fi
        done
}

echo -e ""
echo -e "${Green}Pulling the SLE BCI busybox image from the SUSE registry${Nc}"
echo -e "${GreenBG}docker pull registry.suse.com/bci/bci-busybox${Nc}"
docker pull registry.suse.com/bci/bci-busybox
echo -e ""

echo -e ""
echo -e "${Green}Pulling the SLE BCI init image from the SUSE registry${Nc}"
echo -e "${GreenBG}docker pull registry.suse.com/bci/bci-init${Nc}"
docker pull registry.suse.com/bci/bci-init
echo -e ""

wait_for_key_press

echo -e "${Green}Retagging the image so that it can be pushed to our local registry${Nc}"
echo -e "${GreenBG}docker image tag registry.suse.com/bci/bci-busybox localhost:${Port_Server_1}/bci/bci-busybox${Nc}"
docker image tag registry.suse.com/bci/bci-busybox localhost:${Port_Server_1}/bci/bci-busybox
echo -e ""

echo -e "${Green}Retagging the image so that it can be pushed to our local registry${Nc}"
echo -e "${GreenBG}docker image tag registry.suse.com/bci/bci-init localhost:${Port_Server_2}/bci/bci-init${Nc}"
docker image tag registry.suse.com/bci/bci-busybox localhost:${Port_Server_2}/bci/bci-init
echo -e ""

wait_for_key_press

echo -e "${Green}Listing all available images to our docker instance${Nc}"
echo -e "${GreenBG}docker images -a${Nc}"
docker images -a
echo ""

wait_for_key_press

echo -e "${Green}Pushing the SLE BCI busybox image to the local registry${Nc}"
echo -e "${GreenBG}docker image push localhost:${Port_Server_1}/bci/bci-busybox${Nc}"
docker image push localhost:${Port_Server_1}/bci/bci-busybox
echo ""

echo -e "${Green}Pushing the SLE BCI init image to the local registry${Nc}"
echo -e "${GreenBG}docker image push localhost:${Port_Server_2}/bci/bci-init${Nc}"
docker image push localhost:${Port_Server_2}/bci/bci-init
echo ""

wait_for_key_press

echo -e "${Green}Removing the SLE BCI busybox image from the local docker cache${Nc}"
echo -e "${GreenBG}docker image rm localhost:${Port_Server_1}/bci/bci-busybox${Nc}"
docker image rm localhost:${Port_Server_1}/bci/bci-busybox
echo -e "${GreenBG}docker image rm registry.suse.com/bci/bci-busybox${Nc}"
docker image rm registry.suse.com/bci/bci-busybox
echo ""

echo -e "${Green}Removing the SLE BCI init image from the local docker cache${Nc}"
echo -e "${GreenBG}docker image rm localhost:${Port_Server_2}/bci/bci-init${Nc}"
docker image rm localhost:${Port_Server_2}/bci/bci-init
echo -e "${GreenBG}docker image rm registry.suse.com/bci/bci-init${Nc}"
docker image rm registry.suse.com/bci/bci-init
echo ""

wait_for_key_press

echo -e "${Green}Listing all available images to our docker instance${Nc}"
echo -e "${GreenBG}docker images -a${Nc}"
docker images -a
echo ""

wait_for_key_press

echo -e "${Green}Pulling the SLE BCI busybox image from our local registry${Nc}"
echo -e "${GreenBG}docker pull localhost:${Port_Server_1}/bci/bci-busybox${Nc}"
docker pull localhost:${Port_Server_1}/bci/bci-busybox
echo ""

echo -e "${Green}Pulling the SLE BCI init image from our local registry${Nc}"
echo -e "${GreenBG}docker pull localhost:${Port_Server_2}/bci/bci-init${Nc}"
docker pull localhost:${Port_Server_2}/bci/bci-init
echo ""

wait_for_key_press

echo -e "${Green}Listing all available images to our docker instance${Nc}"
echo -e "${GreenBG}docker images -a${Nc}"
docker images -a
echo ""

echo "That's all, folks! :)"
