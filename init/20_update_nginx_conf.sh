#!/usr/bin/env bash

# Turn off daemon mode.
if ! grep -q "daemon off;" /etc/nginx/nginx.conf;
then
  echo "daemon off;" >> /etc/nginx/nginx.conf
fi

# Update php-fpm conf.
sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini
