#!/usr/bin/env sh
if [ "$DEPLOY_ENV" = "dev" ]; then
  sed -i "s|PHP_FPM_ERROR_LOG|/proc/self/fd/2|g" /etc/php/php-fpm.conf
else
  sed -i "s|PHP_FPM_ERROR_LOG|$PHP_FPM_ERROR_LOG|g" /etc/php/php-fpm.conf
fi

sed -i "s|APP_HOSTNAME|$APP_HOSTNAME|g" /etc/php/php-fpm.conf
php-fpm
