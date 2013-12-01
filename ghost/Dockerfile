# ghost Dockerfile
FROM		stack
MAINTAINER	Guillaume J. Charmes <charmes.guillaume@gmail.com>

# Install Nodejs & build deps
RUN		apt-get -qq install -y nodejs wget unzip

ENV		GHOST_VERSION	0.3.3
ENV		GHOST_ROOT	/var/www

# Install Ghost
RUN		mkdir $GHOST_ROOT && cd $GHOST_ROOT && \
		wget https://ghost.org/zip/ghost-$GHOST_VERSION.zip && \
		unzip ghost-$GHOST_VERSION.zip && \
		rm ghost-$GHOST_VERSION.zip
RUN		cd $GHOST_ROOT && npm install --production && npm install mysql && npm install node-etcd
RUN		chown -R www-data:www-data $GHOST_ROOT

EXPOSE		2368

ENV		NODE_ENV	production
CMD		npm start --sourceDir $GHOST_ROOT index.js

VOLUME		/var/www

ADD		config.js /var/www/config.js
