#!/bin/bash

if [ -z "$(ls -A /var/lib/mysql)" ]; then
    echo "Inicializando la base de datos de MariaDB..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

chown -R mysql:mysql /var/lib/mysql

mysqld_safe --datadir=/var/lib/mysql &

until mysqladmin ping --silent; do
    sleep 1
done

if ! mysql -u root -e "USE $DB_NAME;" 2>/dev/null; then
    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
fi

wait