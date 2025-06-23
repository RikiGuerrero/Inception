FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y \
	php-fpm \
	php-mysqli \
	curl \
	default-mysql-client

RUN mkdir -p /run/php

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/script.sh /script.sh
RUN chmod +x /script.sh

EXPOSE 9000

CMD ["/script.sh"]