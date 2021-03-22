FROM debian:buster
MAINTAINER pgueugno <pgueugno@student.42.fr>
RUN apt-get update && apt-get install -y nginx
RUN apt-get install -y openssl
RUN apt-get install -y mariadb-server
RUN apt-get install -y php-fpm php-mysql php-json php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
RUN -P /tmp/ wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
#RUN apt-get install -y wget
RUN tar -xzvf /tmp/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN mv /tmp/phpMyAdmin-4.9.0.1-all-languages var/www/projet/html/phpmyadmin
# RUN wget -P /tmp/ "$https://wordpress.org/latest.tar.gz"
# RUN tar xzvf /tmp/latest.tar.gz && cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
RUN openssl req -newkey rsa:4096 -sha256 -x509 -days 365 -nodes -out /etc/ssl/certs/cert.pem -keyout /etc/ssl/private/key.pem -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=pgueugno/CN=localhost"
RUN mkdir -p /var/www/projet/html
COPY projet.html /var/www/projet/html/
# RUN cp -a /tmp/wordpress/. /var/wwyw/projet
RUN chmod -R 755 /var/www/projet
#COPY nginx.conf /etc/nginx/
#RUN	rm /etc/nginx/nginx.conf
COPY default /etc/nginx/sites-available/
#RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
#RUN service nginx start
#RUN sleep infinity
#RUN -d -p 80:80 --name=ft_server ft_server

CMD service mysql start && service php7.3-fpm start && service nginx start && tail -f /var/log/nginx/*.log
# && bash