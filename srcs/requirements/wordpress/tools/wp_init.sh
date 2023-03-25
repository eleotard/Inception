#!/bin/sh

if [ -f /var/www/worpress/wp-config.php]

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
	cd /
	mv wordpress /var/www/
	echo "Wordpress installation finished"
fi

#exec "$@"
