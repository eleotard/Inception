FROM	debian:buster

RUN	apt-get update -y; \
	apt-get upgrade -y; \
	apt-get install -y wget; \
	apt-get install -y php7.3; \
	apt-get install -y php-fpm; \
	apt-get install -y php-mysql; \
	apt-get install -y mariadb-client

#juste specifie le port d'ecoute pour fpm
COPY	./conf/www.conf /etc/php/7.3/fpm/pool.d/
COPY	./tools/wp_init.sh /usr/local/bin/	

RUN	chmod +x /usr/local/bin/wp_init.sh

ENTRYPOINT ["/usr/local/bin/wp_init.sh"]

CMD ["/usr/sbin/php-fpm7.3", "-F"]


