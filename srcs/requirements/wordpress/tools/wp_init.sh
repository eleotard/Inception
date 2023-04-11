#!/bin/sh

sleep 5

if [ -f /var/www/wp-config.php ]
then
	echo "===> wp-config.php already exist <==="
	sleep 2
else
	echo "===> create wp-config.php <==== "

	wp core download --locale=fr_FR --allow-root

	wp config create --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$DB_HOST_NAME

	wp core install --url="eleotard.42.fr" \
					--title=Inception \
					--admin_user=$WP_ADMIN \
					--admin_password=$WP_ADMIN_PASS \
					--admin_email=eleotard@student.42.fr \
					--skip-email \
					--allow-root
						
	wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASS --allow-root

	sleep 2
fi

mkdir -p /run/php/7.3/fpm
chown -R www-data:www-data /run/php/7.3/fpm
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

exec "$@"
