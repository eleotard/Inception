FROM	debian:buster

EXPOSE 443

RUN	apt-get update -y; \
	apt-get upgrade -y; \
	apt-get install -y nginx openssl; \ 
	apt-get autoclean

RUN	openssl req -x509 -nodes -out /etc/ssl/inception.crt -keyout /etc/ssl/inception.key -subj "/C=FR/ST=IDF/L=PARIS/OU=42/CN=eleotard.42.fr/UID=eleotard"

RUN chmod -R 755 /var/www/*
RUN chown -R www-data:www-data /var/www/

COPY ./conf/default /etc/nginx/sites-enabled/

ENTRYPOINT ["nginx", "-g", "daemon off;"]
