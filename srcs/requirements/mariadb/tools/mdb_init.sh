#!/bin/bash

#MYSQL_DATABASE=wordpress_ddb
#MYSQL_ROOT_PASSWORD=johnny58
#MYSQL_USER=clara58
#MYSQL_PASSWORD=mamoure58
set -ex

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ];

then
	mysql_install_db
	service mysql start
	# PID=$!
	until mysqladmin ping; do 
		sleep 2
	done
		

	# mysql -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
	# mysql -e "FLUSH PRIVILEGES;"
	mysql -D mysql < "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;SET PASSWORD FOR 'root'@'localhost'=PASSWORD('$MYSQL_ROOT_PASSWORD');FLUSH PRIVILEGES;" | true

	# mysql -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"

	echo "Database created ! "

	# kill $PID	
	# wait $PID
	service mysql stop | echo -n ""
fi

mysqld_safe

#exec "$@"
