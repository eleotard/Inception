#!/bin/sh

sleep 5

if [ -f /var/www/wp-config.php ]
then
	echo "===> wp-config.php already exist <==="
	sleep 2
else
echo "===> create wp-config.php <==== "
wp core download --locale=fr_FR --allow-root
sleep 5

wp config create --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=db
# wp config create --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD
wp core install --url="eleotard.42.fr" \
				--title=Inception \
				--admin_user=$MYSQL_USER \
				--admin_password=$MYSQL_PASSWORD \
				--admin_email=eleotard@student.42.fr \
				--skip-email \
				--allow-root
				

# wp core config --dbname=$MYSQL_DATABASE \
#   --dbuser=$MYSQL_USER \
#   --dbpass=$MYSQL_PASSWORD \
#   --dbhost=$DB_HOST_NAME \
#   --dbcharset=$WP_CHARSET \
#   --dbprefix=wp_ \
#   --dbcollate="utf8_general_ci" \
#   --allow-root

    # --dbcharset=$WP_CHARSET \
    # --dbprefix=wp_ \
    # --dbcollate=utf8_general_ci \
    # --dbpass=$MYSQL_PASSWORD \
    # --dbhost=$DB_HOST_NAME \
					
sleep 2


# wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root

fi

mkdir -p /run/php/7.3/fpm
chown -R www-data:www-data /run/php/7.3/fpm
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

exec "$@"
