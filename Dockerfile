FROM debian:buster
MAINTAINER pgueugno <pgueugno@student.42.fr>
RUN apt-get update && apt-get install -y nginx && apt-get install -y openssl
RUN openssl req -newkey rsa:4096 -sha256 -x509 -days 365 -nodes -out /etc/ssl/certs/cert.pem -keyout /etc/ssl/private/key.pem -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=pgueugno/CN=localhost"
RUN mkdir -p /var/www/projet/html
RUN chmod 755 /var/www/projet
COPY projet.html /var/www/projet/html/
#COPY nginx.conf /etc/nginx/
#RUN	rm /etc/nginx/nginx.conf
COPY default /etc/nginx/sites-available/
#RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
#RUN service nginx start
#RUN sleep infinity
#RUN -d -p 80:80 --name=ft_server ft_server

CMD service nginx start && tail -f /var/log/nginx/*.log