#!/bin/bash

until mysqladmin ping -h"$DB_HOST" -u"root" --silent; do
  echo "Esperando a la base de datos..."
  sleep 2
done

cd /var/www/html
if [ ! -f wp-config.php ]; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	./wp-cli.phar core download --allow-root

	./wp-cli.phar config create \
		--dbname=$DB_NAME \
		--dbuser=$DB_USER \
		--dbpass=$DB_PASS \
		--dbhost=$DB_HOST \
		--allow-root

	./wp-cli.phar core install \
		--url=https://rguerrer.42.fr \
		--title=inception \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASS \
		--admin_email=$WP_ADMIN_EMAIL \
		--allow-root

	./wp-cli.phar user create \
		$WP_USER_USER \
		$WP_USER_EMAIL \
		--role=subscriber \
		--user_pass=$WP_USER_PASS \
		--allow-root

    # !!! AÑADIR ESTAS LÍNEAS !!!
    echo "Cambiando permisos de los archivos de WordPress a www-data..."
    chown -R www-data:www-data /var/www/html
    # Es recomendable ajustar también los permisos de directorios a 755 y archivos a 644 para seguridad
    find /var/www/html -type d -exec chmod 755 {} \;
    find /var/www/html -type f -exec chmod 644 {} \;
    chmod 640 /var/www/html/wp-config.php # Especialmente wp-config.php
    # !!! FIN DE LAS LÍNEAS A AÑADIR !!!

fi

php-fpm7.4 -F