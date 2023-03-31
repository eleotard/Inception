FROM	debian:buster

EXPOSE	9000

RUN	apt-get update -y; \
	apt-get upgrade -y; \
	apt-get install -y sudo; \
	apt-get install -y wget; \
	apt-get install -y php7.3 php-fpm php-mysql; \
	apt-get install -y mariadb-client; \
	apt-get autoclean

#juste specifie le port d'ecoute pour fpm
COPY	./conf/www.conf /etc/php/7.3/fpm/pool.d/
COPY	./tools/wp_init.sh /usr/local/bin/	

RUN	chmod +x /usr/local/bin/wp_init.sh

# RUN	wget https://wordpress.org/wordpress-6.0.tar.gz -P /var/www
# RUN cd /var/www && tar -xzf wordpress-6.0.tar.gz && rm wordpress-6.0.tar.gz
# RUN chown -R root:root /var/www/wordpress

WORKDIR /var/www/

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

ENTRYPOINT ["/usr/local/bin/wp_init.sh"]

CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]


