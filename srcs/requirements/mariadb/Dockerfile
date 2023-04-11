FROM	debian:buster

EXPOSE	3306

RUN	apt-get update -y; \
	apt-get upgrade -y; \
	apt-get install mariadb-server mariadb-client -y 

COPY	./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY	./tools/mdb_init.sh /usr/local/bin

RUN	chmod +x /usr/local/bin/mdb_init.sh

RUN	rm -rf /var/lib/mysql; \
	mkdir -p /run/mysqld /var/lib/mysql; \
	chown -R mysql:mysql /var/run/mysqld; \
	chmod 777 /var/run/mysqld; \
	apt-get autoclean -y

ENTRYPOINT ["sh", "/usr/local/bin/mdb_init.sh"]

