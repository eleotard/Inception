#!/bin/bash

#MYSQL_DATABASE=wordpress_ddb
#MYSQL_ROOT_PASSWORD=johnny58
#MYSQL_USER=clara58
#MYSQL_PASSWORD=mamoure58
set -e

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ];

then
	mysql_install_db
	mysqld &
	PID=$!
	until mysqladmin ping; do 
		sleep 2
	done
		

	mysql -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
	mysql -e "FLUSH PRIVILEGES;"
	mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
	mysql -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mysql -e "FLUSH PRIVILEGES;"

	echo "Database created ! "

	kill $PID	
	wait $PID
	
fi

mysqld

#exec "$@"
