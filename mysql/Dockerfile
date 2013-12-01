# mysql Dockerfile
FROM		stack
MAINTAINER	Guillaume J. Charmes <charmes.guillaume@gmail.com>

# Install Mysql
RUN		apt-get -qq install -y mysql-client mysql-server

#ENV		HOST	     localhost
ENV		HOST	     172.17.0.%
#ENV		HOST	     0.0.0.0

# Make Mysql listen on 0.0.0.0 instead of 127.0.0.1
RUN		sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

RUN		mysqld_safe& sleep 4; \
		echo "CREATE DATABASE ghostdev; \
		CREATE DATABASE ghost; \
		CREATE USER 'ghost'@'$HOST' identified by 'ghost'; \
		GRANT ALL PRIVILEGES ON ghost.* to 'ghost'@'$HOST'; \
		GRANT ALL PRIVILEGES ON ghostdev.* to 'ghost'@'$HOST'; \
		FLUSH PRIVILEGES; " | mysql -u root

# Allow root to connect from host
#RUN		mysqld_safe& sleep 4; echo "GRANT ALL ON *.* TO root@'172.17.42.1' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql -u root

EXPOSE		3306
CMD		["mysqld_safe"]
