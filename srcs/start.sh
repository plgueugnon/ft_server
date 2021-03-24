#!/bin/bash/

# Dealing with nginx service as a precaution
echo "\033[33mKilling nginx service before starting - please enter admin code to proceed\033[0m"
sudo systemctl stop nginx
echo "\033[33mDone - thank you!\033[0m"

# Debug (safer but less efficient)
#sudo groupadd docker 
#sudo usermod -aG docker ${USER}
#newgrp docker
#su -s ${USER}

# Hardcore debug
#sudo chmod 666 /var/run/docker.sock

# Testing and cleaning options
#echo "killing previous running containers"
#sudo docker kill $(docker ps -qa)
#sudo docker rmi $(docker images -qa)
#docker images purge

# Build docker image ft_server
echo "\033[32mStarting to build - please wait while docker image is being built\033[0m"
touch log.txt
docker build -t ft_server . >> log.txt
echo "\033[32mBuild finished\033[0m"

# Launching container without specific name from image ft_server
echo "\033[32mLaunching container\033[0m"
docker run -d -p 80:80 -p 443:443 ft_server
echo "\033[32mContainer launched - ready when you are :)\033[0m"
docker exec -it $(docker ps -q) bash