FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y \
	mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/script.sh /script.sh

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld && chown -R mysql:mysql /var/lib/mysql \
	&& chmod 777 /var/run/mysqld && chmod +x /script.sh

CMD ["./script.sh"]