FROM php:8.0-apache
WORKDIR /var/www/html

COPY index.php index.php
COPY content/ content
COPY includes/ includes
COPY template/ template
EXPOSE 80