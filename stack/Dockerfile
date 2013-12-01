# stack Dockerfile
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
