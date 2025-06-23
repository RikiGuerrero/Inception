FROM debian:bullseye

ARG CRED_PATH SSL_CERT SSL_KEY

RUN apt update && apt upgrade -y && apt install -y \
	nginx \
	openssl \
	gettext

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/nginx/ssl/ssl-cert.key	\
-out /etc/nginx/ssl/ssl-cert.crt \
-subj "/C=FR/ST=France/L=Paris/O=42/OU=42/CN=localhost"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]