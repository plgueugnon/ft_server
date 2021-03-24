FROM debian:buster
LABEL pgueugno <pgueugno@student.42.fr>

# Installing all required packages
RUN apt-get update && apt-get install -y nginx
RUN apt-get install -y openssl
RUN apt-get install -y mariadb-server
RUN apt-get install -y php-fpm php-mysql php-json php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
RUN apt-get install -y wget

# Creating root dir to receive server, wp and php config files
RUN mkdir -p /var/www/projet/wordpress && mkdir /var/www/projet/test\
&& touch /var/www/projet/test/hahayoufoundmeee.txt
COPY projet.html /var/www/projet/
RUN chmod -R 755 /var/www/projet

# Getting php, wp-cli and wp files
RUN wget -P /tmp/ https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -xzvf /tmp/phpMyAdmin-4.9.0.1-all-languages.tar.gz -C /tmp/
RUN mv /tmp/phpMyAdmin-4.9.0.1-all-languages var/www/projet/phpmyadmin
RUN wget -P /tmp/ https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x /tmp/wp-cli.phar && mv /tmp/wp-cli.phar /usr/local/bin/wp
RUN wp core download --path=/var/www/projet/wordpress/ --allow-root

# Creating ssl key
RUN openssl req -newkey rsa:4096 -sha256 -x509 -days 365 -nodes -out /etc/ssl/certs/cert.pem -keyout /etc/ssl/private/key.pem -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=pgueugno/CN=localhost"

# Creating env var autoindex & copying last config script and files 
#RUN export AUTOINDEX=on
COPY default /etc/nginx/sites-available/
COPY autoindex.sh /tmp/
COPY config_mysql.sh /tmp/
# Cmd not required as we replace default - otherwise necessary
#RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Launching all services & script to config mysql ans wp
CMD service mysql start && service php7.3-fpm start\
&& service nginx start && sh /tmp/config_mysql.sh\
&& tail -f /var/log/nginx/*.log