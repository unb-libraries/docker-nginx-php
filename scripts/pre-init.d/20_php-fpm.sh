#!/usr/bin/env sh
sed -i "s|PHP_FPM_ERROR_LOG|$PHP_FPM_ERROR_LOG|g" /etc/php5/fpm.d/zz_app.conf
sed -i "s|NGINX_RUN_USER|$NGINX_RUN_USER|g" /etc/php5/fpm.d/zz_app.conf
sed -i "s|NGINX_RUN_GROUP|$NGINX_RUN_GROUP|g" /etc/php5/fpm.d/zz_app.conf

php-fpm5
