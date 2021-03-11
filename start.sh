#!/bin/bash/

# OPTION 1
sudo systemctl stop nginx
sudo chmod 666 /var/run/docker.sock

# OPTION 2 (safer but less efficient)
#sudo groupadd docker 
#sudo usermod -aG docker ${USER}
#newgrp docker
#su -s ${USER}
docker rm -f $(docker ps -qa)
#docker rmi $(docker images -qa)
docker images purge
docker build -t ft_server .
docker run -td -p 80:80 --name=ft_server ft_server
docker exec -it ft_server service nginx start
#docker exec -it ft_server service nginx stop
#docker stop ft_server
