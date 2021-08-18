FROM php:fpm

RUN apt-get update -y \
    && apt-get install -y nginx

COPY ./entrypoint.sh /etc/entrypoint.sh
COPY ./nginx/default.conf /etc/nginx/sites-enabled/default
COPY ./php/index.php ./php/info.php /var/www/html/

WORKDIR /var/www/html

EXPOSE 80

ENTRYPOINT ["sh", "/etc/entrypoint.sh"]
