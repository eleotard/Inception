FROM	debian:buster

EXPOSE	3306

RUN	apt-get update -y; \
	apt-get upgrade -y; \
	apt-get install mariadb-server mariadb-client -y 

COPY	./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY	./tools/mdb_init.sh /usr/local/bin

RUN	chmod +x /user/local/bin/mdb_init.sh

RUN	mkdir -p /var/run/mysql; \
	chown -R mysql:mysql /var/run/mysql; \
	apt-get autoclean -y

ENTRYPOINT ["sh", "/usr/local/bin/init.sh"]

CMD ["mysqld", "--bind-adress=0.0.0.0", "--log-error=/var/lib/mysql/error.log"]
