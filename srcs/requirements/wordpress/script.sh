#!/bin/bash
cd /var/www/html
if [ ! -f wp-config.php ]; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	./wp-cli.phar core download --allow-root
	./wp-cli.phar config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST --allow-root
	./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root
fi

php-fpm7.4 -F