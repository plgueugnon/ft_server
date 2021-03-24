#!/bin/bash/

# do not forget to use source /tmp/autoindex.sh cmd to avoid being in locked in child shell
if [ "$AUTOINDEX" = "on" ];
then 
        sed -i 's/autoindex off/autoindex on/' /etc/nginx/sites-available/default && service nginx restart && export AUTOINDEX=off
elif [ "$AUTOINDEX" = "off" ];
then 
        sed -i 's/autoindex on/autoindex off/' /etc/nginx/sites-available/default && service nginx restart && export AUTOINDEX=on
fi