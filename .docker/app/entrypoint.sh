#!/bin/sh

echo ">> Changing ownership of '/var/www' to 'www-data'"
chown -R www-data.www-data /var/www

echo ">> Executing 'composer install'"
composer install

echo ">> Executing 'php artisan cache:clear'"
php artisan cache:clear

echo ">> Executing 'php artisan config:cache'"
php artisan config:cache

echo ">> Executing 'php artisan key:generate'"
php artisan key:generate

# echo ">> Executing 'php artisan migrate'"
# php artisan migrate

echo ">> Executing 'php-fpm'"
exec php-fpm "${@}"
