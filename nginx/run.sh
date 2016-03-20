#!/bin/bash
sed -i "s|NGINX__SERVER_NAME|$NGINX_SERVER_NAME|g" /etc/nginx/sites-available/symfony.conf && \
sed -i "s|NGINX__DOCUMENT_ROOT|$NGINX_DOCUMENT_ROOT|g" /etc/nginx/sites-available/symfony.conf && \
sed -i "s|NGINX__INDEX_FILE|$NGINX_INDEX_FILE|g" /etc/nginx/sites-available/symfony.conf
nginx