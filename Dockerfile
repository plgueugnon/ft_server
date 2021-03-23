FROM debian:buster
LABEL pgueugno <pgueugno@student.42.fr>
RUN apt-get update && apt-get install -y nginx
RUN apt-get install -y openssl
RUN apt-get install -y mariadb-server
RUN apt-get install -y php-fpm php-mysql php-json php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
RUN apt-get install -y wget
RUN mkdir -p /var/www/projet/wordpress
COPY projet.html /var/www/projet/
RUN chmod -R 755 /var/www/projet
RUN wget -P /tmp/ https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -xzvf /tmp/phpMyAdmin-4.9.0.1-all-languages.tar.gz -C /tmp/
RUN mv /tmp/phpMyAdmin-4.9.0.1-all-languages var/www/projet/phpmyadmin
RUN wget -P /tmp/ https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x /tmp/wp-cli.phar && mv /tmp/wp-cli.phar /usr/local/bin/wp
RUN wp core download --path=/var/www/projet/wordpress/ --allow-root
# RUN wget -P /tmp/ "$https://wordpress.org/latest.tar.gz"
# RUN tar xzvf /tmp/latest.tar.gz && cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
RUN openssl req -newkey rsa:4096 -sha256 -x509 -days 365 -nodes -out /etc/ssl/certs/cert.pem -keyout /etc/ssl/private/key.pem -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=pgueugno/CN=localhost"
# RUN cp -a /tmp/wordpress/. /var/wwyw/projet
#COPY nginx.conf /etc/nginx/
#RUN	rm /etc/nginx/nginx.conf
COPY default /etc/nginx/sites-available/
#RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
#RUN service nginx start
#RUN sleep infinity
#RUN -d -p 80:80 --name=ft_server ft_server
#RUN service mysql start
#RUN chmod -R 755 /var/run/mysqld/mysqld.sock
COPY config_mysql.sh /tmp/
#RUN sh /tmp/config_mysql.sh
#RUN sleep 5
#RUN service mysql status
#RUN echo "create database dbprojet default character set utf8 collate utf8_unicode_ci;" | mysql -u root
#RUN echo "grant all on dbprojet.* to 'yo'@'localhost' identified by 'yopwd';" | mysql -u root
#RUN echo "flush privileges;" | mysql -u root
CMD service mysql start && service php7.3-fpm start && service nginx start && sh /tmp/config_mysql.sh && tail -f /var/log/nginx/*.log
# && bash