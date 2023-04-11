#!/bin/bash

if [ -d /var/lib/mysql/mysql ]; then 
	echo "===> $MYSQL_DATABASE already exist !"
else
	echo "Create DATABASE $MYSQL_DATABASE"
	mysql_install_db --datadir=/var/lib/mysql
	mysqld_safe &
	sleep 2

	mysql -u root --skip-password << EOF
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
		DELETE FROM mysql.user WHERE User='';
		CREATE DATABASE  IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
		CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';
		GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';
		FLUSH PRIVILEGES;
EOF

	mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
	sleep 2
fi

exec mysqld -u root