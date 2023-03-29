#!/bin/sh

sleep 10

if [ -f ./worpress/wp-config.php ];

then
	echo "Wordpress already installed"
else
	wget http://wordpress.org/latest.tar.gz
	tar -xzf latest.tar.gz
	rm -f latest.tar.gz
	chown -R root:root wordpress
	
	cd wordpress
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	sed -i "s/localhost/$WORDPRESS_DB_HOST/g" wp-config-sample.php

	mv wp-config-sample.php wp-config.php
	
	#wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	#chmod +x wp-cli.phar
	#mkdir -p /usr/local/bin/wp
	#mv wp-cli.phar /usr/local/bin/wp
	#echo "Wordpress installation finished"
fi

exec "$@"
