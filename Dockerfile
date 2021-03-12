FROM debian:buster
MAINTAINER pgueugno <pgueugno@student.42.fr>
RUN apt-get update && apt-get install -y nginx
RUN mkdir -p /var/www/projet/html
RUN chmod 755 /var/www/projet
COPY projet.html /var/www/projet/html/
COPY nginx.conf /etc/nginx/
COPY default /etc/nginx/sites-available/
#RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
#RUN service nginx start
#RUN sleep infinity
#RUN -d -p 80:80 --name=ft_server ft_server
