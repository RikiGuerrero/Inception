FROM debian:bullseye

ARG CRED_PATH SSL_CERT SSL_KEY

RUN apt update && apt upgrade -y && apt install -y \
	nginx \
	openssl \
	gettext

RUN mkdir -p ${CRED_PATH}
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout ${CRED_PATH}/${SSL_KEY}	\
-out ${CRED_PATH}/${SSL_CERT} \
-subj "/C=FR/ST=France/L=Paris/O=42/OU=42/CN=localhost"

COPY default ./tmp/default

RUN envsubst '${CRED_PATH} ${SSL_CERT} ${SSL_KEY}' < /tmp/default > /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]