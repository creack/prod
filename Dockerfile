FROM		ubuntu:12.10
MAINTAINER	Guillaume J. Charmes <charmes.guillaume@gmail.com>

# Install add-apt-repository
RUN		apt-get -qq install -y software-properties-common
# Add nodejs ppa
RUN		add-apt-repository ppa:chris-lea/node.js
RUN		apt-get -qq update

# Install Nodejs
RUN		apt-get -qq install -y nodejs

# Keep apt-get from complaining
RUN		dpkg-divert --local --rename --add /sbin/initctl
RUN		ln -s /bin/true /sbin/initctl

# Install Mysql
RUN		apt-get -qq install -y mysql-client mysql-server
# Make Mysql listen on 0.0.0.0 instead of 127.0.0.1
#RUN		sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Allow root to connect from host
#RUN		mysqld_safe& sleep 2; echo "GRANT ALL ON *.* TO root@'172.17.42.1' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql -u root

ENV		HOST	     localhost
#ENV		HOST	     172.17.42.%

RUN		mysqld_safe& sleep 2; \
		echo "CREATE DATABASE ghostdev; \
		CREATE DATABASE ghost; \
		CREATE USER 'ghost'@'$HOST' identified by 'ghost'; \
		GRANT ALL PRIVILEGES ON ghost.* to 'ghost'@'$HOST'; \
		GRANT ALL PRIVILEGES ON ghostdev.* to 'ghost'@'$HOST'; \
		FLUSH PRIVILEGES; " | mysql -u root

# Install Nginx
RUN		apt-get -qq install -y nginx
RUN		mkdir /var/cache/nginx && chown www-data:www-data /var/cache/nginx
RUN		mkdir /var/www && chown www-data:www-data /var/www

# Install Ghost
RUN		apt-get -qq install -y wget unzip
# FIXME: rm ghost.zip after unzip
RUN		cd /var/www && wget https://ghost.org/zip/ghost-0.3.3.zip && unzip ghost-0.3.3.zip
RUN		cd /var/www && npm install --production && npm install mysql

#RUN		mv /var/www/config.example.js /var/www/config.js
#RUN		sed -i -e"s/my-ghost-blog.com/guillaumecharmes.net/" /var/www/config.js
RUN		chown -R www-data:www-data /var/www

EXPOSE		80
CMD		["/bin/sh", "/var/www/starter.sh"]

ADD		config.js /var/www/config.js
ADD		starter.sh /var/www/starter.sh
ADD		nginx.conf /etc/nginx/nginx.conf
