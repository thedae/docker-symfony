FROM debian:jessie

MAINTAINER Vincent Composieux <vincent.composieux@gmail.com>

ENV NGINX_SERVER_NAME symfony.dev
ENV NGINX_DOCUMENT_ROOT /var/www/symfony/web
ENV NGINX_INDEX_FILE app.php

RUN apt-get update && apt-get install -y nginx

ADD nginx.conf /etc/nginx/
ADD symfony.conf /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony
RUN rm /etc/nginx/sites-enabled/default

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]

EXPOSE 80
EXPOSE 443
