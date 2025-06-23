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
fi

php-fpm7.4 -F