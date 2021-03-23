#!/bin/bash/

# OPTION 1
echo "killing nginx service before starting"
sudo systemctl stop nginx
echo "Done - thank you!"
#&& sudo mkdir -p /var/www/projet/html

#sudo chmod 666 /var/run/docker.sock
#&& sudo chmod 755 /var/www/projet


# OPTION 2 (safer but less efficient)
#sudo groupadd docker 
#sudo usermod -aG docker ${USER}
#newgrp docker
#su -s ${USER}
echo "killing previous running containers"
sudo docker kill $(docker ps -qa)
#sudo docker rmi $(docker images -qa)
#docker images purge
echo "Starting to build"
touch log.txt
sudo docker build -t ft_server . >> log.txt
echo "Build finished"
#sudo cp projet.html /var/www/projet/html/projet.html\
#&& sudo cp nginx.conf /etc/nginx/\
#&& sudo cp server_config /etc/nginx/sites-available/\
#&& sudo ln -s /etc/nginx/sites-available/server_config /etc/nginx/sites-enabled/
#&& sudo systemctl reload nginx.service
echo "launching container"
docker run -d -p 80:80 -p 443:443 ft_server
# docker exec -it ft_server service nginx start
#docker exec -it ft_server service nginx stop
#docker stop ft_server
