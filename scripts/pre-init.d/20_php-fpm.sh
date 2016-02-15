#!/bin/sh
sed -i "s|APP_HOSTNAME|$APP_HOSTNAME|g" /etc/php/php-fpm.conf
sed -i "s|APP_LOG_DIR|$APP_LOG_DIR|g" /etc/php/php-fpm.conf
php-fpm
