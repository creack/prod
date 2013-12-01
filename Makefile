all	:	mysql nginx ghost backup

mysql	:	stack
	docker build -t mysql ./mysql

nginx	:	stack
	docker build -t nginx ./nginx

ghost	:	stack
	docker build -t ghost ./ghost

backup	:	stack backup/Dockerfile
	docker build -t backup ./backup

stack	:
	docker build -t stack ./stack


start	:
	docker run -v /var/www -name data ghost echo Volume Placeholder
	docker run -d -p 127.0.0.1::3306 -name mysql mysql
	docker run -d -p 127.0.0.1::2368 -volumes-from data -name ghost -link mysql:db ghost
	docker run -d -p 198.50.239.81:80:80 -p 0.0.0.0:443:443 -volumes-from ghost -name nginx -link ghost:ghost nginx

clean	:
	docker kill mysql ghost nginx
	docker rm mysql ghost nginx

re	:	clean start

.PHONY	:	stack
