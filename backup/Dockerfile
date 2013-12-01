# backup Dockerfile
#
# docker run -link mysql:db -volumes-from ghost -v `pwd`:/backup backup
#
FROM		stack
MAINTAINER	Guillaume J. Charmes <charmes.guillaume@gmail.com>

# Install Mysql
RUN		apt-get -qq install -y mysql-client

RUN		mkdir /backup

VOLUMES		/backup

CMD		mysqldump --all-databases -u ghost -pghost -h $DB_PORT_3306_TCP_ADDR -P $DB_PORT_3306_TCP_PORT | gzip -9 > /backup/backup.database.`date +%m-%d-%Y`.sql.gz && \
		cd /var/www && tar -czf /backup/backup.ghost.data.`date +%m-%d-%Y`.tar.gz .
