# nginx Dockerfile
FROM		stack
MAINTAINER	Guillaume J. Charmes <charmes.guillaume@gmail.com>

# Install Nginx
RUN		apt-get -qq install -y nginx
RUN		mkdir /var/cache/nginx && chown www-data:www-data /var/cache/nginx

EXPOSE		80 443

CMD		sed -i -e"s/\$GHOST_PORT_2368_TCP_ADDR/$GHOST_PORT_2368_TCP_ADDR/" /etc/nginx/nginx.conf && \
		sed -i -e"s/\$GHOST_PORT_2368_TCP_PORT/$GHOST_PORT_2368_TCP_PORT/" /etc/nginx/nginx.conf && \
		nginx
ADD		nginx.conf /etc/nginx/nginx.conf
