#!/bin/bash

# Inicia el servidor en segundo plano
mysqld_safe --datadir=/var/lib/mysql &

# Espera a que MariaDB esté listo
until mysqladmin ping --silent; do
    sleep 1
done

# Ejecuta solo si la base de datos no existe
if ! mysql -u root -e "USE $DB_NAME;" 2>/dev/null; then
    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
fi

# Espera en primer plano
wait