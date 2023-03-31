#!/bin/bash

#set -ex

# 	mysql_install_db --datadir=/var/lib/mysql
# 	mysqld_safe &
# 	sleep 2

# 	#mysql -D mysql < "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;SET PASSWORD FOR 'root'@'localhost'=PASSWORD('$MYSQL_ROOT_PASSWORD');FLUSH PRIVILEGES;" | true
# 	mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
# 	mysql -u root --skip-password -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
# 	mysql -u root --skip-password -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
# 	mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
# 	mysql -u root --skip-password -e "FLUSH PRIVILEGES;"

# 	#echo "Database created ! "

# 	#service mysql stop | echo -n ""
# 	mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

# exec mysqld_safe


if [ -d /var/lib/mysql/mysql ]; then 
	echo "===> $MYSQL_DATABASE already exist !"
else
	echo "Create DATABASE $MYSQL_DATABASE"
	mysql_install_db --datadir=/var/lib/mysql
	mysqld_safe &
	sleep 2

	mysql -u  root  --skip-password << EOF
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
		CREATE DATABASE  IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
		CREATE USER  IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';
		GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
		FLUSH PRIVILEGES;
EOF

	mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
	sleep 2
fi

exec mysqld -u root