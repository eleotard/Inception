FROM	debian:buster

EXPOSE	3306

RUN	apt-get update -y; \
	apt-get upgrade -y; \
	apt-get install mariadb-server -y 

COPY	./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY	./tools/mdb_init.sh /usr/local/bin

RUN	chmod +x /usr/local/bin/mdb_init.sh

RUN	chmod 777 /var/lib/mysql; \
	mkdir -p /var/run/mysqld; \
	chown -R mysql:mysql /var/run/mysqld; \
	chmod 777 /var/run/mysqld; \
	apt-get autoclean -y

ENTRYPOINT ["sh", "/usr/local/bin/mdb_init.sh"]

#CMD ["mysqld", "--bind-adress=0.0.0.0", "--log-error=/var/lib/mysql/error.log"]
