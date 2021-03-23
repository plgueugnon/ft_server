echo "create database dbprojet default character set utf8 collate utf8_unicode_ci;" | mysql -u root
echo "grant all on dbprojet.* to 'yo'@'localhost' identified by 'yopwd';" | mysql -u root
echo "flush privileges;" | mysql -u root
wp core config --dbname=dbprojet --dbuser=yo --dbpass=yopwd --dbhost=localhost --path=/var/www/projet --allow-root
wp core install --url="https://localhost/wordpress/" --title="PROOOOJET" --admin_user="yo" --admin_password="yopwd" --admin_email="yo@yo.com" --path=/var/www/projet/ --allow-root