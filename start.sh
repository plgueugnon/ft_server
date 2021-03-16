#!/bin/bash/

# OPTION 1
sudo systemctl stop nginx
#&& sudo mkdir -p /var/www/projet/html

sudo chmod 666 /var/run/docker.sock
#&& sudo chmod 755 /var/www/projet


# OPTION 2 (safer but less efficient)
#sudo groupadd docker 
#sudo usermod -aG docker ${USER}
#newgrp docker
#su -s ${USER}
sudo docker rm -f $(docker ps -qa)
sudo docker rmi $(docker images -qa)
#docker images purge
sudo docker build -t ft_server .
#sudo cp projet.html /var/www/projet/html/projet.html\
#&& sudo cp nginx.conf /etc/nginx/\
#&& sudo cp server_config /etc/nginx/sites-available/\
#&& sudo ln -s /etc/nginx/sites-available/server_config /etc/nginx/sites-enabled/
#&& sudo systemctl reload nginx.service
docker run -tid -p 80:80 -p 443:443 --name=ft_server ft_server
docker exec -it ft_server service nginx start
#docker exec -it ft_server service nginx stop
#docker stop ft_server
