#!/bin/bash/

export AUTOINDEX=on

# Config mysql
echo "create database dbprojet default character set utf8 collate utf8_unicode_ci;" | mysql -u root
echo "grant all on dbprojet.* to 'yo'@'localhost' identified by 'yopwd';" | mysql -u root
echo "flush privileges;" | mysql -u root

# Config wp to work with mysql
wp core config --dbname=dbprojet --dbuser=yo --dbpass=yopwd --dbhost=localhost --path=/var/www/projet/wordpress/ --allow-root

# Launch wp with basic config
wp core install --url="https://localhost/wordpress/" --title="Et voici notre prooojet!!" --admin_user="yo" --admin_password="yopwd" --admin_email="yo@yo.com" --path=/var/www/projet/wordpress/ --allow-root