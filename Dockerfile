FROM debian:buster
MAINTAINER pgueugno <pgueugno@student.42.fr>
RUN apt-get update && apt-get install -y nginx
#RUN service nginx start
#RUN sleep infinity
#RUN -d -p 80:80 --name=ft_server ft_server
