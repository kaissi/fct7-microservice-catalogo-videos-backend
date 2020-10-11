FROM php:7.3.6-fpm-alpine3.9

RUN apk add --no-cache \
        openssl \
        shadow \
        mysql-client \
        nodejs \
        npm \
    && docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www

COPY composer-install.sh /tmp

RUN usermod -u 1000 www-data \
    && chown -R www-data.www-data /var/www \
    && /tmp/composer-install.sh \
    && mv composer.phar /usr/local/bin/composer

USER www-data

RUN rm -rf /var/www/html \
    && composer create-project laravel/laravel . \
    && ln -s public html

VOLUME /var/www

ENTRYPOINT [ "ls", "-laht" ]
