#!/usr/bin/env sh
if [ "$DEPLOY_ENV" = "dev" ]; then
  sed -i "s|PHP_FPM_ERROR_LOG|/proc/self/fd/2|g" /etc/php7/php-fpm.conf
else
  sed -i "s|PHP_FPM_ERROR_LOG|$PHP_FPM_ERROR_LOG|g" /etc/php7/php-fpm.conf
fi

sed -i "s|NGINX_RUN_USER|$NGINX_RUN_USER|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|NGINX_RUN_GROUP|$NGINX_RUN_GROUP|g" /etc/php7/php-fpm.d/www.conf

/usr/sbin/php-fpm7
