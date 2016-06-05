#!/usr/bin/env sh
sed -i "s|PHP_FPM_ERROR_LOG|$PHP_FPM_ERROR_LOG|g" /etc/php7/php-fpm.conf

sed -i "s|NGINX_RUN_USER|$NGINX_RUN_USER|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|NGINX_RUN_GROUP|$NGINX_RUN_GROUP|g" /etc/php7/php-fpm.d/www.conf

/usr/sbin/php-fpm7
