#!/bin/bash


PASS="atec123"


mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$PASS';"
mariadb -u root -p"$PASS" -e "DELETE FROM mysql.user WHERE User='';"
mariadb -u root -p"$PASS" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
mariadb -u root -p"$PASS" -e "DROP DATABASE IF EXISTS test;"
mariadb -u root -p"$PASS" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
mariadb -u root -p"$PASS" -e "FLUSH PRIVILEGES;"

echo "MariaDB configurado com seguranca."
