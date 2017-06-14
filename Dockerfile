FROM unblibraries/nginx:alpine
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

LABEL ca.unb.lib.php="7.1"
LABEL vcs-ref="alpine-php7"
LABEL vcs-url="https://github.com/unb-libraries/docker-nginx-php"

ENV COMPOSER_PATH /usr/local/bin
ENV PHP_FPM_ERROR_LOG /proc/self/fd/2
ENV PHP_PID_DIR /var/run/php

RUN apk --update add php7 php7-fpm php7-json php7-zlib php7-xml php7-phar php7-iconv php7-mcrypt curl php7-curl php7-openssl php7-gd && \
  rm -f /var/cache/apk/* && \
  mkdir -p ${PHP_PID_DIR}/ && \
  chown ${NGINX_RUN_USER}:${NGINX_RUN_GROUP} ${PHP_PID_DIR}/ && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=${COMPOSER_PATH} --filename=composer

COPY conf/nginx/app.conf /etc/nginx/conf.d/app.conf
COPY conf/php/app-php.ini /etc/php7/conf.d/zz_app.ini
COPY conf/php/app-php-fpm.conf /etc/php7/php-fpm.d/zz_app.conf

COPY scripts /scripts
RUN chmod -R 755 /scripts
