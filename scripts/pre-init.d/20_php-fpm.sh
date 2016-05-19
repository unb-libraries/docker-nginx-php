#!/usr/bin/env sh
if [ "$DEPLOY_ENV" = "dev" ]; then
  sed -i "s|PHP_FPM_ERROR_LOG|/proc/self/fd/2|g" /etc/php/php-fpm.conf
else
  sed -i "s|PHP_FPM_ERROR_LOG|$PHP_FPM_ERROR_LOG|g" /etc/php/php-fpm.conf
fi

sed -i "s|NGINX_RUN_USER|$NGINX_RUN_USER|g" /etc/php/php-fpm.conf
sed -i "s|NGINX_RUN_GROUP|$NGINX_RUN_GROUP|g" /etc/php/php-fpm.conf

php-fpm
